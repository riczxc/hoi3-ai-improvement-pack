-----------------------------------------------------------
-- espionage & intelligence
-----------------------------------------------------------

require('ai_diplomacy')
require('helper_functions')

function IntelligenceMinister_Tick(minister)
	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.INTELLIGENCE_DELAY) == 0 then
		--Utils.LUA_DEBUGOUT("->IntelligenceMinister_Tick " .. tostring(minister:GetCountryTag()))
		local ministerTag = minister:GetCountryTag()
		local ministerCountry = minister:GetCountry()
		local ai = minister:GetOwnerAI()

		ManageSpiesAtHome(minister, ministerTag, ministerCountry, ai)
		--Utils.LUA_DEBUGOUT("manage spies abroad start")
		ManageSpiesAbroad(minister, ministerTag, ministerCountry, ai)
		--Utils.LUA_DEBUGOUT("manage spies abroad end")
		--Utils.LUA_DEBUGOUT("<-IntelligenceMinister_Tick")
	end
end

function ManageSpiesAtHome(minister, ministerTag, ministerCountry, ai)
	local domesticSpyPresence = ministerCountry:GetSpyPresence(ministerTag)
	local currentMission = domesticSpyPresence:GetMission()
	local newMission = currentMission
	local changeMission = 0
	local totalIC = ministerCountry:GetMaxIC() -- too lazy to rename the variable

	--Utils.LUA_DEBUGOUT("manage spies at home for: "..tostring(ministerTag))
	local currentMonth = CCurrentGameState.GetCurrentDate():GetMonthOfYear()

	-- only consider switching to a new mission if current one lasted at least a month
	local missionMonth = domesticSpyPresence:GetLastMissionChangeDate():GetMonthOfYear()
	if currentMonth < missionMonth then
		currentMonth = currentMonth + 12
	end

	if currentMonth > missionMonth then
		changeMission = 1
	end

	-- consider new mission if month has changed
	if changeMission == 1 then

		-- Default mission type is counterespionage
		newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE

		-- Consider switching to a mission other than counterespionage with a chance of 70%
		if math.mod(CCurrentGameState.GetAIRand(), 100) < 70 then
			--Utils.LUA_DEBUGOUT("hit 70% to change")

			-- raise national unity if less than 60 or if neutrality is less than 60 and NU > 70 (for draft laws)
			local unity = ministerCountry:GetNationalUnity():Get()
			local neutrality = ministerCountry:GetNeutrality():Get()
			if ( unity < 60 ) or ( neutrality < 60 and unity < 70 ) then
				--Utils.LUA_DEBUGOUT( tostring(ministerTag).." raise national unity mission - month: "..tostring(currentMonth))
				newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY
			-- otherwise lower neutrality for economic laws, except for micro powers and neutral countries
			elseif totalIC >= 10 and (ministerCountry:IsMajor() or neutrality < 90) then
				--Utils.LUA_DEBUGOUT("not micro power")
				local economicLawGroup = CLawDataBase.GetLawGroup(GetLawGroupIndexByName('economic_law'))
				local economicLawIndex = ministerCountry:GetLaw(economicLawGroup):GetIndex()
				local targetedEconomicLawIndex = GetLawIndexByName('war_economy')

				if economicLawIndex < targetedEconomicLawIndex then
					--Utils.LUA_DEBUGOUT( tostring(ministerTag).." lower neutrality mission - month: "..tostring(currentMonth))
					newMission = SpyMission.SPYMISSION_LOWER_NEUTRALITY
				end
			end

			-- minors might support ruling party instead
			if totalIC < 20 then
				if math.mod(CCurrentGameState.GetAIRand(), 3) == 0 then
					--Utils.LUA_DEBUGOUT( tostring(ministerTag).." minor exception support ruling party mission - month: "..tostring(currentMonth))
					newMission = 5
				end
			end
		end
	end

	-- priority based on IC + war status, with random modifier
	-- (easier to use spies against minor nations)
	local newPriority = domesticSpyPresence:GetPriority()
	if changeMission == 1 then

		-- minors get 1 priority
		newPriority = 1

		-- mediums get 2
		if totalIC > 20 then
			newPriority = newPriority + 1
		end

		-- majors get 3
		if totalIC > 100 then
			newPriority = newPriority + 1
		end

		-- +1 for war
		if ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar() or ministerCountry:IsGovernmentInExile() then
			newPriority = newPriority + 1
		end

		-- some countries are weaker
		if newPriority > 1 and math.mod(CCurrentGameState.GetAIRand(), 2) == 0 then
			newPriority = newPriority - 1
		end

		-- Max priority to lowering neutrality or increasing national unity
		if newMission ~= SpyMission.SPYMISSION_COUNTER_ESPIONAGE then
			newPriority = CSpyPresence.MAX_SPY_PRIORITY
		end

		-- cap
		newPriority = math.min( newPriority, CSpyPresence.MAX_SPY_PRIORITY )

		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." change home priority to "..newPriority.." - month: "..tostring(currentMonth))
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." change home mission to "..newMission.." - month: "..tostring(currentMonth))
	end

	-- change mission
	if newMission ~= currentMission then
		local command = CChangeSpyMission(ministerTag, ministerTag, newMission)
		ai:Post(command)
		--Utils.LUA_DEBUGOUT("mission changed")
	end

	-- update priority
	if domesticSpyPresence:GetPriority() ~= newPriority then
		command = CChangeSpyPriority(ministerTag, ministerTag, newPriority)
		ai:Post(command)
		--Utils.LUA_DEBUGOUT("priority changed")
	end
end


function PickBestMission(country, minister, ministerTag, ministerCountry, ai)
	local countryTag = country:GetCountryTag()
	--Utils.LUA_DEBUGOUT("pick best mission for: "..tostring(ministerTag) .. " towards "..tostring(countryTag))


	local dislike = 0
	local rel = ministerCountry:GetRelation( countryTag )
	local strategy = ministerCountry:GetStrategy()
	local ourIC = ministerCountry:GetMaxIC()
	local theirIC = country:GetMaxIC()

	-- We are in the same faction. Nothing to be done.
	if country:HasFaction() and ministerCountry:HasFaction() and ministerCountry:GetFaction() == country:GetFaction()  then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." in same faction -> SPYMISSION_NONE" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_NONE, 100)
	end

	-- We are allied. Nothing to be done.
	if rel:HasAlliance() then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." are allied -> SPYMISSION_NONE" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_NONE, 100)
	end

	-- We are in exile and the country is a enemy controller? Lower their unity to hurt them and maybe force a revolt.
	if ministerCountry:IsGovernmentInExile() then
		local capitalController = ministerCountry:GetCapitalLocation():GetController()
		if not ministerCountry:IsFriend(capitalController, false) and countryTag == capitalController then
			--Utils.LUA_DEBUGOUT( tostring(ministerTag).." in exile and occupied by "..tostring(countryTag).." -> SPYMISSION_LOWER_NATIONAL_UNITY" )
			return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY, 100)
		end
	end

	-- We are at war with each other?
	if strategy:IsPreparingWarWith(countryTag) or rel:HasWar()
	then
		-- If they are weak try and push them over the edge.
		if country:GetSurrenderLevel():Get() > 0.5 then
			--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." at war -> SPYMISSION_LOWER_NATIONAL_UNITY" )
			return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY, 100)
		end

		-- Support our military!
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." at war -> SPYMISSION_MILITARY" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_MILITARY, 100)
	end

	-- if we have claims on them then increase threat so we can declare war faster
	if HasClaims(ministerTag, countryTag) then
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_INCREASE_THREAT, 100)
	end


	-- calculate dislike
	if rel:GetValue():Get() < 0  then
		-- 0 to 50
		dislike = -1*rel:GetValue():Get()/4
	end
--Utils.LUA_DEBUGOUT("dislike from rel: "..tostring(dislike))
	dislike = dislike + rel:GetThreat():Get() * CalculateAlignmentFactor( ai, ministerCountry, country )
--Utils.LUA_DEBUGOUT("dislike after alignment threat: "..tostring(dislike))
	dislike = dislike - strategy:GetFriendliness(countryTag) / 4
--Utils.LUA_DEBUGOUT("dislike after friendliness: "..tostring(dislike))
	dislike = dislike + strategy:GetAntagonism(countryTag) / 4
--Utils.LUA_DEBUGOUT("dislike after antagonism: "..tostring(dislike))

	-- We don't like them?
	if dislike > 50 then
		local bestMission = nil
		local bestScore = 40
		local score = 0

		score = country:GetGlobalModifier():GetValue(CModifier._MODIFIER_PARTISAN_EFFICENCY_):Get()+30
		if score > bestScore then
			bestMission = SpyMission.SPYMISSION_SUPPORT_RESISTANCE
			bestScore = score
		end

		-- are they about to have a coup we want part in?
		if country:GetDissent():Get() > 5 then
			local ideology = country:GetRulingIdeology()
			local ministerIdeology = ministerCountry:GetRulingIdeology()
			if not (ideology:GetGroup() == ministerIdeology:GetGroup()) then
				local popularity = country:AccessIdeologyPopularity():GetValue( ideology ):Get()
				local organization = country:AccessIdeologyOrganization():GetValue( ideology ):Get()
				if popularity < 75 and organization < 75 then
					local nationalUnity = country:GetNationalUnity():Get()
					if nationalUnity >= 80 and nationalUnity < 90 then
						local score = 50 + (10 - (nationalUnity - 80)) * 3
						if score > bestScore then
							bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
							bestScore = score
						end
					end
					if ministerCountry:AccessIdeologyPopularity():GetValue( ministerIdeology ):Get() > 35 then
						local score = 50 + (80 - popularity)
						if score > bestScore then
							bestMission = SpyMission.SPYMISSION_BOOST_OUR_PARTY
							bestScore = score
						end
					end
				end
			end
		end

		-- didn't find anything good
		if nil == bestMission then

			-- setup
			local rollPassive = 0
			local rollActive = 0
			local isneighbor = 0
			if ministerCountry:IsNeighbour(countryTag) then
				isneighbor = 1
			end

			--Utils.LUA_DEBUGOUT("our IC is "..ourIC)
			--Utils.LUA_DEBUGOUT("theirIC is "..theirIC)

			-- we are small?
			if ourIC < 20 then
				--Utils.LUA_DEBUGOUT("we are small")

				-- they are big?
				if theirIC > 60 then

					-- if neighbors, watch their military so that we
					-- can prepare better defense against aggression
					if isneighbor == 1 then
						bestMission = SpyMission.SPYMISSION_MILITARY

					-- otherwise maybe keep an eye on them
					else
						rollPassive = 1
					end

				-- they are medium? roll passive
				elseif theirIC >= 20 then
					rollPassive = 1
				end


			-- we are big?
			elseif ourIC > 60 then
				--Utils.LUA_DEBUGOUT("we are big")

				-- they are big? roll active
				if theirIC > 60 then
					rollActive = 1

				-- they are medium? roll passive
				elseif theirIC >= 20 then
					rollPassive = 1
				end

			-- we are medium?
			else
				--Utils.LUA_DEBUGOUT("we are medium")

				-- they are big? roll passive
				if theirIC > 60 then
					rollPassive = 1

				-- they are medium? roll active
				elseif theirIC >= 20 then
					rollActive = 1

				-- they are small neighbor? roll active
				elseif isneighbor == 1 then
					rollActive = 1
				end
			end

			-- roll for active mission
			if rollActive == 1 then
				--Utils.LUA_DEBUGOUT("roll active")
				local diceRoll = math.mod( CCurrentGameState.GetAIRand(), 6)
				--Utils.LUA_DEBUGOUT("roll is ".. tostring(diceRoll))
				if diceRoll == 0 then
					bestMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE
				elseif diceRoll == 1 then
					bestMission = SpyMission.SPYMISSION_DISRUPT_RESEARCH
				elseif diceRoll == 2 then
					bestMission = SpyMission.SPYMISSION_DISRUPT_PRODUCTION
				elseif diceRoll == 3 then
					bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
				elseif diceRoll == 4 then
					bestMission = SpyMission.SPYMISSION_MILITARY
				elseif diceRoll == 5 then
					bestMission = SpyMission.SPYMISSION_TECH
				end

			-- roll for passive mission
			elseif rollPassive == 1 then
				--Utils.LUA_DEBUGOUT("roll passive")
				local diceRoll = math.mod( CCurrentGameState.GetAIRand(), 8)
				--Utils.LUA_DEBUGOUT("roll is ".. tostring(diceRoll))
				if diceRoll == 0 then
					bestMission = SpyMission.SPYMISSION_BOOST_OUR_PARTY
				elseif diceRoll == 1 then
					bestMission = SpyMission.SPYMISSION_POLITICAL
				elseif diceRoll == 2 then
					bestMission = SpyMission.SPYMISSION_MILITARY
				elseif diceRoll == 3 then
					bestMission = SpyMission.SPYMISSION_TECH
				else
					bestMission = SpyMission.SPYMISSION_NONE
				end

			-- otherwise we actually don't care
			else
				bestMission = SpyMission.SPYMISSION_NONE
			end

		end
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, bestMission, bestScore )
	end

	-- we are in different factions...increase their threat to weaken their faction's attraction and make it easier for them to be attacked
	if country:HasFaction() and ministerCountry:HasFaction() and ministerCountry:GetFaction() ~= country:GetFaction() then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." in different factions -> SPYMISSION_INCREASE_THREAT" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_INCREASE_THREAT, 50 )
	end

	-- We are in a faction but they are not and have a different ideology. Boost our party to help them aligning with us.
	local ourIdeologyGroup = ministerCountry:GetRulingIdeology():GetGroup()
	local theirIdeologyGroup = country:GetRulingIdeology():GetGroup()
	if	not country:HasFaction()
		and ministerCountry:HasFaction()
		and (ourIdeologyGroup ~= theirIdeologyGroup)
	then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." mission for "..tostring(countryTag).." is SPYMISSION_BOOST_OUR_PARTY (ideology alignment)" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_BOOST_OUR_PARTY, 50 )
	end

	-- nothing to be done
	--Utils.LUA_DEBUGOUT( tostring(ministerTag).." NO mission for "..tostring(countryTag).." -> SPYMISSION_NONE" )
	return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_NONE, 0 )
end


function PickBestMissionCallback( ministerTag, ai, minister, countryTag, SelectedSpyMission, score )
	if Utils.HasCountryAIFunction( ministerTag, 'PickBestMission' ) then
		--Utils.LUA_DEBUGOUT( "-------------- "..tostring(ministerTag).." modified mission "..tostring(countryTag).." ---- " )
		return Utils.CallCountryAI( ministerTag, 'PickBestMission', ai, minister, countryTag, SelectedSpyMission, score )
	else
		return SelectedSpyMission
	end
end


function ManageSpiesAbroad(minister, ministerTag, ministerCountry, ai)
	--Utils.LUA_DEBUGOUT( tostring(ministerTag).." ManageSpiesAbroad ")
	local strategy = ministerCountry:GetStrategy()

	-- get overlord tag
	local overlordTag = nil
	if ministerCountry:isPuppet() then
		overlordTag = ministerCountry:GetOverlord()
	end

	-- check countries
	for country in CCurrentGameState.GetCountries() do
		local tag = country:GetCountryTag()

		-- not us
		if tag ~= ministerTag then
			local SpyPresence = ministerCountry:GetSpyPresence(tag)
			local nPrio = 0
			local mission = SpyMission.SPYMISSION_NONE

			-- no spies for master
			if overlordTag ~= nil and tag == overlordTag then
				--Utils.LUA_DEBUGOUT("skipping master "..tostring(tag))

			-- valid countries
			elseif IsValidCountry(country) and not (ministerCountry:GetFaction():IsValid() and ministerCountry:GetFaction() == country:GetFaction()) then
				--Utils.LUA_DEBUGOUT("evaluating spymission for: ".. tostring(tag))

				-- war targets
				if ministerCountry:IsAtWar() or strategy:IsPreparingWar() then

					-- At war. Only concentrate on countries we're preparing war with.
					if strategy:IsPreparingWarWith(tag) then
						nPrio = 3
					elseif ministerCountry:GetRelation(tag):HasWar() then
						if (ministerCountry:IsMajor() and country:IsMajor())
						or ministerCountry:IsNeighbour(tag)
						or IsOceanNeighbor(ministerTag, tag) then
							nPrio = 2
						else
							nPrio = 1
						end
					end

				-- at peace
				else

					-- majors need to be cautiuos
					if ministerCountry:IsMajor() and country:IsMajor() then
						nPrio = nPrio + 1
					end

					-- extra priority for neighbors
					-- same continent to prevent guangxi spies in england for example
					-- exception for countries isolated by oceans
					if IsNeighbourOnSameContinent(ministerTag, ministerCountry, tag, country)
					or IsOceanNeighbor(ministerTag, tag) then
						nPrio = nPrio + 1
						if country:IsMajor() then
							nPrio = nPrio + 1
						end
					end

					-- less priority for puppets and allies
					if country:isPuppet() or ministerCountry:GetRelation(tag):HasAlliance() then
						nPrio = nPrio - 1
					end

					-- extra priority for other factions
					if ministerCountry:GetFaction():IsValid() and country:GetFaction():IsValid() and ministerCountry:GetFaction() ~= country:GetFaction() then
						nPrio = nPrio + 1
					end
				end

				-- bound
				nPrio = math.min( nPrio, CSpyPresence.MAX_SPY_PRIORITY )
				nPrio = math.max( nPrio, 0 )

				-- pick mission
				if nPrio > 0 then
					--Utils.LUA_DEBUGOUT("priority for: ".. tostring(tag).." set to "..nPrio)
					mission = PickBestMission(country, minister, ministerTag, ministerCountry, ai)
				end
			end

			-- don't waste spies if they're near defeat
			-- (also stops invincible spy bug)
			local surrenderLevel = country:GetSurrenderLevel():Get()
			--Utils.LUA_DEBUGOUT( tostring(tag).." is at surrender level "..surrenderLevel)
			if surrenderLevel > 0.80 then
				local nPrio = 0
				local mission = SpyMission.SPYMISSION_NONE
			end

			-- change priority
			if nPrio ~= SpyPresence:GetPriority() then
				local command = CChangeSpyPriority( ministerTag, tag, nPrio )
				ai:Post(command)
			end

			-- change mission
			if mission ~= SpyPresence:GetMission() then
				local missionCommand = CChangeSpyMission( ministerTag, tag, mission )
				ai:Post(missionCommand)
			end
		end
	end
end


