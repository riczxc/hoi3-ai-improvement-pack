require 'aiip'
require 'government'

function TechMinister_Tick(minister)
	gov = Government.createFromAgent(minister)
	gov:startMeeting(Department.TECH, minister)
end

function BalanceLeadershipSliders(ai, ministerCountry)
end
