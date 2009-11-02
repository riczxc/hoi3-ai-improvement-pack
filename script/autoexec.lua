-- AUTOEXEC.LUA
-- This file is run on app start after exports are done inside the engine (once per context created)

package.path = package.path .. ";script\\?.lua;script\\country\\?.lua;common\\?.lua"

--require('hoi') -- already imported by game, contains all exported classes
require('utils')
require('defines')
require('ai_country')
require('ai_foreign_minister')
require('ai_production_minister')
require('ai_intelligence_minister')
require('ai_tech_minister')
require('ai_politics_minister')
require('ai_configuration')
require('CustomTriggers')


-- load country specific AI modules.
require('ENG')
require('GER')
require('SOV')
require('USA')
require('SWE')
require('FIN')
require('ITA')
require('JAP')
