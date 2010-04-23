require 'aiip'
require 'scheduler'
require 'scheduled_task_factory'

Government = class('Government')

Government:getter('country')
Government:getter('scheduler')
Government:getter('factory')

local governments = {}
local task_pool = require 'task_pool'

function Government.createFromAgent(agent)
	local key = tostring(agent:GetCountryTag())
	if (governments[key]) then
		return governments[key]
	end

	local gov = Government:new(agent:GetCountry())
	governments[key] = gov
	return gov
end

function Government:initialize(country)
	self.country = country
	self.minister_pool = {}
	self.factory = ScheduledTaskFactory:new(self)
	self.scheduler = Scheduler:new(self)
	self.complete = false
	self.last_meeting = -1
end

function Government:addMinister(department, minister)
	self.minister_pool[department] = minister
end

function Government:isComplete()
	if not self.complete then
		for department, departmentName in pairs(Department) do
			if department ~= 'ALL' then
				if not self.minister_pool[departmentName] then
					return false
				end
			end
		end
		self.complete = true
	end
	return self.complete
end

function Government:startMeeting(department, minister)
	self:addMinister(department, minister)

	if not self:isComplete() then
		return
	end

	dtools.setLogContext(self.country, 'ROOT')
	dtools.wrap(Government._startMeeting, self, department)
end

function Government:_startMeeting(department)
	-- Government meets once a day
	local today = CCurrentGameState.GetCurrentDate():GetDayOfMonth()
	if today ~= self.last_meeting then
		self.last_meeting = today

		-- Load basic task pool (will be loaded only once for all countries)
		task_pool.load_tasks()

		dtools.debug('Started meeting.')
	--
--~ 	for _, task in ipairs(task_pool) do
--~ 		self.scheduler:schedule(task, 1)
--~ 	end
		self.scheduler:schedule(task_pool.getTaskByName('rocket_engine'), 1)

		self.scheduler:prepare()
	end

	-- Run all tasks for this department (got access violations else)
	dtools.setLogContext(self.country, department)
	self.scheduler:run(department)
end

function Government:minister(department)
	-- Special case. Was introduced later on, because tasks like AndTask or OrTask
	-- need to have access to all ministers.
	if department == Department.ALL then
		return self
	end

	return self.minister_pool[department]
end

function Government:techMinister()
	return self:minister(Department.TECH)
end

function Government:prodMinister()
	return self:minister(Department.PROD)
end

function Government:intelMinister()
	return self:minister(Department.INTEL)
end

function Government:politMinister()
	return self:minister(Department.POLIT)
end

function Government:diplMinister()
	return self:minister(Department.DIPLO)
end

function Government:getCountryTag()
	return self.country:GetCountryTag()
end