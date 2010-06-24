--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.abstract", package.seeall, lunit.testcase )

require("hoi3.AbstractObject")

function testDate()
	local d = CDate.random()
	assert_number(d:GetDayOfMonth())
	assert_true(d:GetDayOfMonth() >= 1)
	assert_true(d:GetDayOfMonth() <= 31)
	
	assert_number(d:GetMonthOfYear())
	assert_true(d:GetMonthOfYear() >= 1)
	assert_true(d:GetMonthOfYear() <= 12)
	
	assert_number(d:GetYear())
	assert_true(d:GetYear() >= 1936)
	assert_true(d:GetYear() <= 1948)
	
	assert_number(d:GetTotalDays())
	assert_true(d:GetTotalDays() >= 0)
	
	d:AddDays(d:GetTotalDays()*(-1))
	assert_equal(0, d:GetTotalDays())
end