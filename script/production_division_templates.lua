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
	if ministerTag == 'GER' then
		--Utils.LUA_DEBUGOUT( "GERMANY" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 10, infantry, infantry, infantry };
											{ 25, infantry, infantry, infantry, artillery };
											{ 20, infantry, infantry, infantry, anti_tank };
											{ 15, infantry, infantry, infantry, anti_air };
											{ 15, infantry, infantry, infantry, rocket_artillery };
											{ 10, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, sh_armor }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 50, militia, militia };
											{ 50, militia, militia, police }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 80, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 5, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 35, motorized, motorized, sp_artillery };
											{ 30, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 30, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, sp_rct_artillery };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 25, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 10, armor, mechanized, sp_rct_artillery };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end			
		------------------------------------------SOVIET UNION---------------------------------------------------
	elseif ministerTag == 'SOV' then
		--Utils.LUA_DEBUGOUT( "SOVIET UNION" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 25, infantry, infantry, infantry };
											{ 25, infantry, infantry, infantry, artillery };
											{ 20, infantry, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, infantry, anti_air };
											{ 10, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, sh_armor };
											{ 5, infantry, infantry, infantry, armored_car }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 50, militia, militia, militia };
											{ 50, militia, militia, police }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 95, light_armor, light_armor, motorized }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 5, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 35, motorized, motorized, sp_artillery };
											{ 30, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 30, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, sp_rct_artillery };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 30, armor, armor, mechanized };
												{ 25, armor, armor, mechanized, sp_artillery };
												{ 25, armor, armor, mechanized, tank_destroyer };
												{ 20, armor, armor, mechanized, sp_rct_artillery }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, armor, motorized, sp_artillery };
												{ 25, armor, armor, motorized, tank_destroyer };
												{ 15, armor, armor, motorized, engineer }
											}	
		end		
		------------------------------------------UNITED STATES OF AMERICA---------------------------------------------------
	elseif ministerTag == 'USA' then
		--Utils.LUA_DEBUGOUT( "USA" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 10, infantry, infantry, infantry };
											{ 30, infantry, infantry, infantry, artillery };
											{ 25, infantry, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, infantry, anti_air };
											{ 10, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, sh_armor };
											{ 10, infantry, infantry, infantry, engineer }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 30, marine, marine, marine };
											{ 30, marine, marine, artillery };
											{ 40, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 100, militia, militia }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 65, light_armor, light_armor, motorized };
											{ 30, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 5, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 30, motorized, motorized, sp_artillery };
											{ 35, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 25, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 25, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 25, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 25, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end	
		------------------------------------------UNITED KINGDOM---------------------------------------------------
	elseif ministerTag == 'ENG' then
		--Utils.LUA_DEBUGOUT( "UNITED KINGDOM" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 25, infantry, infantry, infantry };
											{ 25, infantry, infantry, artillery };
											{ 20, infantry, infantry, anti_tank };
											{ 20, infantry, infantry, anti_air };
											{ 10, infantry, infantry, infantry, engineer }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end	
		------------------------------------------FRANCE---------------------------------------------------
	elseif ministerTag == 'FRA' then
		--Utils.LUA_DEBUGOUT( "FRANCE" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 25, infantry, infantry, infantry };
											{ 30, infantry, infantry, artillery };
											{ 25, infantry, infantry, anti_tank };
											{ 15, infantry, infantry, anti_air };
											{ 5, infantry, infantry, engineer }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end	
		------------------------------------------ITALY---------------------------------------------------
	elseif ministerTag == 'ITA' then
		--Utils.LUA_DEBUGOUT( "ITALY" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 30, infantry, infantry, infantry };
											{ 30, infantry, infantry, artillery };
											{ 15, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, anti_air };
											{ 10, infantry, infantry, armored_car };
											{ 5, infantry, infantry, engineer }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end	
		------------------------------------------JAPAN---------------------------------------------------
	elseif ministerTag == 'JAP' then
		--Utils.LUA_DEBUGOUT( "JAPAN" )
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 35, infantry, infantry, infantry };
											{ 35, infantry, infantry, artillery };
											{ 10, infantry, infantry, anti_tank };
											{ 10, infantry, infantry, anti_air };
											{ 10, infantry, infantry, engineer }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 30, mountain, mountain, mountain };
											{ 35, mountain, mountain, artillery };
											{ 35, mountain, mountain, engineer }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 25, motorized, motorized };
											{ 25, motorized, motorized, engineer };
											{ 25, motorized, motorized, sp_artillery };
											{ 25, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 50, mechanized, mechanized, motorized };
											{ 20, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 10, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 35, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 15, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end		
	------------------------------------------OTHERS---------------------------------------------------
	else
		--Utils.LUA_DEBUGOUT( "GENERIC" )	
		-- First number is the % of chance to build this template when AI wants to build this type of division
		-- Be sure to have a total of 100%, no more no less
		-- CAUTION: if a brigade is not available in the choosen template, the first template will be build
		-- So, be sure that the first template of a type is the most basic template
		-- Next, you define the brigades of a template
		prod_ratio['infantry_template'] = { 	-- Infantry
											{ 50, infantry, infantry, infantry };
											{ 25, infantry, infantry, artillery };
											{ 10, infantry, infantry, anti_tank };
											{ 5, infantry, infantry, anti_air };
											{ 5, infantry, infantry, heavy_armor };
											{ 5, infantry, infantry, armored_car }
										}		
		prod_ratio['marine_template'] = {		-- Marine
											{ 50, marine, marine, marine };
											{ 50, marine, marine, engineer }
										}
		prod_ratio['militia_template'] = {		-- Militia
											{ 100, militia, militia, militia }
										}
		prod_ratio['garrison_template'] = {		-- Garrison
											{ 100, garrison, garrison }
										}
		prod_ratio['cavalry_template'] = {		-- Cavalry
											{ 100, cavalry, cavalry }
										}
		prod_ratio['mountain_template'] = {		-- Mountain
											{ 50, mountain, mountain, mountain };
											{ 50, mountain, mountain, artillery }
										}	
		prod_ratio['paratrooper_template'] = {	-- Paratrooper
											{ 100, paratrooper, paratrooper, paratrooper }
										}			
		prod_ratio['light_armor_template'] = {	-- Light Armor
											{ 5, light_armor, light_armor, armored_car };
											{ 75, light_armor, light_armor, motorized };
											{ 20, light_armor, light_armor, motorized, engineer }
										}	
		prod_ratio['motorized_template'] = {	-- Motorized
											{ 10, motorized, motorized, armored_car };
											{ 30, motorized, motorized, engineer };
											{ 30, motorized, motorized, sp_artillery };
											{ 30, motorized, motorized, tank_destroyer }
										}
		prod_ratio['mechanized_template'] = {	-- mechanized
											{ 30, mechanized, mechanized, motorized };
											{ 30, mechanized, mechanized, sp_artillery };
											{ 20, mechanized, mechanized, tank_destroyer };
											{ 20, mechanized, mechanized, engineer }
										}
		if ministerCountry:GetTechnologyStatus():IsUnitAvailable(mechanized) then
			prod_ratio['armor_template'] = {		-- Armor with mechanized
												{ 25, armor, armor, mechanized };
												{ 25, armor, mechanized, sp_artillery };
												{ 25, armor, mechanized, tank_destroyer };
												{ 25, armor, mechanized, engineer }
											}
		else
			prod_ratio['armor_template'] = {		-- Armor with motorized
												{ 35, armor, armor, motorized };
												{ 25, armor, motorized, sp_artillery };
												{ 25, armor, motorized, tank_destroyer };
												{ 15, armor, motorized, engineer }
											}	
		end		
	-----------------------------------------
	end
	--Utils.LUA_DEBUGOUT( "EXIT LoadProductionRatio function" )
	return prod_ratio
end

--Darkzodiak