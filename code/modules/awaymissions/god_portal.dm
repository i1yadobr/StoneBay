GLOBAL_VAR(god_portal)

/obj/structure/god_portal
    name = "portal"
    desc = "A God bless portal."
    density = FALSE
    anchored = TRUE
    icon = 'icons/obj/objects.dmi'
    icon_state = "portal-off"
    turf_height_offset = 12

    var/active = FALSE
    var/power_on = FALSE
    var/list/dead_queue = list()

/obj/structure/god_portal/Destroy()
	GLOB.god_portal = null
	..()

/obj/structure/god_portal/Initialize()
    . = ..()

    if(GLOB.god_portal)
        var/obj/structure/god_portal/GP = GLOB.god_portal
        dead_queue += GP.dead_queue
        explosion(GP.loc, 0, 0, 1, 0)
        qdel(GP)
    GLOB.god_portal = src

    update_icon()
    for(var/mob/living/M in GLOB.player_list)
        register_signal(M, SIGNAL_MOB_DEATH, nameof(.proc/add_dead_queue))
    add_think_ctx("start_reborn", CALLBACK(src, nameof(.proc/start_reborn)))

/obj/structure/god_portal/proc/add_dead_queue(mob/dead_mob)
	if(power_on && !(dead_mob in dead_queue))
		dead_queue += dead_mob
		if(length(dead_queue) == 1)
			set_next_think_ctx("start_reborn", world.time + 2 SECONDS)

/obj/structure/god_portal/proc/start_reborn()
	if(!power_on)
		active = FALSE
	else if(length(dead_queue) > 0)
		if(!active)
			active = TRUE
			update_icon()
			var/mob/dead_mob = dead_queue[1]
			mob_reborn(dead_mob)

		set_next_think_ctx("start_reborn", world.time + 2 SECONDS)
	else
		active = FALSE
	update_icon()

/obj/structure/god_portal/attackby(obj/item/O, mob/user)
	. = ..()
	if(istype(O, /obj/item/card/id/god))
		power_on = !power_on
		start_reborn()

/obj/structure/god_portal/proc/mob_reborn(mob/M)
	if(M.status_flags & FAKEDEATH)
		dead_queue -= M
		return

	unregister_signal(M, SIGNAL_MOB_DEATH)

	if(isbrain(M))
		for(var/mob/living/carbon/human/H in dead_queue)
			if(M.real_name == H.real_name)
				transfer_mind(M, H)
				dead_queue -= M
				mob_reborn(H)
				return

		var/obj/item/organ/internal/cerebrum/brain/B = new /obj/item/organ/internal/cerebrum/brain(loc)
		B.brainmob = M
		var/obj/item/organ/internal/cerebrum/mmi/MM = new /obj/item/organ/internal/cerebrum/mmi(loc)
		B.loc = MM
		MM.locked = TRUE
		MM._add_brainmob(B)
		MM.update_name()
		MM.update_desc()
		MM.update_icon()
		var/mob/living/simple_animal/spiderbot/S = new /mob/living/simple_animal/spiderbot()
		S.forceMove(loc)
		S.mmi = MM
		S.transfer_personality(MM)
		MM.loc = S
		S.update_icon()

	if(ishuman(M))
		for(var/mob/living/carbon/brain/B in dead_queue)
			if(M.real_name == B.real_name)
				transfer_mind(B, M)
				dead_queue -= B
				return

		var/mob/living/carbon/human/H = M
		var/datum/absorbed_dna/newDNA = new(H.real_name, H.dna, H.species.name, H.languages, H.modifiers, H.flavor_texts)

		var/mob/living/carbon/human/HB = new H.type()
		HB.teleop = H
		HB.forceMove(loc)
		HB.dna = newDNA.dna
		HB.real_name = newDNA.name
		HB.flavor_text = ""

		var/newSpecies = newDNA.speciesName
		HB.modifiers = newDNA.modifiers
		HB.flavor_texts = newDNA.flavor_texts
		HB.update_underwear()
		HB.set_species(newSpecies, 1)
		HB.b_type = newDNA.dna.b_type
		HB.sync_organ_dna()
		HB.make_changeling()
		HB.UpdateAppearance()
		HB.set_nutrition(H.nutrition)
		for(var/obj/item/underwear/U in H.worn_underwear)
			var/obj/item/underwear/NU = new U.type()
			NU.name = U.name
			NU.gender = U.gender
			NU.icon_state = U.icon_state
			NU.color = U.color
			NU.ForceEquipUnderwear(HB)

		for(var/i = slot_first, i <= slot_last, i++)
			var/slot
			if(i == slot_w_uniform)
				slot = slot_first
			else if(i == slot_first)
				slot = slot_w_uniform
			else
				slot = i

			var/obj/item/I = H.get_equipped_item(slot)
			if(!isnull(I) && !istype(I, /obj/item/device/radio) && !istype(I, /obj/item/device/pda) && !istype(I, /obj/item/card/id))
				var/obj/item/NI = new I.type()
				if(I.is_bloodied)
					NI.add_blood()
				HB.equip_to_slot_or_del(NI, slot)

		if(!isnull(M.mind))
			HB.key = M.mind.key
			HB.handle_regular_hud_updates()
			M.mind = null
		HB.teleop = null
	dead_queue -= M
	active = FALSE


/obj/structure/god_portal/proc/transfer_mind(mob/M, mob/living/carbon/human/H)
	if(!isnull(M.mind))
		H.mind = M.mind
		M.mind = null

/obj/structure/god_portal/update_icon()
	..()
	if(!power_on)
		icon_state = "portal-off"
		set_light(0.5, 0.1, 1, 1, "#8aa7e5")
	else if(!active)
		icon_state = "portal-on"
		set_light(0.75, 0.3, 2, 2, "#a7a422")
	else
		icon_state = "portal-active"
		set_light(1, 0.5, 4, 2, "#fffd75")

/obj/structure/god_portal/active
    power_on = TRUE
