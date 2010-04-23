require 'aiip'
require 'task'

ProxyTask = class('ProxyTask', Task)

function ProxyTask:initialize(name, gov, task_class, ...)
	super.initialize(self, name, gov, Department.ALL)
	self.task_class = task_class
	self.arg = arg
	self.internal_tasks = nil
end

function ProxyTask:getInternalTask()
	if not self.internal_tasks then
		local args = {}

		for i, v in ipairs(self.arg) do
			if type(v) == 'function' then
				table.insert(args, v(gov))
			else
				table.insert(args, v)
			end
		end

		self.internal_tasks = self.task_class:new(unpack(args))
	end
	return self.tasks[gov]
end

function ProxyTask:isExecutable(gov)
	local task = self:getInternalTask(gov)
	return task:isExecutable(gov:minister(task:getDepartment()))
end

function ProxyTask:execute(gov)
	local task = self:getInternalTask(gov)
	return task:execute(gov:minister(task:getDepartment()))
end

function ProxyTask:isRunning(gov)
	local task = self:getInternalTask(gov)
	return task:isRunning(gov:minister(task:getDepartment()))
end

function ProxyTask:resourceUse(gov)
	local task = self:getInternalTask(gov)
	return task:resourceUse(gov:minister(task:getDepartment()))
end

