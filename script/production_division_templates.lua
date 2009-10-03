function LoadProductionRatio(minister, ministerCountry)
	--Utils.LUA_DEBUGOUT( "ENTER LoadProductionRatio function" )

	local ministerTag = tostring(minister:GetCountryTag())
	local prod_ratio = { }

	local infantry = CSubUnitDataBase.GetSubUnit("infantry_brigade")
	local mountain = CSubUnitDataBase.GetSubUnit("bergsjaeger_brigade")
	local marine = CSubUnitDataBase.GetSubUnit("marine_brigade")
	local paratrooper = CSubUnitDataBase.GetSubUnit("paratrooper_brigade")
	local cavalry = CSubUnitDataBase.GetSubUnit("cavalry_brigade")
	local garrison = CSubUnitDataBase.GetSubUnit("garrison_brigade")
	local militia = CSubUnitDataBase.GetSubUnit("militia_brigade")

	local light_armor = CSubUnitDataBase.GetSubUnit("light_armor_brigade")
	local armor = CSubUnitDataBase.GetSubUnit("armor_brigade")
	local mechanized = CSubUnitDataBase.GetSubUnit("mechanized_brigade")
	local motorized = CSubUnitDataBase.GetSubUnit("motorized_brigade")

	local artillery = CSubUnitDataBase.GetSubUnit("artillery_brigade")
	local anti_tank = CSubUnitDataBase.GetSubUnit("anti_tank_brigade")
	local anti_air = CSubUnitDataBase.GetSubUnit("anti_air_brigade")
	local engineer = CSubUnitDataBase.GetSubUnit("engineer_brigade")
	local police = CSubUnitDataBase.GetSubUnit("police_brigade")
	local rocket_artillery = CSubUnitDataBase.GetSubUnit("rocket_artillery_brigade")
	local heavy_armor = CSubUnitDataBase.GetSubUnit("heavy_armor_brigade")
	local sh_armor = CSubUnitDataBase.GetSubUnit("super_heavy_armor_brigade")

	local armored_car = CSubUnitDataBase.GetSubUnit("armored_car_brigade")
	local sp_artillery = CSubUnitDataBase.GetSubUnit("sp_artillery_brigade")
	local sp_rct_artillery = CSubUnitDataBase.GetSubUnit("sp_rct_artillery_brigade")
	local tank_destroyer = CSubUnitDataBase.GetSubUnit("tank_destroyer_brigade")

	------------------------------------------GERMANY---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "GERMANY" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['GER'] = {}
		prod_ratio['GER']['infantry_brigade'] = { 	-- Infantry
											{ 10, infantry, infantry, infantry };
											{ 25, infantry, infantry, infantry, artillery };
											{ 20, infantry, infantry, infantry, anti_tank };
											{ 15, infantry, infantry, infantry, anti_air };
											{ 15, infantry, infantry, infantry, rocket_artillery };
											{ 10, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, sh_armor }
										}
		prod_ratio['GER']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['GER']['militia_brigade'] = {		-- Militia
											{ 50, militia, militia };
											{ 50, militia, militia, police }
										}
		prod_ratio['GER']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['GER']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['GER']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['GER']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['GER']['light_armor_brigade'] = {	-- Light Armor
											{ 80, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['GER']['motorized_brigade'] = {	-- Motorized
											{ 5, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 35, motorized, motorized, sp_artillery };
											{ 30, motorized, motorized, tank_destroyer }
										}
		prod_ratio['GER']['mechanized_brigade'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 30, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, sp_rct_artillery };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['GER']['armor_brigade'] = {		-- Armor with mechanized
												{ 25, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 10, armor, mechanized, sp_rct_artillery };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['GER']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
		------------------------------------------SOVIET UNION---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "SOVIET UNION" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['SOV'] = {}
		prod_ratio['SOV']['infantry_brigade'] = { 	-- Infantry
											{ 25, infantry, infantry, infantry };
											{ 25, infantry, infantry, infantry, artillery };
											{ 20, infantry, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, infantry, anti_air };
											{ 10, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, sh_armor };
											{ 5, infantry, infantry, infantry, armored_car }
										}
		prod_ratio['SOV']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine }
										}
		prod_ratio['SOV']['militia_brigade'] = {		-- Militia
											{ 50, militia, militia, militia };
											{ 50, militia, militia, police }
										}
		prod_ratio['SOV']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['SOV']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry, cavalry }
										}
		prod_ratio['SOV']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['SOV']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['SOV']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 95, light_armor, light_armor, motorized }
										}
		prod_ratio['SOV']['motorized_brigade'] = {	-- Motorized
											{ 5, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 35, motorized, motorized, sp_artillery };
											{ 30, motorized, motorized, tank_destroyer }
										}
		prod_ratio['SOV']['mechanized_brigade'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 30, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, sp_rct_artillery };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['SOV']['armor_brigade'] = {		-- Armor with mechanized
												{ 30, armor, armor, mechanized };
												{ 25, armor, armor, mechanized, sp_artillery };
												{ 25, armor, armor, mechanized, tank_destroyer };
												{ 20, armor, armor, mechanized, sp_rct_artillery }
											}
		else
			prod_ratio['SOV']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, armor, motorized, sp_artillery };
												{ 25, armor, armor, motorized, tank_destroyer };
												{ 15, armor, armor, motorized, engineer }
											}
		end
		------------------------------------------UNITED STATES OF AMERICA---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "USA" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['USA'] = {}
		prod_ratio['USA']['infantry_brigade'] = { 	-- Infantry
											{ 10, infantry, infantry, infantry };
											{ 30, infantry, infantry, infantry, artillery };
											{ 25, infantry, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, infantry, anti_air };
											{ 10, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, sh_armor };
											{ 10, infantry, infantry, infantry, engineer }
										}
		prod_ratio['USA']['marine_brigade'] = {		-- Marine
											{ 30, marine, marine, marine };
											{ 30, marine, marine, artillery };
											{ 40, marine, marine, engineer }
										}
		prod_ratio['USA']['militia_brigade'] = {		-- Militia
											{ 100, militia, militia }
										}
		prod_ratio['USA']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['USA']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['USA']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['USA']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['USA']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 65, light_armor, light_armor, motorized };
											{ 30, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['USA']['motorized_brigade'] = {	-- Motorized
											{ 5, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 30, motorized, motorized, sp_artillery };
											{ 35, motorized, motorized, tank_destroyer }
										}
		prod_ratio['USA']['mechanized_brigade'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 25, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 25, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['USA']['armor_brigade'] = {		-- Armor with mechanized
												{ 25, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 25, armor, mechanized, engineer }
											}
		else
			prod_ratio['USA']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
		------------------------------------------UNITED KINGDOM---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "UNITED KINGDOM" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['ENG'] = {}
		prod_ratio['ENG']['infantry_brigade'] = { 	-- Infantry
											{ 25, infantry, infantry, infantry };
											{ 25, infantry, infantry, artillery };
											{ 20, infantry, infantry, anti_tank };
											{ 20, infantry, infantry, anti_air };
											{ 10, infantry, infantry, infantry, engineer }
										}
		prod_ratio['ENG']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['ENG']['militia_brigade'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['ENG']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['ENG']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['ENG']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['ENG']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['ENG']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['ENG']['motorized_brigade'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['ENG']['mechanized_brigade'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['ENG']['armor_brigade'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['ENG']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
		------------------------------------------FRANCE---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "FRANCE" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['FRA'] = {}
		prod_ratio['FRA']['infantry_brigade'] = { 	-- Infantry
											{ 25, infantry, infantry, infantry };
											{ 30, infantry, infantry, artillery };
											{ 25, infantry, infantry, anti_tank };
											{ 15, infantry, infantry, anti_air };
											{ 5, infantry, infantry, engineer }
										}
		prod_ratio['FRA']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['FRA']['militia_brigade'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['FRA']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['FRA']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['FRA']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['FRA']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['FRA']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['FRA']['motorized_brigade'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['FRA']['mechanized_brigade'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['FRA']['armor_brigade'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['FRA']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
		------------------------------------------ITALY---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "ITALY" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['ITA'] = {}
		prod_ratio['ITA']['infantry_brigade'] = { 	-- Infantry
											{ 30, infantry, infantry, infantry };
											{ 30, infantry, infantry, artillery };
											{ 15, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, anti_air };
											{ 10, infantry, infantry, armored_car };
											{ 5, infantry, infantry, engineer }
										}
		prod_ratio['ITA']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['ITA']['militia_brigade'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['ITA']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['ITA']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['ITA']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['ITA']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['ITA']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['ITA']['motorized_brigade'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['ITA']['mechanized_brigade'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['ITA']['armor_brigade'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['ITA']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
		------------------------------------------JAPAN---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "JAPAN" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['JAP'] = {}
		prod_ratio['JAP']['infantry_brigade'] = { 	-- Infantry
											{ 35, infantry, infantry, infantry };
											{ 35, infantry, infantry, artillery };
											{ 10, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, anti_air };
											{ 10, infantry, infantry, engineer }
										}
		prod_ratio['JAP']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['JAP']['militia_brigade'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['JAP']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['JAP']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['JAP']['mountain_brigade'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}
		prod_ratio['JAP']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['JAP']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['JAP']['motorized_brigade'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['JAP']['mechanized_brigade'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['JAP']['armor_brigade'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['JAP']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
	------------------------------------------OTHERS---------------------------------------------------
		--Utils.LUA_DEBUGOUT( "GENERIC" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['default'] = {}
		prod_ratio['default']['infantry_brigade'] = { 	-- Infantry
											{ 50, infantry, infantry, infantry };
											{ 25, infantry, infantry, artillery };
											{ 10, infantry, infantry, anti_tank };
											{ 5, infantry, infantry, anti_air };
											{ 5, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, armored_car }
										}
		prod_ratio['default']['marine_brigade'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['default']['militia_brigade'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['default']['garrison_brigade'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['default']['cavalry_brigade'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['default']['mountain_brigade'] = {		-- Mountain
											{ 50, mountain, mountain, mountain };
											{ 50, mountain, mountain, artillery }
										}
		prod_ratio['default']['paratrooper_brigade'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}
		prod_ratio['default']['light_armor_brigade'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}
		prod_ratio['default']['motorized_brigade'] = {	-- Motorized
											{ 10, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 30, motorized, motorized, sp_artillery };
											{ 30, motorized, motorized, tank_destroyer }
										}
		prod_ratio['default']['mechanized_brigade'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 30, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 20, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['default']['armor_brigade'] = {		-- Armor with mechanized
												{ 25, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 25, armor, mechanized, engineer }
											}
		else
			prod_ratio['default']['armor_brigade'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}
		end
	-----------------------------------------

	--Utils.LUA_DEBUGOUT( "EXIT LoadProductionRatio function" )
	if prod_ratio[ministerTag] then
		return prod_ratio[ministerTag]
	else
		return prod_ratio['default']
	end
end

--Darkzodiak
