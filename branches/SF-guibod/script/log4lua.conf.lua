-- Log file definition
--
-- @see http://www.hscale.org/display/LUA/Log4LUA
--
-- ROOT category is mandatory as it is the fallback log file
-- SQL category is reserved for SQLite traces
-- DEVEL category is great to log information from the function you work on
-- Other categories are dedicated to ministers

-- Notes:
-- * Composite loggers are working great
-- * Log4lua provide an SMTP (mail) support
-- * Console logger will not work inside Clausewitz engine ! There is no STDOUT.

-- Please consider that log4lua is UNABLE to create directories
-- You'll may need to create "logs" directory in mod dir for log4lua to work in SciTE editor.

require("dtools.log4lua")
require("dtools.log4lua.appenders.console")
require("dtools.log4lua.appenders.file")

local config = {}

config["ROOT"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.console.new(),
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d")
					},
					"ROOT",
					dtools.log4lua.Logger.DEBUG
				)

config["ALL"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
					},
					"ROOT",
					dtools.log4lua.Logger.DEBUG
				)

config["INTEL"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						dtools.log4lua.appenders.file.new("logs/AIIP-INTEL-%s.log", "%Y-%m-%d", "[%DATE] [%RDATE] [%LEVEL] [%COUNTRY] %MESSAGE at %FILE:%LINE(%METHOD)\n")
					},
					"INTEL",
					dtools.log4lua.Logger.DEBUG
				)

config["POLIT"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						dtools.log4lua.appenders.file.new("logs/AIIP-POLIT-%s.log", "%Y-%m-%d", "[%DATE] [%RDATE] [%LEVEL] [%COUNTRY] %MESSAGE at %FILE:%LINE(%METHOD)\n")
					},
					"POLIT",
					dtools.log4lua.Logger.DEBUG
				)

config["PROD"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						dtools.log4lua.appenders.file.new("logs/AIIP-PROD-%s.log", "%Y-%m-%d", "[%DATE] [%RDATE] [%LEVEL] [%COUNTRY] %MESSAGE at %FILE:%LINE(%METHOD)\n")
					},
					"PROD",
					dtools.log4lua.Logger.DEBUG
				)

config["DIPLO"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						dtools.log4lua.appenders.file.new("logs/AIIP-DIPLO-%s.log", "%Y-%m-%d", "[%DATE] [%RDATE] [%LEVEL] [%COUNTRY] %MESSAGE at %FILE:%LINE(%METHOD)\n")
					},
					"DIPLO",
					dtools.log4lua.Logger.DEBUG
				)

config["TECH"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						dtools.log4lua.appenders.file.new("logs/AIIP-TECH-%s.log", "%Y-%m-%d", "[%DATE] [%RDATE] [%LEVEL] [%COUNTRY] %MESSAGE at %FILE:%LINE(%METHOD)\n")
					},
					"TECH",
					dtools.log4lua.Logger.DEBUG
				)

-- dedicated to SQLite extensions
config["SQL"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.console.new(),
						dtools.log4lua.appenders.file.new("logs/AIIP-SQL-%s.log", "%Y-%m-%d")
					},
					"SQL",
					dtools.log4lua.Logger.DEBUG
				)

config["DEVEL"] = dtools.log4lua.Logger(
					{
						dtools.log4lua.appenders.console.new(),
						dtools.log4lua.appenders.file.new("logs/AIIP-DEVEL-%s.log", "%Y-%m-%d")
					},
					"DEVEL",
					dtools.log4lua.Logger.DEBUG
				)

-- The config table must be returned.
return config
