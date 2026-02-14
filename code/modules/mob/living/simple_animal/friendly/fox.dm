//Foxxy
/mob/living/simple_animal/fox
	name = "fox"
	desc = "They're a fox."
	icon_state = "fox"
	item_state = "fox"
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

//Captain fox
/mob/living/simple_animal/fox/renault
	name = "Renault"
	desc = "Renault, the Captain's trustworthy fox."
	gender = FEMALE
