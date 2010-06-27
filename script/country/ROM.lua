-----------------------------------------------------------
-- LUA Hearts of Iron 3 Romania File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 6/26/2010
-----------------------------------------------------------

local P = {}
AI_ROM = P

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	if tostring(actor) == "GER" or tostring(actor) == "ITA" then
		score = score + 10
	elseif tostring(actor) == "SOV" then
		score = score - 10
	end
	
	return score
end

function P.Call_ForeignMinister(minister)
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = ministerTag:GetCountry()

	if not(ministerCountry:HasFaction()) and not(ministerCountry:IsAtWar()) then
		local sovTag = CCountryDataBase.GetTag("SOV")
		
		-- If Russia controls Romania border align with Germany
		if CCurrentGameState.GetProvince(3377):GetController() == sovTag then
			local loAction = CInfluenceAllianceLeader(minister:GetCountryTag(), CCountryDataBase.GetTag("GER"))
			--loAction:SetValue(true)
			
			if loAction:IsSelectable() then
				minister:Propose(loAction, 1000)
			end
		end
	end
end

return AI_ROM

