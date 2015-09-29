myBaseObj = undefined

if replaceBaseRoll != undefined then destroydialog replaceBaseRoll

rollout replaceBaseRoll "Replace Base objects" width:200 height:70
(
	button pckBaseBtn "Pick Base" pos:[9,13] width:69 height:47
	button applyBaseBtn "Apply Base" pos:[98,13] width:69 height:47
	on pckBaseBtn pressed  do(
		try (myBaseObj = selection[1])
		catch() 
		pckBaseBtn.caption = myBaseObj.name
		
	)
	on applyBaseBtn pressed  do(
		undo on
			for i in selection do(
		try(i.baseobject = myBaseObj.baseobject)catch()
				
			)
		
	)
)


createDialog replaceBaseRoll
