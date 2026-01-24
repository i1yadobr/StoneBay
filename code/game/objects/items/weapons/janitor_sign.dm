/obj/item/caution
	name = "wet floor sign"
	desc = "Caution! Wet Floor!"
	icon = 'icons/obj/janitor.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/custodial_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
		)
	icon_state = "caution"
	force = 5.0
	throwforce = 3.0
	throw_range = 5
	w_class = ITEM_SIZE_SMALL
	mod_weight = 0.75
	mod_reach = 1.0
	mod_handy = 0.75
	attack_verb = list("warned", "cautioned", "smashed")

/obj/item/caution/cone
	name = "warning cone"
	desc = "This cone is trying to warn you of something!"
	icon_state = "cone"
	slot_flags = SLOT_HEAD
