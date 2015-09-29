

if $.mat = multiMaterial
	then
	(
	for i = 1 to $.mat.materialList.count do
		(
		myFalloff = falloff()
		myFalloff.type = 4
		myFalloff.color1 = color 255 255 255
		oldmap = $.mat.materialList[i].diffusemap
		$.mat.materialList[i].diffuseMap = Mix ()
		$.mat.materialList[i].map1 = myFalloff
		$.mat.materialList[i].map2 = oldmap
		print i
		)
	
	)
	else
	(
	myFalloff = falloff()
	myFalloff.type = 4
	myFalloff.color1 = color 255 255 255


	oldmap = $.mat.diffusemap
	$.mat.diffuseMap = Mix ()
	$.mat.diffuseMap.map1 = myFalloff
	$.mat.diffuseMap.map2 = oldmap
	)
	