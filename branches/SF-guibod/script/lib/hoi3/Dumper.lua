require('hoi3.api')

module( "hoi3", package.seeall)

--[[
All possible arg type for API calls
*CAction -> void, don't bother
*CBuilding -> db, but from index or key
*CCommand -> returns void, don't bother
*CCountry -> db
*CCountryTag -> db
CDecision -> no db, must provide a hardcoded list... :(
*CDiplomaticAction -> returns void, don't bother
*CFaction -> db
*CFixedPoint -> don't bother, store scalar value
*CGovernmentPosition -> from constants
CIdeology -> via minister
CIdeologyGroup -> db, via faction
*CLawGroup -> db
*CProvince -> via ccountry
* CSubUnitConstructionEntry -> used for void, don't need this
* CSubUnitDefinition -> db
CTechnology -> nothing to seek all available tech :(
*CTechnologyCategory -> db
CTradeRoute -> ccountry or through diplostatus
boolean
*number -> 
*string -> either void or db lookup
*unknown -> ignored not supported
]]

function dump()
	-- Clean the environment
	hoi3.api.MultitonObject.clearInstances()
	
	-- First of all, check ALL constants !
	if not checkStatic() or not checkConstant() then
		report("Failed to dump, either static methods or constants are not synchronize between fake API and real API.")
		return
	end
	
	-- Read all needed objects used in data
	checkDataBases()
	
	-- Start
	
end

function report(err)
	dtools.error(err)
end

function saveAll()
	for k,v in pairs(hoi3.api.CCountryTag:getInstances()) do
		CCountryTag:runRealApiAndSave()
	end 
end

---
-- creates an instance for every named/unique object outthere.
function checkDataBases()
	-- Start by referencing all databased objects
	for d in CCurrentGameState.GetCountries() do
		local t = hoi3.api.CCountryTag(tostring(d:GetCountryTag()))
		t:bind(d)
		
		local o = hoi3.api.CCountry(t)
		o:bind(d:GetCountryTag())
		
		for pid in d:GetControlledProvinces() do
			local p = CProvince(pid)
			p:bind(CCurrentGameState.GetProvince(pid))
		end
	end
	
	for d in CCurrentGameState.GetFactions() do
		local o = hoi3.api.CFaction(tostring(d:GetTag()))
		o:bind(d)
	end
	
	for d in CLawDataBase.GetGroups() do
		local o = hoi3.api.CLawGroup(d:GetKey())
		o:bind(d)
	end
	
	for d in CLawDataBase.GetLawList() do
		local o = hoi3.api.CLaw(d:GetKey())
		o:bind(d)
	end
	
	for d in CSubUnitDataBase.GetSubUnitList() do
		local o = hoi3.api.CSubUnitDefinition(d:GetKey():GetString())
		o:bind(d)
	end
	
	for d in CTechnologyDataBase.GetCategories() do
		local o = hoi3.api.CTechnologyCategory(d:GetKey():GetString())
		o:bind(d)
	end
	
	-- From here there is no complete iterator, only index
	for i=0,99 do
		d = CBuildingDataBase.GetBuildingFromIndex(i)
		local o = hoi3.api.CBuilding(d:GetName())
		o:bind(d)
	end
	
	for i=0,99 do
		d = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(i)
		local o = hoi3.api.CGovernmentPosition(tostring(i))
		o:bind(d)
	end
	
	-- Missing :
	-- * CDecision
	-- * CIdeology
	-- * CIdeologyGroup
	-- * CTechnology
	-- * CTradeRoute 
end

function checkStatic()
	local hasErr = false
	for className, class in dtools.table.orderedPairs(hoi3.api.getApi()) do
		for methodName, method in class:getApiFunctions() do
			if _G[className] == nil then
				report("Expected static class "..className.." does not exists")
				hasErr = true
			else
				if _G[className].methodName == nil then
					report("Expected static method "..className.."."..methodName.." does not exists")
					hasErr = true
				else
					local t = type(_G[className].methodName)
					if t ~= hoi3.TYPE_FUNCTION then
						report("Expected static method "..className.."."..methodName.." is not function !")
						hasErr = true
					end 
				end
			end
		end
	end
	
	return hasErr
end

function checkConstants()
	local hasErr = false
	for className, class in dtools.table.orderedPairs(hoi3.api.getCompleteApi()) do
		for constantName, constant in class:getConstants() do
			if _G[className] == nil then
				report("Expected static class "..className.." does not exists")
				hasErr = true
			else
				if _G[className].constantName == nil then
					report("Expected static constant "..className.."."..constantName.." does not exists")
					hasErr = true
				else
					local t = type(_G[className][constantName])
					local t2 = type(constant)
					if t ~= t2 then
						report("Expected static constant "..className.."."..methodName.." has not the right type, expected "..t2.." got "..t1.." !")
						hasErr = true
					else
						if _G[className][constantName] ~= constant then
							report("Expected static constant "..className.."."..methodName.." has not the right value, expected "..constant.." got "..tostring(_G[className][constantName]).." !")
							hasErr = true
						end
					end 
				end
			end
		end
	end
	
	return hasErr
end