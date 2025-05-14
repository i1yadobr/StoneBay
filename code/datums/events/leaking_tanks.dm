#define MIN_TANK_QUANTITY 2
#define MAX_TANK_QUANTITY 5
#define MIN_FUEL_TO_LEAK 50
#define MAX_FUEL_TO_LEAK 250

/datum/event/leaking_tanks
	id = "leaking_tanks"
	name = "Leaking fueltanks"
	description = "Some fueltanks was leaking"

	mtth = 1 HOURS
	difficulty = 10

/datum/event/leaking_tanks/check_conditions()
	. = SSevents.triggers.roles_count["Station Engineer"] >= 1

/datum/event/leaking_tanks/get_mtth()
	. = ..()
	. -= (SSevents.triggers.roles_count["Station Engineer"] * (15 MINUTES))
	. = max(1 HOUR, .)

/datum/event/leaking_tanks/on_fire()
	var/list/station_levels = GLOB.using_map.get_levels_with_trait(ZTRAIT_STATION)
	var/list/matching_tanks = list()
	//var/leaking_tanks_quantity = rand(2, 5)

	for (var/z_level in station_levels)
		var/z_level_string = "[z_level]"
		var/list/fueltanks_at_station  = (islist(GLOB.fueltanks[z_level_string]) ? GLOB.fueltanks[z_level_string] : list())

		for (var/obj/structure/reagent_dispensers/fueltank/candidate as anything in fueltanks_at_station)
			matching_tanks += candidate

	if(!matching_tanks.len)
		return

	announce()

	for (var/i in 1 to rand(MIN_TANK_QUANTITY, MAX_TANK_QUANTITY))
		if (!matching_tanks.len)
			break

		var/obj/structure/reagent_dispensers/fueltank/fueltank_leaked = pick_n_take(matching_tanks)

		if (fueltank_leaked)
			var/fuel_units_leak = rand(MIN_FUEL_TO_LEAK, MAX_FUEL_TO_LEAK)
			fueltank_leaked.leak_fuel(fuel_units_leak)

			message_admins("Fuel tank was leaked by event at ([fueltank_leaked.x],[fueltank_leaked.y],[fueltank_leaked.z]), leaking [fuel_units_leak] units.")

/datum/event/leaking_tanks/proc/announce()
	SSannounce.play_station_announce(/datum/announce/leak_fueltanks)

#undef MIN_TANK_QUANTITY
#undef MAX_TANK_QUANTITY
#undef MIN_FUEL_TO_LEAK
#undef MAX_FUEL_TO_LEAK
