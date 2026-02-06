/obj/item/modular_computer/laptop
	name = "laptop computer"
	desc = "A portable computer."
	icon = 'icons/obj/modular_laptop.dmi'
	icon_state = "laptop-open"
	item_state = "laptop"
	base_icon_state = "laptop"
	icon_state_screensaver = "standby"
	w_class = ITEM_SIZE_NORMAL
	anchored = TRUE
	hardware_flag = PROGRAM_LAPTOP
	base_idle_power_usage = 25 WATTS
	base_active_power_usage = 200 WATTS
	max_hardware_size = 2
	light_strength = 3
	max_damage = 200
	broken_damage = 100

/obj/item/modular_computer/laptop/AltClick(mob/user)
// Prevents carrying of open laptops inhand.
// While they work inhand, i feel it'd make tablets lose some of their high-mobility advantage they have over laptops now.
	if(!CanPhysicallyInteract(user))
		return
	if(!istype(loc, /turf/))
		to_chat(usr, "\The [src] has to be on a stable surface first!")
		return
	anchored = !anchored
	screen_on = anchored
	update_icon()

/obj/item/modular_computer/laptop/on_update_icon()
	if(anchored)
		icon_state = "[base_icon_state]-open"
		..()
	else
		set_light(0)
		ClearOverlays()
		icon_state = "[base_icon_state]-closed"

/obj/item/modular_computer/laptop/preset
	anchored = FALSE

/obj/item/modular_computer/laptop/CouldUseTopic(mob/user)
	..()
	if(istype(user, /mob/living/carbon))
		playsound(src, SFX_KEYBOARD, 50, 1)
