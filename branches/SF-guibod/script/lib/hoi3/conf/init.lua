--[[
	Impl HOI3 API configuration file for randomizer
	
	It is quite interresting to be able to randomize data but we prefer
	to avoid bullcrap. Instead of relying on too much hardcoded value
	definition (countries, factions, provinces, ...) in xxxImpl() methods 
]]

module("hoi3.conf", package.seeall)

function factionDatabase()
	local db = {}
	db[1] = CFaction(1,'cominterm')
	db[2] = CFaction(2,'allies')
	db[3] = CFaction(3,'axis')
	
	return db
end

function buildingDatabase()
	local db = {}
	db[1] = CBuilding(1,'air_base')
	db[2] = CBuilding(2,'naval_base')
	db[3] = CBuilding(3,'radar_station')
	db[4] = CBuilding(4,'land_fort')
	db[5] = CBuilding(5,'coastal_fort')
	db[6] = CBuilding(6,'anti_air')
	db[7] = CBuilding(7,'industry')
	db[8] = CBuilding(8,'infra')
	db[9] = CBuilding(9,'rocket_test')
	db[10] = CBuilding(10,'nuclear_reactor')
	
	return db
end