#define CHANCE_TO_BROKE_LEGS = 1

/mob/living/carbon/human/MiddleClickOn(atom/A)
	switch(mmb_intents)
		if(MMB_JUMP)
			INVOKE_ASYNC(src, nameof(.proc/jump), A)

/mob/living/carbon/human/proc/mmb_switch(intent)
	if (mmb_intents == intent)
		mmb_intents = null
	else
		mmb_intents = intent

	if (intent)
		if (src.jump_icon?.icon_state == "act_jump0")
			src.jump_icon?.icon_state = "act_jump1"
		if (src.jump_icon?.icon_state == "act_jump1")
			src.jump_icon?.icon_state = "act_jump0"

/mob/living/carbon/human/proc/jump(atom/A)
    if (QDELETED(A) || QDELETED(src) || A.z != z)
        return

    if (A == src || A == loc || lying || pulledby || LAZYLEN(grabbed_by))
        to_chat(src, SPAN_WARNING(lying ? "You need to stand up!" : "You're restrained!"))
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
/*
/mob/living/carbon/human/MiddleClickOn(atom/A)
	. = ..()
	switch(mmb_intents)
		if (MMB_JUMP)
			INVOKE_ASYNC(src, nameof(.proc/jump), A)

/mob/living/carbon/human/proc/mmb_switch(intent)
	if (mmb_intents == intent)
		mmb_intents = null
	else
		mmb_intents = intent

	switch (intent)
		if (jump_icon?.icon_state == "act_jump1")
			jump_icon?.icon_state = "act_jump0"
		else
			jump_icon?.icon_state = "act_jump1"

/mob/living/carbon/human/proc/jump(atom/A)
	if(!A || QDELETED(A) || !A.loc)
		return

	if(A == src || A == src.loc)
		return

	if(lying)
		to_chat(src, SPAN_WARNING("I should stand up first."))
		return

	if(pulledby || LAZYLEN(grabbed_by))
		to_chat(src, SPAN_WARNING("I'm being grabbed!"))
		return

	if(poise <= poise_pool / 2)
		to_chat(src, SPAN_WARNING("I haven't regained my balance yet."))
		return

	if(A.z != z)
		return

	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	face_atom(A)
	emote("jump")
	throw_spin = FALSE
	var/jump_turf = get_step(get_step(src, dir), dir)

	damage_poise(body_build.poise_pool / 2)
	throw_at(jump_turf, 2, 2, src)
	throw_spin = TRUE
*/
