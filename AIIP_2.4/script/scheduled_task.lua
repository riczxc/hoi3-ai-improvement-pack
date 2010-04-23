require 'aiip'
require 'resource_container'

ScheduledTask = class('ScheduledTask')

ScheduledTask:getter('task')
ScheduledTask:getterSetter('priority')

function ScheduledTask:initialize(gov, task, priority)
	dtools.debug('Creating ScheduledTask for ' .. task:getName())

	self.gov = gov
	self.factory = gov:getFactory()
	self.task = task
	self.priority = priority
	self.round = 0

	self.executed = false

	self:clearCache()
end

--~ function ScheduledTask:initializeDependencies(priority)
--~ 	for _, dep in ipairs(self.task:getDependencies()) do
--~ 		local dependendTask = self.factory:createScheduledTask(dep[1], priority)
--~ 		local constraint = dep[2]

--~ 		table.insert(self.dependencies, { dependendTask, constraint })
--~ 	end
--~ end

function ScheduledTask:getName()
	return self.task:getName()
end

function ScheduledTask:getMinister()
	return self.gov:minister(self.task:getDepartment())
end

function ScheduledTask:getDependantTasks()
	if not self.cache.valid_dependencies then
		self.cache.valid_dependencies = {}

		for _, task in ipairs(self.task:getDependencies(self.gov)) do
			local dependendTask = self.factory:createScheduledTask(task, self.priority)
			table.insert(self.cache.valid_dependencies, dependendTask)
		end
	end
	return self.cache.valid_dependencies
end

function ScheduledTask:clearCache()
	self.cache = {}
end

function ScheduledTask:setRound(round)
	if round > self.round then
		self.round = round
		self:clearCache()

		-- Inform all our dependencies about the new round.
		for _, dep in ipairs(self:getDependantTasks()) do
			dep:setRound(round)
		end
	end
end

function ScheduledTask:getRound(round)
	return self.round
end

-- Puts this task and all its dependencies on the table tasks if filter function
-- returns true. If the table tasks contains this task already the value
-- of this table entry will be increased by one.
function ScheduledTask:unfold(tasks, filter, true_case, false_case)
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

		for _, dep in ipairs(self:getDependantTasks()) do
			dep:unfold(tasks, filter, true_case, false_case)
		end

		self.validating_unfold = false
	end
end

-- Execute this task.
function ScheduledTask:execute(department, availResources)
--~ 	if department ~= self.task:getDepartment() then
--~ 		return false
--~ 	end

	if self.cache.executed then
		return true
	end

	if not self:isExecutable() then
		return false
	end

	if availResources:hasResourcesLeftFor(self:resourceUse()) then
		if self.task:execute(self:getMinister()) then
			availResources:remove(self:resourceUse())
			self.cache.executed = true
		end
	end

	return self.cache.executed
end

-- This function returns true if the wrapped task and all its dependencies
-- can be executed.
function ScheduledTask:isExecutable()
	if not self.cache.checked_is_executable then
		local result = false

		if not self.validating_is_executable then
			self.validating_is_executable = true

			result = self.task:isExecutable(self:getMinister())
			if result then
				for _, dep in ipairs(self:getDependantTasks()) do
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

-- Returns true if the wrapped task or one of its dependencies are running.
function ScheduledTask:isRunning()
	if not self.cache.checked_is_running then
		local result = false

		if not self.validating_is_running then
			self.validating_is_running = true

			result = self.task:isRunning(self:getMinister())
			if not result then
				for _, dep in ipairs(self:getDependantTasks()) do
					if dep:isRunning() then
						result = true
						break
					end
				end
			end

			self.validating_is_running = false
		else
			-- Propbably a loop here.
			return false
		end

		self.cache.is_running = result
		self.cache.checked_is_running = true
	end
	return self.cache.is_running
end

-- Returns true if the wrapped task and all its dependencies completed execution.
function ScheduledTask:completed()
	if not self.cache.checked_for_completion then
		local result = false

		if not self.validating_completed then
			self.validating_completed = true

			result = self.executed and not self:isRunning()
			if not result then
				for _, dep in ipairs(self:getDependantTasks()) do
					if not dep:completed() then
						result = false
						break
					end
				end
			end

			self.validating_completed = false
		else
			-- Propbably a loop here.
			return true
		end

		self.cache.completed = result
		self.cache.checked_for_completion = true
	end
	return self.cache.completed
end

-- Returns the resource use of the wrapped task.
function ScheduledTask:resourceUse()
	if not self.cache.resourceUse then
		self.cache.resourceUse = self.task:resourceUse(self:getMinister())
	end
	return self.cache.resourceUse
end

-- Sums up the resource use on resourceResult of this tasks
-- and all its dependencies. Only tasks not already in table tasks
-- will be accounted for.
function ScheduledTask:sumResourceUse(resourceResult, tasks)
	if not tasks[self] then
		tasks[self] = true

		resourceResult:add(self:resourceUse())

		for _, dep in ipairs(self:getDependantTasks()) do
			dep:sumResourceUse(resourceResult, tasks)
		end
	end
end
