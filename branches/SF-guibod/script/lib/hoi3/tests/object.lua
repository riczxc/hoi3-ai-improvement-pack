--[[
	Save/Load HOI3OBJECT test case
]]
module( "hoi3.tests.object", package.seeall, lunit.testcase )

require("hoi3")

local obj = nil

function setup()
 	obj = hoi3.Hoi3Object:subclass("test.object")
 	obj.testInstance = hoi3.f(obj, 'testInstance', false, hoi3.TYPE_STRING, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)
 	obj.testStatic = hoi3.f(obj, 'testStatic', true, hoi3.TYPE_STRING, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

 	function obj:initialize(str)
 		self.string = str
 	end
 	
 	function obj:testInstanceImpl(x,y)
		hoi3.assertNonStatic(self)
		return self.string.sub(x,y)
	end
	
	function obj.testStaticImpl(x,y)
		hoi3.assertNonStatic(self)
		local r = hoi3.Randomizer(hoi3.TYPE_STRING)
		local ret = ""
		r.len = x
		for i=0,i<y do
			ret = ret..r.compute()
		end
		return ret
	end
end

function teardown()
  obj = nil
end

function testFunctionObject()
	local myObj = obj("niekniekniek")
	assert_string(obj:testInstance(4,5))
	assert_equal('kn', obj:testInstance(4,5))
	
	assert_string(obj.testStatic(4,5))
	assert_equal(20, string.len(obj.testStatic(4,5)))
end