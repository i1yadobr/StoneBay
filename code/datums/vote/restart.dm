/datum/vote/restart
	name = "Restart"
	default_choices = list("Restart Round","Continue Playing")

/datum/vote/restart/can_be_initiated(mob/by_who, forced)
	. = ..()
	if(forced)
		return TRUE
	if(config.vote.allow_vote_restart || is_admin(by_who))
		return TRUE
	return FALSE

/datum/vote/restart/finalize_vote(winning_option)
	if(..())
		return 1
	if(winning_option == "Restart Round")
		SSvote.restart_world()
