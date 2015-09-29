
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

resultantArray = subtractFromArray array1 array2