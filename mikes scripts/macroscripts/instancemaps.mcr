MacroScript InstanceMaterial category:"Mikes" tooltip:"InstanceMaterial" buttonText:"InstanceMat" 
(
	iMat = medit.getCurMtl()
	if ((classOf iMat) == Standardmaterial) then
	(
		inst = 0
		allObj = objects as array
		for o=1 to allObj.count do
		(
			oMat = allObj[o].material
			oMatClass = classOf oMat
			if oMatClass == standardMaterial do
			(
				if ((oMat != iMat) and (oMat.name == iMat.name)) then 
				(
					allObj[o].material = iMat
					inst += 1
				)
			)
			if oMatClass == multiMaterial do
			(
				for m=1 to oMat.count do
				(
					if (classof oMat[m]) == standardMaterial do
					(
						if ((oMat[m] != iMat) and (oMat[m].name == iMat.name)) then 
						(
							allObj[o].material[m] = iMat
							inst += 1
						)
					)
				)
			)
		)
		messagebox ((inst as string) + " material(s) instanced!") title:"Info"
	)
	else if ((classOf iMat) == multiMaterial) then
	(
		matCount = iMat.count
		for mm = 1 to matCount do
		(
			subMat = iMat[mm]
			inst = 0
			allObj = objects as array
			for o=1 to allObj.count do
			(
				oMat = allObj[o].material
				oMatClass = classOf oMat
				if oMatClass == standardMaterial do
				(
					if ((oMat != subMat) and (oMat.name == subMat.name)) then 
					(
						allObj[o].material = subMat
						inst += 1
					)
				)
				if oMatClass == multiMaterial do
				(
					for m=1 to oMat.count do
					(
						if (classof oMat[m]) == standardMaterial do
						(
							if ((oMat[m] != subMat) and (oMat[m].name == subMat.name)) then 
							(
								allObj[o].material[m] = subMat
								inst += 1
							)
						)
					)
				)
			)
		)
		messagebox ((inst as string) + " material(s) instanced!") title:"Info"
	)
)