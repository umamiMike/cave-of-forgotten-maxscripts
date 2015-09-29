	myPoint = Point()
	myPoint.pos = $.center
	myPoint.Box = on
	myPoint.name = maxFileName +"parent"
	
	for i in objects where i.parent == undefined and i != myPoint do (i.parent = myPoint)
	
	select myPoint