/datum/spell/targeted/sent_to_purgatory
	name = "Sent to purgatory"
	desc = "This spell immediately and permanently sent to purgatory."
	school = ""

	invocation_type = SPI_SHOUT

	level_max = list(SP_TOTAL = 0, SP_SPEED = 0, SP_POWER = 0)

	spell_flags = INCLUDEUSER | SELECTABLE
	range = 6
	max_targets = 1

	charge_max = 60
	cooldown_min = 60
	cooldown_reduc = 60

	compatible_mobs = list(/mob/living/carbon/human)

	icon_state = "onyx"

	cast_sound = 'sound/effects/squelch2.ogg'

/datum/spell/targeted/sent_to_purgatory/cast(list/targets, mob/user)
	for(var/mob/living/carbon/human/T in targets)
		T.Paralyse(5)

		for(var/i = slot_first, i <= slot_last, i++)
			var/obj/item/I = T.get_equipped_item(i)
			if(!isnull(I))
				qdel(I)
		T.equip_to_slot_or_del(new /obj/item/clothing/under/color/orange(), slot_w_uniform)
		T.equip_to_slot_or_del(new /obj/item/clothing/shoes/orange(), slot_shoes)
		T.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(), slot_r_store)
		T.equip_to_slot_or_del(new /obj/item/underwear/neck/cross/wood(), slot_l_store)

		T.forceMove(pick(GLOB.purgatorywarp))
