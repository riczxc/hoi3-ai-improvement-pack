require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeLeadershipCommand = CCommand:subclass('hoi3.CChangeLeadershipCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CFixedPoint change1
-- @param CFixedPoint change2
-- @param CFixedPoint change3
-- @param CFixedPoint ...
-- @return CChangeInvestmentCommand
function CChangeLeadershipCommand:initialize(tag, ...)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	for i,v in ipairs({...}) do
		hoi3.assertParameterType(i+1, v, 'CFixedPoint')
	end

	self.tag = tag
	self.changes = {...}
end

function CChangeLeadershipCommand:__tostring()
	local str = "Changed leadership by "..tostring(self.tag).."."
	
	for i,v in ipairs(self.changes) do
		str = str .. " #"..i.."="..v:Get()
	end
	
	return str
end