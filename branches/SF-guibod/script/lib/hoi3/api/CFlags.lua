require('hoi3')

module("hoi3.api", package.seeall)

CFlags = hoi3.Hoi3Object:subclass('hoi3.CFlags')

---
-- @since 1.3
-- @param string key
-- @return bool
function CFlags:IsFlagSet(key)
	hoi3.assertParameterType(1, key, 'string')
	
	hoi3.throwNotYetImplemented()
end
