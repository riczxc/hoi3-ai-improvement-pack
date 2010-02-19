--[[
    Copyright (C) 2010 Guillaume Boddaert

	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or
	sell copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
	OR OTHER DEALINGS IN THE SOFTWARE.
--]]

--- HOI3 devtools initializer<br>
--
--
-- @author Guibod <guibod@users.sf.net>
-- @release $Date$ $Rev$

-- A simple script to enable and load Devtools

-- Devtools relies on lua modules
-- we need to specify an absolute path for our "devtools" directory
--
-- Lua configuration for HOI3 provides <HOI3_INSTALL_DIR>\lua directory
-- we can't use it without the need for a mod to install files out of mod directory...

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
	mod_package_path = "C:\\Documents and Settings\\GUBO\\AIIPDEV\\1.3\\AIIP_1.3\\script\\lib"
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
