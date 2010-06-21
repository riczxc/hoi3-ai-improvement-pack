require('hoi3.Hoi3Object')

CFlags = Hoi3Object:subclass('hoi3.CFlags')

---
-- @since 1.3
-- @param string key
-- @return bool
function CFlags:IsFlagSet(key)
	Hoi3Object.assertParameterType(1, key, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end
