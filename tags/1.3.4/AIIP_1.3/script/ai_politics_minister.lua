require('utils')
require('ai_diplomacy')
require('helper_functions')

--Use our wrapper method in order to trap and log our errors
function PoliticsMinister_Tick(minister)
	dtools.setLogContext(minister,"POLIT")
	dtools.info('PoliticsMinister_Tick')
	return dtools.wrap(PoliticsMinister_Tick_Impl,minister)
end

function PoliticsMinister_Tick_Impl(minister)
	local ministerCountry = minister:GetCountry()
	if not IsValidCountry(ministerCountry) then
		return
	end

	local politicsDelay = 7
	if ai_configuration ~= nil and ai_configuration.POLITICS_DELAY ~= nil then
		politicsDelay = ai_configuration.POLITICS_DELAY
	end

	if math.mod( CCurrentGameState.GetAIRand(), politicsDelay) > 0 then
		return
	end

	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()

	--Utils.LUA_DEBUGOUT("->PoliticsMinister_Tick " .. tostring(minister:GetCountryTag()))

	--Utils.LUA_DEBUGOUT("HandleLaws")
	HandleLaws(minister)
	--Utils.LUA_DEBUGOUT("HandleMobilization")
	HandleMobilization(minister)
	--Utils.LUA_DEBUGOUT("HandlePuppets")
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
	--Utils.LUA_DEBUGOUT("<-PoliticsMinister_Tick")
end

function HandleMobilization( minister )
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	-- Note: we are automatically mobilized when war breaks out, so this is for kicking off mobilization early.
	if not ministerCountry:IsMobilized() then
		local ai = minister:GetOwnerAI()
		if ministerCountry:GetStrategy():IsPreparingWar() then
			local neutrality = ministerCountry:GetNeutrality():Get() * 0.9
			for country in CCurrentGameState.GetCountries() do
				local countryTag = country:GetCountryTag()
				if IsValidCountry(country) and countryTag ~= ministerTag then
					if ministerCountry:GetStrategy():IsPreparingWarWith(countryTag) and neutrality < ministerCountry:GetMaxNeutralityForWarWith(countryTag):Get() then
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
				local lawGroup = CLawDataBase.GetLawGroup(GetLawGroupIndexByName('conscription_law'))
				local lawIndex = ministerCountry:GetLaw(lawGroup):GetIndex()
				local targetedLawIndex = GetLawIndexByName('two_year_draft')

				-- Don't mobilize as long as we don't have appropriate conscription laws.
				-- Manpower would kill us.
				if lawIndex >= targetedLawIndex then
					-- check if a neighbour is starting to look threatening
					for neighbour in ministerCountry:GetNeighbours() do
						local neighbourCountry = neighbour:GetCountry()

						local neutrality = neighbourCountry:GetNeutrality():Get() * 0.9
						local threat = CalculateThreat(ai, ministerTag, ministerCountry, neighbour, neighbourCountry)

						-- If their threat to us is high enough and their neutrality low enough to declar war upon us
						if threat > 50 and neutrality < neighbourCountry:GetMaxNeutralityForWarWith(ministerTag):Get() then
							--Utils.LUA_DEBUGOUT( "MOBILIZE " .. tostring(ministerTag) .. " " .. tostring(threat) .. "towards" .. tostring(neighbour) )
							local command = CToggleMobilizationCommand(ministerTag, true)
							ai:Post(command)
							return
						end
					end
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

				-- at war, try for heavy industry but settle for mixed if country is small
				if ministerCountry:IsAtWar() then
					newLaw = CLawDataBase.GetLaw(GetLawIndexByName('heavy_industry_emphasis'))
					if ministerCountry:GetTotalIC() < 30 or not newLaw:ValidFor( ministerTag ) then
						newLaw = CLawDataBase.GetLaw(GetLawIndexByName('mixed_industry'))
					end

				-- at peace, try for mixed industry but settle for CPO if CG need is high or country is small
				-- CPO saves 16% of total IC compared to mixed industry, but has 5% worse industrial efficiency
				-- not much benefit from switching to CPO for large countries unless CG need is substantial
				-- better method would probably be something like:
				-- if production IC * 0.14 <= min(CGNeed,0.16*TotalIC) then switch to CPO
				-- .14 approx = 1-(0.95^2) which is how much IC you save on production with +5% efficiency
				-- but haven't tested for sure

				-- by azeno:
				-- I don't agree to this:
				-- We save 1-(0.95^2) = 9.75% IC*days in production with MI but lose 16% of our total IC in comparison to CPO.
				-- Again in IC*days this is a factor of at least 16% since total IC is always greater than production IC.
				-- So in total in terms of IC*days we lose at least 16% - 9.75% = 6.25%.
				-- CPO is bugged in my opinion. Adding the -20% dissent gain to the CG ratio is just wrong.
				-- I mentioned this in the forums a couple of times, but with no success. I think I'll post it again in bug forums
				-- and see what other people think of this topic. But for now I'll let the AI go with CPO, because that's
				-- what a human player would do.
				-- See: http://forum.paradoxplaza.com/forum/showthread.php?t=456380
				else
					-- Commented out, see above
					-- newLaw = CLawDataBase.GetLaw(GetLawIndexByName('mixed_industry'))

					-- local CGRatio = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get() / ministerCountry:GetTotalIC()

					-- if ministerCountry:GetTotalIC() < 30 or not newLaw:ValidFor( ministerTag ) then
						-- newLaw = CLawDataBase.GetLaw(GetLawIndexByName('consumer_product_orientation'))
					-- elseif CGRatio > 0.10 then
						-- newLaw = CLawDataBase.GetLaw(GetLawIndexByName('consumer_product_orientation'))
					-- end

					newLaw = CLawDataBase.GetLaw(GetLawIndexByName('consumer_product_orientation'))
				end

			elseif tostring(group:GetKey()) == 'education_investment_law' then

				-- Base on total leadership
				-- big investment is useless for countries with < 4 leadership but minimal investment always sucks
				local newLaw = CLawDataBase.GetLaw(GetLawIndexByName('big_education_investment'))

				local leadership = ministerCountry:GetTotalLeadership():Get()
				if leadership < 4 then
					newLaw = CLawDataBase.GetLaw(GetLawIndexByName('medium_large_education_investment'))
				elseif leadership < 3 then
					newLaw = CLawDataBase.GetLaw(GetLawIndexByName('averge_education_investment'))
				end

			elseif tostring(group:GetKey()) == 'training_laws' then

					-- Make decision based on manpower
					-- If we've alot reduce recruiting time to spam infantry
					-- If we're short increase recruiting time to save manpowerFactor
					local manpowerFactor = math.min(2, ministerCountry:GetManpower():Get() / ministerCountry:GetTotalIC())
					local index = GetLawIndexByName('specialist_training')
					local officerRatio = ministerCountry:GetOfficerRatio():Get()
					local factor = 1 - (officerRatio * manpowerFactor) / 4

					--[[
						mp\or        0.000   0.250   0.500   0.750   1.000   1.250   1.500   1.750   2.000
						0.000        1.000   1.000   1.000   1.000   1.000   1.000   1.000   1.000   1.000
						0.100        1.000   0.994   0.988   0.981   0.975   0.969   0.963   0.956   0.950
						0.200        1.000   0.988   0.975   0.963   0.950   0.938   0.925   0.913   0.900
						0.300        1.000   0.981   0.963   0.944   0.925   0.906   0.888   0.869   0.850
						0.400        1.000   0.975   0.950   0.925   0.900   0.875   0.850   0.825   0.800
						0.500        1.000   0.969   0.938   0.906   0.875   0.844   0.813   0.781   0.750
						0.600        1.000   0.963   0.925   0.888   0.850   0.813   0.775   0.738   0.700
						0.700        1.000   0.956   0.913   0.869   0.825   0.781   0.738   0.694   0.650
						0.800        1.000   0.950   0.900   0.850   0.800   0.750   0.700   0.650   0.600
						0.900        1.000   0.944   0.888   0.831   0.775   0.719   0.663   0.606   0.550
						1.000        1.000   0.938   0.875   0.813   0.750   0.688   0.625   0.563   0.500
						1.100        1.000   0.931   0.863   0.794   0.725   0.656   0.588   0.519   0.450
						1.200        1.000   0.925   0.850   0.775   0.700   0.625   0.550   0.475   0.400
						1.300        1.000   0.919   0.838   0.756   0.675   0.594   0.513   0.431   0.350
						1.400        1.000   0.913   0.825   0.738   0.650   0.563   0.475   0.388   0.300
						1.500        1.000   0.906   0.813   0.719   0.625   0.531   0.438   0.344   0.250
						1.600        1.000   0.900   0.800   0.700   0.600   0.500   0.400   0.300   0.200
						1.700        1.000   0.894   0.788   0.681   0.575   0.469   0.363   0.256   0.150
						1.800        1.000   0.888   0.775   0.663   0.550   0.438   0.325   0.213   0.100
						1.900        1.000   0.881   0.763   0.644   0.525   0.406   0.288   0.169   0.050
						2.000        1.000   0.875   0.750   0.625   0.500   0.375   0.250   0.125   0.000
					]]

					if factor > 0.9 then
							index = GetLawIndexByName('specialist_training')
					elseif factor > 0.7 then
							index = GetLawIndexByName('advanced_training')
					elseif factor > 0.4 then
							index = GetLawIndexByName('basic_training')
					else
							index = GetLawIndexByName('minimal_training')
					end
					newLaw = CLawDataBase.GetLaw(index)
			end

			if newLaw == nil then
				--local three_year_draft_law = CLawDataBase.GetLaw(GetLawIndexByName('three_year_draft'))
				local index = currentLaw:GetIndex() + 1
				while index < CLawDataBase.GetNumberOfLaws() do
					local tmpLaw = CLawDataBase.GetLaw( index )
					if not (group:GetIndex() == tmpLaw:GetGroup():GetIndex()) then
						break
					end
					if not tmpLaw:ValidFor( ministerTag ) then
						break
					end
					-- three-year draft is bugged, makes production of units very expensive...not worth it
					--if	tmpLaw:GetIndex() ~= three_year_draft_law:GetIndex() then
						newLaw = tmpLaw
					--end
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
