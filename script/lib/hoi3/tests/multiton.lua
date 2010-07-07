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
 	objectC = hoi3.MultitonObject:subclass("test.multitonC")
 	objectC.numkeys = 3 --The first two parameters are considered as keys !
end

function teardown()
  objectA:clearResults()
  objectA:clearInstances()
  objectB:clearResults()
  objectB:clearInstances()
  objectC:clearResults()
  objectC:clearInstances()
  
  objectA = nil
  objectB = nil
  objectC = nil
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

function test5()
	-- Two distinct object type don't shares the same pool
	obj1 = objectC("X","Y","Z")
	obj2 = objectC("X","Y","Z")
	obj3 = objectC("X","Z","Y")
	
	assert_equal(obj1,obj2)
	assert_not_equal(obj1,obj3)
	assert_not_equal(obj2,obj3)
	
	local instances = objectC:getInstances()
	for k, v in pairs(instances) do
		assert(middleclass.instanceOf(objectC, v))
	end
	
	objectC:clearInstances()
	assert_equal(0,#objectC:getInstances())
end