require 'aiip'
require 'ai_diplomacy'
require 'government'

function ForeignMinister_Tick(minister)
	gov = Government.createFromAgent(minister)
	gov:startMeeting(Department.DIPLO, minister)
	-- run any decisions available
	--minister:ExecuteDiploDecisions()
end

function ForeignMinister_EvaluateDecision(agent, decision, scope)
--~ 	dtools.setLogContext(agent, 'DIPLO')
--~ 	dtools.info('ForeignMinister_EvaluateDecision')
	return 0
end

function ForeignMinister_OnWar(agent, countryTag1, countryTag2, war)
--~ 	dtools.setLogContext(agent, 'DIPLO')
--~ 	dtools.info('ForeignMinister_OnWar')
end

function ForeignMinister_ManageTrade(ai, ministerTag)
--~ 	dtools.setLogContext(ministerTag, 'DIPLO')
--~ 	dtools.info('ForeignMinister_ManageTrade')
end

if not CAI then
	local agent = {}
	function agent.GetCountryTag()
		return 'GER'
	end
	function agent.GetCountry()
		return {}
	end
	ForeignMinister_Tick(agent)
end
