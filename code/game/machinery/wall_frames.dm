/obj/item/frame
	name = "frame"
	desc = "Used for building machines."
	icon = 'icons/obj/monitors.dmi'
	icon_state = "fire_bitem"
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	// The list of turfs that the frame can be built on
	var/list/buildon_types = list(/turf/simulated/wall)
	// Whether the frame can be built on the floor, or only on walls
	var/allow_floor_mounting = FALSE
	// The number of sheets refunded when the frame is deconstructed
	var/sheets_refunded = 2
	// The type of stack that will be created when the frame is deconstructed
	var/refund_type = /obj/item/stack/material/steel
	// The flags that define the properties of the frame, such as whether it can be built on simfloors or in space
	var/frame_flags = 0
	// Note: This switch works 50/50, and in some cases it breaks the logic of the building
	// Based on this, either it should be polished and clean up, or the possibility should be removed
	// Used for light fixtures
	var/reverse = FALSE

/obj/item/frame/attackby(obj/item/W, mob/user)
	if(isWrench(W))
		new refund_type(get_turf(src.loc), sheets_refunded)
		qdel(src)
		return
	..()

/obj/item/frame/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(is_type_in_list(target, buildon_types))
		if(try_build(target, user, proximity_flag))
			return do_build(target, user)
	..()

/obj/item/frame/proc/try_build(turf/on_wall, mob/user, proximity_flag)
	if(!proximity_flag) //if we aren't next to the turf
		return FALSE

	if(!on_wall || !user)
		return FALSE

	var/turf/build_turf = get_turf(user)
	if(!allow_floor_mounting)
		var/ndir
		if(reverse)
			ndir = get_dir(user, on_wall)
		else
			ndir = get_dir(on_wall, user)

		if(!(ndir in GLOB.cardinal))
			to_chat(user, SPAN("danger", "You need to be standing next to [on_wall] to place [src]."))
			return FALSE
		if(gotwallitem(build_turf, ndir))
			to_chat(user, SPAN("danger", "There's already an item on this wall!"))
			return FALSE

	// Note: This check is here to prevent placing wall-mounted items on the floor when allow_floor_mounting is TRUE,
	// since gotwallitem() only checks for items on the wall, and not on the floor
	// However, maybe it should be moved to a separate proc, or this check should be assigned to /obj/item/frame/light/floor
	if(locate(/obj/machinery/light_construct/floor, on_wall) || locate(/obj/machinery/light/floor, on_wall))
		to_chat(user, SPAN("warning", "There's already an item on this floor!"))
		return FALSE
	if((frame_flags & FRAME_FLAG_SIMFLOOR) && !isfloorturf(build_turf))
		to_chat(user, SPAN("warning", "[src] cannot be placed on this spot."))
		return FALSE
	if(frame_flags & FRAME_FLAG_NOSPACE)
		var/area/my_area = get_area(build_turf)
		if(!istype(my_area) || !my_area.requires_power || isspace(my_area))
			to_chat(user, SPAN("warning", "[src] cannot be placed in this area."))
			return FALSE

	return TRUE

/obj/item/frame/proc/do_build(turf/on_wall, mob/user) //the buildy bit after we pass the checks
	return

/obj/item/frame/fire_alarm
	name = "fire alarm frame"
	desc = "Used for building fire alarms."
	frame_flags = FRAME_FLAG_SIMFLOOR | FRAME_FLAG_NOSPACE

/obj/item/frame/fire_alarm/do_build(turf/on_wall, mob/user)
	var/obj/machinery/firealarm/F = new /obj/machinery/firealarm(get_turf(src), get_dir(on_wall, user), src)
	F.buildstage = 0 // Set the build stage to the initial state
	F.update_icon()
	user.visible_message("[user] attaches \the [src] to \the [on_wall].", \
		"You attach \the [src] to \the [on_wall].")
	qdel(src)

/obj/item/frame/air_alarm
	name = "air alarm frame"
	desc = "Used for building air alarms."
	icon_state = "alarm_bitem"
	frame_flags = FRAME_FLAG_SIMFLOOR | FRAME_FLAG_NOSPACE

/obj/item/frame/air_alarm/do_build(turf/on_wall, mob/user)
	var/obj/machinery/alarm/A = new /obj/machinery/alarm(get_turf(src), get_dir(on_wall, user), src)
	A.buildstage = 0 // Set the build stage to the initial state
	A.update_icon()
	user.visible_message("[user] attaches \the [src] to \the [on_wall].", \
		"You attach \the [src] to \the [on_wall].")
	qdel(src)

/obj/item/frame/light
	name = "light fixture frame"
	desc = "Used for building lights."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube-construct-item"
	frame_flags = FRAME_FLAG_SIMFLOOR
	reverse = TRUE
	// Specifies which type of light fixture this frame will build
	var/fixture_type = "tube"

/obj/item/frame/light/do_build(turf/on_wall, mob/user)
	playsound(src, 'sound/machines/click.ogg', 75, 1)
	var/constrdir = user.dir
	var/constrloc = get_turf(user)
	var/obj/machinery/light_construct/newlight
	switch(fixture_type)
		if("bulb")
			newlight = new /obj/machinery/light_construct/small(constrloc)
		if("tube")
			newlight = new /obj/machinery/light_construct(constrloc)
		if("floor")
			newlight = new /obj/machinery/light_construct/floor(on_wall)
		else
			newlight = new /obj/machinery/light_construct/small(constrloc)

	// TODO: If possible, it should be rewritten into something more clear and constructive than this!
	// Note: It's a very cursed system, but it works like this:
	// Since gotwallitem() defines an item on the wall using dirs,
	// we simply assign /obj/item/frame/light/floor its own, third independent, dir
	// So, floor lighting shouldn't interfere with other types of frames being placed on the wall. I guess...
	if(allow_floor_mounting)
		newlight.dir = 16
	else
		newlight.dir = constrdir
	newlight.fingerprints = src.fingerprints

	user.visible_message("[user] attaches \the [src] to \the [on_wall].", \
		"You attach \the [src] to \the [on_wall].")
	qdel(src)

/obj/item/frame/light/small
	name = "small light fixture frame"
	icon_state = "bulb-construct-item"
	fixture_type = "bulb"
	sheets_refunded = 1

/obj/item/frame/light/floor
	name = "floor light fixture frame"
	icon_state = "floor-construct-item"
	fixture_type = "floor"
	sheets_refunded = 3
	buildon_types = list(/turf/simulated/floor)
	allow_floor_mounting = TRUE

/obj/item/frame/intercom
	name = "intercom frame"
	desc = "Used for building intercoms."
	icon = 'icons/obj/radio.dmi'
	icon_state = "intercom_bitem"
	frame_flags = FRAME_FLAG_SIMFLOOR | FRAME_FLAG_NOSPACE

/obj/item/frame/intercom/do_build(turf/on_wall, mob/user)
	new /obj/item/intercom_assembly(get_turf(src), get_dir(on_wall, user), src)
	user.visible_message("[user] attaches \the [src] to \the [on_wall].", \
		"You attach \the [src] to \the [on_wall].")
	qdel(src)
