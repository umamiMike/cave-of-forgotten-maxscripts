Mydirectory = getSavePath  caption:"open it bitch"
filesarray = getfiles ( Mydirectory + "\*.*" )	

for i = 1 to filesarray.count do 	
(
		
		m = bitmap filename: filesarray [i]
		mat = standardMaterial()
		
		diff = bitmapTexture bitmap:m
		
		mat.diffuseMap = diff
		
		r = (quat 0.707107 0 0 0.707107)
		p = Plane pos:[0,0,0] rotation:r
		
		w = m.width as float
		h = m.height as float
		ratio = h / w
		
		matName = getFilenameFile (m.filename)
		p.name = "plate_" + matName
		mat.name = "Plate_" + matName
		mat.selfIllumAmount = 100
		diff.alphaSource = 0
		diff.monoOutput = 1
		mat.Diffuse = color 0 0 0
		mat.Ambient = color 0 0 0
		mat.opacityMap = diff
		mat.showInViewport = true
		mat.opacity = 0
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
	print file
	)


 	
