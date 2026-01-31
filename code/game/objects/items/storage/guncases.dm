/obj/item/storage/guncase
	name = "guncase"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
		)
	icon_state = "guncase"
	item_state = "guncase"
	force = 8
	throw_range = 4
	w_class = ITEM_SIZE_LARGE
	mod_weight = 1.4
	mod_reach = 0.7
	mod_handy = 1
	locked = TRUE
	max_w_class = ITEM_SIZE_NORMAL
	storage_slots = 7
	inspect_state = FALSE

	// icon_state of the overlay that will be drawn over the guncase when it's unlocked.
	// Green LED indicator by default.
	var/opened_overlay_icon_state = "guncase0"
	// icon_state of the overlay that will be temporarily drawn over the guncase when it's being hacked.
	// Sparking blinking LED indicator by default.
	var/emag_sparks_overlay_icon_state = "guncasespark"
	// icon_state of the overlay that will be drawn over the guncase when it's hacked. Takes precedence over other overlays.
	// Blinking red-green LED indicator by default.
	var/hacked_overlay_icon_state = "guncaseb"
	// Holds lock overlay of this storage.
	var/image/lock_overlay
	// Used to track if items were already spawned.
	// If not, items from the `selected_option` will be spawned upon unlocking.
	var/items_spawned = FALSE
	// Currently selected 'possible_guns' list or null if nothing was selected yet.
	var/selected_option = null
	// An associative list of possible guns. 'gun name' = 'gun description'
	var/list/possible_guns = list()
	// An associative list of gun - contents.
	var/list/gun_spawn = list()
	// If guncase was hacked and is no longer lockable, set by emag_act.
	var/hacked = FALSE

/obj/item/storage/guncase/Destroy()
	QDEL_NULL(lock_overlay)
	return ..()

// update_icon of the guncase cleans and re-applies the overlays of the LED indicator based on the current state.
/obj/item/storage/guncase/on_update_icon()
    ClearOverlays()

    lock_overlay = null

    if(hacked)
        lock_overlay = image(icon, hacked_overlay_icon_state)
    else if(!locked)
        lock_overlay = image(icon, opened_overlay_icon_state)

    AddOverlays(lock_overlay)

/obj/item/storage/guncase/examine(mob/user, infix)
	. = ..()
	if(hacked)
		. += "The lock system broken. It doesn't seem to be working anymore."
	else
		. += "The lock system [locked ? "" : "un"]locked."

/obj/item/storage/guncase/attack_self(mob/user)
	tgui_interact(user)

// attackby of the guncase handles locking and unlocking if W is an item that acts as an ID card,
// and hacking if W is a multitool or a melee energy weapon.
// If nothing of the above is the case, the call is delegated to the parent implementation for regular
// item-storage interactions.
/obj/item/storage/guncase/attackby(obj/item/W, mob/user)
	var/obj/item/card/id/ID = W.get_id_card()
	if(istype(ID))
		if(hacked)
			to_chat(user, SPAN("notice", "You swipe your card through the lock system of \the [src], but nothing happens."))
			return

		if(!allowed(user))
			show_splash_text(user, "access denied!", SPAN("warning", "\icon[src] Access Denied!"))
			return

		if(!selected_option)
			show_splash_text(user, "no gun selected!", SPAN("warning", "You must select a gun first!"))
			return

		if(!items_spawned)
			tgui_update()
			spawn_set(selected_option)
			for(var/obj/item/gun/energy/security/gun in contents)
				gun.owner = ID.registered_name

		show_splash_text(user, "[locked ? "un" : ""]locked", SPAN("notice", "You [locked ? "un" : ""]lock \the [src]."))
		locked = !locked
		update_icon()
		return

	else if(istype(W, /obj/item/device/multitool))
		multitool_hack(W, user)
		return

	else if(istype(W, /obj/item/melee/energy))
		var/obj/item/melee/energy/energy_weapon = W
		if(!energy_weapon.active)
			return ..() // act as a normal item
		show_splash_text(user, "unlocked", SPAN("notice", "You remove the cover and expose [src] bolts."))
		get_hacked()
		return

	else return ..()

// can_be_inserted override for guncases forbids re-insertion of "normal" or larger items.
// This is applied on top of the regular storage insertion restrictions. Guncases set `can_hold` based
// on the spawned items, which allows only small items from the spawned set to be reinserted.
// This prevents usage of guncases as unbalanced storage that holds a whole set while fitting in a backpack.
/obj/item/storage/guncase/can_be_inserted(obj/item/W, mob/user, feedback)
	var/res = ..()
	if(!res)
		return FALSE
	if(W.w_class >= ITEM_SIZE_NORMAL)
		to_chat(user, SPAN("warning", "The foam padding blocks won't align back into their original arrangement, \
		                               and \the bulky [W] won't fit back into the guncase, unfortunately."))
		return FALSE
	return TRUE

// emag_act of the guncase causes the guncase to get hacked, which unlocks it and, if item's haven't been
// spawned yet, spawns items from a random option from the `spawn_options` list.
// If guncase is already hacked or emag doesn't have charges, emag_act reports this to the user and returns.
/obj/item/storage/guncase/emag_act(remaining_charges, mob/user, emag_source)
	if(hacked || !remaining_charges)
		to_chat(user, SPAN("notice", "You swipe your [emag_source] through the lock system of \the [src], but nothing happens."))
		return FALSE
	get_hacked()
	return TRUE

// get_hacked unlocks the guncase, if item's haven't been spawned yet, spawns items from a random option from
// the `spawn_options` list, and triggers visual hacking effects and sounds.
/obj/item/storage/guncase/proc/get_hacked()
	if(!items_spawned)
		tgui_update()
		spawn_set(selected_option)
	locked = FALSE
	hacked = TRUE
	hack_effects()

// hack_effects proc displays overlays and plays sound effects indicating that the guncase is being hacked.
/obj/item/storage/guncase/proc/hack_effects()
	var/datum/effect/effect/system/spark_spread/spark_system = new
	spark_system.set_up(5, 0, src)
	spark_system.start()
	playsound(src, SFX_SPARK, 50, TRUE)
	AddOverlays(image(icon, emag_sparks_overlay_icon_state))
	spawn(0.6 SECOND)
		update_icon()

// multitool_hack starts a hacking interaction sequence for the user and triggers `get_hacked()` on success.
// The hacking sequence consists of 3-10 attempts to short circuit the lock system, 12 seconds each.
// Each attempt is a simple `do_after()` call that displays a progress bar to the user, followed by a progress
// feedback message.
/obj/item/storage/guncase/proc/multitool_hack(obj/item/device/multitool/tool, mob/user)
	if(!istype(tool))
		CRASH("multitool_hack() of the [src] called with wrong tool: expected /obj/item/device/multitool, got [tool.type] ([tool])")
	if(hacked)
		to_chat(user, SPAN("warning", "You check the wiring of \the [src] and find the ID system already fried!"))
		return
	if(tool.in_use)
		to_chat(user, SPAN("warning", "This multitool is already in use!"))
		return
	tool.in_use = TRUE
	// Rolling twice in favor of the player to keep things fun and fast, no need to keep them waiting too long.
	var/required_attempts = min(rand(3, 10), rand(3, 10))
	for(var/i in 1 to required_attempts)
		user.visible_message(SPAN("warning", "[user] picks in the wires of \the [src] with a multitool."),
		                     SPAN("warning", "Attempting to short circuit the ID system... ([i])"))
		// 12 seconds per attempt gives us 2 minutes in the worst case scenario,
		// matching the amount of time it takes to break out of handcuffs.
		if(!do_after(user, 12 SECONDS))
			to_chat(user, SPAN("warning", "You stop manipulating the ID system of \the [src] and it resets itself into a working state!"))
			tool.in_use = FALSE
			return
		if(i == 5 && required_attempts > 5)
			// Some additional text midway through the attempts so users know the system is working as intended
			// and they just had bad luck.
			to_chat(user, SPAN("warning", "Your attempts to crash the ID system caused a failsafe ciruit to activate. \
			                               This will take some additional time to bypass."))
	get_hacked()
	tool.in_use = FALSE
	user.visible_message(SPAN("warning", "[user] short ciruits ID system of \the [src] with a multitool."),
	                     SPAN("warning", "You short circuit the ID system of \the [src]."))

/obj/item/storage/guncase/proc/spawn_set(set_name)
	if(items_spawned)
		return

	if(!length(gun_spawn[set_name]))
		return

	for(var/path in gun_spawn[set_name])
		new path (src)

	items_spawned = TRUE

/obj/item/storage/guncase/open(mob/user)
	tgui_update()
	return ..()

/obj/item/storage/guncase/close(mob/user)
	tgui_update()
	return ..()

/obj/item/storage/guncase/tgui_data(mob/user)
	var/list/data = list(
		"chosenGun" = selected_option,
		"items_spawned" = items_spawned,
		"possibleGuns",
	)

	for(var/gun_name in possible_guns)
		var/list/gun_data = list(
			"gunName" = gun_name,
			"gunDesc" = possible_guns[gun_name]
		)
		data["possibleGuns"] += list(gun_data)

	if(!isnull(selected_option))
		data["chosenGunDesc"] = possible_guns[selected_option]

	data += ..()

	return data

/obj/item/storage/guncase/tgui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return TRUE

	if(action != "chooseGun")
		return

	switch(action)
		if("chooseGun")
			selected_option = params["gunName"]
			return TRUE

/obj/item/storage/guncase/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Guncase", name)
		ui.open()

/obj/item/storage/guncase/security
	name = "security hardcase"
	desc = "A robust hardcase painted in the NT Security colors. \
	        Equipped with an ID-based locking system to ensure that only authorized personnel can access the contents."
	icon_state = "guncasesec"
	item_state = "guncasesec"
	selected_option = "Pistol"

	possible_guns = list(
		"Pistol" = "A taser pistol. The smallest of all the tasers. It only has a single fire mode, but each shot wields power. Comes with a baton, a handheld barrier, a couple of handcuffs, and a pair of donuts.",
		"SMG" = "A taser SMG. This model is not as powerful as pistols, but is capable of launching electrodes left and right with its remarkable rate of fire. Comes with a baton, a handheld barrier, a couple of handcuffs, and a pair of donuts.",
		"Rifle" = "A taser rifle. Bulky and heavy, it must be wielded with both hands. Although its rate of fire is way below average, it is capable of shooting stun beams. Comes with a baton, a handheld barrier, a couple of handcuffs, and a pair of donuts.",
		"Classic" = "A rusty-and-trusty taser. It's overall worse than the modern baseline tasers, but it still does its job. Useful for those who want to assert their robust dominance. Or, maybe, for old farts. Comes with a baton, a couple of handcuffs, a pair of donuts, and a drink to stay cool."
	)

	gun_spawn = list(
		"Pistol" = list(
			/obj/item/gun/energy/security/pistol,
			/obj/item/shield/barrier
		),
		"SMG" = list(
			/obj/item/gun/energy/security/smg,
			/obj/item/shield/barrier
		),
		"Rifle" = list(
			/obj/item/gun/energy/security/rifle,
			/obj/item/shield/barrier
		),
		"Classic" = list(
			/obj/item/gun/energy/classictaser
		)
	)

	req_access = list(access_security)

/obj/item/storage/guncase/security/spawn_set(set_name)
	new /obj/item/melee/baton/loaded(src)
	new /obj/item/handcuffs(src)
	new /obj/item/handcuffs(src)
	new /obj/item/reagent_containers/food/donut/normal(src)
	new /obj/item/reagent_containers/food/donut/normal(src)

	if(set_name == "Classic")
		if(prob(70))
			new /obj/item/reagent_containers/vessel/bottle/small/darkbeer(src)
		else
			new /obj/item/reagent_containers/vessel/bottle/whiskey(src)

	..()

/obj/item/storage/guncase/security/hos
	name = "high command security hardcase"
	desc = "A heavy-duty container with an ID-based locking system. This one is painted in NT High Command Security colors."
	icon_state = "guncasehos"
	item_state = "guncasehos"

	opened_overlay_icon_state = "guncaseheavy0"
	emag_sparks_overlay_icon_state = "guncaseheavyspark"
	hacked_overlay_icon_state = "guncaseheavyb"

	selected_option = "Razor"

	possible_guns = list(
		"Razor" = "Hephaestus Industries G50SE \"Razor\", a cheaper version of G50XS \"Raijin\". It has lethal and stun settings.",
		"Lawgiver" = "The Lawgiver II. A twenty-five round sidearm with mission-variable voice-programmed ammunition. You must use the words STUN, LASER, RAPID, FLASH and AP to change modes."
	)

	gun_spawn = list(
		"Lawgiver" = list(
			/obj/item/gun/projectile/lawgiver,
			/obj/item/ammo_magazine/lawgiver
		),
		"Razor" = list(
			/obj/item/gun/energy/rifle/cheap
		)
	)

	req_access = list(access_hos)

/obj/item/storage/guncase/security/hos/spawn_set(set_name)
	if(set_name != "Lawgiver") // Delete lawgiver steal contract, we can't get lawgiver legally.
		GLOB.contracts_steal_items.Remove("the head of security's lawgiver gun")
		for(var/datum/antag_contract/item/steal/C in GLOB.all_contracts)
			if(C.target_type == /obj/item/gun/projectile/lawgiver)
				C.remove()

	..()

/obj/item/storage/guncase/warden
	name = "warden's hardcase"
	desc = "A heavy-duty security case reserved for handguns, painted in NT Security colors. \
	      It is specially designed for those responsible for the armory and brig, \
	      highlighted by distinctive silver accents."
	icon_state = "guncasewarden"
	item_state = "guncasewarden"
	selected_option = "Energy Gun"

	possible_guns = list(
		"Energy Gun" = "A basic energy-based gun with two settings: Stun and kill.",
		"VP78" = "The VP78 pistol is a common and reliable sidearm, used by security forces and colonial marshalls all over the world. This one has a sweet wooden grip, among other modifications. Uses .45 rounds."
	)

	gun_spawn = list(
		"Energy Gun" = list(
			/obj/item/gun/energy/egun,
			/obj/item/handcuffs,
			/obj/item/handcuffs,
			/obj/item/storage/box/donut
		),
		"VP78" = list(
			/obj/item/gun/projectile/pistol/vp78/wood,
			/obj/item/ammo_magazine/c45m/stun,
			/obj/item/ammo_magazine/c45m/stun,
			/obj/item/ammo_magazine/c45m/flash
		)
	)

	req_access = list(access_armory)

/obj/item/storage/guncase/warden/spawn_set(set_name)
	new /obj/item/storage/box/donut(src)
	new /obj/item/shield/barrier(src)
	new /obj/item/melee/baton/loaded(src)

	..()

/obj/item/storage/guncase/wardenheavy
	name = "warden's heavy weapons hardcase"
	desc = "A large, durable hardcase designed for heavy weaponry. \
        This one is specifically for the warden's use, as denoted by the distinctive silver accents."
	icon_state = "guncaseheavywarden"
	item_state = "guncaseheavywarden"

	opened_overlay_icon_state = "guncaseheavy0"
	emag_sparks_overlay_icon_state = "guncaseheavyspark"
	hacked_overlay_icon_state = "guncaseheavyb"

	selected_option = "Non-lethal combo"

	possible_guns = list(
		"Non-lethal combo" = "A combination of a stun rifle and the pepperspray's big brother, the CrowdBuster kit. \
	        Let officers handle the dirty part, your job is to stop an odd permabrig escapee. \
	        Unfortunately, pepperspray refills are not included. \
	        NOTE: By selecting the Non-lethal combo™, you agree to NanoTrasen's \"Non-lethal\" liability waiver.",
		"Shotgun" = "A reliable pump-action shotgun, perfect for those moments when subtlety is optional. \
	        Comes with supplementary ammunition: two boxes of (relatively) non-lethal beanbags, \
	        two boxes of slightly-more-lethal shells, and a box of heavy-duty slugs, just in case. \
	        Limited time offer: select Shotgun set™ now and get your very own bandolier! \
	        Only 1 package left! Offer expires in 2 minutes!"
	)

	gun_spawn = list(
		"Non-lethal combo" = list(
			/obj/item/gun/energy/stunrevolver/rifle,
			/obj/item/backwear/reagent/pepper
		),
		"Shotgun" = list(
		/obj/item/gun/projectile/shotgun/pump,
		/obj/item/storage/box/shotgun/beanbags = 2,
		/obj/item/storage/box/shotgun/shells = 2,
		/obj/item/storage/box/shotgun/slugs,
		/obj/item/clothing/accessory/storage/bandolier
		)
	)

/obj/item/storage/guncase/detective
	name = "detective's gun case"
	desc = "An elegantly crafted gun case with a vintage wooden finish and brass-colored locks, \
	     featuring an ID-based locking system. Combines classic style with modern access control."
	icon_state = "guncasedet"
	item_state = "guncasedet"
	selected_option = "M1911"

	possible_guns = list(
		"M1911" = "A cheap Martian knock-off of a Colt M1911. Uses .45 rounds. Extremely popular among space detectives nowadays. Comes with two .45 seven round magazines and two .45 rubber seven round magazines.",
		"S&W Legacy" = "A cheap Martian knock-off of a Smith & Wesson Model 10. Uses .38-Special rounds. Used to be NanoTrasen's service weapon for detectives. Comes with two .38 six round speedloaders and two .38 rubber six round speedloaders.",
		"S&W 620" = "A cheap Martian knock-off of a Smith & Wesson Model 620. Uses .38-Special rounds. Quite popular among professionals.Comes with two .38 six round speedloaders and two .38 rubber six round speedloaders.",
		"M2019" = "Quite a controversial weapon. Combining both pros and cons of revolvers and railguns, it's extremely versatile, yet requires a lot of care. Comes with three .38 SPEC five round speedloaders, two .38 CHEM five round speedloaders, and two replaceable power cells.",
		"T9 Patrol" = "A relatively cheap and reliable knock-off of a Beretta M9. Uses 9mm rounds. Used to be a standart-issue gun in almost every security company. Comes with three ten round 9mm magazines and two 9mm flash ten round magazines."
	)

	gun_spawn = list(
		"M1911" = list(
			/obj/item/gun/projectile/pistol/colt/detective,
			/obj/item/ammo_magazine/c45m/rubber,
			/obj/item/ammo_magazine/c45m/rubber,
			/obj/item/ammo_magazine/c45m/stun,
			/obj/item/ammo_magazine/c45m/stun,
			/obj/item/ammo_magazine/c45m,
			/obj/item/ammo_magazine/c45m
		),
		"S&W Legacy" = list(
			/obj/item/gun/projectile/revolver/detective,
			/obj/item/ammo_magazine/c38/rubber,
			/obj/item/ammo_magazine/c38/rubber,
			/obj/item/ammo_magazine/c38,
			/obj/item/ammo_magazine/c38
		),
		"S&W 620" = list(
			/obj/item/gun/projectile/revolver/detective/saw620,
			/obj/item/ammo_magazine/c38/rubber,
			/obj/item/ammo_magazine/c38/rubber,
			/obj/item/ammo_magazine/c38,
			/obj/item/ammo_magazine/c38
		),
		"M2019" = list(
			/obj/item/gun/projectile/revolver/m2019/detective,
			/obj/item/ammo_magazine/c38/spec,
			/obj/item/ammo_magazine/c38/spec,
			/obj/item/ammo_magazine/c38/spec,
			/obj/item/ammo_magazine/c38/chem,
			/obj/item/ammo_magazine/c38/chem,
			/obj/item/cell/device/high
		),
		"T9 Patrol" = list(
			/obj/item/gun/projectile/pistol/det_m9,
			/obj/item/ammo_magazine/mc9mm,
			/obj/item/ammo_magazine/mc9mm,
			/obj/item/ammo_magazine/mc9mm,
			/obj/item/ammo_magazine/mc9mm/flash,
			/obj/item/ammo_magazine/mc9mm/flash
		)
	)

	req_access = list(access_forensics_lockers)
