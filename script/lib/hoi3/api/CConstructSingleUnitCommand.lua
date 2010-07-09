require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructSingleUnitCommand = CCommand:subclass('hoi3.api.CConstructSingleUnitCommand')

--There is explicitely NO constructor for this one

function CConstructSingleUnitCommand:desc()
	return "Issued single unit construction. Should not happen 'cause no constructor."
end