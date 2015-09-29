macroScript SelLayerObjBySel
	category:"umami"
	toolTip:"Select Layer Objects"
	(
	
	if (selection.count != 1) then (messagebox "you can only have 1 object selected")
else select (for i in objects where i.layer.name == selection[1].layer.name collect i)


	)