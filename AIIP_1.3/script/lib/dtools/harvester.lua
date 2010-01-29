-- HOI3 data binder for luasql
--
-- by Guibod

module("dtools.harvester", package.seeall)

-- Class definition
local Harvester = {}
Harvester.__index = Harvester

local _module = Harvester

_module._tables = {}
_module._db = nil
_module._session_name = nil

local log = require("log4lua.logger")
local dtools = require("dtools")

function _module.getDb()
	if _module.db == nil then
		require("luasql.sqlite3")

		local env = assert (luasql.sqlite3())
		_module._db = assert (env:connect"AIIP.sqlite")
	end

	return _module._db
end

function _module.harvest(name, data)
	if _module._tables[name] == nil then
		-- create a new Harvester object, that will create table if needed
		_module._tables[name] = Harvester.new(name, data)
	end

	_module._tables[name]:insertData(data)
end


function _module.callSql(sql)
	local ret, msg
	assert(sql ~= nil, "empty sql statement")

	ret, msg = _module.getDb():execute(sql)

	--trace sql
	dtools.debug(sql)
	if ret == nil and msg ~= nil then
		-- log an sql error message
		dtools.error(msg)
	end

	return ret
end


function Harvester.new(name, data)
    local self = {}
    setmetatable(self, Harvester)

	assert(name ~= nil, "Invalid table name.")
	assert(data ~= nil and type(data) == "table", "Invalid value for fields (table required).")

    self._fields = _module.dataToTableDefinition(data)
    self._name = name
	self._created = false

    return self
end

function _module.dataToTableDefinition(data)
	local fields = {}
	local t

	for fname, fvalue in pairs(data) do
		fname = tostring(fname) --cast whatever index is to string, to name the field

		if type(fvalue) == "table" then
			return _module.dataToTableDefinition(fvalue)
		elseif type(fvalue) == "number" then
			t = "REAL" --lua has no distinction between INT & FLOAT, use REAL
		elseif type(value) == "userdata" and type(value.GetCountryTag) == "function" then
			t = "TEXT" --we support some HOI3 standard method
		else
			t = "TEXT" --all will fit TEXT
		end

		fields[tostring(fname)] = t
    end

	return fields
end

function Harvester:toCreateScript()
	local str = string.format("CREATE TABLE IF NOT EXISTS %s (",self._name)

	for fname, ftype in pairs(self._fields) do
        str = str .. string.format("\"%s\" %s,", fname , ftype )
    end

	str = str .. "DATE_REAL TEXT, DATE_INGAME TEXT, GAME_SESSION TEXT)"

	return str
end

-- Returns a INSERT statement skeleton
--
-- INSERT INTO MYTABLE (FOO, BAR, DATE_REAL, DATE_INGAME, GAME_SESSION) VALUES (%s)
function Harvester:getInsertSkel()
	if self._insertSkel == nil then
		self._insertSkel = string.format("INSERT INTO %s ( ", self._name )

		for fname, ftype in pairs(self._fields) do
			self._insertSkel = self._insertSkel .. string.format("\"%s\", ", fname )
		end

		self._insertSkel = self._insertSkel .. "DATE_REAL, DATE_INGAME, GAME_SESSION) VALUES (%s);"
	end

	return self._insertSkel
end

function Harvester:toInsertScript(data)
	local tmpstr
	local stmt = self:getInsertSkel()

	-- compute common data for each table (columns DATE_REAL, DATE_INGAME, GAME_SESSION)
	tmpstr = "date('now'), " --realtime
	tmpstr = tmpstr .. "\"".. _module.getInGameDate() .. " 00:00:00.000\", " --ingame time
	tmpstr = tmpstr .. "\"".. _module.getSessionName() .. "\"" --first time ingame time + country tag

	-- Now the base statement is something like :
	--
	-- INSERT INTO MYTABLE (FOO, BAR, DATE_REAL, DATE_INGAME, GAME_SESSION) VALUES (%s, date('now'), "1943-10-21 00:00:00.000", "<GAMESESSION>")
	stmt = string.format(stmt, "%s "..tmpstr)

	tmpstr = ""
	for _,value in pairs(data) do
		if type(value) == "userdata" and type(value.GetCountryTag) == "function" then
			--Most likely CCountry or any CAIAgent class
			tmpstr = tmpstr .. "\"".. tostring(value:GetCountryTag()) .. "\", "
		else
			tmpstr = tmpstr .. "\"".. tostring(value) .. "\", "
		end
	end

	stmt = string.format(stmt, tmpstr)
	dtools.debug(str,nil,"SQL")

	return stmt
end

function Harvester:createTable()
	if self._created == true then
		return
	end

	_module.callSql(self:toCreateScript())
	dtools.info("Table "..self._name.." created")
	self._created = true
end

function Harvester:insertData(data)
	self:createTable()
	_module.callSql(self:toInsertScript(data))
end

function _module.getInGameDate()
	if CCurrentGameState ~= nil then
		return CCurrentGameState.GetCurrentDate():GetYear() .. "-" ..
				CCurrentGameState.GetCurrentDate():GetMonthOfYear()+1 .. "-" ..
				CCurrentGameState.GetCurrentDate():GetDayOfMonth()+1
	end
	return "1900-01-01"
end

function _module.getSessionName()
	if _module._session_name == nil then
		_module._session_name = "UNKNOWN"

		-- Running in HOI3 ?
		if CCurrentGameState ~= nil then
			_module._session_name = tostring(CCurrentGameState.GetPlayer()) .. " " .. _module.getInGameDate() .. " " .. os.date("%Y%m%d%H%M%S")
		end
	end

	return _module._session_name
end

function _module.rows (connection, sql_statement)
  local cursor = assert (_module.getDb():execute (sql_statement))
  return function ()
    return cursor:fetch()
  end
end


return _module
