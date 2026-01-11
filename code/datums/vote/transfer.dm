/datum/vote/transfer
	name = "Initiate Crew Transfer"
	override_question = "End the shift?"

/datum/vote/transfer/can_be_initiated(mob/by_who, forced)
	. = ..()
	if(GAME_STATE <= RUNLEVEL_SETUP)
		return FALSE
	if(evacuation_controller?.state != EVAC_IDLE)
		return FALSE
	if(forced)
		return TRUE
	if(config.vote.allow_vote_restart || is_admin(by_who))
		return TRUE
	return FALSE

/datum/vote/transfer/New()
	default_choices = list("Initiate Crew Transfer", "Extend the Round ([config.vote.autotransfer_interval / 600] minutes)")
	..()

/datum/vote/transfer/finalize_vote(winning_option)
	if(..())
		return 1
	if(winning_option == "Initiate Crew Transfer")
		init_autotransfer()
