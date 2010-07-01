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
--print(string.format("DEV_PATH = %s", DEV_PATH))

-- Fake autoexec
require('utils')

-- Now uses homemade pure LUA fake HOI3 API
-- relies on aiip_enabler.lua that is called
-- from utils.lua
require('hoi3')
require('hoi3.api')

dtools.setLogContext("","DEVEL")

--Run all test suites
if not(hoi3.testAll()) then
	os.exit()
end

--Load and create instance for some preconfigured objects (countries, continent, ...)
require('hoi3.conf')

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

tickFunctions = {
	ForeignMinister_OnWar,
	ForeignMinister_EvaluateDecision,
	ForeignMinister_Tick,
	ForeignMinister_ManageTrade,
	DiploScore_OfferTrade,
	IntelligenceMinister_Tick,
	PoliticsMinister_Tick,
	ProductionMinister_Tick,
	BalanceProductionSliders,
	TechMinister_Tick
}

for i=0,1000  do
	print("--------- loop #"..i.."--------------------")
	hoi3.MultitonObject.instances = {}
	hoi3.conf.generateAll()	
	local tag = CCountryTag:random()
	local minister = CAIPoliticsMinister(tag)
    
    for k,v in ipairs(tickFunctions) do
    	v(minister)
    	
    	print(tostring(hoi3.FunctionObject.numApiCalls).." api calls")
    	hoi3.FunctionObject.numApiCalls = 0
    end
end