myBaseObj = undefined

if replaceBaseRoll != undefined then destroydialog replaceBaseRoll

rollout replaceBaseRoll "Replace Base objects" width:200 height:224
(
	button pckBaseBtn "Pick Base" pos:[9,13] width:69 height:47
	button applyBaseBtn "Apply Base" pos:[118,12] width:69 height:47
	checkbox wirecolorChk "wirecolor" pos:[22,100] width:74 height:18 checked:true
	checkbox matChk "Material" pos:[21,122] width:74 height:18 checked:true
	groupBox grp1 "Copy property?" pos:[11,79] width:168 height:71
	on pckBaseBtn pressed do
	(
			try (myBaseObj = selection[1])
			catch() 
			pckBaseBtn.caption = myBaseObj.name
			
		)
	on applyBaseBtn pressed do
	(
			undo on
				for i in selection do(
			try(i.baseobject = myBaseObj.baseobject
				if wirecolorChk.checked == true do ( i.wirecolor = myBaseObj.wirecolor)
				if matChk.checked == true do (i.material = myBaseObj.material)
				
				)catch()
					
				)
			
		)
)


createDialog replaceBaseRoll
