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
	
	
			 myFiles = (getFiles (myPath+"/*.tga"))

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
		
		myMat = standardMat()
		selection[i].material = myMat
		myMat.diffusemap = myBitmaps[i]
		myMat.opacityMap = myBitmaps[i]
		myMat.Ambient = color 0 0 0
		myMat.Diffuse = color 0 0 0
		myMat.opacity = 0
		selection[i].material.showinviewport = true
		--deleteItem myBitmaps 1
		)
	)
)
createDialog MyRollout