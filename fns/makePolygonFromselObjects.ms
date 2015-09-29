selObjArray = selection as array

myVerts = #()
for i in selection do(
	myVert = polyOp.createVert myPoly i.pos
	append myVerts myVert

	)

polyOp.createPolygon myPoly myVerts