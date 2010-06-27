require('hoi3')

module( "hoi3", package.seeall)

FunctionObject = Object:subclass('hoi3.FunctionObject')

function FunctionObject:initialize(class, name, ret, ...)
	self.class	= class
	self.name = name
	self.ret = ret
	self.param = {...}
end

function FunctionObject:__call(...)
	hoi3.assertNonStatic(self)
	
	local myparams = {...}
	
	for i, v in ipairs(self.param) do
		hoi3.assertParameterType(i, myparams[i], v)
	end
	
	return self.class:loadResultOrImplOrRandom(
		self.ret, 
		self.name, 
		...
	)
end