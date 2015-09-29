utility CondenseMaterialIDs "Condense Material IDs"
(
	local collapseBy = "Name"
	
	radioButtons CollapseByRadioButtons "Collapse By:" labels:#("Name", "Diffuse Texture Name") default:1
	
	on CollapseByRadioButtons changed state do
	(
		collapseBy = case CollapseByRadioButtons.state of
		(
			1: "Name"
			2: "TextureName"
			default: "Name"
		)
	)
	
	fn getTextureName mat =
	(
		local textureName = mat.name
		try
		(
			diffuseTextureMap = mat.diffusemap
			print (classof diffuseTextureMap)
			if classof diffuseTextureMap == Bitmaptexture do
			(
				textureName = getFileNameFile diffuseTextureMap.bitmap.filename
			)
		)
		catch()
		textureName
	)
	
	button CondenseMaterialIDsButton "Condense Material IDs"
	
	on CondenseMaterialIDsButton pressed do
	(
		sel = selection as array
		for obj in sel where classof obj == Editable_Poly and obj.material != undefined and classof obj.material == MultiMaterial do
		(
			for originalMaterial in obj.material.materialList do
			(
				print (getTextureName originalMaterial)
			)
			materialIDList = obj.material.materialIDList
			materialMap = #()
			append materialMap (findItem materialIDList 1)
			materialList = #(obj.material.materialList[materialMap[1]])
			for i = 2 to materialIDList.count do
			(
				index = (findItem materialIDList i)
				mat = obj.material.materialList[index]
				notFound = true
				newIndex = 0
				for j = 1 to materialList.count while notFound do
				(
					otherMat = materialList[j]
					if collapseBy == "Name" then
					(
						if mat.name == otherMat.name do 
						(
							notFound = false
						)
					)
					else 
					(
						if collapseBy == "TextureName" do
						(
							if (getTextureName mat) == (getTextureName otherMat) do
							(
								notFound = false
							)
						)
					)
					if not notFound do 
					(
						newIndex = j
					)
				)
				if notFound do
				(
					append materialList mat
					newIndex = materialList.count
				)
				append materialMap newIndex;
			)
			print "materialMap {"
			print materialMap
			print "}"
			if materialList.count != obj.material.materialList.count do
			(
				newMat = MultiMaterial numsubs:materialList.count
				materialFaces = #()
				for i = 1 to newMat.materialList.count do
				(
					newMat.materialList[i] = materialList[i]
					newMat.materialIDList[i] = i
					newMat.names[i] = materialList[i].name
					append materialFaces #()
				)
				obj.material = newMat
				for i = 1 to obj.GetNumFaces() do
				(
					oldMaterialID = obj.GetFaceMaterial i
					oldMaterialIndex = findItem materialIDList oldMaterialID
					newMaterialID = materialMap[oldMaterialIndex]
					if oldMaterialID != newMaterialID do
					(
						append materialFaces[newMaterialID] i
					)
				)
				for i = 1 to materialFaces.count where materialFaces[i].count > 0 do
				(
					polyOp.setFaceMatID obj materialFaces[i] i
				)
			)
		)
	)
	
	on CondenseMaterialIDs open do
	(
	)
	on CondenseMaterialIDs close do
	(
	)
)
