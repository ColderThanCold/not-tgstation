GLOBAL_DATUM_INIT(typing_indicator, /mutable_appearance, mutable_appearance('icons/mob/talk.dmi', "default0", -TYPING_LAYER))

/mob/proc/create_typing_indicator()
	return

/mob/proc/remove_typing_indicator()
	return

/mob/set_stat(new_stat)
	. = ..()
	if(.)
		remove_typing_indicator()

/mob/Logout()
	remove_typing_indicator()
	. = ..()

////Wrappers////
//Keybindings were updated to change to use these wrappers. If you ever remove this file, revert those keybind changes
/mob/verb/say_wrapper()
	set name = ".Say"
	set hidden = 1
    set instant = 1

	create_typing_indicator()
	var/message = input("","say (text)") as text|null
	remove_typing_indicator()
	if(message)
		say_verb(message)

/mob/verb/me_wrapper()
	set name = ".Me"
	set hidden = 1
    set instant = 1

	create_typing_indicator()
	var/message = input("","me (text)") as text|null
	remove_typing_indicator()
	if(message)
		me_verb(message)

///Human Typing Indicators///
/mob/living/create_typing_indicator()
	if(!typing_indicator && stat == CONSCIOUS) //Prevents sticky overlays and typing while in any state besides conscious
		add_overlay(GLOB.typing_indicator)
		typing_indicator = TRUE

/mob/living/remove_typing_indicator()
	if(typing_indicator)
		cut_overlay(GLOB.typing_indicator)
		typing_indicator = FALSE
