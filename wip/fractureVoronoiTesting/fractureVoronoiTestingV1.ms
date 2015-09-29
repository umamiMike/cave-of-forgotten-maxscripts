nbParts = 30
obj = $


	
					aPartsTemp = for i = 1 to nbParts collect copy obj
					pSys = pcloud emitter:obj formation:3 total_number:nbParts quantityMethod:1 viewPercent:100 seed:(random 0 100)
					aCoords = for i = 1 to nbParts collect particlePos pSys i	-- fill with random coordinates
					delete pSys
					for i = 1 to nbParts - 1 do for j = i + 1 to nbParts while not abortBreaking do	-- for each pair of coords
					(
						thePlane.pos = (aCoords[i] + aCoords[j]) / 2
						thePlane.dir = aCoords[j] - aCoords[i]
						
						addModifier aPartsTemp[i] (sliceModifier slice_type:2)
						addModifier aPartsTemp[j] (sliceModifier slice_type:3)
						aPartsTemp[i].slice.slice_plane.transform = thePlane.transform
						aPartsTemp[j].slice.slice_plane.transform = thePlane.transform
						addModifier aPartsTemp[i] (cap_holes())
						addModifier aPartsTemp[j] (cap_holes())
						convertToMesh aPartsTemp[i]
						convertToMesh aPartsTemp[j]
						
						if keyboard.escPressed do abortBreaking = queryBox "Do you want to abort and delete already created parts?"
					)	-- end i loop
					aPartsEnd += aPartsTemp
					aAllParts += aPartsTemp
					aAllCoords += aCoords
					
					total = nbParts * ((nbParts^nbIter - 1) / (nbParts - 1))
					prog = 100 * aAllParts.count / total
					pbProgress.value = prog
					pbProgress.color = [200 - prog * 2,prog * 2,0]
		