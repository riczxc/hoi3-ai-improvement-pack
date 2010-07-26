require('hoi3.api')
require('dtools.table')
module( "hoi3", package.seeall)

--[[
All possible arg type for API calls
*CDiplomaticAction -> void, don't bother
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
local didRun = false

function dump()
	if didRun == true then return end
	
	hoi3.MultitonObject.clearInstances()
	
	-- First of all, check ALL constants !
	if not checkMethods() or not checkConstants() then
		report("Failed to dump, either static methods or constants are not synchronize between fake API and real API.")
		didRun = true
		return
	end
	
	-- Read all needed objects used in data
	dtools.debug("hoi3.dump - About to check db")
	checkDataBases()
	
	dtools.debug("hoi3.dump - About to run saveAll")
	saveAll()
	
	-- Serialize
	dtools.debug("hoi3.dump - About to Serialize")
	hoi3.MultitonObject.serializeInstances("SAVE000.lua")
	
	-- Start
	dtools.debug("hoi3.dump - Done !")
	didRun = true
end

function pingStatic(class,name)
	local function _pingStatic(class,name)
		if name ~= nil then 
			return _G[class][name] ~= nil
		else
			return _G[class] ~= nil
		end
	end

	local retOK, ret = pcall(_pingStatic, class, name)
	if retOK == false then
		return false
	else
		return ret
	end
end


function report(err)
	dtools.error(err)
end

function saveAll()
	-- Save all object instances from ccountrytag, we should scan
	-- all object types from here.
	for k,v in pairs(hoi3.api.CCountryTag:getInstances()) do
		v:runRealApiAndSave()
	end 
	
	-- Display performance summary
	for className, class in dtools.table.orderedPairs(hoi3.api.getApi()) do
		for methodName, m in pairs(class:getApiFunctions()) do
			dtools.debug(m:signatureAsString().."/"..m.realruns.."/"..m.realtime)
		end
	end			
end

---
-- creates an instance for every named/unique object outthere.
function checkDataBases()
	dtools.debug("CCountryTag & CCountry & CProvince & CIdeology & CIdeologyGroup")
	-- Start by referencing all databased objects
	for d in CCurrentGameState.GetCountries() do
		local t = hoi3.api.CCountryTag:userdataToInstance(d:GetCountryTag())
		local o = hoi3.api.CCountry:userdataToInstance(d)
		
		for pid in d:GetControlledProvinces() do
			local p = hoi3.api.CProvince:userdataToInstance(CCurrentGameState.GetProvince(pid))
		end
		
		for min in d:GetPossibleMinisters() do	
			local i = hoi3.api.CIdeology:userdataToInstance(min:GetIdeology())		
			local i = hoi3.api.CIdeologyGroup:userdataToInstance(min:GetIdeology():GetGroup())
		end
	end
	
	dtools.debug("CFaction")
	for d in CCurrentGameState.GetFactions() do
		local o = hoi3.api.CFaction:userdataToInstance(d)
	end
	dtools.debug("CLawGroup")
	for d in CLawDataBase.GetGroups() do
		local o = hoi3.api.CLawGroup:userdataToInstance(d)
	end
	dtools.debug("CLaw")
	for d in CLawDataBase.GetLawList() do
		local o = hoi3.api.CLaw:userdataToInstance(d)
	end
	dtools.debug("CSubUnitDefinition")
	for d in CSubUnitDataBase.GetSubUnitList() do
		local o = hoi3.api.CSubUnitDefinition:userdataToInstance(d)
	end
	dtools.debug("CTechnology")
	for d in CTechnologyDataBase.GetTechnologies() do
		local o = hoi3.api.CTechnology:userdataToInstance(d)
	end
	dtools.debug("CTechnologyCategory")
	for d in CTechnologyDataBase.GetCategories() do
		local o = hoi3.api.CTechnologyCategory:userdataToInstance(d)
	end
	dtools.debug("CGovernmentPosition")
	for d in CGovernmentPositionDataBase.GetGovernmentPositionList() do
		local o = hoi3.api.CGovernmentPosition:userdataToInstance(d)
	end
	dtools.debug("CMinisterType")
	for d in CMinisterTypeDataBase.GetMinisterTypeList() do
		local o = hoi3.api.CMinisterType:userdataToInstance(d)
	end
	dtools.debug("CBuilding")
	-- From here there is no complete iterator, only index
	for i=0,10 do
		d = CBuildingDataBase.GetBuildingFromIndex(i)
		if d ~= nil then 
			local o = hoi3.api.CBuilding:userdataToInstance(d)
		end
	end
	-- Missing :
	-- * CTradeRoute 
end

function checkMethods()
	local hasErr = false
	for className, class in dtools.table.orderedPairs(hoi3.api.getApi()) do
		if pingStatic(className) and not middleclass.subclassOf(hoi3.api.AbstractObject, class) then
			for methodName, method in pairs(class:getApiFunctions()) do
				if not pingStatic(className,methodName) then
					report("Expected static method "..className.."."..methodName.." does not exists")
					hasErr = true
				else
					local t = type(_G[className][methodName])
					if t ~= hoi3.TYPE_FUNCTION then
						report("Expected static method "..className.."."..methodName.." is not function !")
						hasErr = true
					end 
				end
			end
		else
			report("Expected static class "..className.." does not exists")
			hasErr = true
		end
	end
	
	return not hasErr
end

function checkConstants()
	local hasErr = false
	for className, class in dtools.table.orderedPairs(hoi3.api.getApi()) do
		if pingStatic(className) then
			for constantName, constant in pairs(class:getConstants()) do
				if not pingStatic(className,constantName) then
					report("Expected static constant "..className.."."..constantName.." does not exists")
					hasErr = true
				else
					local t = type(_G[className][constantName])
					local t2 = type(constant)
					if t ~= t2 then
						report("Expected static constant "..className.."."..constantName.." has not the right type, expected "..t2.." got "..t1.." !")
						hasErr = true
					else
						if _G[className][constantName] ~= constant then
							report("Expected static constant "..className.."."..constantName.." has not the right value, expected "..constant.." got "..tostring(_G[className][constantName]).." !")
							hasErr = true
						end
					end 
				end
			end
		else
			report("Expected static class "..className.." does not exists")
			hasErr = true
		end
	end
	
	return not hasErr
end