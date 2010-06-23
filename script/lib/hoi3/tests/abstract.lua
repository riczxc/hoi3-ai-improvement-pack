--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.abstract", package.seeall, lunit.testcase )

require("hoi3.AbstractObject")

local obj = nil

function setup()
 	obj = hoi3.AbstractObject:subclass("test.abstract")
end

function teardown()
  obj = nil
end

function testNoInstance()
	assert_error(nil,obj.new)
	--obj()
	assert_error(nil,getmetatable(obj).__call)
end