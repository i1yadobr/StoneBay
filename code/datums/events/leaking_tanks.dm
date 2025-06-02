#define MIN_TANK_QUANTITY 2
#define MAX_TANK_QUANTITY 5
#define MIN_FUEL_TO_LEAK 0.05 LITERS
#define MAX_FUEL_TO_LEAK 0.25 LITERS

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
	var/list/matching_tanks = list()

	for (var/z_level as anything in GLOB.using_map.get_levels_with_trait(ZTRAIT_STATION))
		LAZYADD(matching_tanks, LAZYCOPY(GLOB.fueltanks["[z_level]"]))

	if (!length(matching_tanks))
		return

	announce()

	for (var/i in 1 to rand(MIN_TANK_QUANTITY, MAX_TANK_QUANTITY))
		var/obj/structure/reagent_dispensers/fueltank/fueltank_leaked = pick_n_take(matching_tanks)

		if (fueltank_leaked)
			fueltank_leaked.leak_fuel(rand(MIN_FUEL_TO_LEAK, MAX_FUEL_TO_LEAK))

			message_admins("Fuel tank was leaked by event at ([fueltank_leaked.x],[fueltank_leaked.y],[fueltank_leaked.z]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[fueltank_leaked.x];Y=[fueltank_leaked.y];Z=[fueltank_leaked.z]'>JMP</a>)")

/datum/event/leaking_tanks/proc/announce()
	SSannounce.play_station_announce(/datum/announce/leak_fueltanks)

#undef MIN_TANK_QUANTITY
#undef MAX_TANK_QUANTITY
#undef MIN_FUEL_TO_LEAK
#undef MAX_FUEL_TO_LEAK
