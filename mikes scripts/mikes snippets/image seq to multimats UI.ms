

--
--


global myPath
global myFiles = #()
global myBitmaps = #()
mynumsubs = 10
global seq_to_submat_Roll
global seq_to_submat_Floater
global myFileType = "/*.tga"
mymademats = #()
global subIndex = 1



rollout seq_to_submat_Roll "Untitled" width:185 height:300
(
	button dirPick_b "pick the file directory" pos:[15,88] width:153 height:28
	button multimat_b "Create The Multi Material" pos:[16,126] width:154 height:22
	spinner submat_Spn "# of Submats" pos:[16,6] width:162 height:16 range:[0,100,10] type:#integer fieldwidth:30
	edittext filetype_edt "File Type" pos:[88,30] width:86 height:16 fieldwidth:30
		
		
		
		
	
	
	button addbitmap_btn "add more bitmaps to the materials" pos:[8,157] width:164 height:25
	
	
	spinner spn15 "which submaterial?" pos:[42,56] width:160 height:16 range:[0,100,0] type:#integer

	on dirPick_b pressed do
	(
			myPath = getSavePath caption:"Open em"
	
	
			 if myPath != undefined then (myFiles = (getFiles (myPath+myFileType)))
	
	for i = 1 to myFiles.count do
	(
	mybitmaptexture = bitmaptexture()
	mybitmaptexture.filename = myFiles[i]
	
	append myBitmaps mybitmaptexture
	
	
	)
	
	if myBitmaps.count == 0 then messagebox "No Files Were Collected"
	
	)
	on multimat_b pressed do
	(
	
	
		for i = 1 to mybitmaps.count do
			(
			
			myMat = multimaterial()
			mymat.name = "the material" + i as string
			myMat.numsubs = mynumsubs 
			--selection[i].material = myMat
			myMat[subIndex].diffusemap = myBitmaps[i]
			append mymademats mymat
			)
		)
	on submat_Spn changed val do
		mynumsubs = val
	on filetype_edt changed text do
		( myFileType =  "/*." + text )
	on addbitmap_btn pressed do
		(for i = 1 to mymadematerials.count do
		(
		mymadematerials[subindex].diffusemap = mybitmaps[i]
		)
	
	)
	on spn15 changed val do
		subIndex = val
)












if seq_to_submat_Floater != undefined then closeRolloutFloater seq_to_submat_Floater
seq_to_submat_Floater = newRolloutFloater "Image Seq to submat" 400 250
			addRollout seq_to_submat_Roll seq_to_submat_Floater

