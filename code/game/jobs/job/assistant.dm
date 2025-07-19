/datum/job/assistant
	title = "Militia Member"
	department = "Civilian"
	department_flag = CIV

	total_positions = 4
	spawn_positions = 4
	supervisors = "Warden"
	selection_color = "#515151"
	economic_modifier = 1
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/assistant
	can_be_hired = FALSE
