//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "Wiki"
	set desc = "Visit the wiki."
	set hidden = 1
	if( config.link.wiki )
		send_link(src, config.link.wiki)
	else
		to_chat(src, SPAN("warning", "The wiki URL is not set in the server configuration."))
	return

/client/verb/discord()
	set name = "Discord"
	set desc = "Visit the community Discord."
	set hidden = 1
	if( config.link.discord )
		send_link(src, config.link.discord)
	else
		to_chat(src, SPAN("warning", "The Discord URL is not set in the server configuration."))
	return

/client/verb/github()
	set name = "Github"
	set desc = "Visit Github repository of the server."
	set hidden = 1
	if( config.link.github )
		send_link(src, config.link.github)
	else
		to_chat(src, SPAN("warning", "The Github URL is not set in the server configuration."))
	return
