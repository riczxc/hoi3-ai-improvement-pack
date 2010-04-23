require 'aiip'
require 'task'
require 'boolean_task'
require 'division_build_task'
require 'province_build_task'
require 'proxy_task'
require 'tech_task'
require 'unit_build_task'

TaskFactory = class('TaskFactory')

function TaskFactory:initialize(task_descriptions, gov)
	self.task_descriptions = task_descriptions
	self.gov = gov
	self.tasks = {}
end

function TaskFactory:createTask(task_name, priority)
	if not self.tasks[task_name] then
		local desc = self.task_descriptions[task_name]
		if desc then
			local task_type = desc.task_type
			local task = nil
			
			if task_type == 'division_build_task' then
				task = DivisionBuildTask:new(task_name, self.gov, task, desc.units)
			elseif task_type == 'province_build_task' then
				task = ProvinceBuildTask:new(task_name, self.gov, desc.building, desc.province)
			elseif task_type == 'tech_task' then
				task = TechTask:new(task_name, self.gov, desc.tech)
			elseif task_type == 'unit_build_task' then
				task = UnitBuildTask:new(task_name, self.gov, desc.unit)
			else
				-- Unknown task type, print a warning, but keep the game running.
				dtools.warn('Unknown task type ' .. task_type .. ' in task ' .. task_name .. '. Creating empty task.')
				task = Task:new(task_name, self.gov, Department.ALL)
			end
		else
			-- No description available for this task. Print an error for now
			-- and return an empty task.
			dtools.error('No description found for task ' .. task_name .. '. Creating empty task.')
			task = Task:new(task_name, self.gov, Department.ALL)
		end

		self.tasks[task_name] = task

		return task
	else
		local task = self.tasks[task_name]

		if priority > task:getPriority() then
			task:setPriority(priority)
		end

		return task
	end
end
