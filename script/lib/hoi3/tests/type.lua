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
	assert_true(hoi3.testType(true, 'boolean'))
	assert_true(hoi3.testType(false, 'boolean'))
	assert_false(hoi3.testType('string', 'boolean'))
	assert_false(hoi3.testType(1, 'boolean'))
	assert_false(hoi3.testType({}, 'boolean'))
end

function testString()
	assert_true(hoi3.testType('a', 'string'))
	assert_true(hoi3.testType('', 'string'))
	assert_false(hoi3.testType(true, 'string'))
	assert_false(hoi3.testType(1, 'string'))
	assert_false(hoi3.testType({}, 'string'))
end

function testNumber()
	assert_true(hoi3.testType(0, 'number'))
	assert_true(hoi3.testType(-120, 'number'))
	assert_false(hoi3.testType("e", 'number'))
	assert_false(hoi3.testType(true, 'number'))
	assert_false(hoi3.testType({}, 'number'))
end

function testObject()
	assert_true(hoi3.testType(myClass(), 'Object'))
	assert_true(hoi3.testType(myClass(), 'Hoi3Object'))
	assert_true(hoi3.testType(myClass(), 'myClass'))
	assert_true(hoi3.testType(myClass:new(), 'myClass'))
end

function testBasicIterator()
	local iterator = {1,2,3,4}
	
	assert_true(hoi3.testType(iterator, 'table<number>'))
	assert_false(hoi3.testType(iterator, 'number'))
	assert_false(hoi3.testType(iterator, 'table<Object>'))
	assert_false(hoi3.testType(iterator, 'table<string>'))
end

function testObjectIterator()
	local iterator = {myClass(),myClass:new(),myClass:new(),myClass()}
	
	assert_true(hoi3.testType(iterator, 'table<myClass>'))
	assert_true(hoi3.testType(iterator, 'table<Object>'))
	assert_false(hoi3.testType(iterator, 'table<NothingButRealObject>'))
	assert_false(hoi3.testType(iterator, 'number'))
	assert_false(hoi3.testType(iterator, 'table<string>'))
end