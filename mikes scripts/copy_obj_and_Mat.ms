macroScript CopyObjectandMat
	category:"Mikes"
	toolTip:"copy object and mat"
(
	myobj = copy $
	myobj.mat = copy $.mat
	myobj.mat.name = $.mat.name + "_Copy"
	meditmaterials[medit.GetActiveMtlSlot()] = myobj.material
	myobj.isSelected = true
)
