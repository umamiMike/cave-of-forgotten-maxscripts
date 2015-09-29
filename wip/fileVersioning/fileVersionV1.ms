 macroScript fileVersioningV1
	category:"Umami"
	toolTip:"fileVersioningV1"
( 

	
	fn setArchivePath  = ( 
		try(
			if maxfilepath.count != 0 do (
				archivePath = (maxfilepath as string) + "archive"
				makedir archivePath
				archivePath += "\\"
			)
			return archivePath
			
		)
		catch(messagebox("no files were selected"))
		)
		
		fn assembleVersionString =  (
			theFileNameBase = getFilenamefile maxfilename
			t = theFileNameBase + "_" + localTime
			a = filterString t "/ :"
			finalString = ""
			for i = 1 to  a.count do (finalString += a[i]
				if i != a.count do ( finalString += "_")

			)
		finalString
		)

	fn makeNote = (
	rollout NoteRollout "NoteRollout" width:500 height:317
	(
		edittext auth "Author" pos:[8,8] width:154 height:17 fieldwidth:150
		edittext dtstmp "Time Stamp" pos:[8,31] width:153 height:16 fieldwidth:200 text:localTime
		checkbox Persist "Show note on file open" pos:[8,54] width:162 height:16 checked:true
		edittext line1 "" pos:[6,81] width:483 height:188
		button CanclAll "Cancel" pos:[330,278] width:75 height:16 
 
 
 
		button go "Add Note" pos:[412,279] width:75 height:16
	
		on NoteRollout open do
		(
			try (auth.text = fileProperties.getPropertyvalue #summary (fileProperties.findProperty #summary "author")) Catch()
			try (line1.text = fileProperties.getPropertyvalue #summary (fileProperties.findProperty #summary "comments")) Catch()
		)
		on CanclAll pressed do
			destroydialog NoteRollout
		on go pressed do
		(
		callbacks.removescripts id:#SceneNote
		
		Persistent Global Note_NoteString = "Rollout noteRoll \"Umami File Version Notes\" width:320 height: 400 ("
			Note_NoteString += "edittext note  width:300 height:390 postion:[0,0] align:#left offset:[-8,0]"
			Note_NoteString += "\n on noteRoll open do (note.text = fileProperties.getPropertyvalue #summary (fileProperties.findProperty #summary \"comments\" ) "
			Note_NoteString += "\n))" + "createDialog noteRoll"
		Persistent Global Note_AuthorString = auth.text
		Persistent Global Note_TextString = localTime + "\n" + "\n" +"\n" +"\n" + line1.text 
		If Persist.checked == true do callbacks.addscript #filepostopen "Execute Note_NoteString" id:#SceneNote persistent:true
		destroydialog NoteRollout
		fileproperties.addproperty #summary "comments" Note_TextString
		fileproperties.addproperty #summary "author" Note_AuthorString
		
			doIt()
		)
	)
	CreateDialog  NoteRollout  width:500 height:300		
)

fn readNote = (
	If Note_NoteString != undefined then (Execute Note_NoteString
		)
	Else  MessageBox "No Notes Present" Title:"No notes present title" beep:no
)

fn run = (
	makeNote()
	
	)		
fn doIt = (
			try(
			theArchivePath = setArchivePath()
			if theArchivePath != "archive\\" then (thisVersion = assembleVersionString()
			thisArchiveFile = theArchivePath + thisVersion
			saveMaxFile thisArchiveFile useNewFile: false
				) else (messagebox "no archive can be made, maybe file hasnt been saved yet?")
			try(
				RPMData.setUICheckData 9 thisVersion 
				rmpasses.rmshotname.entered thisVersion
			) catch(messagebox "rpmanager data doesnt exist or something else went wrong")
			thisFileSave = maxfilepath + maxfileName
			saveMaxFile thisFileSave
			)
			catch(messagebox "it didnt work")
			
			)
			
			

	
	
	


run()

			---doIt()
		--makedir
		--saveMaxFile <filename_string>  
		--Saves the scene to the current 3ds Max scene directory if there is no explicit directory path on the supplied file name. 
		--If no filename extension is specified, ".max" is automatically appended to the filename.
			
	fn saveIncrementalRaw = (
		
  if maxFileName != "" then (
        max saveplus
        TheFile = maxFilePath + (trimRight (getFilenameFile maxFileName) "1234567890") + ".max"
        if doesFileExist TheFile do deleteFile TheFile
        copyFile (maxFilePath + maxFileName) TheFile
    ) else checkForSave()
	
)
	
	fn altSaveProcessTest = (
		
  if maxFileName != "" then (
	  
       -- max saveplus
        TheFile = maxFilePath + (trimRight (getFilenameFile maxFileName) "1234567890") + ".max"
        if doesFileExist TheFile do deleteFile TheFile
        copyFile (maxFilePath + maxFileName) TheFile
    ) else checkForSave()
	
)




)