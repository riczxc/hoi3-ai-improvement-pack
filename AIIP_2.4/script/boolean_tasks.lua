require 'aiip'
require 'task'

OrTask = class('OrTask', Task)

function OrTask:initialize(name, gov, department)
	super.initialize(self, name, gov, department)
end

function OrTask:getDependencies()
	local dependencies = super.getDependencies(self)

	-- TODO: Ask the government about the dependency decision.
	for _, task in ipairs(dependencies) do
		if task:isExecutable() then
			return { task }
		end
	end

	return dependencies
end
