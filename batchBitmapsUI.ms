if bulkFileRoll != undefined do (destroyDialog bulkFileRoll)

--global myfiles = #()
--myBitmaps = #()
persistant global defPath
	
	fn gatherBitmapsFromDir  = ( 
		try(
		f = getSavePath initialDir:(defPath)
		ftest = f + "\*" + bulkFileRoll.fileTypeDdl.selected
		myfiles = getfiles ftest
		return myFiles
		--bulkFileRoll.ddl3.items = for i in myFiles collect getFileNameFile i
		)
		catch(messagebox("no files were selected"))
		)
	
	fn createBitmapsFromFile fileArray = (
		
		myBitmaps = #()
		progressStart "Creating The Bitmaps" 
		for o = 1 to  fileArray.count do (
			theName = getFileNameFile fileArray[o]
			
			TheBitmapTex = bitmaptexture filename:fileArray[o] name:theName
			append myBitmaps theBitmapTex
			progressUpdate (100 * o/fileArray.count)
			)
		progressEnd()
			
		bulkFileRoll.ddl3.items = for o in myBitmaps collect o.name
			gc()
	)
		
rollout bulkFileRoll "Untitled" width:312 height:300
(
	button btn1 "getBitmaps" pos:[219,49] width:78 height:25
	dropdownList fileTypeDdl "" pos:[22,50] width:101 height:21 items:#(".tif", ".exr", ".tga", ".psd")
	dropdownList ddl3 "" pos:[10,82] width:256 height:21  
  
  
  
  
	edittext edt1 "" pos:[9,18] width:203 height:16
	label lbl1 "Default Path" pos:[224,18] width:77 height:15
  
	on btn1 pressed do
		(myFiles = gatherBitmapsFromDir()
			createBitmapsFromFile myFiles )
	on edt1 entered text do
		defPath = edt1.text
)


createDialog bulkFileRoll
