require('helper_functions')

function GetICRatioForProvinceImprovements(country)
	local countryTag = tostring(country:GetCountryTag())
	local strategy = country:GetStrategy()
	local year = CCurrentGameState.GetCurrentDate():GetYear()

	-- DEFAULT RATIO
	local ratioPeace = 0.2
	local ratioPreparingWar = 0.1
	local ratioWar = 0.05

	-- SPECIFIC RATIO
	------------------------------------------SOVIET UNION---------------------------------------------------
	if countryTag == 'SOV' then
		--Utils.LUA_DEBUGOUT( "SOVIET UNION" )

		if year <= 1939 then
			ratioPeace = 0.5 -- Needs to build up lot's of infra (~240 provinces and ~2-4 infra per province)
		else
			ratioPeace = 0.4
		end
		ratioPreparingWar = 0.3
		ratioWar = 0.2

	------------------------------------------GERMANY---------------------------------------------------
	elseif countryTag == 'GER' then
		--Utils.LUA_DEBUGOUT( "GERMANY" )

		ratioPeace = 0.15 -- Has best infra of the world
		ratioPreparingWar = 0.1
		ratioWar = 0.05

	------------------------------------------UNITED KINGDOM---------------------------------------------------
	elseif countryTag == 'ENG' then
		--Utils.LUA_DEBUGOUT( "UNITED KINGDOM" )

	------------------------------------------USA---------------------------------------------------
	elseif countryTag == 'USA' then
		--Utils.LUA_DEBUGOUT( "USA" )

		ratioPeace = 0.15 -- Build some naval bases in pacific
		ratioPreparingWar = 0.1
		ratioWar = 0.05

	------------------------------------------JAPAN---------------------------------------------------
	elseif countryTag == 'JAP' then
		--Utils.LUA_DEBUGOUT( "JAPAN" )

		ratioPeace = 0.3 -- Needs to build some naval bases and infra for china supply (TODO: add provinces like for SOV)
		ratioPreparingWar = 0.2
		ratioWar = 0.1

	------------------------------------------FRANCE---------------------------------------------------
	elseif countryTag == 'FRA' then
		--Utils.LUA_DEBUGOUT( "FRANCE" )


	------------------------------------------ITALY---------------------------------------------------
	elseif countryTag == 'ITA' then
		--Utils.LUA_DEBUGOUT( "ITALY" )


	----------------------------------------------------------------------------------------------------
	end

	if country:IsAtWar() then
		return ratioWar
	end

	if strategy:IsPreparingWar() then
		return ratioPreparingWar
	end

	return ratioPeace
end

function LoadProvinceImprovements(country)
	--Utils.LUA_DEBUGOUT( "ENTER LoadProvinceImprovements function" )
	local countryTag = tostring(country:GetCountryTag())
	local year = CCurrentGameState.GetCurrentDate():GetYear()

	local averageInfraLevel = GetAverageInfrastructure(country)
	local ports = country:GetNumOfPorts()
	local airfields = country:GetNumOfAirfields()
	local portsAndAirfields = ports + airfields
	if portsAndAirfields == 0 then
		portsAndAirfields = 1
	end

	-- DEFAULT IMPROVEMENTS
	local prod_improvements = {
		infra = {
			priority = (1 - averageInfraLevel),
			max_level = 0.8
		},
		industry = {
			priority = averageInfraLevel * 0.2
		},
		air_base = {
			priority = (airfields / portsAndAirfields) * averageInfraLevel * 0.3
		},
		naval_base = {
			priority = (ports / portsAndAirfields) * averageInfraLevel * 0.3
		},
		anti_air = {
			priority = averageInfraLevel * 0.2
		},
		land_fort = {
			priority = averageInfraLevel * 0.1
		},
		coastal_fort = {
			priority = (ports / portsAndAirfields) * averageInfraLevel * 0.2
		},
		radar_station = {
			priority = (airfields / portsAndAirfields) * averageInfraLevel * 0.2
		}
	}

	-- If a improvement is not specified it is assumend its priority is 0.
	-- If ids are not specified provinces will be selected randomly.

	-- SPECIFIC IMPROVEMENTS
	------------------------------------------GERMANY---------------------------------------------------
	if countryTag == 'GER' then
		--Utils.LUA_DEBUGOUT( "GERMANY" )

		prod_improvements = {
			industry = {
				priority = 0.1
			},
			air_base = {
				priority = 0.3
			},
			naval_base = {
				priority = 0.3
			},
			coastal_fort = {
				priority = 0.2
			},
			radar_station = {
				priority = 0.1
			}
		}

	------------------------------------------SOVIET UNION---------------------------------------------------
	elseif countryTag == 'SOV' then
		--Utils.LUA_DEBUGOUT( "SOVIET UNION" )

		prod_improvements = {
			infra = {
				priority = 0.6,
				max_level = 0.8,
				ids = {
					998, 1002, 919, 960, 961, 958, 1041, 1042, 1004, 1005,
					1006, 967, 968, 928, 969, 929, 1010, 971, 931, 1051,
					1088, 6637, 6640, 8190, 8174, 1510, 8191, 8175, 8210, 8234,
					8286, 8261, 8262, 8288, 8342, 8316, 8343, 8369, 8421, 8452,
					8490, 8528, 8560, 8529, 8561, 8594, 8627, 8595, 8563, 8596,
					8629, 8597, 8630, 8690, 8716, 8743, 8796, 8822, 8744, 8797,
					8770, 8719, 8746, 8693, 8667, 8635, 8668, 8604, 8504, 8542,
					8574, 8638, 8697, 8724, 6966, 8776, 7044, 7028, 7045, 3789,
					3858, 3996, 4130, 4196, 4263, 4328, 4390, -- from Moskva to Valdivostok (from Miskovo east)
					1073, 1110, 1191, 1233, 1275, 1365,  -- from Moskva to Valdivostok (93 provinces)
					1364, 1319, 1273, 1230, 1187, 1146, 1105, 1067, 1030, 992,
					951, 910, 867, 822, 782, -- from Moskva to Leningrad
					783, 742, 700, 620, 582, 508, 435, 405, 377, 353,
					329, 286, 268, 253, 237, 210, 183, 145, 108, 73,
					59, 46, -- from Leningrad to Murmansk
					1453, 1498, 1540, 1641, 1700, 1760, 1819, 1879, 1938, 1993,
					2050, 2108, 2165, 2223, -- from Moskva to Kyiv
					2051, 2110, 2168, 2227, 2284, 2342, 2400, 2459, 2401, 2520,
					2648, 2779, 2843, -- from Kyiv to Dnipropetrovsk
					2910, 3045, 3112, 3178, 3245, 3311, 3447, 3584, -- from Dnipropetrovsk to Sevastopol
					1454, 1410, 1455, 1456, 1502, 1545, 1646, 1766, 1826, 1887,
					1947, 2003, 2061, 2177, 2236, 2293, 2351, 2409, 2352, 2410,
					2469, 2530, 2593, 2659, 2725, 2791, 2856, 2922, 2857, -- from Moskva to Stalingrad
					2988, 3124, 3255, 3389, 3523, 3588, 3650, 3649, 3715, 3781,
					3849, 3991, 4059, -- from Stalingrad to Bat'um
					2923, 2858, 2924, 2991, 3060, 3128, 3194, 3260, 3327, 3464, -- from Stalingrad to Astrahan'
					3529, 3594, 3593, 3722, 7106, 7176, 7252, 7289, 7307 -- from Astrahan' to Baki
				}
			},
			industry = {
				priority = 0.10,
				ids = {
					8174, 1510, 8191, 8175, 8210, 8234, 8286, 8261, 8262, 8288,
					8342, 8316, 8343, 8369, 8421, 8452, 8490, 8528, 8560, 8529
				}
			},
			air_base = {
				priority = 0.20
			},
			naval_base = {
				priority = 0.05
			},
			radar_station = {
				priority = 0.05
			}
		}
	------------------------------------------UNITED KINGDOM---------------------------------------------------
	elseif countryTag == 'ENG' then
		--Utils.LUA_DEBUGOUT( "UNITED KINGDOM" )

		prod_improvements = {
			industry = {
				priority = 0.1
			},
			air_base = {
				priority = 0.3
			},
			naval_base = {
				priority = 0.3
			},
			coastal_fort = {
				priority = 0.2
			},
			radar_station = {
				priority = 0.1
			}
		}

	------------------------------------------USA---------------------------------------------------
	elseif countryTag == 'USA' then
		--Utils.LUA_DEBUGOUT( "USA" )

		prod_improvements = {
			air_base = {
				priority = 0.3
			},
			naval_base = {
				priority = 0.5
			},
			coastal_fort = {
				priority = 0.1
			},
			radar_station = {
				priority = 0.1
			}
		}

	------------------------------------------JAPAN---------------------------------------------------
	elseif countryTag == 'JAP' then
		--Utils.LUA_DEBUGOUT( "JAPAN" )
		prod_improvements = {
			infra = {
				priority = 0.5,
				max_level = 0.8
				},
			industry = {
				priority = 0.05
			},
			air_base = {
				priority = 0.05
			},
			naval_base = {
				priority = 0.3
			},
			coastal_fort = {
				priority = 0.05
			},
			radar_station = {
				priority = 0.05
			}
		}
	------------------------------------------FRANCE---------------------------------------------------
	elseif countryTag == 'FRA' then
		--Utils.LUA_DEBUGOUT( "FRANCE" )


	------------------------------------------ITALY---------------------------------------------------
	elseif countryTag == 'ITA' then
		--Utils.LUA_DEBUGOUT( "ITALY" )


	----------------------------------------------------------------------------------------------------
	end

	-- Make sure the improvements table is complete
	local requiredKeys = {
		infra = {
			priority = 0,
			max_level = 0.8
		},
		industry = {
			priority = 0
		},
		air_base = {
			priority = 0
		},
		naval_base = {
			priority = 0
		},
		anti_air = {
			priority = 0
		},
		land_fort = {
			priority = 0
		},
		coastal_fort = {
			priority = 0
		},
		radar_station = {
			priority = 0
		}
	}

	for k,v in pairs(requiredKeys) do
		if prod_improvements[k] == nil then
			prod_improvements[k] = v
		else
		-- Cycle through subkeys
			for subk,subv in pairs(v) do
				if prod_improvements[k][subk] == nil then
					prod_improvements[k][subk] = subv
				end
			end
		end
	end

	-- If infra isn't available build industry instead
	-- Note:	There's no need to also check for industry because if it's not available
	-- 			it's priority will be set to 0 and all the other improvements
	--			will be rebalanced.
	local techStatus = country:GetTechnologyStatus()
	local infraTech = GetTechByName('advanced_construction_engineering')
	if techStatus:GetLevel(infraTech) == 0 then
		prod_improvements.industry.priority = prod_improvements.industry.priority + prod_improvements.infra.priority
		prod_improvements.infra.priority = 0
	end

	--Utils.LUA_DEBUGOUT( "EXIT LoadProvinceImprovements function" )
	--Utils.LUA_DEBUGOUT("\n")
	return prod_improvements
end

-- Azeno
