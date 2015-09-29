fn findInstances theOb theClass = (--finds a certain map of a certain name in an objects material
	--theBitmap = findMyBitMaps $ "mask" bitmaptexture
			myShit = #()
		myShit += getClassInstances theClass target:theOb
	--print myShit
	--	for i in myShit where  i.name ==  theName do (return i)--filters for name of map
return myShit
)

fn collectAllNoisesInScene  = ( -- returns an array of noiseControllers
allNoises = #()
 for o in objects do (me = findInstances o Noise_position
	 for i in me do (
	append allNoises i
	 )
	)
return allNoises
)


fn collectAllPosXYZsInScene  = ( -- returns an array of noiseControllers
allNoises = #()
 for o in objects do (me = findInstances o Position_XYZ
	 for i in me do (
	append allNoises i
	 )
	)
return allNoises
)