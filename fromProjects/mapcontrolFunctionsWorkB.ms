
 
 fn subFromArray array1 array2 = (
	-- this will subtract all items from array2 which exist in array1
	tempArray = deepcopy array2
		for i in array1 do(
			v =  findItem tempArray i
			while v != 0 do (
			deleteItem	tempArray v
			v =  findItem tempArray i
				
			)
			
		)
		return tempArray
	
)

fn makeInstanceArray  = (
	
	 mySel = selection as Array
	groupsOfObs = #()
	while mySel.count != 0 do (
		
		 myFilename = mySel[1].material.texmap_opacity.filename
 
		filteredObs = for i in selection where i.material.texmap_opacity.filename  == myFilename  collect i
		append groupsOfObs filteredObs
		mySel = subFromArray filteredObs mySel
		
	)
	
	return groupsOfObs
	)
	
	
	fn makeInstancesOfMats = (
	myInstances = makeInstanceArray()
	
	for i in myInstances do (
		
		myMat = copy i[1].material
		for o in i do (o.material = myMat)
		
		
	)
	
	free myInstances
	
)