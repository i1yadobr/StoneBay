
/turf/simulated/open/airless
	initial_gas = null

/turf/simulated/open/airmix
	initial_gas = list("oxygen" = MOLES_O2ATMOS, "nitrogen" = MOLES_N2ATMOS)

/turf/simulated/open/nitrogen
	initial_gas = list("nitrogen" = ATMOSTANK_NITROGEN)

/turf/simulated/open/nitrogen/engine
	initial_gas = list("nitrogen" = MOLES_N2STANDARD)

/turf/simulated/open/hydrogen
	initial_gas = list("hydrogen" = ATMOSTANK_HYDROGEN)

/turf/simulated/open/hydrogen/fuel
	initial_gas = list("hydrogen" = ATMOSTANK_HYDROGEN_FUEL)

/turf/simulated/open/oxygen
	initial_gas = list("oxygen" = ATMOSTANK_OXYGEN)

/turf/simulated/open/plasma
	initial_gas = list("plasma" = ATMOSTANK_PLASMA)

/turf/simulated/open/plasma/fuel
	initial_gas = list("plasma" = ATMOSTANK_PLASMA_FUEL)

/turf/simulated/open/carbon_dioxide
	initial_gas = list("carbon_dioxide" = ATMOSTANK_CO2)

/turf/simulated/open/n20
	initial_gas = list("sleeping_agent" = ATMOSTANK_NITROUSOXIDE)


/turf/simulated/floor/grid/bluegrid/nitrogen
	initial_gas = list("nitrogen" = MOLES_N2STANDARD)