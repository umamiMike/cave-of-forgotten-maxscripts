
		try (destroyDialog roCreatePlate) catch()
global roCreatePlate


	fn createBitmapPlate theMat type constrain width =
	(
		
		theMat = copy $.material	
		theBitmaps = getClassInstances bitmapTexture target:theMat
		
		if (type == #file) then (
			
			for i in theBitmaps do (
				theCap = "select a bitmap for " + i.name
			thisMap = selectBitmap caption:theCap
			i.filename = thisMap.filename
			)
		)
		
		m = theBitmaps[1].bitmap
		if m != undefined do (
	
		r = (quat 0.707107 0 0 0.707107)
			thePos = selection[1].position
		p = Plane pos:thePos rotation:r
		p.lengthsegs = 1
		p.widthsegs = 1
		
		w = m.width as float
		h = m.height as float
		ratio = h / w
			
			
			
			
			
			
		p.material = theMat
		p.width = width
		p.length = p.width / ratio		
		--p.castshadows = off
		--p.receiveshadows = off
		--p.material.opacity = 0

		--meditmaterials[medit.GetActiveMtlSlot()] = p.material
		
		leftOperationString = "length*" + ((1/ratio) as string)
		rightOperationString = "width*" + (ratio as string)
		
		if (constrain) then (paramWire.connect2way p.baseObject[#width] p.baseObject[#length] leftOperationString rightOperationString)
	
	--print 	else p.transform = (matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0])
	p.isselected = true
	)
	)

			
	rollout roCreatePlate "Create Plate" width:162 height:141
	(
		groupBox grp1 "File Location" pos:[4,37] width:154 height:41
		button btnFile "File..." pos:[12,56] width:140 height:16
		
		spinner spnSize "Size:" pos:[56,88] width:93 height:16 range:[0,9e+010,100] type:#float
		
		checkbox chkConstrain "Constrain Aspect Ratio" pos:[13,109] width:132 height:15 checked:true
		materialButton btn2 "MaterialButton" pos:[10,6] width:73 height:25
		

	
		on btnFile pressed do
			undo "Create Bitmap Plate" on CreateBitmapPlate btn2.material #file chkConstrain.checked spnSize.value
		on btn2 picked mtl do
			btn2.caption = mtl.name
	)


		createDialog roCreatePlate
