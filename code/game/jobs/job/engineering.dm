/datum/job/chief_engineer
	title = "Chief Engineer"
	title_ru = "Главный инженер станции"
	head_position = 1
	department = "Engineering"
	department_ru = "Технический отдел"
	department_flag = ENG|COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#7f6e2c"
	req_admin_notify = 1
	economic_modifier = 10
	faction_restricted = TRUE
	ideal_character_age = 50
	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_player_age = 30
	minimum_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer

/datum/job/engineer
	title = "Station Engineer"
	department = "Engineering"
	title_ru = "Дежурный инженер"
	department_ru = "Технический отдел"
	department_flag = ENG

	total_positions = 8
	spawn_positions = 7
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	alt_titles = list("Ремонтник", "Слесарь-ремонтник", "Электромонтёр станции", "Инженер по жизнеобеспечению" = /decl/hierarchy/outfit/job/engineering/atmos)
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer
	hud_icon = "hudengineer"

/datum/job/atmos
	title = "Atmospheric Technician"
	department = "Engineering"
	title_ru = "Инженер по жизнеобеспечению"
	department_ru = "Технический отдел"
	department_flag = ENG

	total_positions = 0
	spawn_positions = 0
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	outfit_type = /decl/hierarchy/outfit/job/engineering/atmos
