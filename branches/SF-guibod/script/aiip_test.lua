--[[
	AIIP test harness code

	This code must be run from script directory
	In LUAECLIPSE, scripts are run from project root directory
]]

-- CONSTANT
DEV_PATH = "C:\\Users\\gboddaert\\Desktop\\luaeclipse\\workspace\\SF-guibod"

-- Fake autoexec
require('utils')

-- Now uses homemade pure LUA fake HOI3 API
-- relies on aiip_enabler.lua that is called
-- from utils.lua
require('hoi3')

-- Resume Fake autoexec
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
--CAllianceAction(1,2)
print(CAI.GetCurrentDate())
myCAI = CAI:new()
myCAI:EvaluateCancelTrades("str",  2)