macroScript CopyMat
	category:"Mikes"
	toolTip:"copy mat of selected Objects"
(
for i = 1 to selection.count do(

	myobj = selection[i]
	myNewMat = copy myobj.mat
	myobj.mat = myNewMat
	myNewMat.name = myNewMat.name + "_Copy"
	--meditmaterials[medit.GetActiveMtlSlot()] = myobj.material
	--myobj.isSelected = true

)

)
