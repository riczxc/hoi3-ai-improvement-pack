--[[
	Abstract class

	Prevents a subclass from being instancied.
]]
require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

AbstractObject = Hoi3Object:subclass('hoi3.AbstractObject')

AbstractObject.initialize = function(instance, ...)
  assert(false, "An abstract class cannot be instancied.")
end
