-----------------------------------------------------------
-- LUA Hearts of Iron 3 Strategic AI file
-- Created By: Guibod
-- Modified By: Guibod
-- Date Last Modified: 6/14/2010
-----------------------------------------------------------

function Strategic_Evaluate(minister) 
	-- Avoid 
	if math.mod( CCurrentGameState.GetAIRand(), 9) == 0 then
		Utils.CallCountryAI(ministerTag, "EvaluateFlags", minister)
	end if
end

function 

-- Convenience shortcut 
function Strategic_SetFlag(minister, sFlagName, bValue)
	local cmd = CSetFlagCommand( minister:getCountryTag(), sFlagName, bValue )
	ai = minister:getCountry():GetOwnerAI() 
	ai:Post( cmd )
end

-- Are we fighting for key provinces ?
--
-- Listed territories are disputed between minister country and 
-- opposed belligerants (country we are currently at war with or willing to fight)
--
-- This function can be resource intensive, piInfoLevel flag allow function caller
-- to stick define information finess from very basic features to complete report. 
-- 
-- INFOLEVEL = 1
-- All other countries are consider as minors and enemies. 
-- No data is provided from province except owner.
-- 
-- INFOLEVEL = 2
-- Distinction is provided between neutral, enemies and allies. Countries are checked
-- as major or not. 
-- No data is provided from province except owner.
-- 
-- INFOLEVEL = 3
-- Distinction is provided between neutral, enemies and allies. Countries are checked
-- as major or not. 
-- Province data ought to be provided but due to lack of LUA support, no information yet.
-- 
-- Returns a table defined as :
-- status.numAll            : number,  count of province that really exists
-- status.isOutOfControl	: boolean, all provinces are owned by enemies (or other country if infolevel =< 1)
-- status.hasOutOfControl	: boolean, some provinces are owned by enemies (or another country if infolevel =< 1)
-- status.numOutOfControl	: number,  count of province owned by enemies (or another country if infolevel =< 1)
-- status.ratioOutOfControl : number,  synonym for numOutOfControl/numAll
-- status.isUnderControl	: boolean, all  provinces are owned by us (or allied country if infolevel > 1)
-- status.hasUnderControl	: boolean, some provinces are owned by us (or allied country if infolevel > 1)
-- status.numUnderControl	: number,  count of provinces owned by us (or allied country if infolevel > 1)
-- status.ratioUnderControl : number,  synonym for numUnderControl/numAll
-- status.isDisputed		: boolean, synonym for hasUnderControl AND hasOufOfControl
-- status.hasMajorInvolved  : boolean, an enemy major country is involved (only provided for infolevel > 1)

function Strategic_TerritoryStatus(minister, paProvinceIdTable, piInfoLevel )
	R = {}
	R.isDisputed = false
	R.isOutOfControl = false
	R.hasOutOfControl = false
	R.numOutOfControl = 0
	R.isUnderControl = false
	R.hasUnderControl = false
	R.numUnderControl = 0
	R.hasMajorInvolved = false
	R.numAll = 0 -- we can't trust a count on paProvinceIdTable since some id may be invalids
	R.ratioUnderControl = 0
	R.ratioOutOfControl = 0
	
	if type(paProvinceIdTable) ~= "table" then
		return R
	end if
	
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ministerStrategy = ministerCountry:GetStrategy()
	
	-- current province related variables
	local liProvinceId
	local loProvince
		
	-- controller country related variables
	-- It is very likely that a same country is found many times, we feed 
	-- a cache array once and then query it.
	local controllerCountryTag
	local laCountryCache =  {}
	local laCountryCachedDefault = {isEnemy=true, isAlly=false, isMajor=false}
	local lbIsCurrentAlly = false
	local lbIsCurrentEnemy= false
	local lbIsCurrentMajor= false
	
	-- Cycle through all listed provinces
	for k, liProvinceId in pairs(paProvinceIdTable) then
		loProvince = CCurrentGameState.GetProvince(liProvinceId)
		
		-- if province exists
		if loProvince ~= nil then
			-- If info level = 3, query current province
			-- unfortunately CProvince does not provide needed information
			R.numAll = R.numAll + 1
			controllerCountryTag = loProvince:GetController()
			
			-- another country owns the province
			if controllerCountryTag == ministerTag then
				R.numUnderControl = R.numUnderControl + 1
				R.hasUnderControl = true
			else
				-- Is cache empty for current country ?
				if laCountryCache[controllerCountryTag] == nil then
					-- load defaults
					laCountryCache[controllerCountryTag] = laCountryCachedDefault
					
					-- If info level = 1, no query on country keep default values
					if piInfoLevel > 1 then
						laCountryCache[controllerCountryTag].isAlly = ministerCountry:CalculateIsAllied(controllerCountryTag)
						laCountryCache[controllerCountryTag].isEnemy = ministerStrategy:IsPreparingWarWith(controllerCountryTag) or ministerCountry:GetRelation(controllerCountryTag):HasWar()
						laCountryCache[controllerCountryTag].isMajor = controllerCountryTag:getCountry():isMajor()
					end
				end if
				
				-- Feed from cache
				lbIsCurrentEnemy = laCountryCache[controllerCountryTag].isEnemy 
				lbIsCurrentAlly  = laCountryCache[controllerCountryTag].isAlly 
				lbIsCurrentMajor = laCountryCache[controllerCountryTag].isMajor 
				
				-- the other country is allied
				if lbIsCurrentAlly then
					R.hasUnderControl = true
					R.numUnderControl = R.numUnderControl + 1
				-- or is at war or is about to being attacked by us
				elseif lbIsCurrentEnemy then
					R.hasOutOfControl = true
					R.numOutOfControl = R.numOutOfControl + 1
					
					if false == R.hasMajorInvolved then
						R.hasMajorInvolved = lbIsCurrentMajor
					end if
				end if
			end if
		end if
	end
	
	-- Not under control
	if R.hasOutOfControl then
		R.isUnderControl = false
	end if
	
	-- Not out of control
	if R.hasUnderControl then
		R.isOutOfControl = false
	end if
	
	R.isDisputed = R.isUnderControl and R.isOutOfControl
	
	-- Calculate a ratio
	R.ratioUnderControl = R.numUnderControl / R.numAll
	R.ratioOutOfControl = R.numOutOfControl / R.numAll
	
	return R
end