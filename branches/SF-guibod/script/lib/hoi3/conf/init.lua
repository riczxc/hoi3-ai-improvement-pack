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

function countryDatabase()
	-- key is country TAG string
	-- value is Ccountry
	
	local db = {}
	--todo add overlord
	--Country	Flag	isreal, isvalid, National Unity - Neutrality	Resources Per IC	GDP	IC Per Manpower	IC Per Leadership	Leadership Per Manpower	National Unity - Neutrality	Resources Per IC	GDP	IC Per Manpower	IC Per Leadership	Leadership Per Manpower		
	db['AFG'] = {'Afghanistan',true,true,-40.0,0.00,5.40,0.00,0.00,0.10,-40.0,0.00,5.40,0.00,0.00,0.10}
	db['ALB'] = {'Albania',true,true,-20.0,0.00,7.45,0.00,0.00,0.10,-20.0,0.00,7.45,0.00,0.00,0.10}
	db['ARG'] = {'Argentina',true,true,-10.0,0.73,42.60,1.44,14.37,0.10,-10.0,0.73,42.60,1.44,14.37,0.10}
	db['AST'] = {'Australia',true,true,-10.0,0.93,44.40,1.56,8.33,0.19,-10.0,0.93,44.40,1.56,8.33,0.19}
	db['AUS'] = {'Austria',true,true,-50.0,1.00,34.10,1.73,17.27,0.10,-50.0,1.00,34.10,1.73,17.27,0.10}
	db['BEL'] = {'Belgium',true,true,-10.0,1.13,46.80,2.60,16.77,0.15,-10.0,1.13,46.80,2.60,16.77,0.15}
	db['BHU'] = {'Bhutan',true,true,-30.0,0.00,5.00,0.00,0.00,0.10,-30.0,0.00,5.00,0.00,0.00,0.10}
	db['BOL'] = {'Bolivia',true,true,-20.0,0.46,19.95,1.75,17.50,0.10,-20.0,0.46,19.95,1.75,17.50,0.10}
	db['BRA'] = {'Brazil',true,true,-10.0,0.69,50.45,1.00,10.00,0.10,-10.0,0.69,50.45,1.00,10.00,0.10}
	db['BUL'] = {'Bulgaria',true,true,-10.0,0.46,30.40,1.91,19.09,0.10,-10.0,0.46,30.40,1.91,19.09,0.10}
	db['CAN'] = {'Canada',true,true,0.0,0.94,50.10,1.80,9.00,0.20,0.0,0.94,50.10,1.80,9.00,0.20}
	db['CGX'] = {'Guangxi Clique',true,true,-10.0,0.71,35.45,0.59,4.26,0.14,-10.0,0.71,35.45,0.59,4.26,0.14}
	db['CHC'] = {'Communist China',true,true,-30.0,0.50,11.60,0.83,8.33,0.10,-30.0,0.50,11.60,0.83,8.33,0.10}
	db['CHI'] = {'Nationalist China',true,true,0.0,0.58,67.20,0.41,7.25,0.06,0.0,0.58,67.20,0.41,7.25,0.06}
	db['CHL'] = {'Chile',true,true,-25.0,0.47,25.60,1.33,13.33,0.10,-25.0,0.47,25.60,1.33,13.33,0.10}
	db['COL'] = {'Colombia',true,true,-10.0,0.50,26.00,1.38,13.75,0.10,-10.0,0.50,26.00,1.38,13.75,0.10}
	db['COS'] = {'Costa Rica',true,true,-15.0,0.00,5.30,0.00,0.00,0.10,-15.0,0.00,5.30,0.00,0.00,0.10}
	db['CRO'] = {'Croatia',false,true,-10.0,0.00,5.00,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	db['CSX'] = {'Shanxi',true,true,0.0,0.44,22.50,0.54,5.42,0.10,0.0,0.44,22.50,0.54,5.42,0.10}
	db['CUB'] = {'Cuba',true,true,-30.0,0.29,8.00,0.40,4.00,0.10,-30.0,0.29,8.00,0.40,4.00,0.10}
	db['CXB'] = {'Xibei San Ma',true,true,0.0,0.55,13.20,0.75,8.57,0.09,0.0,0.55,13.20,0.75,8.57,0.09}
	db['CYN'] = {'Yunnan',true,true,0.0,0.50,14.05,0.67,6.67,0.10,0.0,0.50,14.05,0.67,6.67,0.10}
	db['CZE'] = {'Czechoslovakia',true,true,-20.0,0.56,45.95,2.70,10.69,0.25,-20.0,0.56,45.95,2.70,10.69,0.25}
	db['DDR'] = {'DDR',false,true,-5.0,0.00,5.00,nil,nil,nil,-5.0,0.00,5.00,nil,nil,nil}
	db['DEN'] = {'Denmark',true,true,0.0,0.50,21.00,1.44,14.44,0.10,0.0,0.50,21.00,1.44,14.44,0.10}
	db['DFR'] = {'FRG',false,true,-15.0,0.00,5.00,nil,nil,nil,-15.0,0.00,5.00,nil,nil,nil}
	db['DOM'] = {'Dominican Republic',true,true,-35.0,0.00,6.50,0.33,3.33,0.10,-35.0,0.00,6.50,0.33,3.33,0.10}
	db['ECU'] = {'Ecuador',true,true,-35.0,0.45,14.15,1.50,15.00,0.10,-35.0,0.45,14.15,1.50,15.00,0.10}
	db['EGY'] = {'Egypt',false,true,-20.0,0.00,5.00,nil,nil,nil,-20.0,0.00,5.00,nil,nil,nil}
	db['ENG'] = {'United Kingdom',true,true,-10.0,1.22,275.58,0.76,4.66,0.16,-10.0,1.22,275.58,0.76,4.66,0.16}
	db['EST'] = {'Estonia',true,true,-30.0,0.00,6.10,0.25,2.50,0.10,-30.0,0.00,6.10,0.25,2.50,0.10}
	db['ETH'] = {'Ethiopia',true,true,5.0,0.00,7.25,0.25,2.50,0.10,5.0,0.00,7.25,0.25,2.50,0.10}
	db['FIN'] = {'Finland',true,true,-30.0,0.72,23.30,1.44,14.44,0.10,-30.0,0.72,23.30,1.44,14.44,0.10}
	db['FRA'] = {'France',true,true,-40.0,1.47,160.25,1.26,8.42,0.15,-40.0,1.47,160.25,1.26,8.42,0.15}
	db['GER'] = {'Germany',true,true,30.0,0.96,199.70,2.31,6.72,0.34,30.0,0.96,199.70,2.31,6.72,0.34}
	db['GRE'] = {'Greece',true,true,15.0,0.60,24.30,1.36,13.64,0.10,15.0,0.60,24.30,1.36,13.64,0.10}
	db['GUA'] = {'Guatemala',true,true,-30.0,0.00,5.40,0.00,0.00,0.10,-30.0,0.00,5.40,0.00,0.00,0.10}
	db['GUY'] = {'Guyana',true,true,0.0,0.00,5.00,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	db['HAI'] = {'Haiti',true,true,-5.0,0.00,5.60,0.00,0.00,0.10,-5.0,0.00,5.60,0.00,0.00,0.10}
	db['HOL'] = {'Netherlands',true,true,-10.0,1.42,87.30,3.69,12.40,0.30,-10.0,1.42,87.30,3.69,12.40,0.30}
	db['HON'] = {'Honduras',true,true,-10.0,0.00,5.50,0.00,0.00,0.10,-10.0,0.00,5.50,0.00,0.00,0.10}
	db['HUN'] = {'Hungary',true,true,20.0,0.65,35.95,1.83,9.17,0.20,20.0,0.65,35.95,1.83,9.17,0.20}
	db['ICL'] = {'Iceland',false,true,10.0,0.00,5.00,nil,nil,nil,10.0,0.00,5.00,nil,nil,nil}
	db['IDC'] = {'Indochina',false,true,-15.0,0.00,5.00,nil,nil,nil,-15.0,0.00,5.00,nil,nil,nil}
	db['IND'] = {'India',false,true,0.0,0.00,5.00,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	db['INO'] = {'Indonesia',false,true,-10.0,0.00,5.00,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	db['IRE'] = {'Ireland',true,true,-15.0,0.67,18.50,2.50,25.00,0.10,-15.0,0.67,18.50,2.50,25.00,0.10}
	db['IRQ'] = {'Iraq',true,true,0.0,0.00,14.75,0.00,0.00,0.10,0.0,0.00,14.75,0.00,0.00,0.10}
	db['ISR'] = {'Israel',false,true,0.0,0.00,5.00,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	db['ITA'] = {'Italy',true,true,20.0,0.86,91.10,1.49,7.11,0.21,20.0,0.86,91.10,1.49,7.11,0.21}
	db['JAP'] = {'Japan',true,true,10.0,0.72,123.50,1.20,6.18,0.19,10.0,0.72,123.50,1.20,6.18,0.19}
	db['JOR'] = {'Jordan',true,true,-5.0,0.00,5.00,nil,nil,nil,-5.0,0.00,5.00,nil,nil,nil}
	db['KOR'] = {'Korea',false,true,0.0,0.00,5.00,nil,nil,nil,0.0,0.00,5.00,nil,nil,nil}
	db['LAT'] = {'Latvia',true,true,-30.0,0.00,8.30,0.75,7.50,0.10,-30.0,0.00,8.30,0.75,7.50,0.10}
	db['LEB'] = {'Lebanon',true,true,-10.0,0.00,5.00,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	db['LIB'] = {'Liberia',true,true,-30.0,0.00,5.80,0.00,0.00,0.10,-30.0,0.00,5.80,0.00,0.00,0.10}
	db['LIT'] = {'Lithuania',true,true,-30.0,0.12,8.50,0.75,7.50,0.10,-30.0,0.12,8.50,0.75,7.50,0.10}
	db['LUX'] = {'Luxemburg',true,true,-20.0,0.50,13.20,5.00,50.00,0.10,-20.0,0.50,13.20,5.00,50.00,0.10}
	db['MAN'] = {'Manchukuo',true,true,0.0,0.58,30.55,0.90,9.05,0.10,0.0,0.58,30.55,0.90,9.05,0.10}
	db['MEN'] = {'Mengkukuo',false,true,5.0,0.00,5.00,nil,nil,nil,5.0,0.00,5.00,nil,nil,nil}
	db['MEX'] = {'Mexico',true,true,0.0,0.32,39.90,0.74,7.37,0.10,0.0,0.32,39.90,0.74,7.37,0.10}
	db['MON'] = {'Mongolia',true,true,-20.0,0.50,11.60,1.67,16.67,0.10,-20.0,0.50,11.60,1.67,16.67,0.10}
	db['NEP'] = {'Nepal',true,true,-20.0,0.00,5.30,0.00,0.00,0.10,-20.0,0.00,5.30,0.00,0.00,0.10}
	db['NIC'] = {'Nicaragua',true,true,-10.0,0.00,5.40,0.00,0.00,0.10,-10.0,0.00,5.40,0.00,0.00,0.10}
	db['NOR'] = {'Norway',true,true,-10.0,0.62,19.50,1.38,11.00,0.12,-10.0,0.62,19.50,1.38,11.00,0.12}
	db['NZL'] = {'New Zealand',true,true,15.0,0.38,9.10,0.50,5.00,0.10,15.0,0.38,9.10,0.50,5.00,0.10}
	db['OMN'] = {'Oman',true,true,-5.0,0.00,5.00,0.00,0.00,0.10,-5.0,0.00,5.00,0.00,0.00,0.10}
	db['PAK'] = {'Pakistan',false,true,-15.0,0.00,5.00,nil,nil,nil,-15.0,0.00,5.00,nil,nil,nil}
	db['PAL'] = {'Palestine',false,true,-20.0,0.00,5.00,nil,nil,nil,-20.0,0.00,5.00,nil,nil,nil}
	db['PAN'] = {'Panama',true,true,5.0,0.00,5.30,nil,nil,nil,5.0,0.00,5.30,nil,nil,nil}
	db['PAR'] = {'Paraguay',true,true,-20.0,0.50,11.60,1.25,12.50,0.10,-20.0,0.50,11.60,1.25,12.50,0.10}
	db['PER'] = {'Persia',true,true,20.0,0.25,40.30,0.38,3.75,0.10,20.0,0.25,40.30,0.38,3.75,0.10}
	db['PHI'] = {'Philippines',true,true,-25.0,0.36,12.60,0.60,6.00,0.10,-25.0,0.36,12.60,0.60,6.00,0.10}
	db['POL'] = {'Poland',true,true,10.0,0.68,67.35,1.35,11.35,0.12,10.0,0.68,67.35,1.35,11.35,0.12}
	db['POR'] = {'Portugal',true,true,0.0,0.59,27.65,1.20,12.00,0.10,0.0,0.59,27.65,1.20,12.00,0.10}
	db['PRK'] = {'People\'s Republic of Korea',false,true,-20.0,0.00,5.00,nil,nil,nil,-20.0,0.00,5.00,nil,nil,nil}
	db['PRU'] = {'Peru',true,true,15.0,0.50,22.75,1.00,10.00,0.10,15.0,0.50,22.75,1.00,10.00,0.10}
	db['REB'] = {'Rebels',false,false,nil,0.00,5.00,nil,nil,nil,nil,0.00,5.00,nil,nil,nil}
	db['ROM'] = {'Romania',true,true,-20.0,0.74,73.95,1.58,15.79,0.10,-20.0,0.74,73.95,1.58,15.79,0.10}
	db['RSI'] = {'Italian Social Republic',false,true,40.0,0.00,5.00,nil,nil,nil,40.0,0.00,5.00,nil,nil,nil}
	db['SAF'] = {'South Africa',true,true,10.0,0.47,23.10,0.92,9.23,0.10,10.0,0.47,23.10,0.92,9.23,0.10}
	db['SAL'] = {'El Salvador',true,true,-25.0,0.00,5.40,0.00,0.00,0.10,-25.0,0.00,5.40,0.00,0.00,0.10}
	db['SAU'] = {'Saudi Arabia',true,true,-5.0,0.00,14.00,0.00,0.00,0.10,-5.0,0.00,14.00,0.00,0.00,0.10}
	db['SWI'] = {'Switzerland',true,true,-15.0,0.82,24.15,2.80,28.00,0.10,-15.0,0.82,24.15,2.80,28.00,0.10}
	db['SIA'] = {'Siam',true,true,5.0,0.30,12.90,0.42,3.85,0.11,5.0,0.30,12.90,0.42,3.85,0.11}
	db['SIK'] = {'Sinkiang',true,true,10.0,0.45,12.65,0.86,8.82,0.10,10.0,0.45,12.65,0.86,8.82,0.10}
	db['SLO'] = {'Slovakia',true,true,30.0,0.00,5.00,nil,nil,nil,30.0,0.00,5.00,nil,nil,nil}
	db['SOV'] = {'Soviet Union',true,true,-25.0,2.31,343.45,0.69,13.28,0.05,-25.0,2.31,343.45,0.69,13.28,0.05}
	db['SPA'] = {'Nationalist Spain',false,true,5.0,0.00,5.00,nil,nil,nil,5.0,0.00,5.00,nil,nil,nil}
	db['SPR'] = {'Republican Spain',true,true,-20.0,0.80,58.70,1.50,15.00,0.10,-20.0,0.80,58.70,1.50,15.00,0.10}
	db['SWE'] = {'Sweden',true,true,-10.0,0.48,36.45,1.91,16.80,0.11,-10.0,0.48,36.45,1.91,16.80,0.11}
	db['SYR'] = {'Syria',true,true,-10.0,0.00,5.00,nil,nil,nil,-10.0,0.00,5.00,nil,nil,nil}
	db['TAN'] = {'Tannu Tuva',true,true,5.0,0.00,5.00,0.00,0.00,0.10,5.0,0.00,5.00,0.00,0.00,0.10}
	db['TIB'] = {'Tibet',true,true,-25.0,0.00,5.00,0.00,0.00,0.10,-25.0,0.00,5.00,0.00,0.00,0.10}
	db['TUR'] = {'Turkey',true,true,-35.0,0.68,32.75,1.54,15.38,0.10,-35.0,0.68,32.75,1.54,15.38,0.10}
	db['URU'] = {'Uruguay',true,true,-25.0,0.53,17.40,2.00,20.00,0.10,-25.0,0.53,17.40,2.00,20.00,0.10}
	db['USA'] = {'USA',true,true,-20.0,1.91,901.25,1.77,10.04,0.18,-20.0,1.91,901.25,1.77,10.04,0.18}
	db['VEN'] = {'Venezuela',true,true,-20.0,0.46,97.92,1.00,10.00,0.10,-20.0,0.46,97.92,1.00,10.00,0.10}
	db['VIC'] = {'Vichy France',false,true,10.0,0.00,5.00,nil,nil,nil,10.0,0.00,5.00,nil,nil,nil}
	db['YEM'] = {'Yemen',true,true,-30.0,0.00,5.00,0.00,0.00,0.10,-30.0,0.00,5.00,0.00,0.00,0.10}
	db['YUG'] = {'Yugoslavia',true,true,-15.0,0.61,39.30,1.37,13.68,0.10,-15.0,0.61,39.30,1.37,13.68,0.10}
	
	return db
end