--[[
	AIIP test harness code

	This code must be run from script directory and absoulte path to
    mod directory given as first program argument.
    For example:
        Working dir = C:\Path\To\Hoi3\mod\AIIP_SF\script
        lua aiip_test.lua "C:\Path\To\Hoi3\mod\AIIP_SF"
	In LUAECLIPSE, scripts are run from project root directory.
    You can change the working directory and program arguments by
    - Right clicking on aiip_test.lua -> Run As -> Run configurations ...
    - Setting the appropriate values under Arguments tab.
    
]]

-- CONSTANT
DEV_PATH = arg[1]
print(string.format("DEV_PATH = %s", DEV_PATH))

-- Fake autoexec
require('utils')

-- Now uses homemade pure LUA fake HOI3 API
-- relies on aiip_enabler.lua that is called
-- from utils.lua
require('hoi3')
require('hoi3.api')

-- hoi3.api.CAction => CAction
hoi3.api.releaseApiOnGlobalScope()

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

dtools.setLogContext("","DEVEL")

--Run all test suites
hoi3.testAll()

--Load and create instance for some preconfigured objects (countries, continent, ...)
--require('hoi3.conf')
--hoi3.conf.generateAll()
--print(#CCountry:getInstances())
--for x in CLawDataBase.GetGroups() do
--	print(x)
--end
--[[
CCurrentGameState.saveResult(CCurrentGameState, 7,CCurrentGameState.GetAIRand)

local minister = CAIPoliticsMinister(CCountryTag('GER'))
     
PoliticsMinister_Tick(minister)
]]
print(tostring(hoi3.FunctionObject.numApiCalls).." api calls")