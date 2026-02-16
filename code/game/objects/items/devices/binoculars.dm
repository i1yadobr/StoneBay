//TODO: Refactor binoculars
//In this form it feels crooked, for example:
//If you turn away from the side where the scaling is going, the scaling will continue to work

/obj/item/device/binoculars

	name = "binoculars"
	desc = "A pair of binoculars."
	zoomdevicename = "eyepieces"
	icon_state = "binoculars"
	item_state = "binoculars"
	base_icon_state = "binoculars"

	obj_flags = OBJ_FLAG_CONDUCTIBLE
	force = 5.0
	mod_weight = 0.6
	mod_reach = 0.5
	mod_handy = 0.85
	w_class = ITEM_SIZE_SMALL
	throwforce = 5.0
	throw_range = 15

/obj/item/device/binoculars/attack_self(mob/user)
	zoom_use(user)

/obj/item/device/binoculars/proc/zoom_use(mob/user)
	if(zoom)
		item_state = base_icon_state
		unzoom(user)
	else
		item_state = "[base_icon_state]_wielded"
		zoom(user)
	update_held_icon()
