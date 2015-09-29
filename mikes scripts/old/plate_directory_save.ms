

global myfiles
global myusefiles

fn makeIt = (
	for i = 1 to myfiles.count do
	
	(
		m = myusefiles[i]
		mat = standardMaterial()
		
		diff = bitmapTexture bitmap:m
		
		mat.diffuseMap = diff
		
		r = (quat 0.707107 0 0 0.707107)
		p = Plane pos:[0,0,0] rotation:r
		p.lengthsegs = 1
		p.widthsegs = 1
		
		w = myusefiles[i].width.as float
		h = myusefiles[i].height.as float
		ratio = h / w
		
		matName = getFilenameFile (myusefiles[i].filename)
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
		p.castshadows = off
		p.receiveshadows = off
		p.material.opacity = 0

		meditMaterials[1]= p.material
		
		leftOperationString = "length*" + ((1/ratio) as string)
		rightOperationString = "width*" + (ratio as string)
		
		if (constrain) then
			paramWire.connect2way p.baseObject[#width] p.baseObject[#length] leftOperationString rightOperationString
	
	print m
	)
)

rollout directoryRoll "Untitled" width:162 height:300
(
	button pickbtn "pick the directory" pos:[4,7] width:107 height:26
	
	button makemtbtn "make em" pos:[5,47] width:107 height:26
	
	
	on pickbtn pressed do
	(
		
		
		f = getSavePath()
		ftest = f + "\*.tif"
		myfiles = getfiles ftest
		myusefiles = #()
		for i = 1 to myfiles.count do
		(
		myusefiles[i] = myfiles[i]
		)
		
		
		)
	on makemtbtn pressed  do
	(
	makeIt()
	)
)
		global directoryRoll
		try (destroyDialog directoryRoll) catch()
		createDialog directoryRoll



--