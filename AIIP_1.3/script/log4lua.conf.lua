local logger = require("log4lua.logger")
local console = require("log4lua.appenders.console")
local file = require("log4lua.appenders.file")

local config = {}

config["ROOT"] = logger.new(
					{
						console.new(),
						file.new("logs/AIIP-%s.log", "%Y-%m-%d")
					},
					"ROOT",
					logger.INFO
				)

config["INTEL"] = logger.new(
					{
						file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						file.new("logs/INTEL-%s.log", "%Y-%m-%d")
					},
					"INTEL",
					logger.INFO
				)

config["POLIT"] = logger.new(
					{
						file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						file.new("logs/POLIT-%s.log", "%Y-%m-%d")
					},
					"POLIT",
					logger.INFO
				)

config["PROD"] = logger.new(
					{
						file.new("logs/AIIP-%s.log", "%Y-%m-%d"),
						file.new("logs/PROD-%s.log", "%Y-%m-%d")
					},
					"PROD",
					logger.INFO
				)

-- dedicated to SQLite extensions
config["SQL"] = logger.new(
					{
						console.new(),
						file.new("logs/SQL-%s.log", "%Y-%m-%d")
					},
					"SQL",
					logger.INFO
				)

config["DEVEL"] = logger.new(
					{
						console.new(),
						file.new("logs/DEVEL-%s.log", "%Y-%m-%d")
					},
					"PROD",
					logger.DEBUG
				)

-- The config table must be returned.
return config
