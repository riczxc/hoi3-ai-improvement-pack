-----------------------------
-- Custom AI by Maclane
-- Version 1.3
-----------------------------

local P = {}
Custom_AI = P

function P.CustomFactionInviteRules( score, ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("Enter the CustomFactionInviteRules -->>")
	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()

	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()

	local engTag = CCountryDataBase.GetTag('ENG')
	local usaTag = CCountryDataBase.GetTag('USA')
	local gerTag = CCountryDataBase.GetTag('GER')
	local sovTag = CCountryDataBase.GetTag('SOV')
	local japTag = CCountryDataBase.GetTag('JAP')

	if tostring(actor) == 'GER' then
		--Utils.LUA_DEBUGOUT("Yep getting in the GER custom script")
		if tostring(recipient) == 'AUS' then -- we got better plans for you...
			return 0
		end



		if tostring(recipient) == 'ITA' or tostring(recipient) == 'SPA' then
			--Utils.LUA_DEBUGOUT("Recipient is ITA or SPA...")

			if year >= 1939 and CCurrentGameState.GetProvince( 1928 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Warsaw is controlled by GER -> return 100")
				return 100
			else
				--Utils.LUA_DEBUGOUT("Condition is false -> return 100")
				return 0
			end
		elseif tostring(recipient) == 'JAP' then
			--Utils.LUA_DEBUGOUT("Recipient is JAP...")

			if year >= 1940 and CCurrentGameState.GetProvince( 2613 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Paris is controlled by GER -> return 100")
				return 100 --Japan is invited if Paris has been conquered
			elseif recipientCountry:GetRelation(engTag):HasWar() or recipientCountry:GetRelation(usaTag):HasWar() then
				--Utils.LUA_DEBUGOUT("JAP is at war with ENG or USA -> return 100")
				return 100 --Japan can join if it is at war with ENG or USA
			else
				--Utils.LUA_DEBUGOUT("no conditions met -> return 0")
				return 0
			end
		elseif tostring(recipient) == 'HUN' or tostring(recipient) == 'ROM' or tostring(recipient) == 'BUL' then
			--Utils.LUA_DEBUGOUT("Recipient is HUN or ROM or BUL...")

			if year >= 1940 and CCurrentGameState.GetProvince( 2613 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Paris is controlled by GER -> return 100")
				return 100
			else
				--Utils.LUA_DEBUGOUT("Condition is false -> return 100")
				return 0
			end
		else
			--Utils.LUA_DEBUGOUT("None of the mentioned recipients -> return score")
			return score
		end
	elseif tostring(actor) == 'ENG' or tostring(actor) == 'USA' then
		--Utils.LUA_DEBUGOUT("Yep getting in the ENG/USA custom script")
		if actorCountry:GetRelation(gerTag):HasWar() then
			--Utils.LUA_DEBUGOUT("Actor is at war with GER")
			if recipientCountry:GetRelation(gerTag):HasWar() then
				--Utils.LUA_DEBUGOUT("Recipient is at war with GER too -> return 100")
				return 100 --each country that is at war with GER will be invited to the Allies if the Allies are at war with Germany too
			end
			--Utils.LUA_DEBUGOUT("Recipient is not at war with GER -> proceed")
		else
			--Utils.LUA_DEBUGOUT("Actor is not at war with GER -> proceed")
		end
		if actorCountry:GetRelation(sovTag):HasWar() then
			--Utils.LUA_DEBUGOUT("Actor is at war with SOV")
			if recipientCountry:GetRelation(sovTag):HasWar() then
				--Utils.LUA_DEBUGOUT("Recipient is at war with SOV too -> return 100")
				return 100 --each country that is at war with SOV will be invited to the Allies if the Allies are at war with Soviet Union too
			end
			--Utils.LUA_DEBUGOUT("Recipient is not at war with SOV -> proceed")
		else
			--Utils.LUA_DEBUGOUT("Actor is not at war with SOV -> proceed")
		end
		if tostring(recipient) == 'USA' then
			--Utils.LUA_DEBUGOUT("Recipient is USA")
			if recipientCountry:GetRelation(japTag):HasWar() or year >= 1942 then
				--Utils.LUA_DEBUGOUT("USA has war with JAP or year is >= 1942 -> return 100")
				return 100 --USA will be invited if at war with JAP or later than 1942
			else
				--Utils.LUA_DEBUGOUT("Conditions not met -> proceed")
			end
		else
			--Utils.LUA_DEBUGOUT("Recipient is not USA -> return score")
			return score
		end
	elseif tostring(actor) == 'SOV' then
	   --Utils.LUA_DEBUGOUT("Yep getting in the SOV custom script")
	   if tostring(recipient) == 'CHC' then
	      --Utils.LUA_DEBUGOUT("Recipient is CHC...")
	      if year >= 1940
		  and not gerTag:GetCountry():IsAtWar() --WW2 is over
	      and not recipientCountry:GetRelation(japTag):HasWar() --sino-japanese war is over too
          then
                --Utils.LUA_DEBUGOUT("WW2 is over -> return 100")
		    	return 100 --Communist China can join after world war is over
	      elseif actorCountry:GetRelation(japtag):HasWar() and recipientCountry:GetRelation(japTag):HasWar() then
	            --Utils.LUA_DEBUGOUT("SOV and CHC at war with JAP -> return 100")
	        	return 100 --Communist China can also join if both countries are at war with Japan
	      else
	            --Utils.LUA_DEBUGOUT("no conditions met -> return 0")
	        	return 0  --Communist China cannot join in other cases
		 end
	   end
	else
		--Utils.LUA_DEBUGOUT("Actor is neither GER nor ENG nor USA nor SOV -> return score")
		return score
	end
	--Utils.LUA_DEBUGOUT("We are after the If-Block -> return score (should not happen!)")
	return score
end

function P.CustomFactionAcceptRules( score, ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("Enter the CustomFactionAcceptRules -->>")
	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()

	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()

	local gerTag = CCountryDataBase.GetTag('GER')
	local japTag = CCountryDataBase.GetTag('JAP')
	local sovTag = CCountryDataBase.GetTag('SOV')
	local itaTag = CCountryDataBase.GetTag('ITA')
	local engTag = CCountryDataBase.GetTag('ENG')
	local usaTag = CCountryDataBase.GetTag('USA')
	local usaCountry = usaTag:GetCountry()

	if tostring(recipient) == 'SCH' or tostring(recipient) == 'SWE' or tostring(recipient) == 'TIB' then
		--Utils.LUA_DEBUGOUT("Recipient is SCH or SWE or TIB")
		if recipientCountry:IsAtWar() then
			--Utils.LUA_DEBUGOUT("Recipient is at war -> return 100")
			return 100
		else
			--Utils.LUA_DEBUGOUT("Recipient is not at war -> return 0")
			return 0 --Switzerland, Sweden and Tibet will only join a faction to protect themselves if they are at war
		end
	end


	if tostring(actor) == 'ENG' or tostring(actor) == 'USA' then
		--Utils.LUA_DEBUGOUT("Actor is ENG or USA")
		if recipientCountry:GetRelation(gerTag):HasWar() then
			--Utils.LUA_DEBUGOUT("Recipient is at war with GER -> return 100")
			return 100 --each country at war with GER will accept invitation
		end


		if tostring(recipient) == 'USA' then
			--Utils.LUA_DEBUGOUT("Recipient is USA...")

			if recipientCountry:GetRelation(japTag):HasWar()
			or recipientCountry:GetRelation(sovTag):HasWar()
			then
				--Utils.LUA_DEBUGOUT("USA has war with JAP or SOV -> return 100")
				return 100 --USA will accept if at war with Japan or Soviet Union
			elseif year >= 1942 then
				--Utils.LUA_DEBUGOUT("year is after 1942 -> return 100")
				return 100 --USA will accept after 1942
			elseif 	CCurrentGameState.GetProvince( 1964 ):GetController() ~= actor then
				--Utils.LUA_DEBUGOUT("London was conquered -> return 100")
				return 100 --USA will accept if London has been conquered before 1942
			else
				--Utils.LUA_DEBUGOUT("Conditions not met -> return 0")
				return 0
			end
		elseif tostring(recipient) == 'CAN'
			or tostring(recipient) == 'AST'
			or tostring(recipient) == 'NZL'
			or tostring(recipient) == 'SAF'
			then
				--Utils.LUA_DEBUGOUT("Recipient is Commomwealth Country -> return 100")
				return 100 --Commonwealth countries will always accept invitation by ENG
		elseif tostring(recipient) == 'GRE' then
			--Utils.LUA_DEBUGOUT("Recipient is GRE...")
			if recipientCountry:GetRelation(itaTag):HasWar() then
				--Utils.LUA_DEBUGOUT("Recipient is at war with ITA -> return 100")
				return 100 --Greece will accept invitation if at war with Italy
			else
				--Utils.LUA_DEBUGOUT("Recipient is not at war with ITA -> return 0")
				return 0 --Greece won't accept if not at war with ITA
			end
		elseif usaCountry:HasFaction() then
		    return 100  --every country will accept if USA is member of a faction
		else
			--Utils.LUA_DEBUGOUT("none of the mentioned recipients -> return 0")
			return 0 --every other Minor won't accept invitation (unless USA is member of the Allies)

		end
	end



	if tostring(actor) == 'GER' then
		--Utils.LUA_DEBUGOUT("Actor is GER...")
		if tostring(recipient) == 'JAP' then
			--Utils.LUA_DEBUGOUT("Recipient is JAP...")
			if CCurrentGameState.GetProvince( 1409 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Moscow is occupied by Germany -> return 100")
				return 100 --Japan will accept if Moscow has been conquered by Germany
			elseif recipientCountry:GetRelation(engTag):HasWar() or recipientCountry:GetRelation(usaTag):HasWar() then
				--Utils.LUA_DEBUGOUT("JAP is at war with ENG or USA")
				return 100 --Japan will accept if it is at war with ENG or USA
			else
				--Utils.LUA_DEBUGOUT("conditions not met -> return 0")
				return 0 --don't accept in others cases
			end
		elseif tostring(recipient) == 'ITA' or tostring(recipient) == 'SPA' then
			--Utils.LUA_DEBUGOUT("Recipient is ITA or SPA...")

			if year >= 1939 and CCurrentGameState.GetProvince( 1928 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Warsaw is controlled by GER -> return 100")
				return 100
			else
				--Utils.LUA_DEBUGOUT("Condition is false -> return 100")
				return 0
			end
		elseif tostring(recipient) == 'HUN' or tostring(recipient) == 'ROM' or tostring(recipient) == 'BUL' then
			--Utils.LUA_DEBUGOUT("Recipient is HUN or ROM or BUL...")

			if year >= 1940 and CCurrentGameState.GetProvince( 2613 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Paris is controlled by GER -> return 100")
				return 100
			else
				--Utils.LUA_DEBUGOUT("Condition is false -> return 100")
				return 0
			end
		else
			if year >= 1940 and CCurrentGameState.GetProvince( 2613 ):GetController() == actor then
				--Utils.LUA_DEBUGOUT("Paris is controlled by GER -> return 100")
				return score
			else
				--Utils.LUA_DEBUGOUT("Condition is false -> return 100")
				return 0
			end
		end
	end



	--Utils.LUA_DEBUGOUT("Last line, no conditions met -> return score")
	return score
end

return Custom_AI