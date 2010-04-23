require 'aiip'

ResourceContainer = class('ResourceContainer')

ResourceContainer:getterSetter('IC', 0)
ResourceContainer:getterSetter('LS', 0)
ResourceContainer:getterSetter('MP', 0)
ResourceContainer:getterSetter('ICdays', 0)
ResourceContainer:getterSetter('LSdays', 0)

function ResourceContainer:initialize(IC, LS, MP, ICdays, LSdays)
	self.IC = IC or 0
	self.LS = LS or 0
	self.MP = MP or 0
	self.ICdays = ICdays or 0
	self.LSdays = LSdays or 0
end

function ResourceContainer:add(other_container)
	self.IC = self.IC + other_container.IC
	self.LS = self.LS + other_container.LS
	self.MP = self.MP + other_container.MP
	self.ICdays = self.ICdays + other_container.ICdays
	self.LSdays = self.LSdays + other_container.LSdays
end

function ResourceContainer:remove(other_container)
	self.IC = math.max(self.IC - other_container.IC, 0)
	self.LS = math.max(self.LS - other_container.LS, 0)
	self.MP = math.max(self.MP - other_container.MP, 0)
	self.ICdays = math.max(self.ICdays - other_container.ICdays, 0)
	self.LSdays = math.max(self.LSdays - other_container.LSdays, 0)
end

function ResourceContainer:hasResourcesLeftFor(other_container)
	return (
		(other_container:getIC() <= 0 or self.IC > 0) and
		(other_container:getLS() <= 0 or self.LS > 0) and
		(other_container:getMP() <= 0 or self.MP > 0)
	)
end

local r1 = ResourceContainer:new()
local r2 = ResourceContainer:new()
r1:remove(r2)
r1:add(r2)
assert(r1:hasResourcesLeftFor(r2))
