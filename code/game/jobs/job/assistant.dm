/datum/job/assistant
	title = "Assistant"
	department = "Civilian"
	department_flag = CIV

	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#515151"
	economic_modifier = 1
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	alt_titles = list("Заключенный","Заключенный высокой лояльности","Заключенный низкой лояльности")
	outfit_type = /decl/hierarchy/outfit/job/assistant
	can_be_hired = FALSE
	latejoin_at_spawnpoints = TRUE

/datum/job/assistant/get_access()
	if(config.game.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()
