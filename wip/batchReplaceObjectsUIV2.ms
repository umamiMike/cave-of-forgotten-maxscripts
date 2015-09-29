if distributeRoll != undefined  then destroydialog distributeRoll

SelSetFromNames = for i in 1 to selectionsets.count collect selectionsets[i].name as string

rollout distributeRoll "quick selectionSet" width:300 height:400
(
	multilistbox SelsetListFromList "Selection Sets" pos:[10,10] width:280 Height:25 items:SelSetFromNames
	button refreshSelSetBtn "Refresh" pos:[20,370]
	on SelsetListFromList doubleClicked sel do
	(
		clearSelection()
		for i in SelsetListFromList.selection do (

		--print selection
		selectmore selectionsets[i]
		--SelSetFrom = selectionsets[sel]
		)
			
			)
			
	on refreshSelSetBtn pressed do(
		
			SelSetListFromList.items = collect (for i in 1 to selectionsets.count collect selectionsets[i].name as string)
			
	)--end button
		
		

		)

createDialog distributeRoll