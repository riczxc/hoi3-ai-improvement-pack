--[[
	AIIP test harness code

	This code must be run from script directory
	In LUAECLIPSE, scripts are run from project root directory
]]

-- CONSTANT
DEV_PATH = "C:\\Users\\gboddaert\\Desktop\\luaeclipse\\workspace\\SF-guibod"

-- Fake autoexec
require('utils')
require('ai_country')
require('ai_foreign_minister')
require('ai_intelligence_minister')
require('ai_politics_minister')
require('ai_production_minister')
require('ai_support_functions')
require('ai_tech_minister')
require('ai_trade')
require('ai_strategic')

-- Call a core-to-lua hook