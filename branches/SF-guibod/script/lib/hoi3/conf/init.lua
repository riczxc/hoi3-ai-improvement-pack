--[[
	Impl HOI3 API configuration file for randomizer
	
	It is quite interresting to be able to randomize data but we prefer
	to avoid bullcrap. Instead of relying on too much hardcoded value
	definition (countries, factions, provinces, ...) in xxxImpl() methods 
]]

module("hoi3.conf", package.seeall)

function generateAll()
	generateContinentDatabase()
	generateIdeologyDatabase()
	generateFactionDatabase()
	generateBuildingDatabase()
	generateLawDatabase()
	generateCountryDatabase()
	generateProvinceDatabase()
	generateSubUnitDatabase()
	generateTechDatabase()
end

function generateContinentDatabase()
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

function generateIdeologyDatabase()
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
		ideology:saveResult(CIdeologyGroup(ideodef[2]),CIdeology.GetGroup)
		
		-- Save to DB
		db[ideology] = ideology
	end
	
	return db
end

function generateFactionDatabase()
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

function generateBuildingDatabase()
	local def = {}
	table.insert(def,{'air_base'})
	table.insert(def,{'air_base'})
	table.insert(def,{'naval_base'})
	table.insert(def,{'radar_station'})
	table.insert(def,{'land_fort'})
	table.insert(def,{'coastal_fort'})
	table.insert(def,{'anti_air'})
	table.insert(def,{'industry'})
	table.insert(def,{'infra'})
	table.insert(def,{'rocket_test'})
	table.insert(def,{'nuclear_reactor'})
	
	local db = {}
	for i,builddef in ipairs(def) do
		local building = CBuilding(builddef[1])
		db[building] = building
	end
	
	return db
end

function generateLawDatabase()
	local def = {}
	-- index, name, group
	
	table.insert(def,{'open_society', 1, 'civil_law'})
	table.insert(def,{'limited_restrictions', 2, 'civil_law'})
	table.insert(def,{'repression', 3, 'civil_law'})
	table.insert(def,{'totalitarian_system',  4, 'civil_law'})

	table.insert(def,{'volunteer_army',  6, 'conscription_law'})
	table.insert(def,{'one_year_draft',  7, 'conscription_law'})
	table.insert(def,{'two_year_draft',  8, 'conscription_law'})
	table.insert(def,{'three_year_draft',  9, 'conscription_law'})
	table.insert(def,{'service_by_requirement',  10, 'conscription_law'})

	table.insert(def,{'full_civilian_economy',  11, 'economic_law'})
	table.insert(def,{'basic_mobilisation',  12, 'economic_law'})
	table.insert(def,{'full_mobilisation',  13, 'economic_law'})
	table.insert(def,{'war_economy',  14, 'economic_law'})
	table.insert(def,{'total_economic_mobilisation',  15, 'economic_law'})

	table.insert(def,{'minimal_education_investment',  16, 'education_investment_law'})
	table.insert(def,{'average_education_investment',  17, 'education_investment_law'})
	table.insert(def,{'medium_large_education_investment',  18, 'education_investment_law'})
	table.insert(def,{'big_education_investment',  19, 'education_investment_law'})
	
	table.insert(def,{'consumer_product_orientation',  20, 'industrial_policy_laws'})
	table.insert(def,{'mixed_industry',  21, 'industrial_policy_laws'})
	table.insert(def,{'heavy_industry_emphasis',  22, 'industrial_policy_laws'})

	table.insert(def,{'free_press',  23, 'press_laws'})
	table.insert(def,{'censored_press',  24, 'press_laws'})
	table.insert(def,{'state_press',  25, 'press_laws'})
	table.insert(def,{'propaganda_press',  26, 'press_laws'})

	table.insert(def,{'minimal_training',  27, 'training_laws'})
	table.insert(def,{'basic_training',  28, 'training_laws'})
	table.insert(def,{'advanced_training',  29, 'training_laws'})
	table.insert(def,{'specialist_training',  30, 'training_laws'})
	
	local db = {}
	for i,lawdef in pairs(def) do
		local law = CLaw(lawdef[1])
		
		-- GetGroup
		law:saveResult(CLawGroup(lawdef[3]),CLaw.GetGroup)
				
		db[law] = law
	end
	
	return db
end

function generateCountryDatabase()
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
			cty:saveResult(CCountryTag(ctyDef[5]),CCountry.GetOverlord)
			cty:saveResult(true,CCountry.isPuppet)
			cty:saveResult(true,CCountry.IsSubject)
		else
			cty:saveResult(CNullTag(),CCountry.GetOverlord)
			cty:saveResult(false,CCountry.isPuppet)
			cty:saveResult(false,CCountry.IsSubject)
		end

		-- Save reference to db  
		db[cty] = cty
	end
	
	return db
end

function generateProvinceDatabase()
	local db = {}
	
	for i=1,12000 do
		local prov = CProvince(i)
		
		-- Save reference to db  
		db[prov] = prov
	end
	
	return db
end

function generateSubUnitDatabase()
	local def = {}
	-- key, name, group
	
	table.insert(def,{'anti_air_brigade'})
	table.insert(def,{'anti_tank_brigade'})
	table.insert(def,{'armor_brigade'})
	table.insert(def,{'armored_car_brigade'})
	table.insert(def,{'artillery_brigade'})
	table.insert(def,{'battlecruiser'})
	table.insert(def,{'battleship'})
	table.insert(def,{'bergsjaeger_brigade'})
	table.insert(def,{'cag'})
	table.insert(def,{'carrier'})
	table.insert(def,{'cas'})
	table.insert(def,{'cavalry_brigade'})
	table.insert(def,{'destroyer'})
	table.insert(def,{'engineer_brigade'})
	table.insert(def,{'escort_carrier'})
	table.insert(def,{'flying_bomb'})
	table.insert(def,{'flying_rocket'})
	table.insert(def,{'garrison_brigade'})
	table.insert(def,{'heavy_armor_brigade'})
	table.insert(def,{'heavy_cruiser'})
	table.insert(def,{'hq_brigade'})
	table.insert(def,{'infantry_brigade'})
	table.insert(def,{'interceptor'})
	table.insert(def,{'light_armor_brigade'})
	table.insert(def,{'light_cruiser'})
	table.insert(def,{'marine_brigade'})
	table.insert(def,{'mechanized_brigade'})
	table.insert(def,{'militia_brigade'})
	table.insert(def,{'motorized_brigade'})
	table.insert(def,{'multi_role'})
	table.insert(def,{'naval_bomber'})
	table.insert(def,{'nuclear_submarine'})
	table.insert(def,{'paratrooper_brigade'})
	table.insert(def,{'partisan_brigade'})
	table.insert(def,{'police_brigade'})
	table.insert(def,{'rocket_artillery_brigade'})
	table.insert(def,{'rocket_interceptor'})
	table.insert(def,{'sp_artillery_brigade'})
	table.insert(def,{'sp_rct_artillery_brigade'})
	table.insert(def,{'strategic_bomber'})
	table.insert(def,{'submarine'})
	table.insert(def,{'super_heavy_armor_brigade'})
	table.insert(def,{'super_heavy_battleship'})
	table.insert(def,{'tactical_bomber'})
	table.insert(def,{'tank_destroyer_brigade'})
	table.insert(def,{'transport'})
	table.insert(def,{'transport_plane'})
	
	local db = {}
	for k,unitDef in pairs(def) do
		local unit = CSubUnitDefinition(unitDef[1])
		
		-- IsReal
		--tag:saveResult(ctyDef[3],CCountryTag.IsReal)

		-- Save reference to db  
		db[unit] = unit
	end
	
	return db
end

function generateTechDatabase()
	local def = {}
	-- key, name, group
	-- key = {group}
	-- Still missing tons of tech since, I don't have access to common file ATM
	def['cavalry_smallarms'] = {'infantry_folder'} 
	def['cavalry_support'] = {'infantry_folder'}
	def['cavalry_guns'] = {'infantry_folder'} 
	def['cavalry_at'] = {'infantry_folder'}
	def['militia_smallarms'] = {'infantry_folder'}
	def['militia_support'] = {'infantry_folder'}
	def['militia_guns'] = {'infantry_folder'}
	def['militia_at'] = {'infantry_folder'}
	def['armored_car_armour'] = {'armour_folder'}
	def['armored_car_gun'] = {'armour_folder'}
	def['paratrooper_infantry'] = {'infantry_folder'}
	def['marine_infantry'] = {'infantry_folder'}
	def['imporved_police_brigade'] = {'infantry_folder'}
	def['desert_warfare_equipment'] = {'infantry_folder'}
	def['jungle_warfare_equipment'] = {'infantry_folder'}
	def['artic_warfare_equipment'] = {'infantry_folder'}
	def['amphibious_warfare_equipment'] = {'infantry_folder'}
	def['airborne_warfare_equipment'] = {'infantry_folder'}
	def['lighttank_brigade'] = {'armour_folder'}
	def['lighttank_gun'] = {'armour_folder'}
	def['lighttank_engine'] = {'armour_folder'}
	def['lighttank_armour'] = {'armour_folder'}
	def['lighttank_reliability'] = {'armour_folder'}
	def['tank_brigade'] = {'armour_folder'}
	def['tank_gun'] = {'armour_folder'}
	def['tank_engine'] = {'armour_folder'}
	def['tank_armour'] = {'armour_folder'}
	def['tank_reliability'] = {'armour_folder'}
	def['heavy_tank_brigade'] = {'armour_folder'}
	def['heavy_tank_gun'] = {'armour_folder'}
	def['heavy_tank_engine'] = {'armour_folder'}
	def['heavy_tank_armour'] = {'armour_folder'}
	def['heavy_tank_reliability'] = {'armour_folder'}
	def['SP_brigade'] = {'armour_folder'}
	def['mechanised_infantry'] = {'infantry_folder'}
	def['super_heavy_tank_brigade'] = {'armour_folder'}
	def['super_heavy_tank_gun'] = {'armour_folder'}
	def['super_heavy_tank_engine'] = {'armour_folder'}
	def['super_heavy_tank_armour'] = {'armour_folder'}
	def['super_heavy_tank_reliability'] = {'armour_folder'}
	def['rocket_art'] = {'armour_folder'}
	def['rocket_art_ammo'] = {'armour_folder'}
	def['rocket_carriage_sights'] = {'armour_folder'}
	def['mobile_warfare'] = {'land_doctrine_folder'}
	def['elastic_defence'] = {'land_doctrine_folder'}
	def['spearhead_doctrine'] = {'land_doctrine_folder'}
	def['schwerpunkt'] = {'land_doctrine_folder'}
	def['blitzkrieg'] = {'land_doctrine_folder'}
	def['operational_level_command_structure'] = {'land_doctrine_folder'}
	def['tactical_command_structure'] = {'land_doctrine_folder'}
	def['delay_doctrine'] = {'land_doctrine_folder'}
	def['integrated_support_doctrine'] = {'land_doctrine_folder'}
	def['superior_firepower'] = {'land_doctrine_folder'}
	def['mechanized_offensive'] = {'land_doctrine_folder'}
	def['combined_arms_warfare'] = {'land_doctrine_folder'}
	def['grand_battle_plan'] = {'land_doctrine_folder'}
	def['large_front'] = {'land_doctrine_folder'}
	def['guerilla_warfare'] = {'land_doctrine_folder'}
	def['peoples_army'] = {'land_doctrine_folder'}
	def['large_formations'] = {'land_doctrine_folder'}
	def['basic_four_engine_airframe'] = {'bomber_folder'}
	def['basic_strategic_bomber'] = {'bomber_folder'}
	def['large_fueltank'] = {'bomber_folder'}
	def['four_engine_airframe'] = {'bomber_folder'}
	def['strategic_bomber_armament'] = {'bomber_folder'}
	def['cargo_hold'] = {'bomber_folder'}
	def['large_bomb'] = {'bomber_folder'}
	def['advanced_aircraft_design'] = {'fighter_folder'}
	def['small_airsearch_radar'] = {'fighter_folder'}
	def['medium_airsearch_radar'] = {'bomber_folder'}
	def['large_airsearch_radar'] = {'bomber_folder'}
	def['small_navagation_radar'] = {'fighter_folder'}
	def['medium_navagation_radar'] = {'bomber_folder'}
	def['large_navagation_radar'] = {'bomber_folder'}
	def['rocket_interceptor_tech'] = {'fighter_folder'}
	def['drop_tanks'] = {'fighter_folder'}
	def['jet_engine'] = {'fighter_folder'}
	def['forward_air_control'] = {'air_doctrine_folder'}
	def['battlefield_interdiction'] = {'air_doctrine_folder'}
	def['bomber_targerting_focus'] = {'air_doctrine_folder'}
	def['fighter_targerting_focus'] = {'air_doctrine_folder'} 
	def['heavy_bomber_pilot_training'] = {'air_doctrine_folder'}
	def['heavy_bomber_groundcrew_training'] = {'air_doctrine_folder'}
	def['strategic_bombardment_tactics'] = {'air_doctrine_folder'}
	def['airborne_assault_tactics'] = {'air_doctrine_folder'}
	def['strategic_air_command'] = {'air_doctrine_folder'}
	def['heavycruiser_technology'] = {'capitalship_folder'}
	def['heavycruiser_armament'] = {'capitalship_folder'}
	def['heavycruiser_antiaircraft'] = {'capitalship_folder'}
	def['heavycruiser_engine'] = {'capitalship_folder'}
	def['heavycruiser_armour'] = {'capitalship_folder'}
	def['battlecruiser_technology'] = {'capitalship_folder'}
	def['battleship_technology'] = {'capitalship_folder'}
	def['capitalship_armament'] = {'capitalship_folder'}
	def['battlecruiser_antiaircraft'] = {'capitalship_folder'}
	def['battlecruiser_engine'] = {'capitalship_folder'}
	def['battlecruiser_armour'] = {'capitalship_folder'}
	def['battleship_antiaircraft'] = {'capitalship_folder'}
	def['battleship_engine'] = {'capitalship_folder'}
	def['battleship_armour'] = {'capitalship_folder'}
	def['super_heavy_battleship_technology'] = {'capitalship_folder'}
	def['cag_development'] = {'capitalship_folder'}
	def['escort_carrier_technology'] = {'capitalship_folder'}
	def['carrier_technology'] = {'capitalship_folder'}
	def['carrier_antiaircraft'] = {'capitalship_folder'}
	def['carrier_engine'] = {'capitalship_folder'}
	def['carrier_armour'] = {'capitalship_folder'}
	def['carrier_hanger'] = {'capitalship_folder'}
	def['largewarship_radar'] = {'capitalship_folder'}
	def['carrier_group_doctrine'] = {'naval_doctrine_folder'}
	def['carrier_crew_training'] = {'naval_doctrine_folder'}
	def['carrier_task_force'] = {'naval_doctrine_folder'}
	def['naval_underway_repleshment'] = {'naval_doctrine_folder'}
	def['radar_training'] = {'naval_doctrine_folder'}
	def['battlefleet_concentration_doctrine'] = {'naval_doctrine_folder'}
	def['battleship_crew_training'] = {'naval_doctrine_folder'}
	def['cruiser_warfare'] = {'naval_doctrine_folder'}
	def['cruiser_crew_training'] = {'naval_doctrine_folder'}
	def['basing'] = {'naval_doctrine_folder'}
	def['oil_to_coal_conversion'] = {'industry_folder'}
	def['heavy_aa_guns'] = {'industry_folder'}
	def['radio_detection_equipment'] = {'industry_folder'}
	def['radar'] = {'industry_folder'}
	def['decryption_machine'] = {'industry_folder'}
	def['encryption_machine'] = {'industry_folder'}
	def['rocket_tests'] = {'industry_folder'}
	def['rocket_engine'] = {'industry_folder'}
	def['theorical_jet_engine'] = {'industry_folder'}
	def['atomic_research'] = {'industry_folder'}
	def['nuclear_research'] = {'industry_folder'}
	def['isotope_seperation'] = {'industry_folder'}
	def['civil_nuclear_research'] = {'industry_folder'}
	def['oil_refinning'] = {'industry_folder'}
	def['steel_production'] = {'industry_folder'}
	def['raremetal_refinning_techniques'] = {'industry_folder'}
	def['coal_processing_technologies'] = {'industry_folder'}
	def['naval_engineering_research'] = {'theory_folder'}
	def['submarine_engineering_research'] = {'theory_folder'}
	def['aeronautic_engineering_research'] = {'theory_folder'}
	def['rocket_science_research'] = {'theory_folder'}
	def['chemical_engineering_research'] = {'theory_folder'}
	def['nuclear_physics_research'] = {'theory_folder'}
	def['jetengine_research'] = {'theory_folder'}
	def['mechanicalengineering_research'] = {'theory_folder'}
	def['automotive_research'] = {'theory_folder'}
	def['electornicegineering_research'] = {'theory_folder'}
	def['artillery_research'] = {'theory_folder'}
	def['mobile_research'] = {'theory_folder'}
	def['militia_research'] = {'theory_folder'}
	def['infantry_research'] = {'theory_folder'}
	def['civil_defence'] = {'theory_folder'}
	
	local db = {}
	for k,techDef in pairs(def) do
		local tech = CTechnology(k)
		
		-- IsReal
		tech:saveResult(CTechnologyFolder(techDef[1]),CTechnology.GetFolder)

		-- Save reference to db  
		db[tech] = tech
	end
	
	return db
end