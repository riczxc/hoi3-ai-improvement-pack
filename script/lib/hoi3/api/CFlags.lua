require('hoi3')

module("hoi3.api", package.seeall)

CFlags = hoi3.Hoi3Object:subclass('hoi3.CFlags')

---
-- @since 1.3
-- @param string key
-- @return bool
function CFlags:IsFlagSet(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	hoi3.throwNotYetImplemented()
end