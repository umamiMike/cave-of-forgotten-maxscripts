macroScript Macrocamassistb
	category:"Mikes"
	toolTip:" new cam map assistant"
(
	global myobj = $
	global myOldrenderPixelaspect = renderPixelAspect
	global myOldRenderwidth = renderWidth
	global myOldRenderheight = renderHeight
	global myRenderwidth 
	global myRenderHeight 
	global myOldRenderHeight = renderheight
	global myOldRenderwidth = renderwidth
	global myOldpixelAspect = renderPixelAspect
	global mycam
	
	global mybitmap = myobj.mat.diffusemap.bitmap

	fn setIt = 

	(
	macros.run "Lights and Cameras" "Camera_CreateFromView"h
	$.targetDistance = 1
	myRenderwidth = myobj.mat.diffusemap.Bitmap.width
	myRenderHeight = myobj.mat.diffusemap.Bitmap.height
	renderSceneDialog.close()
	renderPixelAspect = 1.0
	renderWidth = mybitmap.width
	renderHeight = mybitmap.height
	setAsBackground mybitmap
	setBkgImageAspect #bitmap
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
	fn imagecontrol =
	(
	imageparent = dummy()
	imageparent.transform = mycam.transform
	imageparent.parent = mycam
	imageparent.name = myobj.name + "controller"
	myobj.parent = imageparent
	
	)

	rollout camMapAssistRoll "Camera Map Assistant" width:162 height:300
	(
		button makeCamBtn "Make The Camera" pos:[8,5] width:100 height:21
		button old_rendersettingsbtn "old render settings" pos:[8,40] width:133 height:20
		button cammap_rend_settingsbtn "camera map render settings" pos:[8,70] width:141 height:23
		checkbutton ckb2 "seethru" pos:[10,104] width:125 height:18
		button imagecntrlbtn "Make Image Control" pos:[10,135] width:132 height:17
		spinner spn1 "" pos:[11,163] width:63 height:16
		
		
		on makeCamBtn pressed do
			setIt()
		on old_rendersettingsbtn pressed do
			oldRendSettings()
		on cammap_rend_settingsbtn pressed do
			myRendSettings()
		on ckb2 changed state do
		(
			myobj = $
	if state == on
				then (myobj.mat.opacityMapAmount = 50
						myobj.mat.opacity = 50)
				else (myobj.mat.opacityMapAmount = 100
						myobj.mat.opacity = 100)
			)
		on imagecntrlbtn pressed do
			imagecontrol()
	)	
	createdialog camMapAssistRoll

)
