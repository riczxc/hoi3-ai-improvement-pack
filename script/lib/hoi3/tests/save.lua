--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.save", package.seeall, lunit.testcase )

require("hoi3")

local obj = nil

function setup()
 	obj = hoi3.Hoi3Object:subclass("test.object")
	function obj:myFunctionWithoutParam()
		return self:loadResultOrFakeOrRandom(
  	 		'string', 
			"myFunctionWithoutParam"
		)
  	end
  	
  	function obj:myFunctionWithParam(a,b)
		return self:loadResultOrFakeOrRandom(
  	 		'string', 
			"myFunctionWithParam",
			a,
			b
		)
  	end
  	
  	obj.myStaticFunctionWithoutParam = function()
		return obj.loadResultOrFakeOrRandom(
			obj,
  	 		'string', 
			"myStaticFunctionWithoutParam"
		)
  	end
  	
  	obj.myStaticFunctionWithParam = function(a, b)
		return obj.loadResultOrFakeOrRandom(
			obj,
  	 		'string', 
			"myStaticFunctionWithParam",
			a,
			b
		)
  	end
  	
  	function obj:myFakableFunction()
		return self:loadResultOrFakeOrRandom(
  	 		'string', 
			"myFakableFunction"
		)
  	end
  	
  	function obj:myFakableFunctionFake()
		return "FakedValue"
  	end
end

function teardown()
  obj = nil
end

function testSavedWithoutParam()
	local myObj = obj()
	local myResult = "abcdefgh"

	myObj:saveResult(myResult,obj.myFunctionWithoutParam)
	assert_equal(myResult,myObj:myFunctionWithoutParam())
	assert_equal(myResult,myObj:myFunctionWithoutParam())
end

function testSavedStaticWithoutParam()
  	local myObj = obj()
	local myResult = "ijklmnop"

	obj.saveResult(obj, myResult,obj.myStaticFunctionWithoutParam)
	assert_equal(myResult,obj.myStaticFunctionWithoutParam())
	assert_equal(myResult,obj.myStaticFunctionWithoutParam())
end

function testSavedWithParam()
	local myObj = obj()
	local myResult = "qrstuvw"

	myObj:saveResult(myResult,obj.myFunctionWithParam, 1, "a")
	assert_equal(myResult,myObj:myFunctionWithParam(1, "a"))
	assert_equal(myResult,myObj:myFunctionWithParam(1, "a"))
end

function testSavedStaticWithoutParam()
  	local myObj = obj()
	local myResult = "xyz1234"

	obj.saveResult(obj, myResult,obj.myStaticFunctionWithParam, "xyz", 23)
	assert_equal(myResult,obj.myStaticFunctionWithParam("xyz", 23))
	assert_equal(myResult,obj.myStaticFunctionWithParam("xyz", 23))
end

function testRandomWithoutParam()
	local myObj = obj()
	
	assert_equal(myObj:myFunctionWithoutParam(),myObj:myFunctionWithoutParam())
	assert_equal(myObj:myFunctionWithoutParam(),myObj:myFunctionWithoutParam())
end

function testRandomStaticWithoutParam()
  	local myObj = obj()
	
	assert_equal(obj.myStaticFunctionWithoutParam(),obj.myStaticFunctionWithoutParam())
	assert_equal(obj.myStaticFunctionWithoutParam(),obj.myStaticFunctionWithoutParam())
end

function testRandomWithParam()
	local myObj = obj()
	local param1 = 3.14
	local param2 = "abd"
	
	assert_string(myObj:myFunctionWithParam(param1, param2))
	assert_equal(myObj:myFunctionWithParam(param1, param2),myObj:myFunctionWithParam(param1, param2))
	assert_equal(myObj:myFunctionWithParam(param1, param2),myObj:myFunctionWithParam(param1, param2))
end

function testSavedStaticWithoutParam()
  	local myObj = obj()
	local param1 = true
	local param2 = 23
	
	assert_string(obj.myStaticFunctionWithParam(param1, param2))
	assert_equal(obj.myStaticFunctionWithParam(param1, param2),obj.myStaticFunctionWithParam(param1, param2))
	assert_equal(obj.myStaticFunctionWithParam(param1, param2),obj.myStaticFunctionWithParam(param1, param2))
end

function testFakable()
  	local myObj = obj()
		
	assert_string(obj:myFakableFunction())
	assert_equal("FakedValue",obj:myFakableFunction())
end