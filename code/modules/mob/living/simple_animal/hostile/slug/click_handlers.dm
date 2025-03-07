/datum/click_handler/action_on_mob
	handler_name = "Choice mob"
	var/datum/action/action

/datum/click_handler/action_on_mob/New()
	..()
	to_chat(user, SPAN("danger", "Select mob!"))

/datum/click_handler/action_on_mob/mob_check(mob/living/carbon/human/user)
	return TRUE

/datum/click_handler/action_on_mob/proc/set_action(datum/action/A)
	action = A

/datum/click_handler/action_on_mob/OnClick(atom/target)
	if (!isliving(target))
		return FALSE

	if(isnull(action))
		to_chat(user, "We cannot find it's action... call dev")
		return FALSE

	var/mob/living/M = user
	for (var/datum/action/A in M.actions)
		if (istype(A, action))
			action.Activate(target)
			return TRUE

	to_chat(user, "We cannot find it's power... call admins")
	return FALSE
