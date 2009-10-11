require('utils')
require('ai_diplomacy')
require('helper_functions')

function PoliticsMinister_Tick(minister)
	--Utils.LUA_DEBUGOUT("PoliticsMinister_Tick")
	local ministerCountry = minister:GetCountry()
	if not IsValidCountry(ministerCountry) then
		--Utils.LUA_DEBUGOUT("PoliticsMinister_TickEnd")
		return
	end

	local politicsDelay = 7
	if ai_configuration ~= nil and ai_configuration.POLITICS_DELAY ~= nil then
		politicsDelay = ai_configuration.POLITICS_DELAY
	end

	if math.mod( CCurrentGameState.GetAIRand(), politicsDelay) > 0 then
		--Utils.LUA_DEBUGOUT("PoliticsMinister_TickEnd")
		return
	end

	HandleLaws(minister)
	HandleMobilization(minister)
	HandlePuppets(minister)

	-- liberate countries if we can
	if ministerCountry:MayLiberateCountries() then
		for member in ministerCountry:GetPossibleLiberations() do
			if minister:IsCapitalSafeToLiberate( member ) then
				local ministerTag = minister:GetCountryTag()
				--Utils.LUA_DEBUGOUT("CLiberateCountryCommand(" .. tostring(member) .. ", " .. tostring(ministerTag) ..")")
				local command = CLiberateCountryCommand( member, ministerTag )
				minister:GetOwnerAI():Post( command )
			end
		end
	end
	--Utils.LUA_DEBUGOUT("PoliticsMinister_TickEnd")
end

function HandleMobilization( minister )
	local ministerCountry = minister:GetCountry()
	-- Note: we are automatically mobilized when war breaks out, so this is for kicking off mobilization early.
	if not ministerCountry:IsMobilized() then
		local ministerTag = minister:GetCountryTag()
		local ai = minister:GetOwnerAI()
		if ministerCountry:GetStrategy():IsPreparingWar() then
			local neutrality = ministerCountry:GetNeutrality() * 0.9
			for country in CCurrentGameState.GetCountries() do
				local countryTag = country:GetCountryTag()
				if IsValidCountry(country) and countryTag ~= ministerTag then
					if ministerCountry:GetStrategy():IsPreparingWarWith(countryTag) and neutrality < ministerCountry:GetMaxNeutralityForWarWith(countryTag) then
						--Utils.LUA_DEBUGOUT( "MOBILIZE BECAUSE OF PREP FOR WAR " .. tostring(ministerTag) )
						local command = CToggleMobilizationCommand( ministerTag, true )
						ai:Post( command )
						return
					end
				end
			end
		else
			local countrySpecific = Utils.HasCountryAIFunction( ministerTag, 'HandleMobilization' )

			if countrySpecific == nil then
				-- check if a neighbor is starting to look threatening
				local ourTotalIC = ministerCountry:GetTotalIC()
				local neutrality = ministerCountry:GetNeutrality():Get() * 0.9
				for neighborCountry in ministerCountry:GetNeighbours() do
					local threat = ministerCountry:GetRelation(neighborCountry):GetThreat():Get()
					neutrality = neutrality - threat
					if neutrality  < 10 then
						threat = threat * CalculateAlignmentFactor(ai, ministerCountry, neighborCountry:GetCountry())

						if ourTotalIC > 50 and neighborCountry:GetCountry():GetTotalIC() < ministerCountry:GetTotalIC() then
							threat = threat / 2 -- we can handle them if they descide to attack anyway
						end

						if  threat > 30 then
							--Utils.LUA_DEBUGOUT( "MOBILIZE " .. tostring(ministerTag) .. " " .. tostring(threat) .. "towards" .. tostring(neighborCountry) )
							local warDesirability = CalculateWarDesirability( ai, neighborCountry:GetCountry(), ministerTag )
							if warDesirability > 70 then
								local command = CToggleMobilizationCommand( ministerTag, true )
								ai:Post( command )
							end
						end
					end
					--Utils.LUA_DEBUGOUT( "_____________MOBILZIE")
				end
			else
				countrySpecific( minister )
			end
		end
	end
end

function HandleLaws(minister)
	local ministerTag = minister:GetCountryTag()

	local countrySpecific = Utils.HasCountryAIFunction( ministerTag, 'HandleLaws' )
	if countrySpecific then
		countrySpecific( minister )
	else
		local ministerCountry = minister:GetCountry()
		-- see if we can get a better law
		for group in CLawDataBase.GetGroups() do
			local currentLaw = ministerCountry:GetLaw( group )
			local newLaw = nil

			if tostring(group:GetKey()) == 'industrial_policy_laws' then
				if not ministerCountry:IsAtWar() then
					-- Aim for mixed_industry
					newLaw = CLawDataBase.GetLaw(GetLawIndexByName('mixed_industry'))
					if not newLaw:ValidFor( ministerTag ) then
						-- Aim for consumer_product_orientation
						newLaw = CLawDataBase.GetLaw(GetLawIndexByName('consumer_product_orientation'))
					end
				end
			elseif tostring(group:GetKey()) == 'education_investment_law' then
				-- Make decision based on money production
				local cgOverProductionRatio = GetCGOverProductionRatio(ministerCountry)
				local index = GetLawIndexByName('big_education_investment')
				-- More than 30% of total IC in overproduction
				if cgOverProductionRatio > 0.3 then
					index = GetLawIndexByName('average_education_investment')
				-- More than 10%
				elseif cgOverProductionRatio > 0.1 then
					index = GetLawIndexByName('medium_large_education_investment')
				end
				newLaw = CLawDataBase.GetLaw(index)
			elseif tostring(group:GetKey()) == 'training_laws' then
				-- Make decision based on manpower
				-- If we've alot reduce recruiting time to spam infantry
				-- If we're short increase recruiting time to save manpowerFactor
				local manpowerFactor = ministerCountry:GetManpower():Get() / ministerCountry:GetTotalIC()
				local index = GetLawIndexByName('specialist_training')
				if manpowerFactor > 4 then
					index = GetLawIndexByName('minimal_training')
				elseif manpowerFactor > 3 then
					index = GetLawIndexByName('basic_training')
				elseif manpowerFactor > 2 then
					index = GetLawIndexByName('advanced_training')
				end
				newLaw = CLawDataBase.GetLaw(index)
			end

			if newLaw == nil then
				local index = currentLaw:GetIndex() + 1
				while index < CLawDataBase.GetNumberOfLaws() do
					local tmpLaw = CLawDataBase.GetLaw( index )
					if not (group:GetIndex() == tmpLaw:GetGroup():GetIndex()) then
						break
					end
					if not tmpLaw:ValidFor( ministerTag ) then
						break
					end
					newLaw = tmpLaw
					index = index + 1
				end
			end

			if newLaw and newLaw:ValidFor( ministerTag ) and not (newLaw:GetIndex() == currentLaw:GetIndex()) then
				--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. " - NEW LAW " .. tostring( newLaw:GetKey() ) .. " from - " .. tostring(group:GetKey()) )
				local command = CChangeLawCommand( ministerTag, newLaw, group )
				minister:GetOwnerAI():Post( command )
			end
		end
	end
end


function HandlePuppets(minister)
	if minister:GetCountry():CanCreatePuppet() then
		Utils.CallCountryAI( minister:GetCountryTag(), 'HandlePuppets', minister )
	end
end
