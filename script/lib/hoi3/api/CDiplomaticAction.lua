require('hoi3.api.CAction')

module("hoi3.api", package.seeall)

CDiplomaticAction = CAction:subclass('hoi3.api.CDiplomaticAction')

CDiplomaticAction.ACCEPT	= 1
CDiplomaticAction.DECLINE = 2
CDiplomaticAction.PROPOSE	= 3  

---
-- @since 1.3
-- @return number
hoi3.f(CDiplomaticAction, 'GetAIAcceptance', hoi3.RAND_PERC)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CDiplomaticAction, 'GetValue', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CDiplomaticAction, 'GetType', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomaticAction, 'IsValid', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomaticAction, 'IsSelectable', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param bool
-- @return void
hoi3.f(CDiplomaticAction, 'SetValue', hoi3.TYPE_VOID, hoi3.TYPE_BOOLEAN)