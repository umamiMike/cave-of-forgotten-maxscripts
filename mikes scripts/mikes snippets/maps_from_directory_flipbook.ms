global myPath
myFiles = #()
myBitmaps = #()




rollout MyRollout "Untitled" width:162 height:300
(
	button btn1 "dirpickbutton" pos:[7,6] width:108 height:28
	button btn3 "Apply bitmaps" pos:[11,42] width:108 height:22
	on btn1 pressed do
	(
			myPath = getSavePath caption:"Open em"
	
	
			 myFiles = (getFiles (myPath+"/*.psd"))

for i = 1 to myFiles.count do
(
mybitmaptexture = bitmaptexture()
mybitmaptexture.filename = myFiles[i]

append myBitmaps mybitmaptexture


)
			)
	on btn3 pressed  do
(


	for i = 1 to selection.count do
		(
		
		myMat = doubleSidedMat()
		selection[i].material = myMat
		myMat.material1.diffusemap = myBitmaps[1]
		myMat.material2.diffusemap = myBitmaps[2]
		deleteItem myBitmaps 1
		deleteItem myBitmaps 2
		)
	)
)
createDialog MyRollout
