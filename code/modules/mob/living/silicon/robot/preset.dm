/mob/living/silicon/robot/syndicate
	lawupdate = 0
	scrambledcodes = 1
	icon_state = "securityrobot"
	bubble_icon = "syndibot"
	modtype = "Security"
	lawchannel = "State"
	laws = /datum/ai_laws/syndicate_override
	idcard = /obj/item/card/id/syndicate
	module = /obj/item/robot_module/syndicate
	silicon_radio = /obj/item/device/radio/borg/syndicate
	spawn_sound = 'sound/mecha/nominalsyndi.ogg'
	cell = /obj/item/cell/super
	pitch_toggle = 0

/mob/living/silicon/robot/combat
	lawupdate = 0
	scrambledcodes = 1
	modtype = "Combat"
	module = /obj/item/robot_module/security/combat
	spawn_sound = 'sound/mecha/nominalsyndi.ogg'
	cell = /obj/item/cell/super
	pitch_toggle = 0

/mob/living/silicon/robot/combat/on_update_icon()
	. = ..()
	var/datum/robot_hull/using_hull = module_hulls[icontype]
	var/obj/item/borg/combat/mobility/speed_module = module_active
	if(speed_module?.active)
		icon_state = "[using_hull.icon_state]-roll"
	else
		icon_state = "[using_hull.icon_state]"

/mob/living/silicon/robot/combat/nt
	laws = /datum/ai_laws/nanotrasen_aggressive
	idcard = /obj/item/card/id/centcom/ERT
	silicon_radio = /obj/item/device/radio/borg/ert
