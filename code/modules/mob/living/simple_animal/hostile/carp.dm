

/mob/living/simple_animal/hostile/carp
	name = "space carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish."
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp_dead"
	icon_gib = "carp_gib"
	speak_chance = 0
	turns_per_move = 5
	meat_type = /obj/item/reagent_containers/food/carpmeat
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	speed = 4
	maxHealth = 25
	health = 25

	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "bitten"
	attack_sound = 'sound/weapons/bite.ogg'
	bodyparts = /decl/simple_animal_bodyparts/fish

	//Space carp aren't affected by atmos.
	min_gas = null
	max_gas = null
	minbodytemp = 0

	break_stuff_probability = 15

	faction = "carp"

/mob/living/simple_animal/hostile/carp/Allow_Spacemove(check_drift = 0)
	return 1	//No drifting in space for space carp!	//original comments do not steal

/mob/living/simple_animal/hostile/carp/find_target()
	. = ..()
	if(.)
		visible_emote("nashes at [.].")

/mob/living/simple_animal/hostile/carp/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		if(prob(15))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\The [src] knocks down \the [L]!</span>")

/mob/living/simple_animal/hostile/carp/holographic
	icon_state = "carp"
	icon = 'icons/mob/hologram.dmi'

	alpha = 127

	icon_living = "carp"

	meat_amount = 0
	meat_type = null

	faction = "neutral"

/mob/living/simple_animal/hostile/carp/holographic/Initialize()
	. = ..()
	set_light(0.5, 0.1, 2)

/mob/living/simple_animal/hostile/carp/holographic/gib(anim, do_gibs)
	death()

/mob/living/simple_animal/hostile/carp/holographic/death()
	..(null, "fades away!", "You have been destroyed.")
	qdel(src)

/mob/living/simple_animal/hostile/carp/dweller
	icon_state = "dweller_alert"
	icon_dead = "dweller_dead"
	icon = 'icons/mob/animal.dmi'
	move_to_delay = 4
	projectiletype = /obj/item/projectile/energy/neurotoxin/shockzard
	projectilesound = 'sound/weapons/pierce.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 4
	ranged_message = "emits energy"
	ranged_cooldown_cap = 20
	maxHealth = 75
	health = 75
	harm_intent_damage = 5
	melee_damage_lower = 12
	melee_damage_upper = 12
	attacktext = "bites into"
	a_intent = "harm"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	bodyparts = /decl/simple_animal_bodyparts/quadruped
	vision_range = 6
	ranged_cooldown_cap = 6
	aggro_vision_range = 6
	idle_vision_range = 6
	var/loot = /obj/item/stack/telecrystal/time_bluespace_crystal

/mob/living/simple_animal/hostile/carp/dweller/death(gibbed, deathmessage, show_dead_message)
	. = ..()
	if(.)
		new loot(loc)

/mob/living/simple_animal/hostile/carp/alt
	icon_state = "carp_alt"
	icon_living = "carp_alt"
	icon_dead = "carp_alt_dead"
	icon_gib = "carp_alt_gib"
	maxHealth = 45
	health = 45

/mob/living/simple_animal/hostile/carp/shark
	name = "space shark"
	desc = "Too healthy for an ordinary space carp. Be careful with your teeth."
	icon_state = "shark"
	icon_living = "shark"
	icon_dead = "shark_dead"
	icon_gib = "shark_gib"
	maxHealth = 75
	health = 75
	move_to_delay = 2
	harm_intent_damage = 8
	melee_damage_lower = 12
	melee_damage_upper = 18
