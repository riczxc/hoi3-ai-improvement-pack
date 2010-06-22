--[[
	HOI3OBJECT test case
]]
module( "hoi3.tests.type", package.seeall, lunit.testcase )

require("hoi3.Hoi3Object")

function setup()
  local myClass = Hoi3Object:subclass("test.object")
  _G["myClass"] = myClass
end

function testBoolean()
	assert_true(Hoi3Object.testType(true, 'boolean'))
	assert_true(Hoi3Object.testType(false, 'boolean'))
	assert_false(Hoi3Object.testType('string', 'boolean'))
	assert_false(Hoi3Object.testType(1, 'boolean'))
	assert_false(Hoi3Object.testType({}, 'boolean'))
end

function testString()
	assert_true(Hoi3Object.testType('a', 'string'))
	assert_true(Hoi3Object.testType('', 'string'))
	assert_false(Hoi3Object.testType(true, 'string'))
	assert_false(Hoi3Object.testType(1, 'string'))
	assert_false(Hoi3Object.testType({}, 'string'))
end

function testNumber()
	assert_true(Hoi3Object.testType(0, 'number'))
	assert_true(Hoi3Object.testType(-120, 'number'))
	assert_false(Hoi3Object.testType("e", 'number'))
	assert_false(Hoi3Object.testType(true, 'number'))
	assert_false(Hoi3Object.testType({}, 'number'))
end

function testHoiObject()
	assert_true(Hoi3Object.testType(myClass(), 'Object'))
	assert_true(Hoi3Object.testType(myClass(), 'myClass'))
	assert_true(Hoi3Object.testType(myClass:new(), 'myClass'))
end

function testBasicIterator()
	local iterator = {1,2,3,4}
	
	assert_true(Hoi3Object.testType(iterator, 'table<number>'))
	assert_false(Hoi3Object.testType(iterator, 'number'))
	assert_false(Hoi3Object.testType(iterator, 'table<Object>'))
	assert_false(Hoi3Object.testType(iterator, 'table<string>'))
end

function testObjectIterator()
	local iterator = {myClass(),myClass:new(),myClass:new(),myClass()}
	
	assert_true(Hoi3Object.testType(iterator, 'table<myClass>'))
	assert_true(Hoi3Object.testType(iterator, 'table<Object>'))
	assert_false(Hoi3Object.testType(iterator, 'table<NothingButRealObject>'))
	assert_false(Hoi3Object.testType(iterator, 'number'))
	assert_false(Hoi3Object.testType(iterator, 'table<string>'))
end