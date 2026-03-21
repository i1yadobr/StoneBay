/obj/item/storage/lockbox
	name = "lockbox"
	desc = "A locked box."
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
		)
	icon_state = "lockbox+l"
	item_state = "lockbox"
	base_icon_state = "lockbox"
	inspect_state = "illdomyshitmyself"
	w_class = ITEM_SIZE_HUGE
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	req_access = list(access_armory)
	locked = TRUE
	var/emagged = FALSE

/obj/item/storage/lockbox/Initialize()
	. = ..()
	update_icon()

/obj/item/storage/lockbox/on_update_icon()
	if(locked)
		icon_state = base_icon_state + "+l"
		return

	icon_state = base_icon_state + (being_inspected ? "+o" : "") + (emagged ? "+b" : "")

/obj/item/storage/lockbox/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/melee/energy))
		emag_act(INFINITY, user, W)
		return
	if(istype(W, /obj/item/card/id))
		if(emagged)
			to_chat(user, SPAN_WARNING("[src] broken!"))
			return
		if(check_access(W))
			locked = !locked
			update_icon()
			if(locked)
				to_chat(user, SPAN_NOTICE("You lock \the [src]!"))
				close_all()
				return
			else
				to_chat(user, SPAN_NOTICE("You unlock \the [src]!"))
				return
		to_chat(user, SPAN_WARNING("Wrong access!"))
		return

	if(!locked)
		return ..()

/obj/item/storage/lockbox/attack_hand(mob/user)
	add_fingerprint(user)

	if(locked && (loc == user)) // lockbox onmob?
		to_chat(usr, SPAN_WARNING("[src] is locked and cannot be opened!"))
		return
	else if(!locked && (loc == user))
		open(usr)
	else
		for(var/mob/M in range(1))
			if(M.s_active == src)
				close(M)
	. = ..()

/obj/item/storage/lockbox/show_to(mob/user)
	if(locked)
		to_chat(user, SPAN_WARNING("It's locked!"))
		return
	. = ..()

/obj/item/storage/lockbox/AltClick(mob/usr)
	if(locked)
		to_chat(usr, SPAN_WARNING("[src] is locked and cannot be opened!"))
		add_fingerprint(usr)
		return
	return ..()

/obj/item/storage/lockbox/emag_act(remaining_charges, mob/user, atom/emag_source, visual_feedback = "", audible_feedback = "")
	if(istype(emag_source, /obj/item/melee/energy))
		var/obj/item/melee/energy/energy_weapon = emag_source
		if(!energy_weapon.active)
			return NO_EMAG_ACT
	if(emagged || !remaining_charges)
		// `emag_source.name` is used to prevent automatic article insertion before the name of the emag source.
		to_chat(user, SPAN("notice", "You swipe your [emag_source.name] through the lock mechanism of \the [src], but nothing happens."))
		return
	emagged = TRUE
	locked = FALSE
	on_hack_behavior()
	return TRUE

/obj/item/storage/lockbox/proc/on_hack_behavior()
	var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
	spark_system.set_up(5, 0, loc)
	spark_system.start()
	playsound(loc, 'sound/weapons/blade1.ogg', 50, 1)
	playsound(loc, "spark", 50, 1)
	update_icon()

/obj/item/storage/lockbox/loyalty
	name = "lockbox of loyalty implants"
	req_access = list(access_security)

// TODO: Move this to "startswith" list
/obj/item/storage/lockbox/loyalty/Initialize()
	. = ..()
	new /obj/item/implantcase/loyalty(src)
	new /obj/item/implantcase/loyalty(src)
	new /obj/item/implantcase/loyalty(src)
	new /obj/item/implanter/loyalty(src)

/obj/item/storage/lockbox/clusterbang
	name = "lockbox of clusterbangs"
	desc = "You have a bad feeling about opening this."
	req_access = list(access_security)

// TODO: Move this to "startswith" list
/obj/item/storage/lockbox/clusterbang/Initialize()
	. = ..()
	new /obj/item/grenade/flashbang/clusterbang(src)

/obj/item/storage/lockbox/vials
	name = "secure vial storage box"
	desc = "A locked box for keeping things away from children."
	icon = 'icons/obj/vialbox.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_righthand.dmi'
		)
	icon_state = "vialbox0"
	item_state = "syringe_kit"
	inspect_state = FALSE

	w_class = ITEM_SIZE_NORMAL
	max_w_class = ITEM_SIZE_TINY
	max_storage_space = null
	storage_slots = 6
	req_access = list(access_virology)

	can_hold = list(
		/obj/item/reagent_containers/vessel/beaker/vial
	)

/obj/item/storage/lockbox/vials/on_update_icon()
	var/total_contents = count_by_type(contents, /obj/item/reagent_containers/vessel/beaker/vial)
	ClearOverlays()
	icon_state = "vialbox[Floor(total_contents)]"
	if(!emagged)
		AddOverlays(image(icon, src, "led[locked]"))
		if(locked)
			AddOverlays(image(icon, src, "cover"))
	else
		AddOverlays(image(icon, src, "ledb"))
	return

/obj/item/storage/lockbox/medal
	name = "medal box"
	desc = "A locked box used to store medals of honor."
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/items/box_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/box_righthand.dmi'
		)
	icon_state = "medalbox+l"
	item_state = "medalbox"
	base_icon_state = "medalbox"

	can_hold = list(
		/obj/item/clothing/accessory/medal
	)

	max_storage_space = null
	storage_slots = 10
	req_access = list(access_captain)

	startswith = list(
	/obj/item/clothing/accessory/medal/bronze,
	/obj/item/clothing/accessory/medal/bronze/heart,
	/obj/item/clothing/accessory/medal/silver,
	/obj/item/clothing/accessory/medal/silver,
	/obj/item/clothing/accessory/medal/plasma,
	/obj/item/clothing/accessory/medal/gold
	)

/obj/item/storage/lockbox/medal/on_update_icon()
	. = ..()

	ClearOverlays()

	if(!contents || !being_inspected)
		return

	for(var/i in 1 to contents.len)
		var/obj/item/clothing/accessory/medal/M = contents[i]
		var/mutable_appearance/medalicon = mutable_appearance(initial(icon), M.medaltype)
		if(i > 1 && i <= 5)
			medalicon.pixel_x += ((i-1)*3)
		else if(i > 5)
			medalicon.pixel_y -= 7
			medalicon.pixel_x -= 2
			medalicon.pixel_x += ((i-6)*3)
		AddOverlays(medalicon)
