#define NO_HURT_JUMP_PROB 15
#define HURT_JUMP_PROB 70
#define KNOCK_DOWN_PROB 35

#define LONG_JUMP_PROB 25
#define MAX_JUMP_LENGTH 3
#define DEFAULT_JUMP_LENGTH 2
#define JUMP_KNOCKOUT_PROB 100

#define SALTO_PROB 10

/mob/living/carbon/human/MiddleClickOn(atom/A)
	. = ..()
	switch (mmb_intents)
		if (MMB_JUMP)
			INVOKE_ASYNC(src, nameof(.proc/jump), A)
			swap_hand() //A crutch solution so that hands don't change during a jump

/mob/living/carbon/human/throw_impact(atom/hit_atom, speed, target_zone)
	. = ..()
	var/jump_in_spaceman = FALSE
	if (hit_atom.density)
		if(ishuman(hit_atom))
			jump_in_spaceman = TRUE
			var/mob/living/carbon/human/jump_target_human = hit_atom

			playsound(src, SFX_FIGHTING_PUNCH, 25, 0, 1)
			do_attack_animation(jump_target_human)

			if (prob(JUMP_KNOCKOUT_PROB))
				jump_target_human.apply_damage(10, BRUTE)
				jump_target_human.Weaken(2)
				visible_message(SPAN_NOTICE("[src] was knokout [hit_atom.name] in jump!."))

			else
				jump_target_human.apply_damage(5, BRUTE)
				jump_target_human.Stun(1)

		if(prob(NO_HURT_JUMP_PROB) && jump_in_spaceman == FALSE)
			to_chat(src, SPAN_WARNING("You jumped into [hit_atom.name]. It's lucky you weren't hurt."))
			return

		if (prob(HURT_JUMP_PROB))
			Weaken(5)
			adjustBruteLoss(20)
			to_chat(src, SPAN_WARNING("Jumping into the [hit_atom.name] knocked the wind out of you"))

		else
			Stun(3)
			adjustBruteLoss(10)
			to_chat(src, SPAN_WARNING("You jumped into [hit_atom.name]. It must have hurt."))

/mob/living/carbon/human/proc/mmb_switch(intent)
	if (mmb_intents == intent)
		mmb_intents = null
	else
		mmb_intents = intent

	switch(intent)
		if (MMB_JUMP)
			if (jump_icon?.icon_state == "act_jump0")
				jump_icon?.icon_state = "act_jump1"
			else
				jump_icon?.icon_state = "act_jump0"

/mob/living/carbon/human/proc/jump(atom/A)
	if (QDELETED(A) || QDELETED(src) || A.z != z)
		return

	if (A == src || A == loc ||	lying || pulledby || LAZYLEN(grabbed_by))
		to_chat(src, SPAN_WARNING("You can'jump right now"))
		return

	if (buckled)
		to_chat(src, SPAN_WARNING("You need unbucked first"))
		return

	if (poise < (poise_pool / 2))
		to_chat(src, SPAN_WARNING("Not enough balance!"))
		return

	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	face_atom(A)
	var/jump_distance = MAX_JUMP_LENGTH
	var/jump_turf = src.loc
	for (var/i = 0, i < jump_distance, i++)
		jump_turf = get_step(jump_turf, dir)

	if (!jump_turf || jump_turf == loc)
		return

	playsound(src, src.gender == MALE ? 'sound/effects/m_jump.ogg' : 'sound/effects/f_jump.ogg', 25, 0, 1)
	visible_message(SPAN_NOTICE("[src] jump to [A]."))

	throw_spin = FALSE

	if (prob(SALTO_PROB)) // добавить код проверки что нет брут или бёрн урона
		throw_spin = TRUE
		visible_message(SPAN_NOTICE("[src] did a somersault!."))

	else
		throw_spin = FALSE

	if (prob(LONG_JUMP_PROB))
		throw_at(jump_turf, MAX_JUMP_LENGTH, 1, src)
		Stun(1)

	else
		throw_at(jump_turf, DEFAULT_JUMP_LENGTH, 1, src)
		Stun(1)

	throw_spin = TRUE
	mmb_switch(MMB_JUMP)

#undef NO_HURT_JUMP_PROB
#undef LITE_HURT_JUMP_PROB
#undef KNOCK_DOWN_PROB
#undef LONG_JUMP_PROB
#undef MAX_JUMP_LENGTH
#undef DEFAULT_JUMP_LENGTH
#undef SALTO_PROB
