/obj/item/stack/nanopaste
	name = "nanopaste"
	singular_name = "nanite swarm"
	desc = "A tube of paste containing swarms of repair nanites. Very effective in repairing robotic machinery."
	icon = 'icons/obj/surgery.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_righthand.dmi'
		)
	icon_state = "nanopaste"
	item_state = null
	base_icon_state = "nanopaste"
	w_class = ITEM_SIZE_SMALL
	origin_tech = list(TECH_MATERIAL = 4, TECH_ENGINEERING = 3)
	amount = 10
	max_amount = 10

/obj/item/stack/nanopaste/proc/fix_robot(mob/living/silicon/robot/R, mob/user)
	if(R.getBruteLoss() || R.getFireLoss())
		R.adjustBruteLoss(-15)
		R.adjustFireLoss(-15)
		R.updatehealth()
		use(1)
		update_icon()
		user.visible_message(SPAN_NOTICE("\The [user] applied some [src] on [R]'s damaged areas."), SPAN_NOTICE("You apply some [src] at [R]'s damaged areas."))
	else
		to_chat(user, SPAN_NOTICE("All [R]'s systems are nominal."))

/obj/item/stack/nanopaste/on_update_icon()
	switch(amount)
		if(10 to INFINITY)
			icon_state = base_icon_state
		if(8 to 9)
			icon_state = "[base_icon_state]8"
		if(6 to 7)
			icon_state = "[base_icon_state]6"
		if(4 to 5)
			icon_state = "[base_icon_state]4"
		if(2 to 3)
			icon_state = "[base_icon_state]2"
		if(0 to 1)
			icon_state = "[base_icon_state]0"
	update_held_icon()

/obj/item/stack/nanopaste/attack(mob/living/M, mob/user)
	if (!istype(M) || !istype(user))
		return 0
	if (istype(M,/mob/living/silicon/robot))	//Repairing cyborgs
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		var/mob/living/silicon/robot/R = M
		if(user != R)
			fix_robot(R, user)
		else
			if(R.opened)
				fix_robot(R, user)
			else
				if(do_after(user, 10, R))
					fix_robot(R, user)

	if (istype(M,/mob/living/carbon/human))		//Repairing robolimbs
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/S = H.get_organ(user.zone_sel.selecting)

		if(!S)
			to_chat(user, SPAN("warning", "\The [M] is missing that body part."))

		if(S && BP_IS_ROBOTIC(S) && S.hatch_state == HATCH_OPENED)
			if(!S.get_damage())
				to_chat(user, SPAN("notice", "Nothing to fix here."))
			else if(can_use(1))
				user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
				S.heal_damage(15, 15, robo_repair = 1)
				H.updatehealth()
				use(1)
				update_icon()
				user.visible_message(SPAN("notice", "\The [user] applies some nanite paste on [user != M ? "[M]'s [S.name]" : "[S]"] with [src]."),\
				SPAN("notice", "You apply some nanite paste on [user == M ? "your" : "[M]'s"] [S.name]."))

/obj/item/stack/nanopaste/get_storage_cost()
	return base_storage_cost(w_class)
