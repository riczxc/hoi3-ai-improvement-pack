ai_configuration = {
DIP_PEACE_DELAY = 14,
DIP_WAR_DELAY = 7,
POLITICS_DELAY = 7,
TRADE_DELAY = 7,
INTELLIGENCE_DELAY = 7,
STOCKPILE_FACTOR = 50,
MINIMUM_SUPPLY_STOCKPILE = 50, -- compatibility for code revisions before 234
LEADERSHIP_TO_INFLUENCE = 0.15,
MINIMUM_IC_TO_INFLUENCE = 20,
COUNTER_INFLUENCE = 1,
USE_CUSTOM_TRIGGERS = 0
}


--
gGeography = {
	-- USED BY IsNeighbourOnSameContinent
	--
	-- Define a list of island country whose mainland can't be on same continent as an other
	island_countries = { 'ENG','AST','NZL','PHI','JAP','ICL','CUB','IRE' },

	-- USED BY IsNeighbourOnSameContinent
	--
	-- Define a group of countries that shares the same small land mass
	island_clusters = {
		haiti = { 'DOM', 'HAI' }
	},

	-- USED BY IsNeighbourOnSameContinent
	--
	-- Defines country that naturally sit accross multiple continent
	-- Useful to compute offshore status for province
	transcontinental = {
		SOV = { 'asia', 'europe' },
		EGY = { 'africa', 'asia' },
		TUR = { 'europe', 'asia' }
	},

	-- USED BY IsOceanNeighbour
	--
	-- table "ocean_neighbour" defines how a country feels a set of province as offshore neighbourhood, the reverse is NOT mandatory.
	-- this code has a weakness, what if SOV reaches Calais ? SOV don't know it is an ENG neighbour by then.
	ocean_neighbour	 = {
		NZL = { 'AST','JAP','PHI','USA' },
		AST = { 'AST','JAP','PHI','USA','HOL' },

		-- east asia
		JAP = { 'USA','AST','SOV','PRK','KOR','CHI','SIA' }, --japan don't bother china cliques, added SIA for increased influence
		PHI = { 'USA','JAP','HOL','CHI','CGX','INO','IDC','SIA' }, --removed too far NZL and AST
		INO = { 'JAP','HOL','IDC','SIA','PHI' },

		CHI = { 'JAP','PHI' },
		CGX = { 'PHI' },
		PRK = { 'JAP' },
		KOR = { 'JAP' },
		CSX = { 'JAP' },
		SOV = { 'JAP' }, --if khouril islands share no more border
		IDC = { 'JAP','IDC','SIA' },

		-- north america
		USA = { 'ENG','PHI','AST','NZL','CUB','ICL' }, --POR and IRE are too far, DEN is bound through colonies, caribean countries are too small
		CAN = { 'ENG','FRA','ICL' }, --CAN has a greater emphasis on atlantic ocean
		ICL = { 'USA','IRE','ENG','CAN','DEN' }, --DEN for historical purpose

		--carribean
		CUB = { 'USA','MEX','HAI','DOM','NIC','HON' }, --added big central america countries (Nicaragua, Honduras)
		HON = { 'CUB' },
		NIC = { 'CUB' },
		MEX = { 'CUB' },
		HAI = { 'USA','CUB','VEN' },
		DOM = { 'USA','CUB','VEN' },
		VEN = { 'HAI','DOM' },

		-- european
		POR = { 'BRA' }, -- BRA for historical purpose

		-- Baltic
		SWE = { 'GER','SOV','POL' }, -- don't bother baltic states, there are bigger players around
		LIT = { 'SWE' },
		LAT = { 'SWE' },
		EST = { 'SWE','FIN' }, --finns are near
		FIN = { 'EST' }, --estonian are near

		-- Mediterean
		ITA = { 'ALB', 'GRE' },
		GRE = { 'ITA' },
		ALB = { 'ITA' },

		-- Black Sea
		ROM = { 'TUR' },
		BUL = { 'TUR' },
		TUR = { 'ROM','BUL','GRE' }, --if istanbul is lost

		-- UK and Ireland
		ENG = { 'USA','CAN','HOL','BEL','FRA'}, --no scandinavian country they are too far away, added france if channel island occupied
		IRE = { 'USA','FRA','ICL' }, --removed canada
		NOR = { 'ENG','DEN' },
		DEN = { 'ENG','NOR' },
		BEL = { 'ENG' },
		HOL = { 'JAP','AST','ZL','ENG'},

		-- Middle East (through Red Sea and persian gulf)
		SAU = { 'ETH', 'PER' },
		YEM = { 'ETH', 'OMN' },
		OMN = { 'YEM', 'PER' },
		PER = { 'OMN', 'SAU' },

		-- isolated countries (not real islands)
		LIB = { 'USA' },
		SIA = { 'JAP','PHI', 'CGX' },
		ETH = { 'SAU','YEM' }
	}
}







