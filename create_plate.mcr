macroScript createPlate
	category:"umami"
	tooltip:"Create Plate_lit"
	buttonText:"Create Plate_lit"
(
	global m
	
	fn createBitmapPlate type constrain width =
	(
		if (type == #file) then
			m = selectBitmap caption:"Open plate image..."
		else if (type == #map) then
		(
			mat = medit.getTopMtlSlot (medit.getActiveMtlSlot())
			try (m = mat.diffuseMap.bitmap)
			catch
			(
				messageBox "Select a select a Bitmap in the Material Editor."
				return undefined
			)
		)
		
		mat = standardMaterial()
		
		diff = bitmapTexture bitmap:m
		
		mat.diffuseMap = diff
		
		r = (quat 0.707107 0 0 0.707107)
		p = Plane pos:[0,0,0] rotation:r
		p.lengthsegs = 1
		p.widthsegs = 1
		
		w = m.width as float
		h = m.height as float
		ratio = h / w
		
		matName = getFilenameFile (m.filename)
		p.name =  matName + "_plate"
		mat.name = "Plate_" + matName
		mat.selfIllumAmount = 100
		diff.alphaSource = 0
		diff.monoOutput = 1
		mat.diffusemap.name = p.name as string
		mat.Diffuse = color 0 0 0
		mat.Ambient = color 0 0 0
		mat.opacityMap = diff
		mat.showInViewport = true
		mat.opacity = 0
		mat.diffusemap.endCondition = 2
		p.material = mat
		p.width = width
		p.length = p.width / ratio		
		--p.castshadows = off
		--p.receiveshadows = off
		p.material.opacity = 0

		meditmaterials[medit.GetActiveMtlSlot()] = p.material
		
		leftOperationString = "length*" + ((1/ratio) as string)
		rightOperationString = "width*" + (ratio as string)
		
		if (constrain) then
			paramWire.connect2way p.baseObject[#width] p.baseObject[#length] leftOperationString rightOperationString
	
	print m
	if $ != undefined then p.transform = $.transform
	else p.transform = (matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0])
	p.isselected = true
	)

			
	rollout roCreatePlate "Create Plate"
	(
		group "File Location"
		(
			button btnMap "Current Map Slot" width:140 height:16
			button btnFile "File..." width:140 height:16
		)
		
		spinner spnSize "Size:" range:[0.0, 9e10, 100.0] type:#float
		
		checkbox chkConstrain "Constrain Aspect Ratio" checked:true
		
		on btnMap pressed do
			undo "Create Bitmap Plate" on CreateBitmapPlate #map chkConstrain.checked spnSize.value
	
		on btnFile pressed do
			undo "Create Bitmap Plate" on CreateBitmapPlate #file chkConstrain.checked spnSize.value
	)
	
	
	on execute do
	(
		global roCreatePlate
		try (destroyDialog roCreatePlate) catch()
		createDialog roCreatePlate
	)	
)
