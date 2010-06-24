--[[
	Save/Load HOI3obj1ECT test case
]]
module( "hoi3.tests.multiton", package.seeall, lunit.testcase )

require("hoi3")

local objectA = nil
local objectB = nil

function setup()
 	objectA = hoi3.MultitonObject:subclass("test.multitonA")
 	objectB = hoi3.MultitonObject:subclass("test.multitonB")
end

function teardown()
  objectA = nil
  objectB = nil
end

function test1()
	obj1 = objectA("Y")
	obj2 = objectA("Y")
	
	assert_equal(obj1,obj2)
end

function test2()
	obj1 = objectA:new("X")
	obj2 = objectA("X")
	
	assert_equal(obj1,obj2)
end

function test3()
	-- Requires a key as first parameter
	assert_error(nil,objectA.new)
	--obj1()
	assert_error(nil,getmetatable(objectA).__call)
end

function test4()
	-- Two distinct object type don't shares the same pool
	obj1 = objectA("X")
	obj2 = objectB("X")
	
	assert_not_equal(obj1,obj2)
end