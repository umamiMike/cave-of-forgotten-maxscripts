fn findMyBitmaps theName theOb = (
			myInstancesOfBitmapTextures = #()
			for i in selection do (
				
			myInstancesOfBitmapTextures += getClassInstances BitmapTexture target:i
				)
				
			filteredForTheName = for i in myInstancesOfBitmapTextures where  i.name ==  theName collect i.filename --filters for name of map
			return filteredForTheName
)

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

fn findMyFilenames theName = (--returns the filename
			myInstancesOfBitmapTextures = #()
			for i in selection do (
				
			myInstancesOfBitmapTextures += getClassInstances BitmapTexture target:i
				)
				
			filteredForTheName = for i in myInstancesOfBitmapTextures where  i.name ==  theName collect i.filename --filters for name of map
				
			--obsToChange = for i = 1 to selection.count  do (if myShit[i])
		return filteredForTheName
)
fn findMyObs theName = (--returns the filename
			
				--if classof 
				)





theFilenames = findMyFilenames "Opacity"
--theBitmaps = findMyBitmaps "Opacity" $

				for i in selection do (
					findMyBitmaps "Opacity" i
					)