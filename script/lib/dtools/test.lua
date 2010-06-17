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

--- HOI3 dtools.test package<br>
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
