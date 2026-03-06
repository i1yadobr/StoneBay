/obj/item/frame/apc
	name = "\improper APC frame"
	desc = "Used for repairing or building APCs."
	icon = 'icons/obj/apc_repair.dmi'
	icon_state = "apc_frame"
	frame_flags = FRAME_FLAG_SIMFLOOR | FRAME_FLAG_NOSPACE

/obj/item/frame/apc/try_build(turf/on_wall, mob/user, proximity_flag)
	if(!..())
		return
	var/turf/T = get_turf(user)
	var/area/A = get_area(T)
	if(A.get_apc())
		to_chat(user, SPAN("warning", "This area already has an APC."))
		return //only one APC per area

	if(!A.requires_power)
		to_chat(user, SPAN("warning", "APC cannot be placed in this area."))
		return //can't place apcs in areas with no power requirement

	for(var/obj/machinery/power/terminal/E in T)
		if(E.master)
			to_chat(user, SPAN("warning", "There is another network terminal here."))
			return

		else
			var/obj/item/stack/cable_coil/C = new /obj/item/stack/cable_coil(T)
			C.amount = 10
			to_chat(user, SPAN("notice", "You cut the cables and disassemble the unused power terminal."))
			qdel(E)
	return TRUE

/obj/item/frame/apc/do_build(turf/on_wall, mob/user)
	new /obj/machinery/power/apc(get_turf(src), get_dir(user, on_wall), TRUE)
	qdel(src)
