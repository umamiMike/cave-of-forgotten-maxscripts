fn deleteModByName obj modNameString = (
 if obj.modifiers[modNameString] != undefined do (	deleteModifier obj obj.modifiers[modNameString])
	
)
	
fn quickDisappear obj =  (
	
	myMod = xform name:"quickDisappear"
	addModifier obj myMod
	myMod.gizmo.position = [9999,9999,9999]
)