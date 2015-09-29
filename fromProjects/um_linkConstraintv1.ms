--$.transform.controller.AddTarget $'Box001 parent001' 90f


--global expose
parentArray = #()
--rollout crap
if linkConRoll != undefined do (destroydialog linkConRoll)

myController = link_constraint()

fn makeLinkConstraint obj = 
	
(
	obj.transform.controller = Link_Constraint 
	
)

fn addSelectionAsTargets obj = ()

fn alignInSequence obj =  (
	increment = linkConRoll.frameSpn.value
	for i = 1 to parentArray.count do (
		parentObj = parentArray[i]
		Animate on 
		(
			at time (currentTime + (increment * i)) obj.transform = parentObj.transform
			
		)--end animate
	) --end for
		
		
	
	)
	
fn deleteAllTargets obj = (--deletes all targets in a linkConstraint controller
	--
	while obj.transform.controller.getNumTargets() != 0 do
	(

		num = obj.transform.controller.getNumTargets()
		obj.transform.controller.DeleteTarget num
		
	)--end while
)--end fn
	


rollout linkConRoll "Untitled" width:246 height:139
(
	button btn1 "Do it" pos:[157,6] width:60 height:16 tooltip: "usage:  hit pick parents in whatever order you desire.  It will add a parent link and offset by the number of frames in the spinner"
	button btn2 "pick parents" pos:[106,28] width:60 height:16
	spinner frameSpn "" pos:[106,6] width:46 height:16 range:[0,1000,30] type:#integer
	label lbl1 "increment frames" pos:[11,7] width:90 height:19
	
	on btn1 pressed do (
		if classof selection[1] .transform.controller != Link_Constraint then (selection[1].transform.controller = Link_Constraint() )
		else (
				for i = 1 to parentArray.count do (selection[1].transform.controller.AddTarget parentArray[i] (currentTime + (frameSpn.value * i))
				)--end for
		)--end else
	)--end btn1 pressed
	
	
		on btn2 pressed do (
			
			parentArray = pickObject  rubberBand:selection[1].pos  count:#multiple forceListenerFocus:false
	
		)

	
	
)--end roll



createdialog linkconroll