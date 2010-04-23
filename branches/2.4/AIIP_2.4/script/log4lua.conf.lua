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

local logger = require("log4lua.logger")
local console = require("log4lua.appenders.console")
local file = require("log4lua.appenders.file")

local config = {}

config["ROOT"] = logger.new(
					{
						console.new(),
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d")
					},
					"ROOT",
					logger.DEBUG
				)

config["ALL"] = logger.new(
					{
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d"),
					},
					"ROOT",
					logger.DEBUG
				)

config["INTEL"] = logger.new(
					{
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d"),
						file.new("logs/AIIP2-INTEL-%s.log", "%Y-%m-%d")
					},
					"INTEL",
					logger.DEBUG
				)

config["POLIT"] = logger.new(
					{
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d"),
						file.new("logs/AIIP2-POLIT-%s.log", "%Y-%m-%d")
					},
					"POLIT",
					logger.DEBUG
				)

config["PROD"] = logger.new(
					{
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d"),
						file.new("logs/AIIP2-PROD-%s.log", "%Y-%m-%d")
					},
					"PROD",
					logger.DEBUG
				)

config["DIPLO"] = logger.new(
					{
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d"),
						file.new("logs/AIIP2-DIPLO-%s.log", "%Y-%m-%d")
					},
					"DIPLO",
					logger.DEBUG
				)

config["TECH"] = logger.new(
					{
						file.new("logs/AIIP2-%s.log", "%Y-%m-%d"),
						file.new("logs/AIIP2-TECH-%s.log", "%Y-%m-%d")
					},
					"TECH",
					logger.DEBUG
				)

-- dedicated to SQLite extensions
config["SQL"] = logger.new(
					{
						console.new(),
						file.new("logs/AIIP2-SQL-%s.log", "%Y-%m-%d")
					},
					"SQL",
					logger.DEBUG
				)

config["DEVEL"] = logger.new(
					{
						console.new(),
						file.new("logs/AIIP2-DEVEL-%s.log", "%Y-%m-%d")
					},
					"DEVEL",
					logger.DEBUG
				)

-- The config table must be returned.
return config
