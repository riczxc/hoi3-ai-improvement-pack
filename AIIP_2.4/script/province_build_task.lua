require 'aiip'
require 'task'

ProvinceBuildTask = class('ProvinceBuildTask', Task)

ProvinceBuildTask:getter('building')
ProvinceBuildTask:getter('province')

function ProvinceBuildTask:initialize(name, gov, building, province)
	super.initialize(self, name, gov, Department.PROD)

	if type(building) == 'string' then
		building = CBuildingDataBase.GetBuilding(building)
	elseif type(building) == 'number' then
		building = CBuildingDataBase.GetBuildingFromIndex(building)
	end

	if type(province) == 'number' then
		province = CCurrentGameState.GetProvince(province)
	end

	self.building = building
	self.province = province
end

function ProvinceBuildTask:_constructCommand(ministerTag)
	return CConstructBuildingCommand(ministerTag, self.building, self.province:GetProvinceID(), 1)
end

function ProvinceBuildTask:_isExecutable()
	local minister = self:getMinister()
	local ministerCountry = minister:GetCountry()
	local allowed = ministerCountry:IsBuildingAllowed(self.building, self.province)

	if allowed then
		local command = self:_constructCommand(minister:GetCountryTag())
		return command:IsValid()
	end

	return false
end

function ProvinceBuildTask:_execute()
	local minister = self:getMinister()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()

	local command = self:_constructCommand(minister:GetCountryTag())
	if command:IsValid() then
		ai:Post(command)
		return true
	else
		return false
	end
end

function ProvinceBuildTask:_isRunning()
	return self.province:GetCurrentConstructionLevel(self.building) > 0
end

function ProvinceBuildTask:_resourceUse()
	local minister = self:getMinister()
	local ministerCountry = minister:GetCountry()

	-- TODO: Calculate nominal build cost here.
	local nominalBuildCostIC = ministerCountry:GetBuildCost(self.building):Get()
	local buildCostIC = ministerCountry:GetBuildCost(self.building):Get()
	local buildModifierIC = buildCostIC / nominalBuildCostIC

	-- TODO: Calculate nominal build time here.
	local nominalBuildTime = 365
	local buildTime = nominalBuildTime * buildModifierIC

	local result = ResourceContainer:new()

	result:setIC(buildCostIC)
	result:setICdays(buildCostIC * buildTime)

	return result
end
