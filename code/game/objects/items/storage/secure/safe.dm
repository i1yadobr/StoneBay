/obj/item/storage/secure/safe
	name = "secure safe"
	icon_state = "safe"
	icon_opened = "safe0"
	emagged_overlay_icon_state = "safeb"
	emag_sparks_overlay_icon_state = "safespark"
	inspect_state = "safe-open"
	force = 0
	w_class = ITEM_SIZE_NO_CONTAINER
	max_w_class = ITEM_SIZE_HUGE
	max_storage_space = 56
	anchored = 1.0
	density = 0
	cant_hold = list(/obj/item/storage/secure/briefcase)

/obj/item/storage/secure/safe/Initialize()
	. = ..()
	new /obj/item/paper(src)
	new /obj/item/pen(src)

/obj/item/storage/secure/safe/attack_hand(mob/user)
	attack_self(user)
	return TRUE
