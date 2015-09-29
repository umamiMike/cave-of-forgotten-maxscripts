--batchRender from Current Render
--
someText
global batchRoll
fn ToBatch = (

renderSceneDialog.close() -- need to close to get info
	gac = getActiveCamera()	
	FileName = getfilenamefile rendOutputFilename
	FilePath = getfilenamepath rendOutputFilename 
	FileXtn = getfilenametype rendOutputFilename 
	NewFileName = FilePath+gac.name+"_"+someText+"_"+FileXtn

w = renderWidth
h = renderHeight
s = animationRange.start
myEnd = animationRange.end
			
myView = batchRenderMgr.CreateView gac
bCount = batchRenderMgr.numviews
v = myView
v.name = gac.name + "_"+someText
v.overridePreset = True
v.startFrame = s
v.endFrame = myEnd
v.width = renderWidth
v.Height = renderHeight
v.outPutFilename = NewFileName

)

try(destroyDialog batchRoll)catch()
rollout batchRoll "to Batch Rollout" width:296 height:72
(
	edittext edt1 "Extra Info" pos:[14,15] width:266 height:16
	button btn1 "Do It" pos:[58,40] width:178 height:20
	on batchRoll open do
	(
		
		)
	on edt1 entered text do
		someText = text
	on btn1 pressed do
		toBatch()
)
createDialog batchRoll