require 'aiip'
require 'task'

UnitBuildTask = class('UnitBuildTask', Task)

UnitBuildTask:getter('unit')

function UnitBuildTask:initialize(name, gov, unit)
	super.initialize(self, name, gov, Department.PROD)

	if type(unit) == 'string' then
		unit = CSubUnitDataBase.GetSubUnit(unit)
	end

	self.unit = unit
end

function UnitBuildTask:_isExecutable()
	local minister = self:getMinister()
	return minister:GetCountry():GetTechnologyStatus():IsUnitAvailable(self.unit)
end

function UnitBuildTask:_execute()
	local minister = self:getMinister()
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()
	local capitalProvId = ministerCountry:GetActingCapitalLocation():GetProvinceID()

	local orderlist = SubUnitList()
	SubUnitList.Append(orderlist, self.unit)

	local command = CConstructUnitCommand(ministerTag, orderlist, capitalProvId, 1, false, CNullTag(), CID())
	ai:Post(command)
	return true
end

function UnitBuildTask:_isRunning()
	return false
end

function UnitBuildTask:_resourceUse()
	local minister = self:getMinister()
	return UnitBuildTask.ResourceUse(minister, self.unit)
end

function UnitBuildTask.ResourceUse(minister, unit)
	local ministerCountry = minister:GetCountry()

	local nominalBuildCostIC = 1.0 * unit:GetBuildCostIC()
	local buildCostIC = ministerCountry:GetBuildCostIC(unit, 1, false):Get()
	local buildModifierIC = buildCostIC / nominalBuildCostIC

	local modifierTime = ministerCountry:GetGlobalModifier():GetValue(CModifier._MODIFIER_UNIT_RECRUITMENT_TIME_):Get()
	local nominalBuildTime = 1.0 * unit:GetBuildTime()
	local buildTime = (nominalBuildTime * buildModifierIC) * (1 + modifierTime)

	local buildCostMP = 1.0 * unit:GetBuildCostMP()

	local result = ResourceContainer:new()

	result:setIC(buildCostIC)
	result:setMP(buildCostMP)
	result:setICdays(buildCostIC * buildTime)

	return result
end
