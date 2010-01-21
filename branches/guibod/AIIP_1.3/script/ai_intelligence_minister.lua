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
			local unity = ministerCountry:GetNationalUnity():Get()
			local neutrality = ministerCountry:GetNeutrality():Get()

			if not ministerCountry:IsAtWar() then
				-- raise national unity if less than 60 or if neutrality is less than 60 and NU > 70 (for draft laws)
				if (unity < 60) or (neutrality < 60 and unity < 70) then
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
			else
				-- Do not aim higher or countries will never give up (no vhichy event etc.)
				if (unity < 50) then
					newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY
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
	-- store open scale results in a dictionary
	local prioTable = {}
	-- store max open scale result in order to use it in rule of three
	local maxPrio = 0

	-- get overlord tag
	local overlordTag = nil
	if ministerCountry:isPuppet() then
		overlordTag = ministerCountry:GetOverlord()
	end

	-- neighbourhood importance (1-100), the more neighbour, the less this is an important factor
	local neighbourCount = 0
	for country in CCurrentGameState.GetCountries() do
 		local tag = country:GetCountryTag()
		if IsNeighbourOnSameContinent(ministerTag, ministerCountry, tag, country)
			or IsOceanNeighbour(ministerTag, tag) then
			neighbourCount = neighbourCount + 1
		end
 	end
	local neighbourImportance = math.floor(100/neighbourCount)

	-- check countries
	for country in CCurrentGameState.GetCountries() do
		local tag = country:GetCountryTag()
		-- Checked country threat (1-100)
		local countryThreat = math.min(100,math.floor(ministerCountry:GetRelation( tag ):GetThreat():Get() + 1))

		-- not us
		if tag ~= ministerTag then
			--open scaled priority
			local oPrio = 0
			local oPrioFactor = 1

			-- no spies for non valid
			if not IsValidCountry(country) then
				--Utils.LUA_DEBUGOUT(tostring(ministerTag).." ManageSpiesAbroad "..tostring(tag).." skipping non-valid "..tostring(tag))
				oPrio = 0

			-- no spies for master
			elseif overlordTag ~= nil and tag == overlordTag then
				--Utils.LUA_DEBUGOUT(tostring(ministerTag).." ManageSpiesAbroad "..tostring(tag).." skipping master "..tostring(tag))
				oPrio = 0

			-- don't waste spies if they're near defeat (also stops invincible spy bug)
			elseif country:GetSurrenderLevel():Get() > 0.8 then
				--Utils.LUA_DEBUGOUT( tostring(ministerTag).." ManageSpiesAbroad "..tostring(tag).." is at surrender level "..country:GetSurrenderLevel():Get())
				oPrio = 0

			-- Don't mind GIE
			elseif country:IsGovernmentInExile() then
				--Utils.LUA_DEBUGOUT( tostring(ministerTag).." ManageSpiesAbroad "..tostring(tag).." is GIE." )
				oPrio = 0

			-- valid countries, not part of current minister faction
			elseif IsValidCountry(country) and not (ministerCountry:GetFaction():IsValid() and ministerCountry:GetFaction() == country:GetFaction()) then
				--Utils.LUA_DEBUGOUT( tostring(ministerTag).." ManageSpiesAbroad ".."evaluating spypriority for: ".. tostring(tag))

				-- majors need to be cautiuos
				if ministerCountry:IsMajor() and country:IsMajor() then
					oPrio = oPrio + 100
				end

				-- less priority for puppets and allies, if current country is faction member.
				if ministerCountry:GetFaction():IsValid() and (country:isPuppet() or ministerCountry:GetRelation(tag):HasAlliance()) then
					oPrio = oPrio - 100
				end

				-- extra priority for other factions
				-- the more members, the less it is a matter
				if ministerCountry:GetFaction():IsValid() and country:GetFaction():IsValid() and ministerCountry:GetFaction() ~= country:GetFaction() then
					if country:GetFaction():GetNumberOfMembers() < 5 then
						oPrio = oPrio + 100
					elseif country:GetFaction():GetNumberOfMembers() < 10 then
						oPrio = oPrio + 50
					else
						oPrio = oPrio + 25
					end
				end

				-- extra priority for neighbors
				-- same continent to prevent guangxi spies in england for example
				-- exception for countries isolated by oceans
				if IsNeighbourOnSameContinent(ministerTag, ministerCountry, tag, country)
				or IsOceanNeighbour(ministerTag, tag) then
					-- oPrio can move 300 max
					oPrioFactor = 0.5
					if country:IsMajor() then
						oPrioFactor = 0.75
					end
					oPrio = oPrio + math.min(math.floor( (countryThreat/2 + math.random(1,10)) * neighbourImportance * oPrioFactor) , 300)
				end

 				-- Now regarding warpath
				if ministerCountry:IsAtWar() or strategy:IsPreparingWar() then
					-- At war. Only concentrate on countries we're preparing war with.
					if strategy:IsPreparingWarWith(tag) then
						--we are on the warpath with them
						oPrio = oPrio + 200
					elseif ministerCountry:GetRelation(tag):HasWar() then
						if ministerCountry:IsMajor() and country:IsMajor() then
							--big players bonus, gets another for being at war together
							oPrio = oPrio + 100
						end

						if ministerCountry:IsNeighbour(tag) or IsOceanNeighbor(ministerTag, tag) then
							--Share frontline
							oPrio = oPrio + 100
						else
							--Remote war
							oPrio = oPrio + 50
						end
					end
				else
					-- In peace, but stay focus on threatening warmongers (using local threat as weight)
					if country:IsAtWar() then
						-- oPrio +(0-150)
						oPrioFactor = 0.5
						for opposingCountry in country:GetCurrentAtWarWith() do
							if ministerCountry:IsFriend(opposingCountry, false) then
								--don't like enemies of my friends
								oPrioFactor = 1.5
							end
						end
						oPrio = oPrio + math.floor( countryThreat * oPrioFactor)

					elseif country:IsMobilized() and ministerCountry:GetRelation( tag ):GetThreat():Get() > 50 then
						-- Something fishy is about to happen around there (using threat as weight)
						-- oPrio +(0-75)
						oPrioFactor = 0.25
						if ministerCountry:IsEnemy(country) then
							-- Mobilizing enemies are to be monitored
							oPrioFactor = 0.75
						end
						oPrio = oPrio + math.floor( countryThreat * oPrioFactor)
					end
				end

				-- Axis gets a counterespionage bonus, we need to take care of this
				if country:GetFaction() == CCurrentGameState.GetFaction('axis') then
					oPrio = math.floor(oPrio * 1.25)
				-- Democracies are weak at the spy game
				elseif country:GetRulingIdeology():GetGroup() == CCurrentGameState.GetFaction('allies'):GetIdeologyGroup() then
					oPrio = math.floor(oPrio * 0.75)
				end
			end

			prioTable[country] = oPrio
			-- Do NEVER allow negative or zero max priority
			maxPrio = math.max( oPrio, maxPrio )
		end
	end

	-- If there is no real threat, openscale has crappy score. Lower normalized score to priority 2 max by cheating the maxPrio
	if 200 > maxPrio then
		maxPrio = maxPrio * 1.5
	end

	for country,oPrio in pairs(prioTable) do
		local tag = country:GetCountryTag()
		local nPrio	 = 0
		local ratio	 = oPrio/maxPrio
		local SpyPresence = ministerCountry:GetSpyPresence(tag)
		local mission = SpyMission.SPYMISSION_NONE --default mission is NONE.

		-- Compute Normalized priority
		if oPrio > 0 then
			if ratio >= 0.8 then
				nPrio = 3
			elseif ratio >= 0.5 then
				nPrio = 2
			elseif ratio >= 0.1 then
				nPrio = 1
			end
		end

		-- How do we plan to use our spies ?
		if nPrio > 0 then
			mission = PickBestMission(country, minister, ministerTag, ministerCountry, ai)

			if mission == SpyMission.SPYMISSION_NONE then
				--a mission was pick but there is nothing to do ! Why the hell send spies there ?
				--we lower normalized priority.
				nPrio = nPrio - 1
			end
		end


		local day = CCurrentGameState.GetCurrentDate():GetDayOfMonth()+1
		local month = CCurrentGameState.GetCurrentDate():GetMonthOfYear()+1
		local year = CCurrentGameState.GetCurrentDate():GetYear()

		--Utils.LUA_DEBUGOUT( day..";"..month..";"..year..";"..tostring(ministerTag)..";"..tostring(tag)..";"..tostring(nPrio)..";"..tostring(mission)..";"..tostring(oPrio))

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
	--Utils.LUA_DEBUGOUT( tostring(ministerTag).." ManageSpiesAbroad ended")
end


