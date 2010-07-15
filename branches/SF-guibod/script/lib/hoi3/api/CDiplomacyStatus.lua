require('hoi3')

module("hoi3.api", package.seeall)

CDiplomacyStatus = hoi3.MultitonObject:subclass('hoi3.api.CDiplomacyStatus')

-- Multiton pattern for this object use 2 keys
CDiplomacyStatus.numkeys = 2

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag target
-- @return CDiplomacyStatus
function CDiplomacyStatus:initialize(actor, target)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	
	self.actor = actor
	self.target = target
end

---
-- @since 1.3
-- @return bool 
hoi3.f(CDiplomacyStatus, 'AllowDebts', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CDiplomacyStatus, 'GetTarget', 'CCountryTag')

function CDiplomacyStatus:GetTarget()
	return self.target 
end

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CDiplomacyStatus, 'GetThreat', 'CFixedPoint')

---
-- @since 1.3
-- @return iterator<CTradeRoute>
hoi3.f(CDiplomacyStatus, 'GetTradeRoutes', 'iterator<CTradeRoute>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CDiplomacyStatus, 'GetValue', 'CFixedPoint')

---
-- @since 2.0
-- @return number
hoi3.f(CDiplomacyStatus, 'GetFloatValue', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CWar
hoi3.f(CDiplomacyStatus, 'GetWar', 'CWar')

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasAlliance', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasAnyAgreement', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasEmbargo', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasFriendlyAgreement', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasHostileAgreement', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasMilitaryAccess', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasNap', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasTruce', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasWar', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsBeingInfluenced', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsFightingWarTogether', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsGuaranteed', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsGuaranting', hoi3.TYPE_BOOLEAN)

function CDiplomacyStatus.random()
	hoi3.error("There cannot be randomizer for DiploStatus sine it relies on two deterministic parameters")
end

function CDiplomacyStatus.userdataToInstance(myClass, userdata, parent)
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	if userdata.GetTarget == nil and type(userdata.GetTarget) ~= hoi3.TYPE_FUNCTION then
		hoi3.error("Bad signature for userdata, didn't match CDiplomacyStatus.userdataToInstance() !")
		return
	end

	hoi3.assert(parent ~= nil and 
		type(parent) == hoi3.TYPE_TABLE and 
		middleclass.instanceOf(hoi3.api.CCountry, parent),
		"CDiplomacyStatus.userdataToInstance needs _parent property to be set on a valid CCountry instance.")
		
	local source = parent:GetCountryTag()
		
	if userdata:GetTarget():GetTag() == nil then
		target = hoi3.api.CNullTag()
	else
		target = hoi3.api.CCountryTag:userdataToInstance(userdata:GetTarget())
	end
	local myInstance = hoi3.api.CDiplomacyStatus(
		source,
		target
	)
	myInstance.__userdata = userdata
	return myInstance
end