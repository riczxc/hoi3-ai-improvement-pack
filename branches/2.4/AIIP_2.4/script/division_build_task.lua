require 'aiip'
require 'task'
require 'unit_build_task'

DivisionBuildTask = class('DivisionBuildTask', Task)

DivisionBuildTask:getter('units')

function DivisionBuildTask:initialize(name, gov, units)
	super.initialize(self, name, gov, Department.PROD)

	self.units = {}
	for _, unit in ipairs(units) do
		if type(unit) == 'string' then
			table.insert(self.units, CSubUnitDataBase.GetSubUnit(unit))
		else
			table.insert(self.units, unit)
		end
	end
end

function DivisionBuildTask:_isExecutable()
	local minister = self:getMinister()
	local techStatus = minister:GetCountry():GetTechnologyStatus()

	local result = true
	for _, unit in ipairs(self.units) do
		result = result and techStatus:IsUnitAvailable(self.unit)
	end

	return result
end

function DivisionBuildTask:_execute()
	local minister = self:getMinister()
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()
	local capitalProvId = ministerCountry:GetActingCapitalLocation():GetProvinceID()

	local orderlist = SubUnitList()
	for _, unit in ipairs(self.units) do
		SubUnitList.Append(orderlist, unit)
	end

	local command = CConstructUnitCommand(ministerTag, orderlist, capitalProvId, 1, false, CNullTag(), CID())
	ai:Post(command)
	return true
end

function DivisionBuildTask:_isRunning()
	return false
end

function DivisionBuildTask:_resourceUse()
	local minister = self:getMinister()
	local result = ResourceContainer:new()

	for _, unit in ipairs(self.units) do
		result:add(UnitBuildTask.ResourceUse(minister, unit))
	end

	return result
end
