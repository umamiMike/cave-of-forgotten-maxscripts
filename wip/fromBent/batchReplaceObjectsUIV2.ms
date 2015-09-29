if distributeRoll != undefined  then destroydialog distributeRoll

SelSetFromNames = for i in 1 to selectionsets.count collect selectionsets[i].name as string

rollout distributeRoll "Batch Object Replace" width:480 height:250
(
	listbox SelsetListFromList "To Scatter From" pos:[10,10] width:140 Height:12 items:SelSetFromNames
	listbox SelsetListToList "To Scatter To" pos:[330,10] width:140 Height:12 items:SelSetFromNames
	
--	checkbox <name> [ <caption> ] [ checked:<boolean> ] [ triState:<integer> ] [ tooltip:<string> ]
	--checkbox typeOptionsCheckBox "What kind of copy?" 
radiobuttons copy_type  pos:[160,10] width: 60 height: 30 columns:1 labels:#("copy", "instance", "reference")


	
	button makeParentsButton "QUICK make Parents" pos:[160,60] width:130 height:31 
	button replaceChildrenBtn "replaceObs" pos:[160,100] width:130 height:31 tooltip: "deletes the current children of the object"
		button replaceChildrenSelectedBtn "replace selected children" pos:[160,150] width:130 height:31 tooltip: "deletes the current children of the object"
	--button replaceChildrenHBtn "replaceObs" pos:[300,240] width:97 height:31 tooltip: "deletes the current children of the object"
	
	on SelsetListFromList doubleClicked sel do
	(
		select selectionsets[sel]
		SelSetFrom = selectionsets[sel]
		)--end button
		
	
		
	on makeParentsButton pressed do(
		for i in selection do (
			
			myPoint = point Box:on size: 40.0 
				myPoint.pos = i.center
			i.parent = myPoint
		)
		
	)-- end button
	
	on replaceChildrenBtn pressed do(
		undo on(
		
		SelSetFrom = selectionsets[SelsetListFromList.selected]
		SelSetTo= selectionsets[SelsetListToList.selected]
			theType = 	case copy_type.state of (
				1: "Copy "
				2: "Instance "
				3: "Reference " )

		for i in SelSetTo do(
			myOb = execute(theType + " SelSetFrom[random 1 SelSetFrom.count]")
			delete i.children
			myOb.transform = i.transform
			myOb.parent = i
			)
		)--end undo
			)--end button
		
		on replaceChildrenSelectedBtn pressed do(
		undo on(
		
		SelSetFrom = selectionsets[SelsetListFromList.selected]
		SelSetTo= selection as array
			theType = 	case copy_type.state of (
				1: "Copy "
				2: "Instance "
				3: "Reference " )

		for i in SelSetTo do(
			myOb = execute(theType + " SelSetFrom[random 1 SelSetFrom.count]")
			delete i.children
			myOb.transform = i.transform
			myOb.parent = i
			select myOb
			)
		)--end undo
			)--end button
-- 			on replaceChildrenHBtn pressed do(
-- 				
-- 		undo on(
-- 		
-- 		SelSetFrom = selectionsets[SelsetListFromList.selected]
-- 		myNodeArrays = #()
-- 		for i in SelSetFrom do(
-- 		
-- 			maxOps.CloneNodes myPickedObjs newNodes:&new
-- 			append myNodeArrays new
-- 			
-- 			)--end mSelSetFrom
-- 			
-- 			for i in selection do(
-- 				
-- 				
-- 			)--end scattering
-- 		)--end undo
-- 			)--end button

	
		)

createDialog distributeRoll