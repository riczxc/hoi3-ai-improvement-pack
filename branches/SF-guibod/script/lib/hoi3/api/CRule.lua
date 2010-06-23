require('hoi3')

module("hoi3.api", package.seeall)

CRule = hoi3.Hoi3Object:subclass('hoi3.CRule')

CRule._RULE_ALLIANCE_GUARANTEE_	= 1
CRule._RULE_FREE_RESOURCE_GIFTS_	= 2
CRule._RULE_LIMITED_WAR_	= 3
CRule._RULE_NONE_	= 4