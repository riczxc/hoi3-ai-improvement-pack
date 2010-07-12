--[[
   Copyright (C) 2008 

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--]]

---	 Logging facility.</br>
--
-- A logger consists of a category (to distinct different modules etc.) and an appender which actually
-- writes the message (to console, file etc.)
--
-- <h3>Configuration</h3>
-- A sample configuration file looks like this:<br />
-- <code class="lua">
--	  require("dtools.log4lua.logger")<br />
--	  require("dtools.log4lua.appenders.console")<br />
--	  require("dtools.log4lua.appenders.file")<br />
--	  local config = {}<br />
--	  <br />
--	  -- ROOT category must be configured.<br />
--	  config["ROOT"] = dtools.log4lua.Logger(dtools.log4lua.appenders.console.new(), "ROOT", logger.FATAL)<br />
--	  config["foo"] = dtools.log4lua.Logger(dtools.log4lua.appenders.file.new("foo-%s.log", "%Y-%m-%d"), "foo", dtools.log4lua.Logger.INFO)<br />
--	  config["bar"] = dtools.log4lua.Logger(dtools.log4lua.appenders.file.new("bar.log", nil, "%LEVEL: %MESSAGE\n"), "bar", dtools.log4lua.INFO)<br />
--	  <br />
--	  -- The config table must be returned.<br />
--	  return config
-- </code><br />
--
-- Then you can load this configuration file "by hand" calling <code>loadConfig(fileName)</code> or you
-- can set a default configuration file using the environment variable <code>LOG4LUA_CONFIG_FILE</code>.
--
-- <h3>Patterns</h3>
-- Patterns may contain the following placeholders:
-- <ul>
--	 <li>%DATE - Ingame time</li>
--	 <li>%RDATE - Real time</li>
--	 <li>%LEVEL</li>
--	 <li>%MESSAGE</li>
--	 <li>%COUNTRY - Current in game country</li>
--	 <li>%FILE - the source filename w/o path</li>
--	 <li>%PATH - the source filename including the path</li>
--	 <li>%LINE - the position in the source file</li>
--	 <li>%FUNCTION - the function name</li>
--	 <li>%STACKTRACE - the complete stack trace</li>
--	 <li>%ERROR - an exception string like the one you get using pcall(...)</li>
-- </ul>
-- <em>Important performance note:</em> Using one of <code>%FILE, %PATH, %LINE, %FUNCTION, %STACKTRACE</code> implies a quite huge performance
-- hit because <code>debug.traceback()</code> has to be called for every message logged. Note that the default pattern uses these placeholders.
--
-- Default pattern for all appenders is <code>[%DATE] [%LEVEL] [%COUNTRY]: %MESSAGE at %FILE:%LINE(%METHOD)\n</code>
--
-- @author $Author: peter.romianowski $
-- @release $Date: 2008-09-23 08:20:56 +0200 (Di, 23 Sep 2008) $ $Rev: 90 $

module("dtools.log4lua", package.seeall)

require("middleclass")
require("dtools.log4lua.utils")
require("dtools.log4lua.appenders.console")
require("dtools.log4lua.appenders.file")

Logger = middleclass.Object:subclass("dtools.Logger")

--- Level constants.
Logger.DEBUG = "DEBUG"
--- Level constants.
Logger.INFO = "INFO"
--- Level constants.
Logger.WARN = "WARN"
--- Level constants.
Logger.ERROR = "ERROR"
--- Level constants.
Logger.FATAL = "FATAL"
--- Level constants.
Logger.OFF = "OFF"

Logger.LOG_LEVELS = {
	DEBUG = 1,
	INFO = 2,
	WARN = 3,
	ERROR = 4,
	FATAL = 5,
	OFF = 6
}

-- Default pattern used for all appenders.
Logger.DEFAULT_PATTERN = "[%RDATE] [%DATE] [%LEVEL] [%COUNTRY] %MESSAGE at %FILE:%LINE(%METHOD)\n"

-- 
Logger.instances = {}

-- Name of the environment variable that holds the path to the default config file.
local ENV_LOGGING_CONFIG_FILE = "LOG4LUA_CONFIG_FILE"

local lpad = function(str, len, char)
	if char == nil then char = ' ' end
	return string.rep(char, len - #str).. str
end

-- Load default configuration found in environment variable.
local function initConfig()
	if (#Logger.instances == 0) then
		local configFile = os.getenv(ENV_LOGGING_CONFIG_FILE)
		if (configFile ~= nil) then
			Logger.loadConfig(configFile)
		else
			-- We need at least a root logger.
			Logger.instances = {}
			Logger.instances["ROOT"] = Logger(dtools.log4lua.appenders.console.new(), "ROOT", Logger.INFO)
		end
	end
end

--- Main method that returns a fully configured logger for the given category.<br />
-- The correct logger is found as follows:
-- <ul>
--	<li>If there is a configured logger with the exact category then use this.</li>
--	<li>Otherwise search for loggers with matching category.
--		Example: If there is a configured logger for category "test" then it is used for category "test.whatever", "testinger" etc.</li>
--	<li>Otherwise use the root category.</li>
-- </ul>
-- @param category the category of the desired logger.
function getLogger(category)
	initConfig()
	local log = nil
	if (category ~= nil) then
		log = Logger.instances[category]
		if (log == nil) then
			for loggerCategory, logger in pairs(Logger.instances) do
				if (string.find(category, loggerCategory, 1, true) == 1) then
					log = logger
					break
				end
			end
		end
	end
	if (log == nil) then
		log = Logger.instances["ROOT"]
	end
	assert(log, "Logger cannot be empty. Check your configuration!")
	return log
end

--- Load a configuration file.
-- @param fileName path to a configuration file written in lua. The lua code must return a map (table) with loggers configured for each category.
function Logger.loadConfig(fileName)
	local result, errorMsg = loadfile(fileName)

	if (result) then
				local loadedLoggers = result()
		assert(loadedLoggers ~= nil and loadedLoggers["ROOT"] ~= nil, "At least a log category 'ROOT' must be specified.")
		Logger.instances = loadedLoggers
	else
				-- Default configuration if no config file has been specified or it could not be loaded.
		Logger.instances = {}
		Logger.instances["ROOT"] = Logger.new(console.new(), "ROOT", Logger.INFO)
		Logger.getLogger("ROOT"):info("No logging configuration found in file '" .. fileName .. "' (Error: " .. tostring(errorMsg) .. "). Using default (INFO to console).")
	end
end

--- Constructor.
-- @param appenders a single function or a table of functions taking a string as parameter that is responsible for writing the log message.
-- @param category the category (== name) of this logger
-- @param level the threshold level. Only messages for equal or higher levels will be logged.
function Logger:new(appenders, category, level)
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:new instead of class.new")
	
	-- Force table creation
  	Logger.instances = Logger.instances or {}
  	
  	if nil == Logger.instances[category] then
  		local instance = setmetatable({ class = self }, self.__classDict)
	  	instance:initialize(appenders, category, level)
	  	Logger.instances[category] = instance 
  	end
  	
  	return Logger.instances[category]
end

function Logger:initialize(appenders, category, level)
   	assert(appenders ~= nil and (type(appenders) == "function" or type(appenders) == "table"), "Invalid value for appenders.")
	if (type(appenders) == "function") then
		appenders = {appenders}
	end
	for _, appender in ipairs(appenders) do
		assert(type(appender) == "function", "First parameter (the appender) must be a function.")
	end
	assert(category ~= nil, "Category not set.")
	
	self._appenders = appenders
	self._level = level or Logger.INFO
	self._category = category
end

--- Set the log level threshold.
function Logger:setLevel(level)
	assert(Logger.LOG_LEVELS[level] ~= nil, "Unknown log level '" .. level .. "'")
	self._level = level
end

--- Log the given message at the given level.
function Logger:log(level, message, exception, country)
		assert(Logger.LOG_LEVELS[level] ~= nil, "Unknown log level '" .. level .. "'")
	if (Logger.LOG_LEVELS[level] >= Logger.LOG_LEVELS[self._level] and level ~= Logger.OFF) then
		for _, appender in ipairs(self._appenders) do
			appender(self, level, message, exception, country)
		end
	end
end

--- Test whether the given level is enabled.
-- @return true if messages of the given level will be logged.
function Logger:isLevel(level)
	local levelPos = Logger.LOG_LEVELS[level]
	assert(levelPos, "Invalid level '" .. tostring(level) .. "'")
	return levelPos >= Logger.LOG_LEVELS[self._level]
end

--- Log message at DEBUG level.
function Logger:debug(message, exception, country)
	self:log(Logger.DEBUG, message, exception, country)
end

--- Log message at INFO level.
function Logger:info(message, exception, country)
	self:log(Logger.INFO, message, exception, country)
end

--- Log message at WARN level.
function Logger:warn(message, exception, country)
	self:log(Logger.WARN, message, exception, country)
end

--- Log message at ERROR level.
function Logger:error(message, exception, country)
	self:log(Logger.ERROR, message, exception, country)
end

--- Log message at FATAL level.
function Logger:fatal(message, exception, country)
	self:log(Logger.FATAL, message, exception, country)
end

function Logger:formatMessage(pattern, level, message, exception, country)
	local result = pattern or Logger.DEFAULT_PATTERN
	if (type(message) == "table") then
		message = dtools.log4lua.utils.convertTableToString(message, 5)
	end
	message = string.gsub(tostring(message), "%%", "%%%%")

	-- If the pattern contains any traceback relevant placeholders process them.
	if (
		string.match(result, "%%PATH")
		or string.match(result, "%%FILE")
		or string.match(result, "%%LINE")
		or string.match(result, "%%METHOD")
		or string.match(result, "%%STACKTRACE")
	) then
		-- Take no risk - format the stacktrace using pcall to prevent ugly errors.
		_, result = pcall(Logger._formatStackTrace, self, result)
	end

	-- Test CCurrentGameState existance, this script may run from pure LUA without HOI3 bindings
	local inGameDate = ""
	if CCurrentGameState ~= nil then		
		inGameDate = CCurrentGameState.GetCurrentDate()
		inGameDate = lpad(tostring(inGameDate:GetYear()),4,"0") .. "-" .. lpad(tostring(inGameDate:GetMonthOfYear()+1),2,"0") .. "-" .. lpad(tostring(inGameDate:GetDayOfMonth()+1),2,"0")
	end

	result = string.gsub(result, "%%DATE", inGameDate)
	result = string.gsub(result, "%%RDATE", tostring(os.date()))
	result = string.gsub(result, "%%LEVEL", lpad(level,6," "))
	result = string.gsub(result, "%%MESSAGE", message)
	result = string.gsub(result, "%%COUNTRY", lpad(country,3," "))
	-- tweak for AIIP (log4lua is bugged)
		if exception ~= nil then
				result = string.gsub(result, "%%ERROR", exception)
		end

	return result
end

-- Format stack trace.
function Logger:_formatStackTrace(pattern)
	local result = pattern

	-- Handle stack trace and method.
	local stackTrace = debug.traceback()

	for line in string.gmatch(stackTrace, "[^\n]-\.lua:%d+: in [^\n]+") do
		if not string.match(line, ".-log4lua.-\.lua:%d+:") and
			-- AIIP added utils.lua in list not to refer to wrapper
			not string.match(line, "utils\.lua") and
			not string.match(line, ".-dtools.-\.lua:%d+:") then
			
			local _, _, sourcePath, sourceLine, sourceMethod = string.find(line, "(.-):(%d+): in (.*)")
			local _, _, sourceFile = string.find(sourcePath or "n/a", ".*\\(.*)")

			result = string.gsub(result, "%%PATH", sourcePath or "n/a")
			result = string.gsub(result, "%%FILE", sourceFile or "n/a")
			result = string.gsub(result, "%%LINE", sourceLine or "n/a")
			result = string.gsub(result, "%%METHOD", sourceMethod or "n/a")
			result = string.gsub(result, "%%STACKTRACE", stackTrace)
			break
		end
	end

	return result
end
