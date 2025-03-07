/datum/action/cooldown/toggle
	action_type = AB_INNATE
	check_flags = AB_CHECK_STUNNED | AB_CHECK_LYING
	cooldown_time = 5 SECONDS
	text_cooldown = FALSE
	click_to_activate = TRUE
	click_handler = /datum/click_handler/action_on_mob

/datum/action/cooldown/toggle/Deactivate()
	..()
	owner.PopClickHandler()
	button.UpdateIcon()
	active = FALSE

/datum/action/cooldown/toggle/Trigger(trigger_flags, atom/target)
	if(active)
		Deactivate()
		return

	if(owner.click_handlers && owner.click_handlers.Top())
		var/datum/click_handler/action_on_mob/topCH = owner.click_handlers.Top()
		if(!isnull(topCH) && topCH.type == click_handler)
			owner.RemoveClickHandler(topCH)
			topCH.action.button.UpdateIcon()
			if(topCH.action == src)
				return

	. = ..()
	var/datum/click_handler/action_on_mob/CH = owner.GetClickHandler()
	if(. && !isnull(CH))
		CH.set_action(src)
		var/image/img = image(button_icon,button,"bg_active")
		img.pixel_x = 0
		img.pixel_y = 0
		button.AddOverlays(img)

/datum/action/cooldown/toggle/Activate(mob/living/target)
	..()
	active = TRUE

/datum/action/cooldown/toggle/transform
	name = "False form"
	button_icon_state = "false_form"
	var/datum/icon_snapshot/original_snap

/datum/action/cooldown/toggle/transform/Grant(mob/M)
	..()
	if(original_snap == null)
		original_snap = copy_snap(owner)
	register_signal(owner, TAKING_DAMAGE, nameof(.proc/on_owner_damaged))

/datum/action/cooldown/toggle/transform/proc/on_owner_damaged()
	if(prob(30) && active)
		Deactivate()

/datum/action/cooldown/toggle/transform/Deactivate()
	..()
	button_icon_state = "false_form"
	button.UpdateIcon()
	set_snap(original_snap)
	StartCooldown()

/datum/action/cooldown/toggle/transform/Activate(mob/living/target)
	..()
	button_icon_state = "true_form"
	button.UpdateIcon()
	var/datum/icon_snapshot/target_snap = copy_snap(target)
	set_snap(target_snap)

/datum/action/cooldown/toggle/transform/proc/copy_snap(mob/living/target)
	var/mob/living/H = target
	var/datum/icon_snapshot/entry = new
	entry.real_name = H.real_name
	entry.name = H.name
	entry.icon = H.icon
	entry.examine = H.examine(H)
	entry.icon_state = H.icon_state
	entry.overlays = H.overlays.Copy()
	entry.faction = H.faction
	return entry

/datum/action/cooldown/toggle/transform/proc/set_snap(datum/icon_snapshot/snap)
	var/mob/living/H = owner
	if(H.name != snap.name)
		playsound(get_turf(H), 'sound/effects/blob/blobweld.ogg', 50, 1)
		anim(get_turf(H), H, 'icons/mob/modifier_effects.dmi',, "pink_sparkles",, H.dir)
		H.real_name = snap.real_name
		H.name = snap.name
		H.icon = snap.icon
		H.icon_state = snap.icon_state
		H.faction = snap.faction
		var/examine = snap.examine
		if(islist(examine))
			H.desc = examine[1]
		else
			H.desc = examine
		H.overlays.Cut()
		H.overlays = snap.overlays.Copy()
		H.update_inv_l_hand()
		H.update_inv_r_hand()


/datum/action/cooldown/toggle/sting_paralize
	name = "Sting paralize"
	button_icon_state = "sting_paralize"
	cooldown_time = 7 SECONDS

/datum/action/cooldown/toggle/sting_paralize/Activate(mob/living/target)
	..()
	Deactivate()
	if (!ishuman(target))
		to_chat(owner, SPAN_WARNING("My poison won't work on this!"))
		return

	if (get_dist(target, owner) > 1)
		to_chat(owner, SPAN_WARNING("You need to be closer to your goal!"))
		return

	var/mob/living/carbon/human/H = target
	to_chat(H, SPAN_WARNING("Your muscles begin to painfully tighten."))
	H.Weaken(4)
	H.Stun(3)
	button.UpdateIcon()
	StartCooldown()

/datum/action/cooldown/toggle/heal_slug
	name = "Healing slug"
	button_icon_state = "heal_minor"
	cooldown_time = 25 SECONDS

/datum/action/cooldown/toggle/heal_slug/Activate(mob/living/target)
	..()
	Deactivate()
	var/mob/living/simple_animal/hostile/slug/S = target
	if(isnull(S))
		to_chat(owner, SPAN_WARNING("This doesn't look like a slug."))
		return

	if(!in_range(S, owner))
		to_chat(owner, SPAN_WARNING("That was not so bright of you."))
		return

	if(S.health >= S.maxHealth)
		to_chat(owner, SPAN_WARNING("Looks like there's no help here."))
		return

	if(do_after(owner, 5 SECONDS, S))
		to_chat(S, SPAN_INFO("I feel a surge of strength."))
		to_chat(owner, SPAN_INFO("That's all I can do for now."))
		playsound(owner, 'sound/effects/squelch2.ogg', 50, 1)
		anim(get_turf(S), S, 'icons/mob/modifier_effects.dmi',, "pink_sparkles",, S.dir)
		S.health = min(S.health + 30, S.maxHealth)
		StartCooldown()

/datum/action/cooldown/toggle/pumping_out_blood
	name = "Pumping out blood"
	button_icon_state = "blood_pump"
	cooldown_time = 120 SECONDS

/datum/action/cooldown/toggle/pumping_out_blood/Activate(mob/living/target)
	..()
	Deactivate()
	if (!ishuman(target) || target.is_ic_dead())
		to_chat(owner, SPAN_WARNING("I need living human blood!"))
		return

	if(!in_range(target, owner))
		to_chat(owner, SPAN_WARNING("That was not so bright of you."))
		return

	var/mob/living/carbon/human/H = target
	if(!H.vessel.get_reagent_amount(/datum/reagent/blood))
		to_chat(owner, SPAN_WARNING("[H] has no more blood left to give."))
		return

	if(do_after(owner, 4 SECONDS, H))
		StartCooldown()
		if(!H.stunned)
			H.Stun(9)
			H.Weaken(9)
			to_chat(H, SPAN_WARNING("Your muscles begin to painfully tighten."))
		to_chat(H, SPAN_WARNING(FONT_LARGE("You feel like you are plunging into a nightmare, from which horror is even frozen on your face.")))
		playsound(owner, 'sound/effects/squelch2.ogg', 50, 1)
		if(do_after(owner, 10 SECONDS, H))
			anim(get_turf(H), H, 'icons/mob/modifier_effects.dmi',, "pink_sparkles",, H.dir)
			playsound(owner.loc, 'sound/effects/drain_blood.ogg', 50, 1)
			H.vessel.remove_reagent(/datum/reagent/blood, 60)
			to_chat(owner, SPAN_INFO("The blood was quite filling."))
			var/datum/action/born_slug/T = locate(/datum/action/born_slug) in owner.actions
			if(T)
				T.add_charge()

/datum/action/born_slug
	name = "Born slug"
	button_icon_state = "ling_division"
	action_type = AB_INNATE
	check_flags = AB_CHECK_STUNNED | AB_CHECK_LYING
	var/charge_max = 3
	var/charge_counter = 1

/datum/action/born_slug/IsAvailable()
	. = ..()
	if(.)
		return charge_counter > 0

/datum/action/born_slug/proc/add_charge()
	charge_counter = min(charge_counter + 1, charge_max)

/datum/action/born_slug/Trigger()
	if(IsAvailable())
		charge_counter--
		to_chat(owner, SPAN_INFO("Welcome to the world, child."))
		var/mob/living/simple_animal/hostile/slug/S = new /mob/living/simple_animal/hostile/slug(owner.loc)
		notify_ghosts("A new slug has been born!", null, source = S, action = NOTIFY_POSSES, posses_mob = TRUE)
	button.UpdateIcon()

/datum/action/thermal
	name = "Thermal"
	button_icon_state = "vamp_darksight_off"
	action_type = AB_INNATE

/datum/action/thermal/Trigger()
	. = ..()
	if(.)
		active = !active
		button.UpdateIcon()

/datum/action/thermal/Activate()
	button_icon_state = "vamp_darksight_on"
	owner.seeThermal = TRUE

/datum/action/thermal/Deactivate()
	button_icon_state = "vamp_darksight_off"
	owner.seeThermal = FALSE
