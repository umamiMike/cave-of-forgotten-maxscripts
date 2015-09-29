function getVolBBox obj =
	(
		local vMin = obj.min
		local vMax = obj.max
	
		local fX = vMax.x - vMin.x
		local fY = vMax.y - vMin.y
		local fZ = vMax.z - vMin.z
	
		( fX * fY * fZ )
	)
	
	
	
	function getbboxValues obj =
	(
		local vMin = obj.min
		local vMax = obj.max
	
		local fX = vMax.x - vMin.x
		local fY = vMax.y - vMin.y
		local fZ = vMax.z - vMin.z
	
		return [fx,fy,fz]
	)
	
	
	function getVolAndCOM obj = 
	( 
		Volume= 0.0 
		Center= [0.0, 0.0, 0.0] 
		
		theMesh = snapshotasmesh obj
		numFaces = theMesh.numfaces 
		
		for i = 1 to numFaces do 
		( 	
			Face= getFace theMesh i 			
			vert2 = getVert theMesh Face.z 		
			vert1 = getVert theMesh Face.y 		
			vert0 = getVert theMesh Face.x 		
			dV = Dot (Cross (vert1 - vert0) (vert2 - vert0)) vert0		
			Volume+= dV 		
			Center+= (vert0 + vert1 + vert2) * dV 	
		) 
		
		delete theMesh
		Volume /= 6 
		Center /= 24 
		Center /= Volume 
		
		#(Volume,Center) 
	)	
	
	