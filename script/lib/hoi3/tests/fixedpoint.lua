--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.fixedpoint", package.seeall, lunit.testcase )

require("hoi3.api.CFixedPoint")

function test1()
	local objFP = hoi3.api.CFixedPoint(1)
	
	assert_equal(1,objFP:Get())
	assert_equal(1,objFP:GetTruncated())
end

function test2()
	local objFP = hoi3.api.CFixedPoint(1.456)
	
	assert_equal(1.456,objFP:Get())
	assert_equal(1,objFP:GetTruncated())
end

function test3()
	local objFP = hoi3.api.CFixedPoint(1.84556)
	
	assert_equal(1.84556,objFP:Get())
	assert_equal(1,objFP:GetTruncated())
end