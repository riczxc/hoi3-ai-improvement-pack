
require('ai_diplomacy')

function PoliticsMinister_Tick(minister)
	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.POLITICS_DELAY) > 0 then
		return
	end
	
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()

	HandleLaws(minister)
	HandleMobilization(minister)
	HandlePuppets(minister)

	-- liberate countries if we can
	if ministerCountry:MayLiberateCountries() then
		for member in ministerCountry:GetPossibleLiberations() do
			if minister:IsCapitalSafeToLiberate( member ) then
				--Utils.LUA_DEBUGOUT("CLiberateCountryCommand(" .. tostring(member) .. ", " .. tostring(ministerTag) ..")")
				local command = CLiberateCountryCommand( member, ministerTag )
				ai:Post( command )
			end
		end
	end
end

function HandleMobilization( minister )
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	local did_it = 0

	-- Note: we are automatically mobilized when war breaks out, so this is for kicking off mobilization early.
	if not ministerCountry:IsMobilized() and ministerCountry:GetStrategy():IsPreparingWar() then
		local neutrality = ministerCountry:GetNeutrality() * 0.9
		for country in CCurrentGameState.GetCountries() do
			local countryTag = country:GetCountryTag()
			if did_it == 0 and countryTag:IsValid() and country:Exists() and countryTag:IsReal() and not (countryTag == ministerTag) then
				if ministerCountry:GetStrategy():IsPreparingWarWith(countryTag) and neutrality < ministerCountry:GetMaxNeutralityForWarWith(countryTag) then
					--Utils.LUA_DEBUGOUT( "MOBILIZE BECAUSE OF PREP FOR WAR " .. tostring(ministerTag) )
					local command = CToggleMobilizationCommand( ministerTag, true )
					ai:Post( command )
					did_it = 1
				end
			end
		end
	elseif not ministerCountry:IsMobilized() then
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

function HandleLaws(minister)
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()

	local countrySpecific = Utils.HasCountryAIFunction( ministerTag, 'HandleLaws' )
	if countrySpecific then
		countrySpecific( minister )
	else
		-- see if we can get a better law
		for group in CLawDataBase.GetGroups() do
			if not (tostring(group:GetKey()) == 'education_investment_law' or tostring(group:GetKey()) == 'training_laws') then
				local newLaw = nil
				local currentLaw = ministerCountry:GetLaw( group )
				local index = currentLaw:GetIndex() + 1
				if index < CLawDataBase.GetNumberOfLaws() then
					newLaw = CLawDataBase.GetLaw( index )
					if not (group:GetIndex() == newLaw:GetGroup():GetIndex()) then 
						newLaw = nil
					end
				end
				if newLaw and newLaw:ValidFor( ministerTag ) then
					--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. " - NEW LAW " .. tostring( newLaw:GetKey() ) .. " from - " .. tostring(group:GetKey()) )
					local command = CChangeLawCommand( ministerTag, newLaw, group )
					ai:Post( command )
				end
			end		
		end
	end
end


function HandlePuppets(minister)
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	
	if ministerCountry:CanCreatePuppet() then
		Utils.CallCountryAI( ministerTag, 'HandlePuppets', minister )
	end
	
end
