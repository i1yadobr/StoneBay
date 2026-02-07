// A collection of pre-set uplinks
/obj/item/device/radio/uplink
	icon_state = "radio-uplink"
	item_state = "radio-uplink"

// Radio-like uplink; not an actual radio though
/obj/item/device/radio/uplink/Initialize(mapload, owner, amount)
	. = ..()
	AddComponent(/datum/component/uplink, owner, FALSE, FALSE, null, amount)

/obj/item/device/radio/uplink/interact(mob/user)
	if(!user)
		return FALSE

	var/datum/component/uplink/uplink = get_component(/datum/component/uplink)
	if(!istype(uplink))
		return
	if(isnull(uplink.owner))
		uplink.owner = user.mind

	uplink.interact(user)

/obj/item/device/radio/uplink/debug
	name = "Debug Uplink"

/obj/item/device/radio/uplink/debug/Initialize(mapload, mob/owner, amount = DEBUG_TELECRYSTAL_AMOUNT)
	. = ..()
	var/datum/component/uplink/uplink = get_component(/datum/component/uplink)
	uplink.name = "debug uplink"
