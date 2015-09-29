-- Notes MacroScript File
--
-- Created:  		Dec 1 2000
-- Last Updated: 	Dec 20 2000
--
-- Author :   Frederick Ruff
/*
Version:  3ds max 6

 
This script adds Popup Notes to scene files.
***********************************************************************************************
 MODIFY THIS AT YOUR OWN RISK
 

	12 dec 2003, Pierre-Felix Breton, 
		added product switcher: this macro file can be shared with all Discreet products


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 Localization Notes

 "Localize On" states an area where locization should begin
 "Localize Off"  states an area where locization should end

*** Localization Note *** states that the next line has special localization instructions for the next line.
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

*/

MacroScript AddPopupNote
enabledIn:#("max", "viz") --pfb: 2003.12.12 added product switch
ButtonText:~ADDPOPUPNOTE_BUTTONTEXT~
Category:~ADDPOPUPNOTE_CATEGORY~ 
internalCategory:"Pop up Note" 
Tooltip:~ADDPOPUPNOTE_TOOLTIP~ 
(
	/* "Localize On" */
	--Persistent Global Note_NoteString
	--Persistent Global Note_AuthorString
	--Persistent Global Note_TextString
	rollout NoteRollout ~NOTEROLLOUT_POP_UP_NOTE~ width:500 height:400
	(
		Edittext auth ~AUTHOR_CAPTION~ pos:~AUTHOR_POSITION~ width:~AUTHOR_WIDTH~ height:~AUTHOR_HEIGHT~ fieldwidth:150 text:""
		Edittext dtstmp ~DATE_CAPTION~ pos:~DATE_POSITION~ width:~DATE_WIDTH~ height:~DATE_HEIGHT~ fieldwidth:150 offset:[8,0] text:localtime
		Checkbox Persist ~SHOW_NOTE_ON_FILE_OPEN~ checked:true pos:~SHOW_NOTE_ON_FILE_OPEN_POSITION~ width:~SHOW_NOTE_ON_FILE_OPEN_WIDTH~ height:~SHOW_NOTE_ON_FILE_OPEN_HEIGHT~
		Edittext line1 pos:~LINE1_POSITION~ width:~LINE1_WIDTH~ height:200 text:""
		Button CanclAll ~CANCEL_CAPTION~ pos:~CANCEL_POSITION~ width:75 height:~CANCEL_HEIGHT~ offset:~CANCEL_OFFSET~
		Button Go ~ADD_NOTE_CAPTION~ pos:~ADD_NOTE_POSITION~ width:~ADD_NOTE_WIDTH~ height:~ADD_NOTE_HEIGHT~ offset:[190,-26]
	
	On Go pressed do
		(
		callbacks.removescripts id:#SceneNote
		
		
		-- *** Localization Note *** states that the next line has special localization instructions for the next line.
		-- Persistent Global Note_NoteString = "Messagebox \"" + "(loc)Author: " + auth.text+"\n"+dtstmp.text+"\n\n(loc)Note Comments:\n"+ line1.text+ "\"" + "title:\"(loc)Pop-up Note\""
		
		Persistent Global Note_NoteString = "Messagebox \"" + ~AUTHOR~ + auth.text+"\n"+dtstmp.text+~NOTE_COMMENTS~+ line1.text+ "\"" + ~POP_UP_NOTE_TITLE~
		Persistent Global Note_AuthorString = auth.text
		Persistent Global Note_TextString = line1.text
		If Persist.checked == true do callbacks.addscript #filepostopen "Execute Note_NoteString" id:#SceneNote persistent:true
		destroydialog NoteRollout
		fileproperties.addproperty #summary "comments" Note_TextString
		fileproperties.addproperty #summary "author" Note_AuthorString

		)
	On NoteRollout Open do 
		(
			try (auth.text = fileProperties.getPropertyvalue #summary 2) Catch()
			try (line1.text = fileProperties.getPropertyvalue #summary 1) Catch()
		)
	On CanclAll pressed do destroydialog NoteRollout
	)
	CreateDialog  NoteRollout  width:500 height:300		
	
)

MacroScript ReadPopupNote
enabledIn:#("max", "viz") --pfb: 2003.12.12 added product switch

ButtonText:~READPOPUPNOTE_BUTTONTEXT~
Category:~READPOPUPNOTE_CATEGORY~ 
internalCategory:"Pop up Note" 
Tooltip:~READPOPUPNOTE_TOOLTIP~ 
(
	If Note_NoteString != undefined then Execute Note_NoteString
	Else  MessageBox ~MSGBOX_NO_NOTES_PRESENT~ Title:~MSGBOX_NO_NOTES_PRESENT_TITLE~ beep:no
)

MacroScript DeletePopupNote
enabledIn:#("max", "viz") --pfb: 2003.12.12 added product switch
ButtonText:~DELETEPOPUPNOTE_BUTTONTEXT~
Category:~DELETEPOPUPNOTE_CATEGORY~
internalCategory:"Pop up Note" 
Tooltip:~DELETEPOPUPNOTE_TOOLTIP~ 
(
	If Note_NoteString != undefined then
	(
		 if querybox ~QUERYBOX_ARE_YOU_SURE~ then 
		(
		callbacks.removescripts id:#SceneNote
		messagebox ~MSGBOX_THE_NOTE_HAS_BEEN_DELETED~ title:~MSGBOX_THE_NOTE_HAS_BEEN_DELETED_TITLE~ beep:no
		Note_NoteString = undefined
		)
	)
	Else  MessageBox ~MB_NO_NOTES_PRESENT~ Title:~MB_NO_NOTES_PRESENT_TITLE~ beep:no
)

MacroScript SupressPopupNote
enabledIn:#("max", "viz") --pfb: 2003.12.12 added product switch
ButtonText:~SUPRESSPOPUPNOTE_BUTTONTEXT~
Category:~SUPRESSPOPUPNOTE_CATEGORY~ 
internalCategory:"Pop up Note" 
Tooltip:~SUPRESSPOPUPNOTE_TOOLTIP~ 
(
	if Note_NoteString != undefined then
		(
		callbacks.removescripts id:#SceneNote
	
		messagebox ~MSGBOX_THE_NOTE_HAS_BEEN_SUPPRESSED~ title:~MSGBOX_THE_NOTE_HAS_BEEN_SUPPRESSED_TITLE~ beep:no
		)
	Else MessageBox ~MSGBOX_NO_NOTE_PRESENT~ Title:~MSGBOX_NO_NOTE_PRESENT_TITLE~ beep:no
)
/* "Localize Off" */

