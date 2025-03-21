//////////////////////Scrying orb//////////////////////

/obj/item/scrying
	name = "scrying orb"
	desc = "An incandescent orb of otherworldly energy, staring into it gives you vision beyond mortal means."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bluespace"
	throw_range = 7
	throwforce = 10
	damtype = BURN
	force = 10
	hitsound = 'sound/items/welder2.ogg'

/obj/item/scrying/proc/check_role(mob/user)
	if((user.mind && !GLOB.wizards.is_antagonist(user.mind)))
		to_chat(user, SPAN_WARNING("You stare into the orb and see nothing but your own reflection."))
		return FALSE
	return TRUE

/obj/item/scrying/attack_self(mob/user)
	if(!check_role(user))
		return

	to_chat(user, "<span class='info'>You can see... everything!</span>") // This never actually happens.
	visible_message("<span class='danger'>[user] stares into [src], their eyes glazing over.</span>")

	user.teleop = user.ghostize(1)
	announce_ghost_joinleave(user.teleop, 1, "You feel that they used a powerful artifact to [pick("invade","disturb","disrupt","infest","taint","spoil","blight")] this place with their presence.")
	return

/obj/item/scrying/not_wiz
	w_class = ITEM_SIZE_SMALL

/obj/item/scrying/not_wiz/check_role(mob/user)
	return TRUE

/////////////////////////Cursed Dice///////////////////////////
/obj/item/dice/d20/cursed
	desc = "A dice with twenty sides said to have an ill effect on those that are unlucky..."

/obj/item/dice/d20/cursed/attack_self(mob/living/user)
	..()
	if(icon_state == "[name][sides]")
		user.adjustBruteLoss(-30)
	else if(icon_state == "[name]1")
		user.adjustBruteLoss(30)

/////////////////////////Sphere of Creation///////////////////////////
/obj/item/sphere_of_creation
	name = "Sphere of Creation"
	desc = "Is a divine artifact capable of materializing any object in existence, bending reality to the wielder’s will."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "electrode-heavy"
	throw_range = 10
	throwforce = 10
	damtype = BURN
	force = 10
	hitsound = 'sound/items/welder2.ogg'
	w_class = ITEM_SIZE_SMALL
	var/create_object_html = null

var/global/list/allow_objs_sphere_of_creation = list()

/obj/item/sphere_of_creation/attack_self(mob/user)
	if (!create_object_html)
		var/objectjs = null
		objectjs = jointext(get_allow_obj(), ";")
		create_object_html = file2text('html/create_once_object.html')
		create_object_html = replacetext(create_object_html, "null /* object types */", "\"[objectjs]\"")

	show_browser(user, replacetext(create_object_html, "/* ref src */", "\ref[src]"), "window=create_object;size=425x450")

/obj/item/sphere_of_creation/proc/get_allow_obj()
	if(allow_objs_sphere_of_creation.len > 0)
		return allow_objs_sphere_of_creation

	for(var/TT in typesof(/obj))
		if(ispath(TT, /obj/item/gun/energy/pulse_rifle) || ispath(TT, /obj/effect) || ispath(TT, /obj/singularity) || ispath(TT, /obj/machinery/power/supermatter))
			continue
		if(ispath(TT, /obj/structure/god_portal) || ispath(TT, /obj/machinery/photocopier/faxmachine/god))
			continue

		allow_objs_sphere_of_creation |= TT

	return allow_objs_sphere_of_creation

/obj/item/sphere_of_creation/Topic(href, href_list, datum/topic_state/state)
	. = ..()
	if(href_list["object_list"])
		var/path
		if (istext(href_list["object_list"]))
			path = href_list["object_list"]
		else if (istype(href_list["object_list"], /list))
			path = href_list["object_list"][1]

		if(!path)
			alert("The path list you sent is empty")
			return

		var/atom/target = get_turf(src)
		if(target)
			var/obj/effect/sphere_of_creation/ES = new /obj/effect/sphere_of_creation(target)
			ES.create_obj = new path()
		else
			alert("Where are you!?")
			return

		log_and_message_admins("created [path]")
		qdel(src)
		return

/obj/effect/sphere_of_creation
	name = "Magical glowing runes"
	icon_state = "create_rune"
	mouse_opacity = FALSE
	var/obj/create_obj
	icon = 'icons/effects/effects.dmi'

/obj/effect/sphere_of_creation/Initialize()
	. = ..()
	set_next_think(world.time + 8 SECONDS)

/obj/effect/sphere_of_creation/think()
	create_obj.loc = get_turf(src)
	qdel(src)
