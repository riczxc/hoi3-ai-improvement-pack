--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.multiton", package.seeall, lunit.testcase )

require("hoi3.MultitonObject")

local obj = nil

function setup()
 	obj = MultitonObject:subclass("test.multiton")
end

function teardown()
  obj = nil
end

function test1()
	obj1 = obj("A")
	obj2 = obj("A")
	
	assert_equal(obj1,obj2)
end