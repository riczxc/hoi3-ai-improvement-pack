require('hoi3')

module("hoi3.api", package.seeall)

CConvoy = hoi3.Hoi3Object:subclass('hoi3.CConvoy')

---
-- @since 1.3
-- @param unknown
-- @return unknown 
hoi3.f(CConvoy, 'GetDesiredEscorts', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CConvoy, 'GetDesiredTransports', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CConvoy, 'GetEfficiency', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CConvoy, 'IsForTradeRoute', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)