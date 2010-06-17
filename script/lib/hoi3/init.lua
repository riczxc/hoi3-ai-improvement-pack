--[[
	HOI3 fake API
	
	It is sometimes difficult to code pure LUA features for HOI3
	This package provide basic support for a fake game instance.

	All values returned fully random atm. 
]]


-- Now declare all HOI3 API objects
require('hoi3.api.CAI')
require('hoi3.api.CAIAgent')
require('hoi3.api.CAIEspionageMinister')
require('hoi3.api.CAIForeignMinister')
require('hoi3.api.CAlignment')
require('hoi3.api.CAllianceAction')
require('hoi3.api.CGoodsPool')
