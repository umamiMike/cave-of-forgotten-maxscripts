global myPath
myFiles = #()
rollout MyRollout "Untitled" width:162 height:300
(
	button btn1 "dirpickbutton" pos:[7,6] width:108 height:28
	button btn3 "Apply bitmaps" pos:[11,42] width:108 height:22
	on btn1 pressed do
	(
			myPath = getSavePath caption:"Open em"
	
	
			 myFiles = (getFiles ( myPath+"/*.tif"))
			)
	on btn3 pressed  do
(
	
	)
)
createDialog MyRollout
