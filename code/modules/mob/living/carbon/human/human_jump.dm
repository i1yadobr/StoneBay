#define CHANCE_TO_HURT_LEGS 1
#define LONG_JUMP_DEFAUL_PROB 25
#define NO_HURT_JUMP_PROB 15
#define LITE_HURT_JUMP_PROB 65

/mob/living/carbon/human/MiddleClickOn(atom/A)
	. = ..()
	switch (mmb_intents)
		if (MMB_JUMP)
			INVOKE_ASYNC(src, nameof(.proc/jump), A)
			swap_hand()

/mob/living/carbon/human/throw_impact(atom/hit_atom, speed, target_zone)
	. = ..()
	if (hit_atom.density)

		//var/hurt_jump_chance = rand(1, 100)
		//if (hurt_jump_chance > 15)
		//Код прыгания в космонавтика
		//Код падения космонавтика в которого прыгнули

		if(prob(NO_HURT_JUMP_PROB))
			to_chat(src, SPAN_WARNING("You jumped into [hit_atom.name]. It's lucky you weren't hurt."))
			return

		if (prob(LITE_HURT_JUMP_PROB))
			Stun(2)
			adjustBruteLoss(10)
			to_chat(src, SPAN_WARNING("You jumped into [hit_atom.name]. It must have hurt."))
		else
			Weaken(5)
			adjustBruteLoss(10)
			to_chat(src, SPAN_WARNING("Jumping into the [hit_atom.name] knocked the wind out of you"))




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
	var/jump_distance = 3 // Максимальная длинна
	var/jump_turf = src.loc
	for (var/i = 0, i < jump_distance, i++)
		jump_turf = get_step(jump_turf, dir)

	if (!jump_turf || jump_turf == loc)
		return

	//damage_poise(body_build.poise_pool / 2)
	emote("jump")
	playsound(client, client.gender == MALE ? 'sound/effects/m_jump.ogg' : 'sound/effects/f_jump.ogg', 25, 0, 1)

	if (prob(50)) // добавить код проверки что нет брут или бёрн урона
		throw_spin = TRUE
		visible_message(SPAN_NOTICE("[src] did a somersault!."))

	else
		throw_spin = FALSE

	if (prob(LONG_JUMP_DEFAUL_PROB))
		throw_at(jump_turf, 3, 1, src)
		Stun(1)

	else
		throw_spin = FALSE
		throw_at(jump_turf, 2, 1, src)
		Stun(1)
	throw_spin = TRUE
	mmb_switch(MMB_JUMP)

#undef CHANCE_TO_HURT_LEGS
#undef LONG_JUMP_DEFAUL_PROB
