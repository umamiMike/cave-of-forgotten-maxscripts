
--loop through every selected ham.
	--make a copy of the masterham
	--copy the original diffusechannel
	-- assign the copy of masterham to the object


	
for i in selection do (
	
	oldHamMat = i.material
	localHamMat = copy $masterham.material
	localHamMat.texmap_diffuse = oldHamMat.diffusemap
	localHamMat.name = i.name+"Material"
	i.material = localHamMat
	
	
)
	
