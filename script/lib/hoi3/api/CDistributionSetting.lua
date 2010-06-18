require('hoi3.Hoi3Object')

CDistributionSettingObject = Hoi3Object:subclass('hoi3.CDistributionSetting')

---
-- @since 1.3
-- @return CFixedPoint
function CDistributionSettingObject:GetNeeded()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDistributionSettingObject:GetPercentage(...)
	Hoi3Object.throwUnknownSignature()
end


CDistributionSettingObject._LEADERSHIP_DIPLOMACY_ = 1
CDistributionSettingObject._LEADERSHIP_ESPIONAGE_ = 2
CDistributionSettingObject._LEADERSHIP_NCO_ = 3
CDistributionSettingObject._LEADERSHIP_numof_ = 4
CDistributionSettingObject._LEADERSHIP_RESEARCH_ = 5
CDistributionSettingObject._PRODUCTION_CONSUMER_ = 6
CDistributionSettingObject._PRODUCTION_numof_ = 7
CDistributionSettingObject._PRODUCTION_PRODUCTION_ = 8
CDistributionSettingObject._PRODUCTION_REINFORCEMENT_ = 9
CDistributionSettingObject._PRODUCTION_SUPPLY_ = 10
CDistributionSettingObject._PRODUCTION_UPGRADE_ = 11

-- CDistributionSetting has static methods and properties
-- we need to declare a CDistributionSetting table
CDistributionSetting = CDistributionSettingObject