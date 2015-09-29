global myDummyArray = #()



for i = 1 to selection.count do(
	myObj = selection[i]
	mydummy = dummy()
	
	myPos = getKnotPoint myObj 1 1
	mydummy.pos = myPos
	myObj.parent = mydummy
	append myDummyArray mydummy
	


)