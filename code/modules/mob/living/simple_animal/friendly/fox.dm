// Foxxy
/mob/living/simple_animal/fox
	name = "fox"
	desc = "They're a fox."
	icon_state = "fox"
	item_state = "fox"
	base_icon_state = "fox"
	icon_living = "fox"
	icon_dead = "fox_dead"
	holder_type = /obj/item/holder/fox
	speak = list("Ack-Ack", "Ack-Ack-Ack-Ackawoooo", "Geckers", "Awoo", "Tchoff")
	speak_emote = list("geckers", "barks")
	emote_hear = list("howls", "barks")
	emote_see = list("shakes their head", "shivers")
	attack_sound = 'sound/weapons/bite.ogg'
	speak_chance = 1
	turns_per_move = 5
	meat_type = /obj/item/reagent_containers/food/meat
	meat_amount = 3
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	see_in_dark = 5
	mob_size = MOB_SMALL
	health = 50
	maxHealth = 50
	holder_type = /obj/item/holder/fox
	bodyparts = /decl/simple_animal_bodyparts/quadruped
	// This is used for randomizing the appearance of animals. Setting it to TRUE will disable randomization and make all animals look the same.
	var/disable_variants = FALSE

/mob/living/simple_animal/fox/Initialize()
	. = ..()
	set_variant()

// This proc allows us to randomize the appearance of the foxes
/mob/living/simple_animal/fox/proc/set_variant()
	if(disable_variants || prob(80))
		return
	else
		base_icon_state = "fox_snow"
	icon_state = base_icon_state
	item_state = base_icon_state
	icon_living = base_icon_state
	icon_dead = "[base_icon_state]_dead"

// Captain fox
/mob/living/simple_animal/fox/renault
	name = "Renault"
	desc = "Renault, the Captain's trustworthy fox."
	gender = FEMALE

/mob/living/simple_animal/fox/snow
	name = "snow fox"
	desc = "A snow fox, with a thick white coat."
	icon_state = "fox_snow"
	item_state = "fox_snow"
	base_icon_state = "fox_snow"
	icon_living = "fox_snow"
	icon_dead = "fox_snow_dead"
	disable_variants = TRUE
