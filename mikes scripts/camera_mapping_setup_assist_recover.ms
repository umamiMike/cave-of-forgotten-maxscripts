global myRenderwidth = $.mat.diffusemap.Bitmap.width
global myRenderHeight = $.mat.diffusemap.Bitmap.height
global myOldRenderHeight = renderheight
global myOldRenderwidth = renderwidth
global myOld pixelAspect = renderPixelAspect
global mycam


fn makecam = 

(
mycam = freecamera()
renderSceneDialog.close()
mycam.transform = $.transform
mycam.name = $.name + "_Cammap_cam"
renderPixelAspect = 1.0
renderWidth = $.mat.diffusemap.Bitmap.width
renderHeight = $.mat.diffusemap.Bitmap.height
mycam.showHorizon = true

)

rollout camMapAssistRoll "Camera Map Assistant" width:162 height:300
(
	button makeCamBtn "Make The Camera" pos:[6,5] width:100 height:21
	on makeCamBtn pressed  do
		makecam()
)

createdialog camMapAssistRoll

--$.mat.diffusemap.Bitmap.width
--$.mat.diffusemap.Bitmap.height