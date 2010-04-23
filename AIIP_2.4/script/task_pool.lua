require 'aiip'
require 'boolean_tasks'
require 'tech_task'
require 'unit_build_task'
require 'province_build_task'
require 'proxy_task'

local TaskPool = {
	tasks_by_name = {},
	tasks = {}
}

local loaded = false

function TaskPool._setupTechDependencies(task, tasks, dependendTechNames, invert)
	for depTechName, level in pairs(dependendTechNames) do
		if type(level) == 'number' then
			local other_task = tasks[depTechName]
			if other_task then
				if invert then
					task:dependsOn(
						other_task,
						function (gov, t)
							return gov:getCountry():GetTechnologyStatus():GetLevel(t:getTech()) >= level
						end
					)
				else
					task:dependsOn(
						other_task,
						function (gov, t)
							return gov:getCountry():GetTechnologyStatus():GetLevel(t:getTech()) < level
						end
					)
				end
			else
				dtools.warn('tech depenency "' .. depTechName .. '" not found in internal tech list.')
			end
		else
			local op = depTechName
			if op == 'AND' then
				-- The ScheduledTask implements just this. So create a simple task
				-- object, add the dependencies and let the wrapping ScheduledTask
				-- object do the job.
				local and_task = Task:new('AND', Department.ALL)
				TaskPool._setupTechDependencies(and_task, tasks, level, invert)
				task:dependsOn(and_task)
			elseif op == 'OR' then
				local or_task = OrTask:new('OR')
				TaskPool._setupTechDependencies(or_task, tasks, level, invert)
				task:dependsOn(or_task)
			elseif op == 'NOT' then
				TaskPool._setupTechDependencies(task, tasks, level, not invert)
			elseif op == 'any_owned_province' then
				TaskPool._setupTechDependencies(task, tasks, level, invert)
			elseif op == 'has_building' then
				local build_task = ProxyTask:new(
					'proxy_has_building_' .. level,
					ProvinceBuildTask,
					level,
					level,
					function (gov)
						return gov:getCountry():GetActingCapitalLocation():GetProvinceID()
					end
				)
				task:dependsOn(build_task)
			else
				dtools.warn('unrecognized operation "' .. op .. '".')
			end
		end
	end
end

function TaskPool.load_tasks()
	if loaded then
		return
	end

	local tasks = {}
	local task_list = {}

	for tech in CTechnologyDataBase.GetTechnologies() do
		if tech:IsValid() then
			local techName = tostring(tech:GetKey())
			local task = TechTask:new(techName, tech)

			tasks[techName] = task
			table.insert(task_list, task)
		end
	end

	local techDependencies = require 'tech_dependencies'
	for techName, dependendTechNames in pairs(techDependencies) do
		local task = tasks[techName]

		if task then
			TaskPool._setupTechDependencies(task, tasks, dependendTechNames, false)
		else
			dtools.warn('tech depenency "' .. techName .. '" not found in internal tech list.')
		end
	end

	for unit in CSubUnitDataBase.GetSubUnitList() do
		if unit:IsValid() then
			if not unit:IsRegiment() then
				local unitName = tostring(unit:GetName())
				local task = UnitBuildTask:new(unitName, unit)

				if not tasks[unitName] then
					tasks[unitName] = task
					table.insert(task_list, task)
				else
					dtools.warn('unit build task ' .. unitName .. ' conflicts with previous defined tech task.')
				end
			end
		end
	end

	TaskPool.tasks_by_name = tasks
	TaskPool.tasks = task_list

	loaded = true
end

function TaskPool.add(tasks)
	for _, t in ipairs(tasks) do
		TaskPool.tasks_by_name[t:getName()] = t
		table.insert(TaskPool.tasks, t)
	end
end

function TaskPool.getTaskByName(name)
	return TaskPool.tasks_by_name[name]
end

return TaskPool
