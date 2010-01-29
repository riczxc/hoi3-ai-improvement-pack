-- A simple script to enable and load Devtools

-- Devtools relies on lua modules
-- we need to specify an absolute path for our "devtools" directory
--
-- Lua configuration for HOI3 provides <HOI3_INSTALL_DIR>\lua directory
-- we can't use it without the need for a mod to install files out of mod directory...

local dtools
local mod_package_path
local hoi3path
-- check for user mod files
if CAI ~= nil and CAI.HasUserExtension() then
	local modDir = tostring(CAI.GetModDirectory())

	-- Extract HOI3 path from package.path
	_,_,hoi3path = package.path:find(';([^;]-)\\lua[^;]-\\init\.lua;')
	mod_package_path = hoi3path..'\\'..tostring(CAI.GetModDirectory())..'\\lib'

	-- End of Devtools specific content
else
	-- This is a code to support run from pure lua in SciTE editor
	-- You may need to update the value to fit your file location
	mod_package_path = "C:\\Documents and Settings\\GUBO\\hoi3\\mod\\AIIP_1.3\\script\\lib"
end

package.path = package.path:gsub('lua\\%?\\init.lua;', 'lua\\%?\\init.lua;'..mod_package_path.."\\%?.lua;"..mod_package_path.."\\%?\\init.lua;", 1)

-- We also rely on binary DLL (sqlite support)
package.cpath = package.cpath .. ";" .. mod_package_path.."\\?.dll"

-- Load dtools as a package
dtools = require('dtools')

-- Read log4lua conf from mod directory
if CAI ~= nil and CAI.HasUserExtension() then
	dtools.loadConfig(hoi3path..'\\'..tostring(CAI.GetModDirectory())..'\\log4lua.conf.lua')
end

-- First debug output
dtools.debug("Devtools loaded...")

return dtools
