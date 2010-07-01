require('hoi3')

module("hoi3.api", package.seeall)

CDistributionSetting = hoi3.Hoi3Object:subclass('hoi3.CDistributionSetting')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CDistributionSetting, 'GetNeeded', false, 'CFixedPoint')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CDistributionSetting, 'GetPercentage', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

CDistributionSetting._LEADERSHIP_DIPLOMACY_ = 1
CDistributionSetting._LEADERSHIP_ESPIONAGE_ = 2
CDistributionSetting._LEADERSHIP_NCO_ = 3
CDistributionSetting._LEADERSHIP_numof_ = 4
CDistributionSetting._LEADERSHIP_RESEARCH_ = 5
CDistributionSetting._PRODUCTION_CONSUMER_ = 1
CDistributionSetting._PRODUCTION_numof_ = 5
CDistributionSetting._PRODUCTION_PRODUCTION_ = 2
CDistributionSetting._PRODUCTION_REINFORCEMENT_ = 3
CDistributionSetting._PRODUCTION_SUPPLY_ = 4
CDistributionSetting._PRODUCTION_UPGRADE_ = 0

function CDistributionSetting:random()
	return CDistributionSetting()
end