/mob/living/simple_animal/rock
	name = "rock"
	real_name = "rock"
	desc = "It's a rock."
	icon_state = "onyx"
	icon = 'icons/mob/mob.dmi'
	turns_per_move = 10
	response_harm = "kicks"
	response_disarm = "kicks"
	response_help = "kicks"
	mob_size = MOB_MEDIUM
	status_flags = list(GODMODE)
	a_intent = I_HURT
	var/turf/target_turf
	var/list/events = list(
        "start_walk_to_start" = 10,
        "start_run_down" = 10,
        "start_orange_fire" = 10,
		"start_create_flash" = 10
    )
	var/def_chance_move = 10
	var/chance_move

/mob/living/simple_animal/rock/attack_hand(mob/user)
	. = ..()
	attack_throw_rock(user)

/mob/living/simple_animal/rock/attackby(obj/item/O, mob/user)
	..()
	attack_throw_rock(user)

/mob/living/simple_animal/rock/proc/attack_throw_rock(mob/user)
    var/turf/target_turf = get_step_away(src, user)
    if (target_turf)
        src.throw_at(target_turf, 1)
        chance_move = min(100, chance_move + 2)


/mob/living/simple_animal/rock/Bumped(AM)
	. = ..()
	chance_move = min(100, chance_move + 1)

/mob/living/simple_animal/rock/New()
	..()
	target_turf = get_turf(src)
	chance_move = def_chance_move

	add_think_ctx("create_orange_fire", CALLBACK(src, nameof(.proc/create_orange_fire)), 0)
	add_think_ctx("life_rock", CALLBACK(src, nameof(.proc/life_rock)), 0)
	add_think_ctx("run_down", CALLBACK(src, nameof(.proc/run_down)), 0)
	add_think_ctx("create_flash", CALLBACK(src, nameof(.proc/create_flash)), 0)
	add_think_ctx("gib_finish", CALLBACK(src, nameof(.proc/gib_finish)), 0)
	set_next_think_ctx("life_rock", world.time + 2 SECONDS)

/mob/living/simple_animal/rock/Life()

/mob/living/simple_animal/rock/proc/life_rock()
	set_next_think_ctx("life_rock", world.time + 2 SECONDS)
	var/area/A = get_area(src)
	if(istype(A, /area/sisyphe/start))
		return

	if(istype(A, /area/sisyphe/finish))
		animate_shiver()
		set_next_think_ctx("life_rock", world.time + 10 SECONDS)
		set_next_think_ctx("gib_finish", world.time + 4 SECONDS)
		return

	if(!isnull(pulledby))
		run_down(pulledby)
		pulledby.stop_pulling()
		start_walk_to_start(3)

	for(var/event in events)
		if(prob(events[event]))
			call(src, event)()
			events[event] = max(events[event] - 50, 0)
			break
		else
			events[event] = min(100, events[event] + 0.08)

	if(prob(chance_move))
		start_walk_to_start(round(rand(chance_move/def_chance_move, 2 * chance_move/def_chance_move)))
	else
		chance_move = min(100, chance_move + 0.5)


/mob/living/simple_animal/rock/proc/start_walk_to_start(count = 1)
    for (var/i = 1, i <= count, i++)
        var/context_name = "walk_to_start_[i]"
        if(!_think_ctxs[context_name])
            add_think_ctx(context_name, CALLBACK(src, nameof(.proc/walk_to_start)), 0)
        set_next_think_ctx(context_name, world.time + 5 * i)
        chance_move = max(0, chance_move - 5)

/mob/living/simple_animal/rock/proc/walk_to_start()
	if(isnull(target_turf))
		target_turf = get_turf(src)
	else
		step_to(src, target_turf)

/mob/living/simple_animal/rock/proc/animate_shiver()
	animate(src, pixel_x = src.pixel_x + 1, time = 0.1 SECONDS)
	for(var/i in 1 to (2 SECONDS))
		animate(pixel_x = src.pixel_x - 1, time = 0.1 SECONDS)
		animate(pixel_x = src.pixel_x + 1, time = 0.1 SECONDS)
	animate(pixel_x = src.pixel_x - 1, time = 0.1 SECONDS)

/mob/living/simple_animal/rock/proc/start_run_down(mob/M)
	animate_shiver()
	set_next_think_ctx("run_down", world.time + 2 SECONDS, M)

/mob/living/simple_animal/rock/proc/run_down(mob/M = find_mob())
	if(isnull(M))
		return

	var/mob/living/ML = M
	if(!isnull(ML))
		ML.take_overall_damage(30)
		ML.weakened = ML.weakened + 3
	var/turf/TV = get_turf(M)
	loc = TV
	playsound(get_turf(TV), SFX_FALL_DAMAGE, 75)

/mob/living/simple_animal/rock/proc/find_mob()
	for(var/mob/living/carbon/human/M in view(src, 2))
		return M

	return null

/mob/living/simple_animal/rock/proc/start_orange_fire()
	animate_shiver()
	set_next_think_ctx("create_orange_fire", world.time + 2 SECONDS)

/mob/living/simple_animal/rock/proc/create_orange_fire()
	for(var/turf/T in orange(1, src))
		new /obj/flamer_fire(T)

/mob/living/simple_animal/rock/proc/start_create_flash()
	playsound(src.loc, 'sound/weapons/flash.ogg', 50, 1)
	set_next_think_ctx("create_flash", world.time + 2 SECONDS)

/mob/living/simple_animal/rock/proc/create_flash()
	for(var/mob/living/carbon/human/M in view(src, 2))
		if(M.stat != DEAD)
			var/safety = M.eyecheck()
			if(safety < FLASH_PROTECTION_MODERATE)
				var/flash_strength = round(M.species.flash_mod * 4)
				if(flash_strength > 0)
					playsound(src.loc, 'sound/weapons/flash.ogg', 100, 1)
					M.flash_eyes(FLASH_PROTECTION_MODERATE - safety)
					M.Stun(flash_strength / 2)
					M.eye_blurry += flash_strength
					M.confused += (flash_strength + 2)
					if(flash_strength > 3)
						M.drop_l_hand()
						M.drop_r_hand()
					if(flash_strength > 5)
						M.Weaken(2)

/mob/living/simple_animal/rock/proc/gib_finish()
	for(var/mob/living/carbon/human/M in view(src, 7))
		if(M.stat != DEAD)
			M.gib()
	new /mob/living/simple_animal/rock(target_turf)
	gib(src)
