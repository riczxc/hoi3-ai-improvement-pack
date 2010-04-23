require 'aiip'

function ProductionMinister_Tick(minister)
	gov = Government.createFromAgent(minister)
	gov:startMeeting(Department.PROD, minister)
end

function BalanceProductionSliders(ai, ministerCountry, prioSelection)
end
