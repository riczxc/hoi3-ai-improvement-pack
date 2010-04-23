require 'aiip'
require 'resource_container'

-- Base class for all tasks.
Task = class('Task')

-- The name of the task.
Task:getter('name')
-- The government which created this task.
Task:getter('gov')
-- Department is one of: PROD, TECH, DIPLO, POLIT, INTEL
-- Important to disable tasks for specific tech minister
-- if minister is played by human.
Task:getter('department')
-- The priority this task is scheduled with.
Task:getterSetter('priority')
-- The scheduling round this task was last scheduled with.
Task:getter('round')

-- A task should only make use of one minister. If you need more
-- complex tasks, create dependencies. Tasks should be kept simple,
-- so they're easyily reusable in other tasks.
function Task:initialize(name, gov, department)
	self.gov = gov
	self.name = name
	self.department = department
	self.priority = 0
	self.round = 0
	self.dependencies = {}
	self.has_dependency_constraints = false
	self.cache = {}
end

-- Clears all the cached values.
function Task:clearCache()
	local deps = false
	
	-- In case there are no dependencies rescue them.
	if not self.has_dependency_constraints then
		local deps = self.cache.dependencies
	end
	
	-- Clear the cache
	self.cache = {}
	
	-- Reassign rescued dependencies
	self.cache.dependencies = deps
end

-- This task depends on another task as long as the dependency
-- contraint returns true.
function Task._dependency_constraint(gov, other_task)
	return true
end

-- Adds a dependency to other_task for this task.
-- This task will only depend on other_task as long as contraint
-- returns true. constraint is a function of type gov -> other_task -> boolean
function Task:dependsOn(other_task, constraint)
	dtools.debug(self:getName() .. ' depends on ' .. other_task:getName())
	if not constraint then
		constraint = self._dependency_constraint
	else
		self.has_dependency_constraints = true
	end
	table.insert(self.dependencies, { other_task, constraint })
end

-- Returns all the tasks this task depends on.
-- The returned dependencies satisfy the dependency constraints.
function Task:getDependencies()	
	if not self.cache.dependencies then
		self.cache.dependencies = {}
	
		for _, dep in ipairs(self.dependencies) do
			local task = dep[1]
			local constraint = dep[2]
	
			-- Check the constraint.
			if constraint(self.gov, task) then
				table.insert(self.cache.dependencies, task)
			end
		end
	end

	return self.cache.dependencies
end

-- Sets a new scheduling round. This call will clear
-- the cache of this task and all its dependencies
-- if round > last round.
function Task:setRound(round)
	-- Check if this is really a new round.
	if round > self.round then
		self.round = round
		self:clearCache()
		
		-- Inform all our dependencies about the new round.
		for _, dep in ipairs(self:getDependencies()) do
			dep:setRound(round)
		end
	end
end

-- Determines if this task and ALL its dependencies can
-- be executed. Overwrite this function if you for example
-- need to implement a task which is satisfied if only
-- one of its dependencies are met.
function Task:isExecutable()
	if not self.cache.checked_is_executable then
		local result = false

		if not self.validating_is_executable then
			self.validating_is_executable = true
			
			result = self:_isExecutable()
			if result then
				for _, dep in ipairs(self:getDependencies()) do
					if not dep:isExecutable() then
						result = false
						break
					end
				end
			end
			
			self.validating_is_executable = false
		else
			-- Propbably a loop here.
			return true
		end
		
		self.cache.is_executable = result
		self.cache.checked_is_executable = true
	end

	return self.cache.is_executable
end

-- Executes this task. The task will only be executed
-- if the department matches the internal department and
-- the task is executable. Returns true if execution was
-- successfull, otherwise false. 
function Task:execute(department)
	if self.cache.executed then
		return true
	end
	
 	if self.department ~= department then
 		return false
	end
	
	if not self:isExecutable() then
		return false
	end
	
	self.cache.executed = self:_execute()
	
	return self.cache.executed
end

-- Determines if this task is still running. In this default
-- implementation this function will only check this task,
-- since it's not possible to execute this task if not all
-- its dependencies are met.
-- But there could be cases when a task is more like a container
-- task and dependencies are used to store the containees and
-- the execution method only decides which of its containees it
-- will execute. In such a case one'd have to overwrite this 
-- method.
function Task:isRunning()
	if not self.cache.checked_is_running then
		self.cache.is_running = self:_isRunning()
		self.cache.checked_is_running = true
	end
	
	return self.cache.is_running
end

-- Returns the resources used by this task and all it's dependencies
-- if executed. Again, overwrite this method in case the dependencies
-- are used in another way.
function Task:resourceUse()
	if not self.cache.resourceUse then
		local result = ResourceContainer:new()
		if self:isExecutable() then
			result = self:_resourceUse()
		end
		
		for _, dep in ipairs(self:getDependencies()) do
			result:add(dep:resourceUse())
		end
		
		self.cache.resourceUse = result
	end
	
	return self.cache.resourceUse
end

-- Returns true if the task completed execution.
function Task:completed()
	return self.executed and not self:isRunning()
end

-- Puts this task and all its dependencies on the table tasks if filter function
-- returns true. If the table tasks contains this task already the value
-- of this table entry will be increased by one.
function Task:unfold(tasks, filter)
	if not self.validating_unfold then
		self.validating_unfold = true
		
		if filter(self) then
			if tasks[self] then
				tasks[self] = tasks[self] + 1
				dtools.debug('Unfolded ' .. self:getName())
			else
				tasks[self] = 1
				dtools.debug('Newly unfolded ' .. self:getName())
			end
		else
			dtools.debug('Filtered out ' .. self:getName())
		end
		
		for _, dep in ipairs(self:getDependencies()) do
			dep:unfold(tasks, filter)
		end
		
		self.validating_unfold = false
	end
end

function Task:getMinister()
	if not self.cache.minister then
		self.cache.minister = self.gov:minister(self.department)
	end
	return self.cache.minister
end

-- Override this function
function Task:_isExecutable()
	return true
end

-- Override this function
function Task:_execute()
	return true
end

-- Override this function
function Task:_isRunning()
	return false
end

-- Override this function
function Task:_resourceUse()
	return ResourceContainer:new()
end
