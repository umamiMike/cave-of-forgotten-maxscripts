global myProp

function adjustMe prop hilo = (
	if hasProperty 
	myProp = getProperty $ prop
	flRan = hilo as float
	myRan = random -flRan flRan
	return myRan
	)

if $ != undefined then adjustMe "thickness" 6
	
	function toDispUnits x y z = (
		
		units.formatValue x
		units.formatValue y
		units.formatValue z

	)
	
	toDispUnits 100 120 563