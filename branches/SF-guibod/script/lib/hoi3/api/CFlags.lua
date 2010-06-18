require('hoi3.Hoi3Object')

CFlagsObject = Hoi3Object:subclass('hoi3.CFlagsObject')

---
-- @since 1.3
-- @param string key
-- @return bool
function CFlagsObject:IsFlagSet(key)
	Hoi3Object.assertParameterType(1, key, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end
