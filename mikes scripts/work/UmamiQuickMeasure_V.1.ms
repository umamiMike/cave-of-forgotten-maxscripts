--make a display floater that shows the real world units of a selection of objects.  Does some unit conversion and gives me back a measurement in the current unit system
for i in selection do (
	myX = convertThePos i 1
	myY = convertThePos i 2
	myZ = convertThePos i 3
	
	myPos = [myX,myY,myZ]
	
)


fn convertThePos myOb posIndex = (
	
	myOb.pos[posIndex]