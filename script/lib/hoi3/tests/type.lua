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
  	hoi3.api.myClass = hoi3.Hoi3Object:subclass("test.object")
  	myClass = hoi3.api.myClass 
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
	assert_true(hoi3.testType(myClass(), 'myClass'))
	assert_true(hoi3.testType(myClass:new(), 'myClass'))
end

function testBasicIterator()
	local table = {1,2,3,4}
	
	assert_true(hoi3.testType(table, 'table<number>'))
	assert_false(hoi3.testType(table, hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType(table, 'table<Object>'))
	assert_false(hoi3.testType(table, 'table<string>'))
end

function testObjectIterator()
	local table = {myClass(),myClass:new(),myClass:new(),myClass()}
	
	assert_true(hoi3.testType(table, 'table<myClass>'))
	assert_true(hoi3.testType(table, 'table<Object>'))
	assert_false(hoi3.testType(table, 'table<NothingButRealObject>'))
	assert_false(hoi3.testType(table, hoi3.TYPE_NUMBER))
	assert_false(hoi3.testType(table, 'table<string>'))
end