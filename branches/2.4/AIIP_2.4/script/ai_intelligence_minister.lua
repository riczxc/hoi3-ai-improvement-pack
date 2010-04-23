require 'aiip'

function IntelligenceMinister_Tick(minister)
	gov = Government.createFromAgent(minister)
	gov:startMeeting(Department.INTEL, minister)
end
