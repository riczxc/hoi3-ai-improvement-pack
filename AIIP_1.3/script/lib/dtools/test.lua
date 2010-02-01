--[[
   Copyright (C) 2010 Guillaume Boddaert

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--]]

--- HOI3 devtools.test package<br>
--
--
-- @author Guibod <guibod@users.sf.net>
-- @release $Date$ $Rev$

module("dtools.test", package.seeall)

-- Class definition
local Test = {}
Test.__index = Test

local _module = Test

local dtools = require('dtools')

function _module.run()
	_module.log()
	_module.harvest()
end

function _module.log()
	dtools.debug('Debug message')
	dtools.info('Info message')
	dtools.warn('Warn message')
	dtools.error('Error message')
	dtools.fatal('Fatal message')
end

function _module.harvest()
	local start, duration

	-- Try to insert 10000 lines without transaction
	start = os.time()
	for var=1,10000,1 do
		dtools.harvest('test_notrans', { integer=math.random(0,1000), real=math.random()*1000, text= string.char(math.random(50,100),math.random(50,100),math.random(50,100)) })
    end
	duration = os.difftime(os.time(), start)
	dtools.info('10000 insertion without transaction : '..tostring(duration))

	-- Try to insert 10000 lines with transaction
	start = os.time()
	for var=1,10000,1 do
		dtools.harvest('test_withtrans', { integer=math.random(0,1000), real=math.random()*1000, text= string.char(math.random(50,100),math.random(50,100),math.random(50,100)) }, false)
    end
	dtools.harvest('test_withtrans', nil, true)
	duration = os.difftime(os.time(), start)
	dtools.info('10000 insertion with transaction : '..tostring(duration))
end

return _module
