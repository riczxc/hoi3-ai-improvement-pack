require('hoi3')

module("hoi3.api", package.seeall)

CEventScope  = hoi3.Hoi3Object:subclass('hoi3.api.CEventScope ')
CEventScope.properties = {
	_Country 	= { "read/write", hoi3.TYPE_UNKNOWN },
	_nProvince 	= { "read/write", hoi3.TYPE_NUMBER }
}

function CEventScope :initialize()
	self._Country = ""
	self._nProvince = ""
end
