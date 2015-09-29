--make routine for finding the max value in the min array and the max array and adding THOSE together

mydummy = point()
	mydummy.name = edt1.text
	mydummy.Box = on
	mydummy.pos = selection.center
	mydummy.size = 100.0
	for i = 1 to selection.count do 
	(
	if selection[i].parent == undefined then (selection[i].parent = mydummy)
	
	)
	mydummy.isSelected = true
