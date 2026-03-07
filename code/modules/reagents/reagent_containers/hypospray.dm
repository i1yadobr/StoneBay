////////////////////////////////////////////////////////////////////////////////
/// HYPOSPRAY
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/hypospray //obsolete, use hypospray/vial for the actual hypospray item
	name = "hypospray"
	desc = "The DeForest Medical Corporation, a subsidiary of Zeng-Hu Pharmaceuticals, \
			hypospray is a sterile, air-needle autoinjector for rapid administration of drugs to patients."
	icon = 'icons/obj/syringe.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_righthand.dmi'
		)
	item_state = "hypo"
	icon_state = "hypo"
	origin_tech = list(TECH_MATERIAL = 4, TECH_BIO = 5)
	amount_per_transfer_from_this = 5
	unacidable = 1
	volume = 30
	possible_transfer_amounts = null
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	slot_flags = SLOT_BELT

	drop_sound = SFX_DROP_GUN
	pickup_sound = SFX_PICKUP_GUN

	var/obj/item/reagent_containers/vessel/beaker/vial/loaded_vial = null

/obj/item/reagent_containers/hypospray/do_surgery(mob/living/carbon/M, mob/living/user)
	if(user.a_intent != I_HELP) //in case it is ever used as a surgery tool
		return ..()
	attack(M, user)
	return TRUE

/obj/item/reagent_containers/hypospray/attack(mob/living/M, mob/user)
	if(!reagents.total_volume)
		to_chat(user, SPAN("warning", "[src] is empty."))
		return
	if(!istype(M))
		return

	var/mob/living/carbon/human/H = M
	if(istype(H))
		var/obj/item/organ/external/affected = H.get_organ(user.zone_sel.selecting)
		if(!affected)
			to_chat(user, SPAN("danger", "\The [H] is missing that limb!"))
			return
		else if(BP_IS_ROBOTIC(affected))
			to_chat(user, SPAN("danger", "You cannot inject a robotic limb."))
			return

	user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	user.do_attack_animation(M)
	to_chat(user, SPAN("notice", "You inject [M] with [src]."))
	to_chat(M, SPAN("notice", "You feel a tiny prick!"))
	user.visible_message(SPAN("warning", "[user] injects [M] with [src]."))
	playsound(src, GET_SFX(SFX_HYPOSPRAY), 50, TRUE)

	if(M.reagents)
		var/contained = reagentlist()
		var/trans = reagents.trans_to_mob(M, amount_per_transfer_from_this, CHEM_BLOOD)
		admin_inject_log(user, M, src, contained, trans)
		to_chat(user, SPAN("notice", "[trans] ml injected. [reagents.total_volume] ml remaining in \the [src]."))

	return

// TODO: Spellcheck, replace "replacable" with "replaceable" in desc for all hyposprays
/obj/item/reagent_containers/hypospray/vial
	name = "hypospray"
	desc = "The DeForest Medical Corporation, a subsidiary of Zeng-Hu Pharmaceuticals, \
			hypospray is a sterile, air-needle autoinjector for rapid administration of drugs to patients. \
			Uses a replacable 50ml vial."
	volume = 0
	var/max_vial_volume = 50
	loaded_vial = /obj/item/reagent_containers/vessel/beaker/vial

/obj/item/reagent_containers/hypospray/vial/Initialize()
	. = ..()
	loaded_vial = new loaded_vial(src)
	volume = loaded_vial.volume
	reagents.maximum_volume = loaded_vial.reagents.maximum_volume

/obj/item/reagent_containers/hypospray/vial/attack_hand(mob/user)
	if(user.has_in_passive_hand(src))
		if(loaded_vial)
			reagents.trans_to_holder(loaded_vial.reagents,volume)
			reagents.maximum_volume = 0
			loaded_vial.update_icon()
			user.pick_or_drop(loaded_vial)
			to_chat(user, "You remove \The [loaded_vial] from \The [src].")
			loaded_vial = null
			update_icon()
			playsound(src, 'sound/weapons/flipblade.ogg', 50, 1)
			return
		..()
	else
		return ..()

/obj/item/reagent_containers/hypospray/vial/attackby(obj/item/W, mob/user)
	var/obj/item/reagent_containers/vessel/beaker/vial/used_vial = W
	if(istype(used_vial))
		if(!loaded_vial)
			if(used_vial.volume > max_vial_volume)
				to_chat(user, "\The [used_vial] doesn't fit into \The [src].")
				return
			if(!do_after(user, 10, src) || loaded_vial || !(used_vial in user))
				return FALSE
			if(!user.drop(used_vial, src))
				return
			if(used_vial.is_open_container())
				used_vial.atom_flags ^= ATOM_FLAG_OPEN_CONTAINER
				used_vial.update_icon()
			loaded_vial = used_vial
			reagents.maximum_volume = loaded_vial.reagents.maximum_volume
			loaded_vial.reagents.trans_to_holder(reagents,volume)
			user.visible_message(SPAN("notice", "[user] has loaded [loaded_vial] into \the [src]."), SPAN("notice", "You load \the [loaded_vial] into \the [src]."))
			update_icon()
			playsound(src, 'sound/weapons/empty.ogg', 50, 1)
		else
			to_chat(user, SPAN("notice", "\The [src] already has a vial."))
	else
		..()

/obj/item/reagent_containers/hypospray/vial/cmo
	desc = "The DeForest Medical Corporation, a subsidiary of Zeng-Hu Pharmaceuticals, \
			hypospray is a sterile, air-needle autoinjector for rapid administration of drugs to patients, \
			special designed for Chief Medical Officer. Uses a replacable 50ml vial."
	loaded_vial = /obj/item/reagent_containers/vessel/beaker/vial/tricordrazine

/obj/item/reagent_containers/hypospray/vial/combat
	name = "combat hypospray"
	desc = "The DeForest Medical Corporation, a subsidiary of Zeng-Hu Pharmaceuticals, \
			combat hypospray is a sterile, modified air-needle autoinjector for rapid administration of drugs to patients. \
			Uses a replacable 80ml reinforced vial."
	icon_state = "combat_hypo"
	item_state = "combat_hypo"
	possible_transfer_amounts = "5;10"
	max_vial_volume = 80
	loaded_vial = /obj/item/reagent_containers/vessel/beaker/vial/reinforced

/obj/item/reagent_containers/hypospray/vial/bluespace
	name = "bluespace hypospray"
	desc = "Experimental hypospray, powered by bluespace technology, \
			is a very sterile, modified air-needle autoinjector for rapid administration of drugs to patients. \
			Uses a replacable 500ml bluespace vial."
	icon_state = "bluespace_hypo"
	item_state = "bluespace_hypo"
	possible_transfer_amounts = "5;10;25;50;75;100"
	max_vial_volume = 500
	loaded_vial = /obj/item/reagent_containers/vessel/beaker/vial/bluespace

/obj/item/reagent_containers/hypospray/vial/bluespace/loaded
	loaded_vial = /obj/item/reagent_containers/vessel/beaker/vial/bluespace/adminordrazine

/obj/item/reagent_containers/hypospray/autoinjector
	name = "autoinjector"
	desc = "A rapid and safe way to administer small amounts of drugs by untrained or trained personnel."
	var/content_desc = "Inaprovaline 10ml. Use to stabilize an injured person."
	icon_state = "injector_blue"
	item_state = "injector_blue"
	amount_per_transfer_from_this = 10
	volume = 10
	origin_tech = list(TECH_MATERIAL = 2, TECH_BIO = 2)
	atom_flags = null
	startswith = list(/datum/reagent/inaprovaline)

/obj/item/reagent_containers/hypospray/autoinjector/Initialize()
	. = ..()
	update_icon()
	if(content_desc)
		desc += " The label reads, \"[content_desc]\"."
	return

/obj/item/reagent_containers/hypospray/autoinjector/attack(mob/M, mob/user)
	..()
	update_icon()
	return

/obj/item/reagent_containers/hypospray/autoinjector/on_update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
		item_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]-used"
		item_state = "[initial(item_state)]-used"
	update_held_icon()

/obj/item/reagent_containers/hypospray/autoinjector/examine(mob/user, infix)
	. = ..()

	if(reagents && reagents.reagent_list.len)
		. += SPAN_NOTICE("It is currently loaded.")
	else
		. += SPAN_NOTICE("It is spent.")

/obj/item/reagent_containers/hypospray/autoinjector/detox
	icon_state = "injector_green"
	item_state = "injector_green"
	content_desc = "Dylovene 10ml. Use in case of poisoning."
	startswith = list(/datum/reagent/dylovene)

/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine
	content_desc = "Tricordrazine 10ml. Use to speed up recovery from physical trauma."
	icon_state = "injector_lightpurple"
	item_state = "injector_lightpurple"
	startswith = list(/datum/reagent/tricordrazine)

/obj/item/reagent_containers/hypospray/autoinjector/pain
	content_desc = "Tramadol 10ml. Highly potent painkiller. Warning: Do Not Mix With Alcohol!"
	icon_state = "injector_purple"
	item_state = "injector_purple"
	startswith = list(/datum/reagent/painkiller/tramadol)

/obj/item/reagent_containers/hypospray/autoinjector/combatpain
	content_desc = "Metazine 5ml. Used for immediate and temporary pain relief."
	icon_state = "injector_black"
	item_state = "injector_black"
	amount_per_transfer_from_this = 5
	volume = 5
	startswith = list(/datum/reagent/painkiller)

/obj/item/reagent_containers/hypospray/autoinjector/mindbreaker
	icon_state = "injector_black"
	item_state = "injector_black"
	content_desc = ""
	amount_per_transfer_from_this = 5
	volume = 5
	startswith = list(/datum/reagent/mindbreaker)

/obj/item/reagent_containers/hypospray/autoinjector/antirad
	content_desc = "Hyronalin 10ml. Use in case of radiation poisoning."
	icon_state = "injector_orange"
	item_state = "injector_orange"
	startswith = list(/datum/reagent/hyronalin)

/obj/item/reagent_containers/hypospray/autoinjector/antirad/mine
	name = "Radfi-X"
	desc = "A rapid way to administer a mix of radiation-purging drugs by untrained personnel. Severe radiation poisoning may require multiple doses."
	content_desc = "#1 brand among uranium miners across the galaxy!"
	icon_state = "injector_mine"
	item_state = "injector_mine"
	startswith = list(
		/datum/reagent/hyronalin = 5,
		/datum/reagent/dylovene = 5)

/obj/item/reagent_containers/hypospray/autoinjector/dexalinp
	content_desc = "Dexalin plus 10ml. Used for hypoxia. Increases oxygenation to almost 85%!"
	icon_state = "injector_darkblue"
	item_state = "injector_darkblue"
	startswith = list(/datum/reagent/dexalinp)

/obj/item/reagent_containers/hypospray/autoinjector/bicaridine
	content_desc = "Bicaridine 10ml. Used to treat serious physical wounds."
	icon_state = "injector_red"
	item_state = "injector_red"
	startswith = list(/datum/reagent/bicaridine)

/obj/item/reagent_containers/hypospray/autoinjector/dermaline
	content_desc = "Dermaline 10ml. Used to treat burn wounds."
	icon_state = "injector_yellow"
	item_state = "injector_yellow"
	startswith = list(/datum/reagent/dermaline)
