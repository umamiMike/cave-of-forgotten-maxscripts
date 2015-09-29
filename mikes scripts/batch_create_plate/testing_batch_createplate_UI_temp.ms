--need to test the extension
--add a multiplier for the length and width to size em
-- a way to tile them in to a grid
global myRoll
global my_floater

Global myDirectory
Global FilesArray = #()
Global BitMapArray = #()
global myExt = ".tif"
Global myWidth = #()
rollout myRoll "rolloutname" width:224 height:101
(
	button DirBtn "Select the Directory" pos:[8,8] width:160 height:24
	button DoBtn "Make The Plates" pos:[8,64] width:160 height:24
	editText XtnEdt "File Type" text: ".tif" pos:[8,40] width:160 height:16
	
	on DirBtn pressed  do
		(
		Mydirectory = getSavePath  caption:"open it bitch"
		filesarray = getfiles (Mydirectory + "\*"+ myExt)
		for i = 1 to filesarray.count do
		 (
		myBM = openBitmap filesarray[i]
		append bitmapArray myBM
		)

	)

	on XtnEdt entered text do
		(
	
	)
	
	on DoBtn pressed  do(
		
		
	for i = 1 to BitMapArray.count do(
		
		m = bitMapArray[i]
		mat = standardMaterial()
		
		diff = bitmapTexture bitmap:m
		
		mat.diffuseMap = diff

		
		r = (quat 0.707107 0 0 0.707107)
	
		
		w = m.width as float
		h = m.height as float
		ratio = h / w
		
		p = Plane pos:[myWidth[i],0,0] rotation:r
		p.lengthsegs = 1
		p.widthsegs = 1
		
		matName = getFilenameFile (m.filename)
		p.name =  matName + "_plate"
		mat.name = "Plate_" + matName
		mat.selfIllumAmount = 0
		diff.alphaSource = 0
		diff.monoOutput = 1
		mat.diffusemap.name = p.name as string
		mat.Diffuse = color 0 0 0
		mat.Ambient = color 0 0 0
		mat.specular = color 0 0 0
		mat.opacityMap = diff
		mat.showInViewport = true
		mat.opacity = 0
		mat.diffusemap.endCondition = 2
		p.material = mat
		p.width = w
		p.length = p.width / ratio		
		--p.castshadows = off
		--p.receiveshadows = off
		p.material.opacity = 0
		--meditmaterials[medit.GetActiveMtlSlot()] = p.material
		
		leftOperationString = "length*" + ((1/ratio) as string)
		rightOperationString = "width*" + (ratio as string)
		
		paramWire.connect2way p.baseObject[#width] p.baseObject[#length] leftOperationString rightOperationString
	

	)
	)	
)






if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 224 150
			addRollout myRoll my_floater
			 
