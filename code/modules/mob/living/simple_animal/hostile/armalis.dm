/mob/living/simple_animal/hostile/armalis
	name = "Vox Armalis"
	desc = "In truth, this scares you."

	icon = 'icons/mob/armalis.dmi'
	icon_state = "armalis_naked"
	icon_living = "armalis_naked"
	icon_dead = "armalis_naked_dead"

	health = 225
	maxHealth = 225
	resistance = 5

	response_help   = "pats"
	response_disarm = "pushes"
	response_harm   = "hits"

	attacktext = "reaped"
	attack_sound = 'sound/effects/bamf.ogg'
	melee_damage_lower = 15
	melee_damage_upper = 20
	can_escape = 1

	min_gas = null
	max_gas = null

	speed = 2

	a_intent = I_HURT

	pixel_x = -5


/mob/living/simple_animal/hostile/armalis/armored
	icon_state = "armalis_armored"
	icon_living = "armalis_armored"
	icon_dead = "armalis_armored_dead"

	health = 275
	maxHealth = 275
	resistance = 8
	speed = 3

/mob/living/simple_animal/hostile/abomination
	name = "Abomination"
	desc = "A twisted mass of human limbs, writhing in agony. Its face is contorted in pain, with wriggling appendages squirming beneath it. Something about it feels profoundly wrong."
	icon_state = "abomination"
	icon_dead = "abomination_dead"
	icon = 'icons/mob/animal.dmi'
	vision_range = 6
	move_to_delay = 3
	ranged = 1
	retreat_distance = 2
	minimum_distance = 4
	projectiletype = /obj/item/projectile/bullet/needle
	ranged_message = "spits out the needle"
	attack_sound = 'sound/weapons/bite.ogg'
	death_sound = 'sound/voice/abomination/abomination_dead.ogg'
	vision_range = 7
	aggro_vision_range = 5
	idle_vision_range = 6

/mob/living/simple_animal/hostile/lesser_ling
	name = "lesser ling"
	desc = "A small creature with long hairy stings on its back and the same paws under its belly. Somewhat reminiscent of a spider and a yard dog."
	icon_state = "lesser_ling"
	icon_dead = "lesser_ling_dead"
	icon_gib = "syndicate_gib"
	attack_sound = 'sound/weapons/bite.ogg'
	death_sound = 'sound/voice/lesser_ling/lesser_ling_dead.ogg'
	maxHealth = 45
	health = 45
	move_to_delay = 2
	bodyparts = /decl/simple_animal_bodyparts/spider
	harm_intent_damage = 15
	melee_damage_lower = 6
	melee_damage_upper = 8
	vision_range = 7
	aggro_vision_range = 7
	idle_vision_range = 7

/mob/living/simple_animal/hostile/lesser_ling/Life()
	. = ..()
	if(. && prob(20))
		playsound(loc, pick('sound/voice/lesser_ling/lesser_ling_life1.ogg', 'sound/voice/lesser_ling/lesser_ling_life2.ogg'), 80, 1)
