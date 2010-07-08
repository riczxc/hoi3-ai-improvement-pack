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
require("dtools.table")
require('hoi3')
require('hoi3.api')

dtools.setLogContext("","DEVEL")

-- doc
require("hoi3.doc")
print(hoi3.doc.genWikiDoc())
os.exit()

--Run all test suites
require("lunit")
require("dtools.tests.dtools")
require("dtools.tests.table")
require("hoi3.tests.unit")
require("hoi3.tests.type")
require("hoi3.tests.save")
require("hoi3.tests.multiton")
require("hoi3.tests.abstract")
require("hoi3.tests.fixedpoint")
require("hoi3.tests.random")
require("hoi3.tests.cdate")
lunit.main()

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
--	{'ForeignMinister_OnWar',hoi3.api.CAIForeignMinister}, --blank function
	{'ForeignMinister_EvaluateDecision',hoi3.api.CAIForeignMinister},
	{'ForeignMinister_Tick',hoi3.api.CAIForeignMinister},
	{'ForeignMinister_ManageTrade',hoi3.api.CAIForeignMinister},
--	{'DiploScore_OfferTrade',hoi3.api.CAIForeignMinister},
	{'IntelligenceMinister_Tick',hoi3.api.CAIEspionageMinister},
	{'PoliticsMinister_Tick',hoi3.api.CAIPoliticsMinister},
	{'ProductionMinister_Tick',hoi3.api.CAIProductionMinister},
	{'BalanceProductionSliders',hoi3.api.CAIProductionMinister},
	{'TechMinister_Tick',hoi3.api.CAITechMinister}
}


if true then
	--for i=1,1  do
	--print("--------- loop #"..i.."--------------------")
	--hoi3.MultitonObject.instances = {}
	--hoi3.Hoi3Object.resultTable = {}
	hoi3.conf.generateAll()	
	local tag = CCountryTag:random()
    
    for k,v in ipairs(tickFunctions) do
    	local tickFunc = _G[v[1]]
    	local mnstFunc = v[2]
    	if tickFunc == BalanceProductionSliders then
    		hoi3.Randomizer.seed()
    		tickFunc(CAI(tag),CCountry(tag),math.random(0,4))
    	elseif tickFunc == ForeignMinister_ManageTrade then
    		-- sepcial signature, i feel lazy to complexify this code only for this
    		tickFunc(CAI(tag),tag)
    	elseif tickFunc == ForeignMinister_EvaluateDecision then
    		tickFunc(mnstFunc(tag), CDecision.random(), "scope?")
    	else
    		tickFunc(mnstFunc(tag))
    	end
    	
    	print(v[1].." "..tostring(hoi3.FunctionObject.numApiCalls).." api calls")
    	hoi3.FunctionObject.numApiCalls = 0
    end
    
    local ger = CCountryDataBase.GetTag("GER")
    print(ger:GetCountry():GetCapitalLocation():GetProvinceID())
    
    
    
    --table.save(hoi3.MultitonObject.instances,"results.txt")
    hoi3.MultitonObject.serializeInstances("SAVE000.lua")
else
	hoi3.MultitonObject.deserializeInstances("SAVE000.lua")
	
	local ger = CCountryDataBase.GetTag("GER")
	print(CCountry.GetCapitalLocation:hasResult(ger:GetCountry()))
	print(ger:GetCountry():GetCapitalLocation():GetProvinceID())
	
	--print(y:GetCapitalLocation())
end