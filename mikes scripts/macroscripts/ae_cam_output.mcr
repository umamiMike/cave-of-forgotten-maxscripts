macroScript ae_cam_output
	category:"Mikes"
	toolTip:"apply a camera to selected objects and add to batch render"
(

for i = 1 to selection.count do

(
trackCam = freecamera()
trackCam.transform = selection[i].transform
trackCam.name = selection[i].name+"_trackcam"
trackCam.parent = selection[i]
trackview = batchRenderMgr.CreateView trackCam
trackview.name = trackCam.name
batchRenderMgr.displayRenderedViews
)

)