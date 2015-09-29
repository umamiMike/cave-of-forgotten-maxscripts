myName = "cupCakeParent"
theSelArray = #()

undo on
(
	myPoint = point box:true size:352.0 name:myName
	myPoint.pos = selection.center
for i in selection do(
	
i.parent = myPoint
	
	append theSelArray myPoint
	
)

select myPoint
)
	
--if selectionSets[myName] != undefined then selectionSets[myName] = theSelArray