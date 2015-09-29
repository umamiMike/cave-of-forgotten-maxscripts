
global myRoll
global my_floater
Global myDirectory
Global FilesArray = #()
Global BitMapArray = #()
global myWidth = #()
global myHeight = #()
global myPlanes #()

fn getBitmaps = (
		--reinitializing various arrays
		myDirectory
		filesarray = #()
		myWidth = #()
		myHeight = #()
	
	Mydirectory = getSavePath  caption:"open it bitch" initialDir:maxFilePath
	filesarray = getfiles (Mydirectory + "\*")
		for i = 1 to filesarray.count do (
				myBM = openBitmap filesarray[i]
				if classof myBM == Bitmap do ( 
					append bitmapArray myBM
					append myWidth myBM.width
					append myHeight myBM.height
				)
			)
		)

fn distribute myPlanes = (
	for i = 2 to myPlanes.count do (
		
		ob = myPlanes[i]
		prevOb = myPlanes[i-1]
		ob.position = [prevOb.position.x + prevOb.width/2 + ob.width/2  ,0,0]
		
		
	)
	
	
	
	)
		
		
rollout myRoll "rolloutname" width:224 height:101
(
	button DirBtn "Select the Directory" pos:[8,8] width:160 height:24
	button DoBtn "Make The Plates" pos:[8,64] width:160 height:24

	
	on DirBtn pressed  do -- 
		(
			getBitmaps()
		)
	
	
	on DoBtn pressed  do(
		
		
		-- inits
		myPlanes = #()
		-- loop to do all the shit
	for i = 1 to BitMapArray.count do(
		
		m = bitMapArray[i]
		mat = standardMaterial()
		
		diff = bitmapTexture bitmap:m
		
		mat.diffuseMap = diff

		
		r = (quat 0.707107 0 0 0.707107)
	
		
		w = m.width as float
		h = m.height as float
		ratio = h / w
		
		p = Plane pos:[0,0,0] rotation:r
		p.lengthsegs = 1
		p.widthsegs = 1
		
		matName = getFilenameFile (m.filename)
		p.name =  matName + "_plate"
		mat.name = "Plate_" + matName
		mat.selfIllumAmount = 100
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
	
		append myPlanes p

	)
	
	distribute myPlanes 
	
	)	
)






if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 224 150
			addRollout myRoll my_floater
			 
