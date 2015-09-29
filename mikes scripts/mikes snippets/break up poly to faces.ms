--break up a mesh in to quads
--add all the exploded parts in to an array
--go through the array, animate the vertices in location, go to variable time before, animate vert 3 to 1 and 4 to 2



--function to break apart all faces as seperate objects-----------------------------------------------------------------------------
undo on(

for i = 1 to selection.count do (

myobj = selection[i]
convertToPoly selection[i]
myfaces = selection[i].faces.count
myfrags="_fragments_"
myname = myobj.name as string
for i = 1 to myfaces do

	(
	polyOp.detachFaces myobj #(i) delete:false asNode:true name:(myname + myfrags)
	
	)

)
)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------