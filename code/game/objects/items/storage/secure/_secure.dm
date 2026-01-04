/obj/item/storage/secure
	name = "secstorage"

	w_class = ITEM_SIZE_NORMAL
	max_w_class = ITEM_SIZE_SMALL
	max_storage_space = DEFAULT_BOX_STORAGE

	var/emagged_overlay_icon_state = "secureb"
	var/emag_sparks_overlay_icon_state = "securespark"
	var/icon_opened = "secure0"

	/// Holds lock overlay of this storage.
	var/image/lock_overlay

	locked = TRUE
	/// The number currently sitting in the briefcase's panel.
	var/numeric_input
	/// The code that will open this safe, set by usually players.
	/// Importantly, can be null if there's no password.
	var/lock_code

	var/lock_setshort = FALSE
	var/hacking = FALSE
	var/emagged = FALSE
	var/open = FALSE

/obj/item/storage/secure/Destroy()
	QDEL_NULL(lock_overlay)
	return ..()

/obj/item/storage/secure/on_update_icon()
	CutOverlays(lock_overlay)

	if(being_inspected && istext(inspect_state))
		icon_state = inspect_state
		return

	icon_state = base_icon_state ? base_icon_state : initial(icon_state)
	if(emagged)
		lock_overlay = image(icon, emagged_overlay_icon_state)
	else if(!locked)
		lock_overlay = image(icon, icon_opened)

	AddOverlays(lock_overlay)

/obj/item/storage/secure/examine(mob/user, infix)
	. = ..()
	. += "The service panel is [open ? "open" : "closed"]."

/obj/item/storage/secure/attackby(obj/item/W, mob/user)
	if(locked)
		if(istype(W, /obj/item/melee/energy))
			emag_act(INFINITY, user, W)
			return

		if(isScrewdriver(W))
			if(!do_after(user, 20, src))
				return

			if(QDELETED(src))
				return

			open = !open
			show_splash_text(user, "service panel [open ? "opened" : "closed"]", "You [open ? "open" : "close"] \the [src] service panel.")
			return

		if(isMultitool(W) && open && !hacking)
			show_splash_text(user, "resetting internal memory...", "You begin resetting \the [src] internal memory...")
			hacking = TRUE
			if(!do_after(usr, 100, src, ))
				return

			if(QDELETED(src))
				return

			if(prob(40))
				lock_setshort = TRUE
				show_splash_text(user, "internal memory reset!", SPAN("notice", "You reset \the [src] internal memory!"))
				sleep(80)
				lock_setshort = FALSE
				hacking = FALSE
				lock_code = null
			else
				show_splash_text(user, "unable to reset internal memory!", SPAN("warning", "You have failed to reset \the [src] internal memory!"))
				hacking = FALSE
				hacking = FALSE

			return
		return

	return ..()

/obj/item/storage/secure/attack_self(mob/user)
	tgui_interact(user)

/obj/item/storage/secure/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LockedSafe", name)
		ui.open()

/obj/item/storage/secure/tgui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return TRUE

	if(action != "keypad")
		return

	if(emagged || lock_setshort)
		return TRUE

	var/digit = params["digit"]
	switch(digit)
		if("C") // locking it back up
			if(locked || isnull(lock_code))
				numeric_input = ""
				return TRUE

			locked = TRUE
			numeric_input = ""
			close(usr)
			update_icon()
			return TRUE

		if("E") //inputting a new code if there isn't one set.
			if(!lock_code)
				if(length(numeric_input) != 5)
					return TRUE

				lock_code = numeric_input
				numeric_input = ""
				return TRUE

			//unlocking the current code.
			if(numeric_input != lock_code)
				numeric_input = ""
				return TRUE

			locked = FALSE
			open(usr)
			numeric_input = ""
			update_icon()
			return TRUE

		//putting digits in.
		if("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
			if(length(numeric_input) == 5)
				return TRUE

			numeric_input += digit
			return TRUE

/obj/item/storage/secure/tgui_data(mob/user)
	var/list/data = list(
		"input_code" = numeric_input || "*****",
		"locked" = locked,
		"lock_code" = !!lock_code,
		"emagged" = emagged,
		"lock_setshort" = lock_setshort
	)
	return data

/obj/item/storage/secure/emag_act(remaining_charges, mob/user, atom/emag_source)
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
	hack_effects()
	return TRUE

/obj/item/storage/secure/proc/hack_effects()
	var/datum/effect/effect/system/spark_spread/spark_system = new
	spark_system.set_up(5, 0, src)
	spark_system.start()
	playsound(loc, 'sound/weapons/blade1.ogg', 50, 1)
	playsound(loc, "spark", 50, 1)
	if(!emagged)
		emagged = TRUE
		AddOverlays(image(icon, emag_sparks_overlay_icon_state))
		sleep(6)
		locked = FALSE
		update_icon()
