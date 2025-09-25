// Include the lobby music tracks to automatically add them to the random selection.

GLOBAL_DATUM(lobby_music, /lobby_music)

/lobby_music
	var/artist
	var/title
	var/album
	var/license
	var/song
	var/url // Remember to include http:// or https://

/lobby_music/proc/play_to(client/listener)
	if(!song)
		return
	if(title)
		to_chat(listener, "<span class='good'>Now Playing:</span>")
		to_chat(listener, "<span class='good'>[url ? "<a href='[url]'>[title]</a>" : "[title]"][artist ? " by [artist]" : ""][album ? " ([album])" : ""]</span>")
	if(license)
		var/license_url = license_to_url[license]
		to_chat(listener, "<span class='good linkify'>License: [license_url ? "<a href='[license_url]'>[license]</a>" : license]</span>")
	var/pref_volume = listener.get_preference_value(/datum/client_preference/volume_lobby_music)
	var/volume_music = get_volume_from_pref(pref_volume)
	sound_to(listener, sound(song, repeat = 0, wait = 0, volume = volume_music, channel = 1))

/lobby_music/proc/get_volume_from_pref(pref_volume)
	switch(pref_volume)
		if(GLOB.PREF_LOW) return 30
		if(GLOB.PREF_MED) return 60
		if(GLOB.PREF_HIGH) return 90
	return 0

/lobby_music/asshole_in_space
	artist = "Peter Mulvey (cover by Toby Thorne & Suno)"
	title = "Asshole in Space"
	song = 'sound/music/asshole_in_space.ogg'

/lobby_music/businessend
	artist = "Cletus Got Shot"
	title = "Business End"
	song = 'sound/music/businessend.ogg'
	album = "Unamerican"
	license = CC_BY_NC_SA_3_0

/lobby_music/chasing_time
	artist = "Dexter Britain"
	title = "Chasing Time"
	album = "Creative Commons Vol. 1"
	song = 'sound/music/chasing_time.ogg'
	license = CC_BY_NC_SA_3_0
	url = "http://www.dexterbritain.co.uk"

/lobby_music/comet_haley
	artist = "Stellardrone"
	title = "Comet Halley"
	album = "Light Years"
	song = 'sound/music/comet_haley.ogg'
	license = CC_BY_3_0
	url = "http://freemusicarchive.org/music/Stellardrone/Light_Years_1227/07_Comet_Halley"

/lobby_music/fly_theme_12
	artist = "Gregory Semenov"
	title = "Fly Theme 12"
	song = 'sound/music/fly_theme_12.ogg'

/lobby_music/human
	artist = "Borrtex"
	title = "Human"
	album = "Creation"
	song = 'sound/music/human.ogg'
	license = CC_BY_NC_3_0
	url = "http://freemusicarchive.org/music/Borrtex/Creation/Borrtex_11_Human"

/lobby_music/issomebodysinging
	artist = "Chris Hadfield & BNL"
	title = "I.S.S. (Is Somebody Singing)"
	song = 'sound/music/IsSomebodySinging.ogg'

/lobby_music/lysendraa
	artist = "TALES"
	title = "Memories Of Lysendraa"
	album = "The Seskian Wars"
	song = 'sound/music/lysendraa.ogg'
	license = CC_BY_NC_ND_4_0
	url = "http://freemusicarchive.org/music/TALES/The_Seskian_Wars/8-Memories_Of_Lysendraa"

/lobby_music/marhaba
	artist = "Ian Alex Mac"
	title = "Marhaba"
	album = "Cues"
	song = 'sound/music/marhaba.ogg'
	license = CC_BY_3_0
	url = "http://freemusicarchive.org/music/Ian_Alex_Mac/Cues/Marhaba"

/lobby_music/imagination
	artist = "MY IMAGINATION"
	title = "Imagination"
	song = 'sound/music/imagination.ogg'

/lobby_music/torch
	artist = "L. Luke Leimer/LorenLuke"
	title = "Torch: A Light in the Darkness"
	song = 'sound/music/Torch.ogg'
	license = CC_BY_NC_SA_3_0
	url = "https://soundcloud.com/luke-leimer/torch-a-light-in-the-darkness"

/lobby_music/salutjohn
	artist = "Quimorucru"
	title = "Salut John"
	song = 'sound/music/salutjohn.ogg'
	album = "Un méchant party"
	license = CC_BY_NC_ND_4_0
	url = "http://freemusicarchive.org/music/Quimorucru/Un_mchant_party/Quimorucru_-_Un_mchant_party__Compilation__-_20_Salut_John"

/lobby_music/chess_slowed
	artist = "Karen Hinosyan"
	title = "Chess slowed"
	song = 'sound/music/chess_slowed.ogg'
	url = "https://youtu.be/TrVx4XiRrrM"

/lobby_music/villainous_behaviours
	artist = "SLACKCIRCUS"
	title = "Villainous Behaviours"
	song = 'sound/music/villainous_behaviours.ogg'
	url = "https://youtu.be/BOeE_Bxzw4I"

/lobby_music/the_settler
	artist = "Chris Remo"
	title = "The Settler"
	song = 'sound/music/the_settler.ogg'
	url = "https://music.youtube.com/watch?v=uDH0HLJH9UQ&si=ufk-YQ_8st8wljov"

/lobby_music/space_oddity
	artist = "David Matthews"
	title = "Space Oddity"
	song = 'sound/music/space_oddity.ogg'
	url = "https://music.youtube.com/watch?v=UYBHXRZOPuk&si=80SUNbosJlItec_0"

/lobby_music/get_around_town
	artist = "Revolver"
	title = "Get Around Town"
	song = 'sound/music/get_around_town.ogg'
	url = "https://youtu.be/1VQjr4bTDdA"

/lobby_music/space_shuttle
	artist = "Edipov Complex"
	title = "Space Shuttle"
	song = 'sound/music/space_shuttle.ogg'
	url = "https://music.youtube.com/watch?v=aOFjbkAHEGg&si=e34uXVI1qWAfJ9Nc"

/lobby_music/rainbow_kraut
	artist = "The John Steel Singers"
	title = "Rainbow Kraut"
	song = 'sound/music/astolfo_music_fan_made.ogg'
	url = "https://youtu.be/42iqg_UFORA"

/lobby_music/a_pledge
	artist = "Gesaffelstein"
	title = "A Pledge"
	song = 'sound/music/a_pledge.ogg'
	url = "https://music.youtube.com/watch?v=cjvkGjQjdIc&si=6AusSlBcKvRkJj_2"

/lobby_music/magicians_assistant
	artist = "Berry Weight"
	title = "Magician's assistant"
	song = 'sound/music/magicians_assistant.ogg'
	url = "https://music.youtube.com/watch?v=t621l-PgXak&si=G_g0Lw_aMpNCQIFB"

/lobby_music/cosmic_temperance
	artist = "Loop Hero"
	title = "Cosmic Temperance"
	song = 'sound/music/cosmic_temperance.ogg'
	url = "https://youtu.be/mvnxWqYzF1E"
