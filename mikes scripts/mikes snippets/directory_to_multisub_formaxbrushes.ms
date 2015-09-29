global myPath
myFiles = #()
myBitmaps = #()
myMat = multimaterial()
myMat.count = 20
meditmaterials[medit.GetActiveMtlSlot()] = myMat


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


	for i = 1 to myBitmaps.count do
		(
		--myMat[i]
		--myMat.diffusemap = myBitmaps[i]
		myMat[i].opacityMap = myBitmaps[i]
		myMat[i].Ambient = color 0 0 0
		myMat[i].Diffuse = color 0 0 0
		myMat[i].opacity = 0
				--deleteItem myBitmaps 1
		)
	)
)
createDialog MyRollout
