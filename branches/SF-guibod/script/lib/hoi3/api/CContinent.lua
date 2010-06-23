require('hoi3')

module("hoi3.api", package.seeall)

CContinent = hoi3.MultitonObject:subclass('hoi3.CContinent')

---
--
function CContinent:initialize(tag, name)
	hoi3.assertParameterType(1, tag, hoi3.TYPE_STRING)
	hoi3.assertParameterType(2, name, hoi3.TYPE_STRING)
	
	self.tag = tag
	self.name = name
end 

---
-- @since 1.3
-- @return string 
function CContinent:GetName()
	return self.name
end

---
-- @since 1.3
-- @return string
function CContinent:GetTag()
	return self.tag
end

function CContinent.random()
	local a = {}
	a['ASI'] = 'asia'
	a['EUR'] = 'europe'
	a['AFR'] = 'africa'
	a['AME'] = 'america'
	a['OCE'] = 'oceania'
	
	math.randomseed(os.time())
	local i = math.random(#a)
	
	for k,v in pairs(a) do
		i = i - 1
		if i < 0 then 
			break
		end
	end
	
	return CContinent(k,v)
end