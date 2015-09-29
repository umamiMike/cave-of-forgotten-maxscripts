global myPath
global myFiles = #()
myBitmaps = #()




rollout MyRollout "Untitled" width:162 height:200
(
	button btn1 "dirpickbutton" pos:[7,6] width:108 height:28
	button btn3 "Apply bitmaps" pos:[11,42] width:108 height:22
	
	on btn1 pressed do
	(

	
			myPath = getSavePath caption:"Open em"
	
	typeOfFile = "/*.jpg"
			 myFiles = (getFiles (myPath+typeOfFile))



for i = 1 to myFiles.count do
(
mybitmaptexture = bitmaptexture()
mybitmaptexture.filename = myFiles[i]

append myBitmaps mybitmaptexture


)

mycompmap = compositetextureMap()
mycompmap.mapList.count= myBitmaps.count
environmentMap = mycompmap

for i = 1 to mycompmap.mapList.count do(

 mycompmap.maplist[i] = mybitmaps[i]
   mycompmap.maplist[i].coordinates.mappingtype = 1
  mycompmap.maplist[i].coordinates.mapping = 3
 )
meditmaterials[medit.GetActiveMtlSlot()] = mycompmap
			
			
			
			)
	on btn3 pressed  do
(


	for i = 1 to selection.count do
		(


		)
	)
)
if myRollout != undefined then (createDialog MyRollout)

