require 'aiip'

function PoliticsMinister_Tick(minister)
	gov = Government.createFromAgent(minister)
	gov:startMeeting(Department.POLIT, minister)
end
