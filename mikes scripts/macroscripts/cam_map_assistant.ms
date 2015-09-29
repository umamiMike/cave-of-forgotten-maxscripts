macroScript Macrocamassist
	category:"Mikes"
	toolTip:"cam map assistant"
(
	global myOldrenderPixelaspect = renderPixelAspect
	global myOldRenderwidth = renderWidth
	global myOldRenderheight = renderHeight
	global myRenderwidth = $.mat.diffusemap.Bitmap.width
	global myRenderHeight = $.mat.diffusemap.Bitmap.height
	global myOldRenderHeight = renderheight
	global myOldRenderwidth = renderwidth
	global myOldpixelAspect = renderPixelAspect
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
	mycam.isselected = true

	)
	fn oldRendSettings = 
	(
	renderwidth = myOldRenderwidth
	renderheight = myOldRenderheight
	renderPixelAspect = MyOldRenderPixelAspect
	)

	fn myRendSettings =
	(
	renderwidth = myRenderwidth
	renderheight = myRenderHeight 
	renderPixelAspect = 1.0
	)

	rollout camMapAssistRoll "Camera Map Assistant" width:162 height:300
	(
		button makeCamBtn "Make The Camera" pos:[8,5] width:100 height:21
		button old_rendersettingsbtn "old render settings" pos:[8,40] width:133 height:20
		button cammap_rend_settingsbtn "camera map render settings" pos:[8,70] width:141 height:23
		
		
		on makeCamBtn pressed do
			makecam()
		on old_rendersettingsbtn pressed do
			oldRendSettings()
		on cammap_rend_settingsbtn pressed  do
			myRendSettings()
	)
	createdialog camMapAssistRoll

)
