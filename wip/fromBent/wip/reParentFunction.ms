--remove controller and reparent

function reParent theObj = (
	myContToDelete = theObj
	theChildren = for i in myContToDelete.children collect i
	if myContToDelete.parent != undefined then myNewParent = myContToDelete.parent
		for i in theChildren do (i.parent = myNewParent)
	
	
)