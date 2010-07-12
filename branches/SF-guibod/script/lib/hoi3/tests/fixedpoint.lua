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

function test4()
	local objFP = hoi3.api.CFixedPoint(32)
	local objFP2 = hoi3.api.CFixedPoint(32)
	
	assert_equal(32*2,objFP*2)
	assert_equal(32/2,objFP/2)
	assert_equal(32+2,objFP+2)
	assert_equal(32-2,objFP-2)
	assert_equal(objFP,objFP2)
end

function test5()
	local obj = hoi3.api.CString("abced")
	local obj2 = hoi3.api.CString("abced")
	
	assert_equal(tostring(obj),"abced")
	assert_not_equal(obj,"abced")
	assert_equal(obj,obj2)
end