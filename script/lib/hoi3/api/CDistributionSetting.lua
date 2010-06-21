require('hoi3.Hoi3Object')

CDistributionSetting = Hoi3Object:subclass('hoi3.CDistributionSetting')

---
-- @since 1.3
-- @return CFixedPoint
function CDistributionSetting:GetNeeded()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDistributionSetting:GetPercentage(...)
	Hoi3Object.throwUnknownSignature()
end


CDistributionSetting._LEADERSHIP_DIPLOMACY_ = 1
CDistributionSetting._LEADERSHIP_ESPIONAGE_ = 2
CDistributionSetting._LEADERSHIP_NCO_ = 3
CDistributionSetting._LEADERSHIP_numof_ = 4
CDistributionSetting._LEADERSHIP_RESEARCH_ = 5
CDistributionSetting._PRODUCTION_CONSUMER_ = 6
CDistributionSetting._PRODUCTION_numof_ = 7
CDistributionSetting._PRODUCTION_PRODUCTION_ = 8
CDistributionSetting._PRODUCTION_REINFORCEMENT_ = 9
CDistributionSetting._PRODUCTION_SUPPLY_ = 10
CDistributionSetting._PRODUCTION_UPGRADE_ = 11