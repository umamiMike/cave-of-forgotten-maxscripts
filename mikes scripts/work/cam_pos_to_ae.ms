trackcam
myTrackView

rollout camposRoll "CamPosRoll" width:158 height:158
(
	button btn1 "cam pos" pos:[10,9] width:140 height:19
	on btn1 pressed do
(	
	for i = 1 to selection.count do

	(
	
	undo on 
		(
		trackCam = freecamera()
		trackCam.transform = selection[i].transform
		trackCam.name = selection[i].name+"_trackcam"
		trackCam.parent = selection[i]
		myTrackView = batchRenderMgr.CreateView trackCam
		--myTrackView.name = trackCam.name
		batchRenderMgr.displayRenderedViews
		myFilePath = getFilenamePath myTrackView.outputFilename
		--fileType = ".rpf"
		--myNewFilename = append selection[i].name fileType
		--myTrackview.outputFilename = append  myFilePath  myNewFilename
		
		)
	)

	
)

)
createDialog camposRoll
