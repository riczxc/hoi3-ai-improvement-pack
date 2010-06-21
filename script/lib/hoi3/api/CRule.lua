require('hoi3.Hoi3Object')

CRuleObject = Hoi3Object:subclass('hoi3.CRule')

CRuleObject._RULE_ALLIANCE_GUARANTEE_	= 1
CRuleObject._RULE_FREE_RESOURCE_GIFTS_	= 2
CRuleObject._RULE_LIMITED_WAR_	= 3
CRuleObject._RULE_NONE_	= 4

-- CRule has static methods and properties
-- we need to declare a CRule table
CRule = CRuleObject