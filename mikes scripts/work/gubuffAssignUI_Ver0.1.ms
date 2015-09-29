global testObRoll
global changeIDRoll
global myObj
if testObRoll != undefined then destroyDialog testObRoll
myItemNames = for i in objects where i.gbufferchannel == 0  and i.ishidden == false collect i.name

rollout testObRoll "Test Objects Rollout" width:377 height:300
(
	listBox lbx1 "ListBox" pos:[12,8] width:356 height:8 items:myItemNames

	on lbx1 doubleclicked itm do (
		
		
		myObj = getNodeByName lbx1.selected
		
		select myObj
		createDialog changeIdRoll
		
		
	)
	
	
)

rollout changeIdRoll "Change The ID" width:224 height:48
(
	spinner spn2 "whatever" pos:[14,15] width:191 height:16 range:[0,100,0] type:#integer scale:0.1
	
	on changeIdRoll open do
	(spn2.value = myObj.gbufferchannel
		spn2.caption = myObj.name)
	on changeIdRoll close do (
		testObRoll.lbx1.items = for i in objects where i.gbufferchannel == 0  and i.ishidden == false collect i.name
		
		
	)
	
	on spn2 changed val do
		myObj.gbufferchannel = spn2.value

)
	

createDialog testObRoll