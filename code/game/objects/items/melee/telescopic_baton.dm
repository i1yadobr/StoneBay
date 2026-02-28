/obj/item/melee/telebaton
	name = "telescopic baton"
	desc = "A compact yet rebalanced personal defense weapon. Can be concealed when folded."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "telebaton"
	item_state = "telebaton"
	base_icon_state = "telebaton"
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_SMALL
	force = 3
	mod_weight = 0.5
	mod_reach = 0.5
	mod_handy = 1.0
	armor_penetration = 15
	var/active = FALSE

/obj/item/melee/telebaton/attack_self(mob/user)
	active = !active
	if(active)
		user.visible_message(SPAN("warning", "With a flick of their wrist, [user] extends their telescopic baton."),
		SPAN("warning", "You extend the baton."),
		"You hear an ominous click.")
		w_class = ITEM_SIZE_NORMAL
		force = 15 //quite robust
		mod_weight = 1.0
		mod_reach = 1.0
		mod_handy = 1.25
		attack_verb = list("smacked", "struck", "slapped")
	else
		user.visible_message(SPAN("notice", "\The [user] collapses their telescopic baton."),
		SPAN("notice", "You collapse the baton."),
		"You hear a click.")
		w_class = ITEM_SIZE_SMALL
		force = 3 //not so robust now
		mod_weight = 0.5
		mod_reach = 0.5
		mod_handy = 1.0
		attack_verb = list("hit", "punched")

	playsound(src, GET_SFX(SFX_USE_TELESCOPIC), 50, 1)
	add_fingerprint(user)
	update_icon()

/obj/item/melee/telebaton/on_update_icon()
	if(active)
		icon_state = "[base_icon_state]_on"
		item_state = "[base_icon_state]_on"
	else
		icon_state = base_icon_state
		item_state = base_icon_state
	update_held_icon()
	update_blood_overlay()

/obj/item/melee/telebaton/attack(mob/target, mob/living/user)
	if(active)
		if(is_pacifist(user))
			to_chat(user, SPAN("warning", "You can't you're pacifist!"))
			return

		if((MUTATION_CLUMSY in user.mutations) && prob(50))
			to_chat(user, SPAN("warning", "You club yourself over the head."))
			user.Weaken(3 * force)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.apply_damage(2 * force, BRUTE, BP_HEAD)
			else
				user.take_organ_damage(2 * force)
			return
		if(..())
			return
	else
		return ..()

// TODO: Implement different types of telescopic batons into the game
// Currently, these are admin items
/obj/item/melee/telebaton/bronze
	name = "bronze-capped telescopic baton"
	desc = "A compact yet rebalanced personal defense weapon. \
			Can be concealed when folded. This one is ranked BRONZE, and thus has mediocre penetrative power."
	icon_state = "telebaton_bronze"
	item_state = "telebaton_bronze"
	base_icon_state = "telebaton_bronze"
	armor_penetration = 20

/obj/item/melee/telebaton/silver
	name = "silver-capped telescopic baton"
	desc = "A compact yet rebalanced personal defense weapon. \
			Can be concealed when folded. This one is ranked SILVER, and thus has decent penetrative power."
	icon_state = "telebaton_silver"
	item_state = "telebaton_silver"
	base_icon_state = "telebaton_silver"
	armor_penetration = 25

/obj/item/melee/telebaton/gold
	name = "gold-capped telescopic baton"
	desc = "A compact yet rebalanced personal defense weapon. \
			Can be concealed when folded. This one is ranked GOLD, and thus has exceptional penetrative power."
	icon_state = "telebaton_gold"
	item_state = "telebaton_gold"
	base_icon_state = "telebaton_gold"
	armor_penetration = 30
