require 'aiip'
require 'task'

TechTask = class('TechTask', Task)

TechTask:getter('tech')

function TechTask:initialize(name, gov, tech)
	super.initialize(self, name, gov, Department.TECH)
	self.tech = tech
end

function TechTask:_isExecutable()
	local minister = self:getMinister()
	return minister:CanResearch(self.tech)
end

function TechTask:_execute()
	local minister = self:getMinister()
	local ai = minister:GetOwnerAI()
	local command = CStartResearchCommand(minister:GetCountryTag(), self.tech)
	ai:Post(command)
	return true
end

function TechTask:_isRunning()
	local ministerCountry = gov:getCountry()
	for tech in ministerCountry:GetCurrentResearch() do
		if tech == self.tech then
			return true
		end
	end
	return false
end

function TechTask:_resourceUse()
	local ministerCountry = self.gov:getCountry()
	local days = CalculateResearchDays(ministerCountry, self.tech)

	return ResourceContainer:new(0, 1, 0, 0, days)
end

-- Return values is between -0.5 and +0.4
function CalculateResearchBonus(country, tech)
	local researchBonus = 0
	for bonus in tech:GetResearchBonus() do
		local ability = 1.0 * country:GetAbility(bonus._pCategory)
		if ability < 5 then
			researchBonus = researchBonus - (5 - ability) * 0.1 * bonus._vWeight:Get()
		elseif ability < 20 then
			researchBonus = researchBonus + math.sqrt(ability - 5) * 0.1 * bonus._vWeight:Get()
		else
			researchBonus = researchBonus + 0.4 * bonus._vWeight:Get()
		end
	end
	return researchBonus
end

function CalculateResearchDays(country, tech)
	local techStatus = country:GetTechnologyStatus()
	local techLvl = techStatus:GetLevel(tech)
	local yearPenalty = techStatus:GetYear(tech, techLvl + 1) - CCurrentGameState.GetCurrentDate():GetYear()
	local researchBonus = CalculateResearchBonus(country, tech)
	local researchEfficiency = country:GetGlobalModifier():GetValue(CModifier._MODIFIER_RESEARCH_EFFICIENCY_):Get()
	local difficultyLevel = tech:GetDifficulty()
	return (125 * (1 + difficultyLevel * 0.1)) * (1 + yearPenalty + researchBonus + researchEfficiency)
end

if not CAI then
	local tasks = {}
	local tech = {}
	local gov = {}
	for i = 0, 3 do
		local techName = tostring(i)
		local task = TechTask:new(techName, gov, tech)
		tasks[techName] = task
	end
	for techName, task in pairs(tasks) do
		assert(techName == task:getName())
		assert(task:getTech() == tech)
	end
end
