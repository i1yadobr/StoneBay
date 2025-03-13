var/global/list/glob_slug_actions = list(/datum/action/cooldown/toggle/transform, /datum/action/thermal, /datum/action/cooldown/toggle/sting_paralize)
var/global/list/glob_worm_actions = list(/datum/action/thermal, /datum/action/cooldown/toggle/heal_slug, /datum/action/cooldown/toggle/pumping_out_blood, /datum/action/born_slug)

/mob/living/simple_animal/hostile/slug
	name = "slug"
	desc = "A slug. This looks disgusting."
	icon = 'icons/mob/animal.dmi'
	icon_state = "worm"
	icon_living = "worm"
	icon_dead = "worm_dead"
	var/icon_rest = "worm_rest"
	speak_emote = list("brays")
	mob_size = MOB_MEDIUM
	attack_sound = 'sound/weapons/bite.ogg'
	mouse_opacity = 1

	universal_speak = 1
	universal_understand = 1

	health = 120
	maxHealth = 120
	melee_damage_lower = 8
	melee_damage_upper = 16
	attacktext = "nibbles"
	bodyparts = /decl/simple_animal_bodyparts/worm

/mob/living/simple_animal/hostile/slug/Initialize()
	..()
	action_spells = glob_slug_actions

/mob/living/simple_animal/hostile/slug/New()
	..()
	verbs += /mob/living/proc/ventcrawl

/mob/living/simple_animal/hostile/slug/restrained()
	return 0

/mob/living/simple_animal/hostile/slug/worm
	name = "worm"
	desc = "A worm. This looks very disgusting."
	icon = 'icons/mob/phoron_worm.dmi'
	icon_state = "worm"
	icon_living = "worm"
	icon_dead = "worm_dead"

	health = 240
	maxHealth = 240
	melee_damage_lower = 16
	melee_damage_upper = 22

/mob/living/simple_animal/hostile/slug/worm/Initialize()
	. = ..()
	action_spells = glob_worm_actions
