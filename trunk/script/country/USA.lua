local P = {}
AI_USA = P

function P.DiploScore_Guarantee( score, ai, actor, recipient, observer)

	local recipientCountry = recipient:GetCountry()
	if not recipientCountry:HasFaction() then
		local continent = tostring( recipientCountry:GetCapitalLocation():GetContinent():GetTag() )
		if (continent == "north_america" or continent == "south_america")
		and not (tostring(recipient) == 'CAN') then
			return 100
		end
	end
	
	return score
end

return AI_USA

