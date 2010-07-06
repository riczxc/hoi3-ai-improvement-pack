--[[
	HOI3OBJECT test case
]]
module( "hoi3.tests.type", package.seeall, lunit.testcase )

require("hoi3")
require("hoi3.api")

local myClass

function setup()
  	-- A Hoi3Object must be defined inside hoi3.api to benefit
  	-- from datatesting based on name (as string)
  	myClass = hoi3.Hoi3Object:subclass("test.object")
end

function testBoolean()
	assert_true(hoi3.testType(true, hoi3.TYPE_BOOLEAN))
	assert_true(hoi3.testType(false, hoi3.TYPE_BOOLEAN))
	assert_false(hoi3.testType(hoi3.TYPE_STRING, hoi3.TYPE_BOOLEAN))
	assert_false(hoi3.testType(1, hoi3.TYPE_BOOLEAN))
	assert_false(hoi3.testType({}, hoi3.TYPE_BOOLEAN))
end

function testString()
	assert_true(hoi3.testType('a', hoi3.TYPE_STRING))
	assert_true(hoi3.testType('', hoi3.TYPE_STRING))
	assert_false(hoi3.testType(true, hoi3.TYPE_STRING))
	assert_false(hoi3.testType(1, hoi3.TYPE_STRING))
	assert_false(hoi3.testType({}, hoi3.TYPE_STRING))
end

function testNumber()
	assert_true(hoi3.testType(0, hoi3.TYPE_NUMBER))
	assert_true(hoi3.testType(-120, hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType("e", hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType(true, hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType({}, hoi3.TYPE_NUMBER))
end

function testObject()
	assert_true(hoi3.testType(myClass(), 'Object'))
	assert_true(hoi3.testType(myClass(), 'Hoi3Object'))
	
	assert_true(hoi3.testType(hoi3.api.CNullTag(), 'Object'))
	assert_true(hoi3.testType(hoi3.api.CNullTag(), 'Hoi3Object'))
	assert_true(hoi3.testType(hoi3.api.CNullTag(), 'CNullTag'))
	assert_true(hoi3.testType(hoi3.api.CNullTag:new(), 'CNullTag'))
end

function testBasicIterator()
	local table = {1,2,3,4}
	
	assert_true(hoi3.testType(table, 'table<number>'))
	assert_false(hoi3.testType(table, hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType(table, 'table<Object>'))
	assert_false(hoi3.testType(table, 'table<string>'))
end

function testObjectIterator()
	local table = {
		hoi3.api.CNullTag(),
		hoi3.api.CNullTag:new(),
		hoi3.api.CNullTag:new(),
		hoi3.api.CNullTag()
	}
	
	assert_true(hoi3.testType(table, 'table<CNullTag>'))
	assert_true(hoi3.testType(table, 'table<Object>'))
	assert_false(hoi3.testType(table, 'table<NothingButRealObject>'))
	assert_false(hoi3.testType(table, hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType(table, 'table<string>'))
end