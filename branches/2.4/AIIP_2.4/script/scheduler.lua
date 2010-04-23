require 'aiip'

Scheduler = class('Scheduler')

function Scheduler:initialize(gov)
	self.gov = gov
	self.scheduled_tasks = {}
	self.executable_tasks = {}
	self.running_tasks = {}
	self.ordered_tasks = {}
	self.round = 0
end

function Scheduler:schedule(task)
	if not self.scheduled_tasks[task] then
	    dtools.debug('Scheduling task ' .. task:getName())
	
	    local today = CCurrentGameState.GetCurrentDate():GetYear() * 12 + CCurrentGameState.GetCurrentDate():GetMonthOfYear()
	    self.scheduled_tasks[scheduled_task] = today
	end
end

function Scheduler:prepare()
	self.round = self.round + 1
	
	dtools.debug('Preparing tasks (round ' .. self.round .. ')')
	
	-- Inform all our scheduled tasks about the new scheduler round and
	-- unfold all executable tasks from our scheduled tasks.
	local executable_tasks = {}
	for task, scheduled in pairs(self.scheduled_tasks) do
	    task:setRound(self.round)
	
	    task:unfold(
	        executable_tasks,
	        function (t) return t:isExecutable() end
	    )
	end
	
	-- Assign a priority to each of the executable tasks
	-- based on usage count and time span between the month they 
	-- were scheduled and today.
	self.ordered_tasks = {}
	local today = CCurrentGameState.GetCurrentDate():GetYear() * 12 + CCurrentGameState.GetCurrentDate():GetMonthOfYear()
	for task, count in pairs(executable_tasks) do
	    local time_span = today - self.scheduled_tasks[task]
	    task:setPriority(count + time_span)
	    table.insert(self.ordered_tasks, task)
	end
	
	 -- Highest priority first.
	table.sort(self.ordered_tasks, function(x, y) return x:getPriority() > y:getPriority() end)
	
	-- Look at the tasks we scheduled in the past and remove 
	-- the completed tasks from the list of running tasks.
	local incomplete_tasks = {}
	for task, priority in pairs(self.running_tasks) do
	    if not task:completed() then
	    	table.insert(incomplete_tasks, task)
	    end
	end
	
	self.running_tasks = {}
	for _, task in ipairs(incomplete_tasks) do
	    table.insert(self.running_tasks, task)
	end
end

function Scheduler:run(department)
	-- Get our available resources.
	local availResources = self:getAvailResources()
	
	local executed_tasks = {}
	for i, task in ipairs(self.ordered_tasks) do
	    if task:execute(department, availResources) then
	        dtools.debug('executed task ' .. task:getName() .. ' with priority ' .. task:getPriority() .. ' in department ' .. department)
	
	        self.running_tasks[task] = task:getPriority()
	    end
	end
end

function Scheduler:getAvailResources()
	local result = ResourceContainer:new()
	local country = self.gov:getCountry()
	
	local IC = country:GetICPart(CDistributionSetting._PRODUCTION_PRODUCTION_):Get() - country:GetUsedIC():Get()
	local LS = country:GetAllowedResearchSlots() - country:GetNumberOfCurrentResearch()
	local MP = country:GetManpower():Get()
	
	result:setIC(IC)
	result:setLS(LS)
	result:setMP(MP)
	
	return result
end
