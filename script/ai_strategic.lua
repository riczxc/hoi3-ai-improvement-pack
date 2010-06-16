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
-- Listed territories are disputed between minister country and 
-- opposed belligerants (country we are currently at war with or willing to fight)
--
-- Returns a table defined as :
-- status.isDisputed
-- status.isOutOfControl
-- status.hasOutOfControl
-- status.isUnderControl
-- status.hasUnderControl
-- status.hasMajorInvolved (major ENEMY)

function Strategic_TerritoryStatus(minister, paProvinceIdTable)
	R = {}
	R.isDisputed = false
	R.isOutOfControl = false
	R.hasOutOfControl = false
	R.isUnderControl = false
	R.hasUnderControl = false
	R.hasMajorInvolved = false
	
	if type(paProvinceIdTable) ~= "table" then
		return R
	end if
	
	local liProvinceId
	local liProvince
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry():
	local ministerStrategy = ministerCountry:GetStrategy()
	local controllerCountryTag
	
	-- Cycle through all listed provinces
	for k, liProvinceId in pairs(paProvinceIdTable) then
		liProvince = CCurrentGameState.GetProvince(liProvinceId)
		-- if province exists
		if liProvince ~= nil then
			controllerCountryTag = liProvince:GetController()
			
			-- another country owns the province
			if controllerCountryTag ~= ministerTag then
				-- Maybe enhance results with troop level or intel level ?
				-- province:GetIntelLevel(ministerTag)
				-- province:GetNumberOfUnits()
					
				-- the other country is allied
				if(ministerCountry:CalculateIsAllied(controllerCountryTag)) then
					R.hasUnderControl = true
				-- or is at war or is about to being attacked by us
				elseif( ministerStrategy:IsPreparingWarWith(controllerCountryTag) or 
					ministerCountry:GetRelation(controllerCountryTag):HasWar()) then
					R.hasOutOfControl = true
					
					if false == R.hasMajorInvolved then
						R.hasMajorInvolved = controllerCountryTag:getCountry():isMajor
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
	
	return R
end