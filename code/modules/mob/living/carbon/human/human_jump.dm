#define CHANCE_TO_HURT_LEGS = 1  //Procent to chance hurn leg

/mob/living/carbon/human/MiddleClickOn(atom/A)
	. = ..()
	switch (mmb_intents)
		if (MMB_JUMP)
			INVOKE_ASYNC(src, nameof(.proc/jump), A)

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

    if (A == src || A == loc ||	lying || buckled || pulledby || LAZYLEN(grabbed_by))
        to_chat(src, SPAN_WARNING(lying ? "You need to stand up!" : buckled ? "I need unbucked first" : "You're restrained!"))
        return

    if (poise < (poise_pool / 2))
        to_chat(src, SPAN_WARNING("Not enough balance!"))
        return

    setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
    face_atom(A)
	emote("jump")

    var/jump_turf = get_step(get_step(src, dir), dir)
    if (!jump_turf || jump_turf == loc)
        return

    damage_poise(body_build.poise_pool / 2)
    throw_spin = FALSE
    throw_at(jump_turf, 2, 2, src)
    throw_spin = TRUE
