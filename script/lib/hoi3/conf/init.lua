--[[
	Fake HOI3 API configuration file for randomizer
	
	It is quite interresting to be able to randomize data but we prefer
	to avoid bullcrap. Instead of relying on too much hardcoded value
	definition (countries, factions, provinces, ...) in 
]]

module("hoi3.conf", package.seeall)

countryTags = {}
factions = {"cominterm", "allies", "axis" }