--[[
	Impl HOI3 API configuration file for randomizer
	
	It is quite interresting to be able to randomize data but we prefer
	to avoid bullcrap. Instead of relying on too much hardcoded value
	definition (countries, factions, provinces, ...) in xxxImpl() methods 
]]

module("hoi3.conf", package.seeall)

function continentDatabase()
	local def = {}
	--tag, name
	table.insert(def,{'ASI','asia'})
	table.insert(def,{'EUR','europe'})
	table.insert(def,{'AFR','africa'})
	table.insert(def,{'AME','america'})
	table.insert(def,{'OCE','oceania'})
	
	local db = {}
	for i,contidef in ipairs(def) do
		local continent = CContinent(contidef[1])
		
		-- Save values
		-- GetName
		continent:saveResult(contidef[2],CContinent.GetName)
		
		-- Save to DB
		db[continent] = continent
	end
	
	return db
end

function ideologyDatabase()
	local def = {}
	--name, ideologygroup
	table.insert(def,{'national_socialist','fascism'})
	table.insert(def,{'fascistic','fascism'})
	table.insert(def,{'paternal_autocrat','fascism'})
	table.insert(def,{'social_conservative','democracy'})
	table.insert(def,{'market_liberal','democracy'})
	table.insert(def,{'social_liberal','democracy'})
	table.insert(def,{'social_democrat','democracy'})
	table.insert(def,{'left_wing_radical','communism'})
	table.insert(def,{'leninist','communism'})
	table.insert(def,{'stalinist','communism'})
	
	local db = {}
	for i,ideodef in ipairs(def) do
		local ideology = CIdeology(ideodef[1])
		
		-- Save values
		-- GetIdeologyGroup
		ideology:saveResult(CIdeologyGroup(factdef[2]),CIdeology.GetIdeologyGroup)
		
		-- Save to DB
		db[ideology] = ideology
	end
	
	return db
end

function factionDatabase()
	local def = {}
	--name, leadertag, members, valid, ideologygroup
	table.insert(def,{'cominterm','SOV',{'SOV'},true,'communism'})
	table.insert(def,{'allies','ENG',{'ENG','FRA'},true,'democracy'})
	table.insert(def,{'axis','GER',{'GER'},true,'fascism'})
	
	local db = {}
	for i,factdef in ipairs(def) do
		local faction = CFaction(factdef[1])
		
		-- Save values
		-- GetFactionLeader
		faction:saveResult(CCountryTag(factdef[2]),CFaction.GetFactionLeader)
		
		-- GetMembers
		local members = {}
		for k, v in pairs(factdef[3]) do
			table.insert(members,CCountryTag(v))
		end
		faction:saveResult(members,CFaction.GetMembers)

		-- IsValid
		faction:saveResult(factdef[4],CFaction.IsValid)
		
		-- GetIdeologyGroup
		faction:saveResult(CIdeologyGroup(factdef[5]),CFaction.GetIdeologyGroup)
		
		-- Save to DB
		db[faction] = faction
	end
	
	return db
end

function buildingDatabase()
	local def = {}
	def:insert({'air_base'})
	def:insert({'air_base'})
	def:insert({'naval_base'})
	def:insert({'radar_station'})
	def:insert({'land_fort'})
	def:insert({'coastal_fort'})
	def:insert({'anti_air'})
	def:insert({'industry'})
	def:insert({'infra'})
	def:insert({'rocket_test'})
	def:insert({'nuclear_reactor'})
	
	local db = {}
	for i,builddef in ipairs(def) do
		local building = CBuilding(builddef[1])
		db[building] = building
	end
	
	return db
end

function lawDatabase()
	local def = {}
	-- index, name, group
	
	def:insert({'open_society', 1, 'civil_law'})
	def:insert({'limited_restrictions', 2, 'civil_law'})
	def:insert({'repression', 3, 'civil_law'})
	def:insert({'totalitarian_system',  4, 'civil_law'})

	def:insert({'volunteer_army',  6, 'conscription_law'})
	def:insert({'one_year_draft',  7, 'conscription_law'})
	def:insert({'two_year_draft',  8, 'conscription_law'})
	def:insert({'three_year_draft',  9, 'conscription_law'})
	def:insert({'service_by_requirement',  10, 'conscription_law'})

	def:insert({'full_civilian_economy',  11, 'economic_law'})
	def:insert({'basic_mobilisation',  12, 'economic_law'})
	def:insert({'full_mobilisation',  13, 'economic_law'})
	def:insert({'war_economy',  14, 'economic_law'})
	def:insert({'total_economic_mobilisation',  15, 'economic_law'})

	def:insert({'minimal_education_investment',  16, 'education_investment_law'})
	def:insert({'average_education_investment',  17, 'education_investment_law'})
	def:insert({'medium_large_education_investment',  18, 'education_investment_law'})
	def:insert({'big_education_investment',  19, 'education_investment_law'})
	
	def:insert({'consumer_product_orientation',  20, 'industrial_policy_laws'})
	def:insert({'mixed_industry',  21, 'industrial_policy_laws'})
	def:insert({'heavy_industry_emphasis',  22, 'industrial_policy_laws'})

	def:insert({'free_press',  23, 'press_laws'})
	def:insert({'censored_press',  24, 'press_laws'})
	def:insert({'state_press',  25, 'press_laws'})
	def:insert({'propaganda_press',  26, 'press_laws'})

	def:insert({'minimal_training',  27, 'training_laws'})
	def:insert({'basic_training',  28, 'training_laws'})
	def:insert({'advanced_training',  29, 'training_laws'})
	def:insert({'specialist_training',  30, 'training_laws'})
	
	local db = {}
	for i,lawdef in pairs(def) do
		local law = CLaw(i, v[1])
		
		-- GetGroup
		law:saveResult(CLawGroup(lawdef[3]),CLaw.GetGroup)
		
		-- GetIndex
		law:saveResult(lawdef[2],CLaw.GetIndex)
		
		db[building] = building
	end
	
	return db
end

function countryDatabase()
	-- key is country TAG string
	-- value is Ccountry
	
	local def = {}
	--Country,ideology, Real,Valid,Overlord,Neutrality,National Unity,Victory Points,IC,Leadership,Manpower,Energy,Metal,Rare Materials,Crude Oil,Air Base,Naval Base,Anti Air,National Unity - Neutrality,Resources Per IC,GDP,IC Per Manpower,IC Per Leadership,Leadership Per Manpower
	def['AFG'] = {"Afghanistan",nil,true,true,nil,90,50.0,2.0,nil,0.5,5.0,8.0,nil,nil,nil,nil,nil,nil,-40.0,0.00,5.40,0.00,0.00,0.10}
	def['ALB'] = {"Albania",nil,true,true,nil,70,50.0,2.0,nil,0.2,2.0,nil,nil,1.0,3.0,2.0,6.0,1.0,-20.0,0.00,7.45,0.00,0.00,0.10}
	def['ARG'] = {"Argentina",nil,true,true,nil,80,70.0,13.0,23.0,1.6,16.0,41.0,21.0,11.0,11.0,6.0,13.0,7.0,-10.0,0.73,42.60,1.44,14.37,0.10}
	def['AST'] = {"Australia",nil,true,true,nil,90,80.0,22.0,25.0,3.0,16.0,73.0,72.0,14.0,1.0,35.0,66.0,26.0,-10.0,0.93,44.40,1.56,8.33,0.19}
	def['AUS'] = {"Austria",nil,true,true,nil,100,50.0,12.0,19.0,1.1,11.0,58.0,33.0,12.0,2.0,14.0,nil,7.0,-50.0,1.00,34.10,1.73,17.27,0.10}
	def['BEL'] = {"Belgium",nil,true,true,nil,100,90.0,8.0,26.0,1.55,10.0,70.0,61.0,31.0,nil,10.0,6.0,5.0,-10.0,1.13,46.80,2.60,16.77,0.15}
	def['BHU'] = {"Bhutan",nil,true,true,"ENG",100,70.0,1.0,nil,0.2,2.0,nil,nil,nil,nil,nil,nil,nil,-30.0,0.00,5.00,0.00,0.00,0.10}
	def['BOL'] = {"Bolivia",nil,true,true,nil,80,60.0,2.0,7.0,0.4,4.0,11.0,64.0,5.0,nil,4.0,nil,1.0,-20.0,0.46,19.95,1.75,17.50,0.10}
	def['BRA'] = {"Brazil",nil,true,true,nil,80,70.0,15.0,35.0,3.5,35.0,55.0,33.0,22.0,nil,12.0,20.0,7.0,-10.0,0.69,50.45,1.00,10.00,0.10}
	def['BUL'] = {"Bulgaria",nil,true,true,nil,80,70.0,3.0,21.0,1.1,11.0,24.0,18.0,7.0,nil,4.0,5.0,4.0,-10.0,0.46,30.40,1.91,19.09,0.10}
	def['CAN'] = {"Canada",nil,true,true,nil,90,90.0,5.0,27.0,3.0,15.0,60.0,81.0,20.0,4.0,42.0,37.0,18.0,0.0,0.94,50.10,1.80,9.00,0.20}
	def['CGX'] = {"Guangxi Clique",nil,true,true,nil,70,60.0,6.0,23.0,5.4,39.0,61.0,24.0,10.0,nil,9.0,20.0,2.0,-10.0,0.71,35.45,0.59,4.26,0.14}
	def['CHC'] = {"Communist China",nil,true,true,nil,100,70.0,1.0,5.0,0.6,6.0,10.0,5.0,3.0,nil,nil,nil,nil,-30.0,0.50,11.60,0.83,8.33,0.10}
	def['CHI'] = {"Nationalist China",nil,true,true,nil,70,70.0,26.0,50.0,6.9,122.0,68.0,56.0,16.0,nil,20.0,20.0,4.0,0.0,0.58,67.20,0.41,7.25,0.06}
	def['CHL'] = {"Chile",nil,true,true,nil,90,65.0,5.0,12.0,0.9,9.0,22.0,67.0,4.0,nil,4.0,8.0,2.0,-25.0,0.47,25.60,1.33,13.33,0.10}
	def['COL'] = {"Colombia",nil,true,true,nil,90,80.0,6.0,11.0,0.8,8.0,16.0,9.0,4.0,10.0,1.0,2.0,4.0,-10.0,0.50,26.00,1.38,13.75,0.10}
	def['COS'] = {"Costa Rica",nil,true,true,nil,90,75.0,1.0,nil,0.2,2.0,6.0,nil,nil,nil,4.0,10.0,1.0,-15.0,0.00,5.30,0.00,0.00,0.10}
	def['CRO'] = {"Croatia",nil,false,true,nil,70,60.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	def['CSX'] = {"Shanxi",nil,true,true,nil,70,70.0,11.0,13.0,2.4,24.0,58.0,8.0,4.0,nil,5.0,8.0,nil,0.0,0.44,22.50,0.54,5.42,0.10}
	def['CUB'] = {"Cuba",nil,true,true,nil,90,60.0,3.0,2.0,0.5,5.0,12.0,2.0,1.0,nil,nil,4.0,1.0,-30.0,0.29,8.00,0.40,4.00,0.10}
	def['CXB'] = {"Xibei San Ma",nil,true,true,nil,70,70.0,2.0,6.0,0.7,8.0,16.0,6.0,4.0,nil,nil,nil,nil,0.0,0.55,13.20,0.75,8.57,0.09}
	def['CYN'] = {"Yunnan",nil,true,true,nil,70,70.0,5.0,6.0,0.9,9.0,11.0,19.0,3.0,nil,nil,nil,nil,0.0,0.50,14.05,0.67,6.67,0.10}
	def['CZE'] = {"Czechoslovakia",nil,true,true,nil,90,70.0,13.0,31.0,2.9,11.5,95.0,32.0,10.0,nil,4.0,nil,8.0,-20.0,0.56,45.95,2.70,10.69,0.25}
	def['DDR'] = {"DDR",nil,false,true,"SOV",80,75.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-5.0,0.00,5.00,nil,nil,nil}
	def['DEN'] = {"Denmark",nil,true,true,nil,90,90.0,3.0,13.0,0.9,9.0,22.0,9.0,5.0,nil,18.0,17.0,4.0,0.0,0.50,21.00,1.44,14.44,0.10}
	def['DFR'] = {"FRG",nil,false,true,nil,95,80.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-15.0,0.00,5.00,nil,nil,nil}
	def['DOM'] = {"Dominican Republic",nil,true,true,nil,100,65.0,5.0,1.0,0.3,3.0,10.0,nil,nil,nil,1.0,2.0,nil,-35.0,0.00,6.50,0.33,3.33,0.10}
	def['ECU'] = {"Ecuador",nil,true,true,nil,95,60.0,2.0,6.0,0.4,4.0,11.0,5.0,3.0,2.0,1.0,7.0,2.0,-35.0,0.45,14.15,1.50,15.00,0.10}
	def['EGY'] = {"Egypt",nil,false,true,nil,85,65.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-20.0,0.00,5.00,nil,nil,nil}
	def['ENG'] = {"United Kingdom",nil,true,true,nil,90,80.0,118.0,155.0,33.29,204.5,390.5,208.0,215.0,43.0,216.0,308.0,89.0,-10.0,1.22,275.58,0.76,4.66,0.16}
	def['EST'] = {"Estonia",nil,true,true,nil,100,70.0,2.0,1.0,0.4,4.0,2.0,nil,nil,nil,2.0,6.0,1.0,-30.0,0.00,6.10,0.25,2.50,0.10}
	def['ETH'] = {"Ethiopia",nil,true,true,nil,70,75.0,2.0,2.0,0.8,8.0,3.0,1.0,nil,nil,nil,nil,nil,5.0,0.00,7.25,0.25,2.50,0.10}
	def['FIN'] = {"Finland",nil,true,true,nil,100,70.0,13.0,13.0,0.9,9.0,26.0,14.0,13.0,nil,29.0,17.0,10.0,-30.0,0.72,23.30,1.44,14.44,0.10}
	def['FRA'] = {"France",nil,true,true,nil,90,50.0,113.5,103.0,12.24,82.0,317.0,192.0,86.0,nil,111.0,128.0,66.0,-40.0,1.47,160.25,1.26,8.42,0.15}
	def['GER'] = {"Germany",nil,true,true,nil,60,90.0,115.0,136.0,20.25,59.0,592.0,140.0,68.0,2.0,82.0,45.0,36.0,30.0,0.96,199.70,2.31,6.72,0.34}
	def['GRE'] = {"Greece",nil,true,true,nil,75,90.0,4.0,15.0,1.1,11.0,24.0,19.0,6.0,nil,6.0,16.0,4.0,15.0,0.60,24.30,1.36,13.64,0.10}
	def['GUA'] = {"Guatemala",nil,true,true,nil,85,55.0,1.0,nil,0.4,4.0,8.0,nil,nil,nil,4.0,4.0,1.0,-30.0,0.00,5.40,0.00,0.00,0.10}
	def['GUY'] = {"Guyana",nil,true,true,nil,80,80.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	def['HAI'] = {"Haiti",nil,true,true,nil,80,75.0,1.0,nil,0.3,3.0,8.0,nil,1.0,nil,2.0,4.0,1.0,-5.0,0.00,5.60,0.00,0.00,0.10}
	def['HOL'] = {"Netherlands",nil,true,true,nil,100,90.0,20.0,31.0,2.5,8.4,102.0,101.0,98.0,22.0,20.0,76.0,14.0,-10.0,1.42,87.30,3.69,12.40,0.30}
	def['HON'] = {"Honduras",nil,true,true,nil,75,65.0,1.0,nil,0.3,3.0,10.0,nil,nil,nil,4.0,4.0,1.0,-10.0,0.00,5.50,0.00,0.00,0.10}
	def['HUN'] = {"Hungary",nil,true,true,nil,50,70.0,5.0,22.0,2.4,12.0,35.0,37.0,10.0,2.0,8.0,nil,2.0,20.0,0.65,35.95,1.83,9.17,0.20}
	def['ICL'] = {"Iceland",nil,false,true,nil,80,90.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,10.0,0.00,5.00,nil,nil,nil}
	def['IDC'] = {"Indochina",nil,false,true,nil,80,65.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-15.0,0.00,5.00,nil,nil,nil}
	def['IND'] = {"India",nil,false,true,nil,80,80.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	def['INO'] = {"Indonesia",nil,false,true,nil,80,70.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	def['IRE'] = {"Ireland",nil,true,true,nil,95,80.0,2.0,10.0,0.4,4.0,22.0,14.0,5.0,nil,4.0,10.0,2.0,-15.0,0.67,18.50,2.50,25.00,0.10}
	def['IRQ'] = {"Iraq",nil,true,true,"ENG",70,70.0,6.0,nil,0.7,7.0,15.0,nil,nil,12.0,4.0,4.0,5.0,0.0,0.00,14.75,0.00,0.00,0.10}
	def['ISR'] = {"Israel",nil,false,true,nil,70,70.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	def['ITA'] = {"Italy",nil,true,true,nil,60,80.0,64.0,64.0,9.0,43.0,118.0,94.0,34.0,nil,86.0,87.0,26.0,20.0,0.86,91.10,1.49,7.11,0.21}
	def['JAP'] = {"Japan",nil,true,true,nil,60,70.0,101.0,89.0,14.4,74.0,218.0,103.0,34.0,2.0,137.0,171.0,58.0,10.0,0.72,123.50,1.20,6.18,0.19}
	def['JOR'] = {"Jordan",nil,false,true,nil,80,75.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-5.0,0.00,5.00,nil,nil,nil}
	def['KOR'] = {"Korea",nil,false,true,nil,70,70.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	def['LAT'] = {"Latvia",nil,true,true,nil,100,70.0,2.0,3.0,0.4,4.0,4.0,1.0,nil,nil,1.0,3.0,1.0,-30.0,0.00,8.30,0.75,7.50,0.10}
	def['LEB'] = {"Lebanon",nil,true,true,nil,80,70.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	def['LIB'] = {"Liberia",nil,true,true,"USA",100,70.0,1.0,nil,0.3,3.0,6.0,nil,2.5,nil,4.0,2.0,1.0,-30.0,0.00,5.80,0.00,0.00,0.10}
	def['LIT'] = {"Lithuania",nil,true,true,nil,100,70.0,2.0,3.0,0.4,4.0,4.0,1.0,1.0,nil,3.0,2.0,1.0,-30.0,0.12,8.50,0.75,7.50,0.10}
	def['LUX'] = {"Luxemburg",nil,true,true,nil,100,80.0,1.0,5.0,0.1,1.0,10.0,21.0,3.0,nil,nil,nil,nil,-20.0,0.50,13.20,5.00,50.00,0.10}
	def['MAN'] = {"Manchukuo",nil,true,true,"JAP",70,70.0,6.0,19.0,2.1,21.0,55.0,24.0,7.0,nil,2.0,3.0,2.0,0.0,0.58,30.55,0.90,9.05,0.10}
	def['MEN'] = {"Mengkukuo",nil,false,true,nil,70,75.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,5.0,0.00,5.00,nil,nil,nil}
	def['MEX'] = {"Mexico",nil,true,true,nil,80,80.0,6.0,14.0,1.9,19.0,26.0,40.0,3.0,20.0,2.0,8.0,6.0,0.0,0.32,39.90,0.74,7.37,0.10}
	def['MON'] = {"Mongolia",nil,true,true,nil,80,60.0,2.0,5.0,0.3,3.0,10.0,5.0,3.0,nil,1.0,nil,nil,-20.0,0.50,11.60,1.67,16.67,0.10}
	def['NEP'] = {"Nepal",nil,true,true,"ENG",90,70.0,1.0,nil,0.5,5.0,6.0,nil,nil,nil,nil,nil,nil,-20.0,0.00,5.30,0.00,0.00,0.10}
	def['NIC'] = {"Nicaragua",nil,true,true,nil,60,50.0,1.0,nil,0.3,3.0,8.0,nil,nil,nil,1.0,1.0,nil,-10.0,0.00,5.40,0.00,0.00,0.10}
	def['NOR'] = {"Norway",nil,true,true,nil,100,90.0,10.0,11.0,1.0,8.0,26.0,12.0,5.0,nil,14.0,27.0,5.0,-10.0,0.62,19.50,1.38,11.00,0.12}
	def['NZL'] = {"New Zealand",nil,true,true,nil,65,80.0,4.0,3.0,0.6,6.0,10.0,3.0,1.5,nil,3.0,13.0,2.0,15.0,0.38,9.10,0.50,5.00,0.10}
	def['OMN'] = {"Oman",nil,true,true,nil,80,75.0,2.0,nil,0.2,2.0,nil,nil,nil,nil,1.0,3.0,2.0,-5.0,0.00,5.00,0.00,0.00,0.10}
	def['PAK'] = {"Pakistan",nil,true,true,nil,75,60.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-15.0,0.00,5.00,nil,nil,nil}
	def['PAL'] = {"Palestine",nil,false,true,nil,90,70.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-20.0,0.00,5.00,nil,nil,nil}
	def['PAN'] = {"Panama",nil,true,true,"USA",70,75.0,5.0,nil,nil,nil,6.0,nil,nil,nil,4.0,4.0,3.0,5.0,0.00,5.30,nil,nil,nil}
	def['PAR'] = {"Paraguay",nil,true,true,nil,70,50.0,1.0,5.0,0.4,4.0,10.0,5.0,3.0,nil,4.0,nil,1.0,-20.0,0.50,11.60,1.25,12.50,0.10}
	def['PER'] = {"Persia",nil,true,true,nil,55,75.0,7.0,3.0,0.8,8.0,24.0,2.0,4.5,40.0,1.0,3.0,2.0,20.0,0.25,40.30,0.38,3.75,0.10}
	def['PHI'] = {"Philippines",nil,true,true,"USA",100,75.0,9.0,6.0,1.0,10.0,8.0,8.0,2.0,nil,6.0,25.0,6.0,-25.0,0.36,12.60,0.60,6.00,0.10}
	def['POL'] = {"Poland",nil,true,true,nil,60,70.0,14.0,42.0,3.7,31.0,187.0,63.0,16.0,2.0,33.0,8.0,18.0,10.0,0.68,67.35,1.35,11.35,0.12}
	def['POR'] = {"Portugal",nil,true,true,nil,80,80.0,14.0,18.0,1.5,15.0,27.0,15.0,9.0,nil,21.0,35.0,11.0,0.0,0.59,27.65,1.20,12.00,0.10}
	def['PRK'] = {"People's Republic of Korea",nil,false,true,nil,70,50.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-20.0,0.00,5.00,nil,nil,nil}
	def['PRU'] = {"Peru",nil,true,true,nil,60,75.0,4.0,10.0,1.0,10.0,15.0,17.0,4.0,6.0,1.0,7.0,2.0,15.0,0.50,22.75,1.00,10.00,0.10}
	def['REB'] = {"Rebels",nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,0.00,5.00,nil,nil,nil}
	def['ROM'] = {"Romania",nil,true,true,nil,90,70.0,8.0,30.0,1.9,19.0,75.0,26.0,13.0,40.0,6.0,8.0,8.0,-20.0,0.74,73.95,1.58,15.79,0.10}
	def['RSI'] = {"Italian Social Republic",nil,false,true,nil,0,40.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,40.0,0.00,5.00,nil,nil,nil}
	def['SAF'] = {"South Africa",nil,true,true,nil,70,80.0,10.0,12.0,1.3,13.0,70.0,18.0,4.0,nil,12.0,16.0,13.0,10.0,0.47,23.10,0.92,9.23,0.10}
	def['SAL'] = {"El Salvador",nil,true,true,nil,80,55.0,2.0,nil,0.6,6.0,8.0,nil,nil,nil,5.0,5.0,1.0,-25.0,0.00,5.40,0.00,0.00,0.10}
	def['SAU'] = {"Saudi Arabia",nil,true,true,nil,80,75.0,1.0,nil,0.4,4.0,nil,nil,nil,12.0,1.0,7.0,2.0,-5.0,0.00,14.00,0.00,0.00,0.10}
	def['SCH'] = {"Switzerland",nil,true,true,nil,100,85.0,2.0,14.0,0.5,5.0,31.0,18.0,9.0,nil,4.0,nil,14.0,-15.0,0.82,24.15,2.80,28.00,0.10}
	def['SIA'] = {"Siam",nil,true,true,nil,60,65.0,6.0,5.0,1.3,12.0,6.0,11.0,7.5,nil,4.0,13.0,2.0,5.0,0.30,12.90,0.42,3.85,0.11}
	def['SIK'] = {"Sinkiang",nil,true,true,nil,60,70.0,1.0,6.0,0.68,7.0,11.0,5.0,3.0,nil,nil,nil,nil,10.0,0.45,12.65,0.86,8.82,0.10}
	def['SLO'] = {"Slovakia",nil,false,true,nil,30,60.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,30.0,0.00,5.00,nil,nil,nil}
	def['SOV'] = {"Soviet Union",nil,true,true,nil,80,55.0,170.0,156.0,11.75,226.5,897.0,404.0,186.0,80.0,121.0,68.0,72.0,-25.0,2.31,343.45,0.69,13.28,0.05}
	def['SPA'] = {"Nationalist Spain",nil,true,true,nil,60,65.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,5.0,0.00,5.00,nil,nil,nil}
	def['SPR'] = {"Republican Spain",nil,false,true,nil,70,50.0,19.0,39.0,2.6,26.0,70.0,46.0,33.0,nil,24.0,48.0,15.0,-20.0,0.80,58.70,1.50,15.00,0.10}
	def['SWE'] = {"Sweden",nil,true,true,nil,100,90.0,13.0,21.0,1.25,11.0,25.0,60.0,16.0,nil,20.0,30.0,8.0,-10.0,0.48,36.45,1.91,16.80,0.11}
	def['SYR'] = {"Syria",nil,true,true,nil,80,70.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	def['TAN'] = {"Tannu Tuva",nil,true,true,"SOV",70,75.0,1.0,nil,0.3,3.0,nil,nil,nil,nil,nil,nil,nil,5.0,0.00,5.00,0.00,0.00,0.10}
	def['TIB'] = {"Tibet",nil,true,true,nil,100,75.0,3.0,nil,0.3,3.0,nil,nil,nil,nil,nil,nil,nil,-25.0,0.00,5.00,0.00,0.00,0.10}
	def['TUR'] = {"Turkey",nil,true,true,nil,90,55.0,11.0,20.0,1.3,13.0,53.0,17.0,17.0,nil,12.0,28.0,8.0,-35.0,0.68,32.75,1.54,15.38,0.10}
	def['URU'] = {"Uruguay",nil,true,true,nil,100,75.0,1.0,10.0,0.5,5.0,16.0,8.0,4.0,nil,1.0,6.0,1.0,-25.0,0.53,17.40,2.00,20.00,0.10}
	def['USA'] = {"USA",nil,true,true,nil,100,80.0,55.0,251.0,25.0,142.0,1389.0,740.0,244.0,604.0,237.0,133.0,69.0,-20.0,1.91,901.25,1.77,10.04,0.18}
	def['VEN'] = {"Venezuela",nil,true,true,nil,80,60.0,4.0,8.0,0.8,8.0,22.5,7.0,3.0,110.0,1.0,6.0,4.0,-20.0,0.46,97.92,1.00,10.00,0.10}
	def['VIC'] = {"Vichy France",nil,false,true,nil,40,50.0,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,10.0,0.00,5.00,nil,nil,nil}
	def['YEM'] = {"Yemen",nil,true,true,nil,100,70.0,1.0,nil,0.2,2.0,nil,nil,nil,nil,nil,3.0,nil,-30.0,0.00,5.00,0.00,0.00,0.10}
	def['YUG'] = {"Yugoslavia",nil,true,true,nil,75,60.0,7.0,26.0,1.9,19.0,38.0,40.0,12.0,nil,8.0,6.0,9.0,-15.0,0.61,39.30,1.37,13.68,0.10}

	local db = {}
	for k,ctyDef in pairs(def) do
		local tag = CCountryTag(k)
		local cty = CCountry(tag)
		
		-- CCountryTag
		-- IsReal
		tag:saveResult(ctyDef[3],CCountryTag.IsReal)
		-- IsValid
		tag:saveResult(ctyDef[4],CCountryTag.IsValid)
		
		-- CCountry
		-- GetOverlord
		if ctyDef[5] ~= nil then
			tag:saveResult(CCountryTag(ctyDef[5]),CCountry.GetOverlord)
			tag:saveResult(true,CCountry.isPuppet)
			tag:saveResult(true,CCountry.IsSubject)
		else
			tag:saveResult(CNullTag(),CCountry.GetOverlord)
			tag:saveResult(false,CCountry.isPuppet)
			tag:saveResult(false,CCountry.IsSubject)
		end
		 
		-- Save reference to db  
		db[cty] = cty
	end

	return db
end