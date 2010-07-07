--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.save", package.seeall, lunit.testcase )

require("hoi3")

local obj = nil

function setup()
 	objClass = hoi3.Hoi3Object:subclass("test.object")
	function objClass:initialize(x)
		self.x = x
	end
	
	hoi3.FunctionObject(objClass, 'myFunctionWithoutParam', false, hoi3.TYPE_STRING)
 	hoi3.FunctionObject(objClass, 'myFunctionWithParam', false, hoi3.TYPE_STRING, hoi3.TYPE_NUMBER, hoi3.TYPE_STRING)
 	--hoi3.f and hoi3.fs are synonyms for hoi3.FunctionObject
 	hoi3.fs(objClass, 'myStaticFunctionWithoutParam', hoi3.TYPE_STRING)
 	hoi3.fs(objClass, 'myStaticFunctionWithParam', hoi3.TYPE_STRING, hoi3.TYPE_STRING, hoi3.TYPE_NUMBER)
	hoi3.f(objClass, 'myImplableFunction', hoi3.TYPE_STRING)
	hoi3.fs(objClass, 'myStaticImplableFunction', hoi3.TYPE_STRING)

  	function objClass:myImplableFunctionImpl()
		return tostring(self.x).."Impl"
  	end
  	
  	function objClass:myStaticImplableFunctionImpl()
		return "ImpldValue"
  	end
end

function teardown()
  objClass = nil
end

function testSavedWithoutParam()
	local myObj = objClass("x")
	local myResult = "abcdefgh"

	objClass.myFunctionWithoutParam:save(myResult, myObj)
	assert_equal(myResult,myObj:myFunctionWithoutParam())
	assert_equal(myResult,myObj:myFunctionWithoutParam())
end

function testSavedStaticWithoutParam()
	local myResult = "ijklmnop"

	--[[
	no more static save support atm.
	objClass.myStaticFunctionWithoutParam:save(myResult)
	assert_equal(myResult,objClass.myStaticFunctionWithoutParam())
	assert_equal(myResult,objClass.myStaticFunctionWithoutParam())

	objClass.myStaticFunctionWithoutParam:save(5)
	assert_equal(5,objClass.myStaticFunctionWithoutParam())
	assert_equal(5,objClass.myStaticFunctionWithoutParam())
	]]
end

function testSavedWithParam()
	local myObj = objClass("x")
	local myResult = "qrstuvw"

	objClass.myFunctionWithParam:save(myResult, myObj, 1, "a")
	assert_equal(myResult,myObj:myFunctionWithParam(1, "a"))
	assert_equal(myResult,myObj:myFunctionWithParam(1, "a"))
end

function testSavedStaticWithoutParam()
  	local myObj = objClass("x")
	local myResult = "xyz1234"

	objClass.myStaticFunctionWithParam:save(myResult, "xyz", 23)
	assert_equal(myResult,objClass.myStaticFunctionWithParam("xyz", 23))
	assert_equal(myResult,objClass.myStaticFunctionWithParam("xyz", 23))
end

function testRandomWithoutParam()
	local myObj = objClass("x")
	
	--No more static save() support atm
	--assert_equal(myObj:myFunctionWithoutParam(),myObj:myFunctionWithoutParam())
	--assert_equal(myObj:myFunctionWithoutParam(),myObj:myFunctionWithoutParam())
end

function testRandomStaticWithoutParam()
  	assert_equal(objClass.myStaticFunctionWithoutParam(),objClass.myStaticFunctionWithoutParam())
	assert_equal(objClass.myStaticFunctionWithoutParam(),objClass.myStaticFunctionWithoutParam())
end

function testRandomWithParam()
	local myObj = objClass("x")
	local param1 = 3.14
	local param2 = "abd"
	
	assert_string(myObj:myFunctionWithParam(param1, param2))
	assert_equal(myObj:myFunctionWithParam(param1, param2),myObj:myFunctionWithParam(param1, param2))
	assert_equal(myObj:myFunctionWithParam(param1, param2),myObj:myFunctionWithParam(param1, param2))
end

function testSavedStaticWithoutParam()
	local param1 = "mystring"
	local param2 = 23
	
	assert_string(objClass.myStaticFunctionWithParam(param1, param2))
	assert_equal(objClass.myStaticFunctionWithParam(param1, param2),objClass.myStaticFunctionWithParam(param1, param2))
	assert_equal(objClass.myStaticFunctionWithParam(param1, param2),objClass.myStaticFunctionWithParam(param1, param2))
end

function testImplable()
  	local myObj = objClass("x")
		
	assert_string(myObj:myImplableFunction())
	assert_equal("xImpl",myObj:myImplableFunction())
end

function testStaticImplable()
  	assert_string(objClass.myStaticImplableFunction())
	assert_equal("ImpldValue",objClass.myStaticImplableFunction())
end