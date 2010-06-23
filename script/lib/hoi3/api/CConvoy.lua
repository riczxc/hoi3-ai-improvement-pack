require('hoi3')

module("hoi3.api", package.seeall)

CConvoy = hoi3.Hoi3Object:subclass('hoi3.CConvoy')

---
-- @since 1.3
-- @return unknown 
function CConvoy:GetDesiredEscorts(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CConvoy:GetDesiredTransports(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CConvoy:GetEfficiency(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CConvoy:IsForTradeRoute(...)
	hoi3.throwUnknownSignature()
end
