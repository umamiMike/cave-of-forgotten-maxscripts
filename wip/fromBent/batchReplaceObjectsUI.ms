if distributeRoll != undefined  then destroydialog distributeRoll

mySelSetNames = for i in 1 to selectionsets.count collect selectionsets[i].name as string

rollout distributeRoll "modifier controller" width:480 height:329
(
	listbox selStLb "selectionSets" pos:[10,11] width:185 height:12 items:mySelSetNames
	button makeParentsButton "QUICK make Parents" pos:[300,200] width:97 height:31 
	button replaceChildrenBtn "replaceObs" pos:[300,240] width:97 height:31 tooltip: "deletes the current children of the object"
	--button replaceChildrenHBtn "replaceObs" pos:[300,240] width:97 height:31 tooltip: "deletes the current children of the object"
	
	on selStLb doubleClicked sel do
	(
		select selectionsets[sel]
		mySelSet = selectionsets[sel]
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
		
		mySelSet = selectionsets[selStLb.selected]
		for i in selection do(
			myOb = copy mySelSet[random 1 mySelset.count]
			delete i.children
			myOb.pos = i.center
			myOb.rotation = i.rotation
			myOb.parent = i
			)
		)--end undo
			)--end button
		
-- 			on replaceChildrenHBtn pressed do(
-- 				
-- 		undo on(
-- 		
-- 		mySelSet = selectionsets[selStLb.selected]
-- 		myNodeArrays = #()
-- 		for i in mySelSet do(
-- 		
-- 			maxOps.CloneNodes myPickedObjs newNodes:&new
-- 			append myNodeArrays new
-- 			
-- 			)--end mmySelSet
-- 			
-- 			for i in selection do(
-- 				
-- 				
-- 			)--end scattering
-- 		)--end undo
-- 			)--end button

	
		)

createDialog distributeRoll