--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.random", package.seeall, lunit.testcase )

require("hoi3")

local obj = nil

function setup()
 	obj = hoi3.Hoi3Object:subclass("test.random")
	-- Function with no save result and no Impl fallback
	function obj:myRandFunctionUsingString()
		return self:loadResultOrImplOrRandom(
  	 		hoi3.TYPE_STRING, 
			"myRandFunctionUsingString"
		)
  	end
  	
  	-- Function with no save result and no Impl fallback
  	-- returns a not so random value from randomizer configuration
  	-- expect 2656 as return
  	function obj:myRandFunctionUsingRandomizer()
		local r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
		r.min = 2656
		r.max = 2656
		
		return self:loadResultOrImplOrRandom(
  	 		r, 
			"myRandFunctionUsingRandomizer"
		)
  	end
end

function teardown()
  obj = nil
end

function testNumber()
	local r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
	
	assert_number(r:compute())
	
	r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
	r.min = 2
	r.max = 2
	
	assert_equal(2,r:compute())	
end

function testString()
	local r = hoi3.Randomizer(hoi3.TYPE_STRING)
	
	assert_string(r:compute())
	-- default len is 10
	assert_equal(10,string.len(r:compute()))
	
	r = hoi3.Randomizer(hoi3.TYPE_STRING)
	r.len = 3
	assert_equal(r.len,string.len(r:compute()))
	r.len = 21
	assert_equal(r.len,string.len(r:compute()))
end

function testBoolean()
	local r = hoi3.Randomizer(hoi3.TYPE_BOOLEAN)
	
	assert_boolean(r:compute())
		
	r = hoi3.Randomizer(hoi3.TYPE_BOOLEAN)
	r.perc = 100
	assert_true(r:compute())
	r.perc = 0
	assert_false(r:compute())
end

function testTable()
	local r = hoi3.Randomizer(hoi3.TYPE_TABLE)
	local iterator = r:compute()
	
	assert_table(iterator)
	assert_true(#iterator > 0)
	for k,v in pairs(iterator) do
		assert_number(v)
	end
end

function testIterator()	
	local r = hoi3.Randomizer('table<string>')
	local iterator = r:compute()
	
	assert_table(iterator)
	assert_true(#iterator > 0)
	for k,v in pairs(iterator) do
		assert_string(v)
	end
end

function testConfiguredIterator()
	local r = hoi3.Randomizer(hoi3.TYPE_TABLE)
	r.subtype = hoi3.Randomizer(hoi3.TYPE_STRING)
	r.subtype.len = 35
	
	local iterator = r:compute()
	
	assert_table(iterator)
	assert_true(#iterator > 0)
	for k,v in pairs(iterator) do
		assert_string(v)
		assert_equal(35,string.len(v))
	end
end

function testRandomValueThroughSave()
	local o = obj()
	
	assert_string(obj:myRandFunctionUsingString())
	assert_equal(2656,obj:myRandFunctionUsingRandomizer())
end