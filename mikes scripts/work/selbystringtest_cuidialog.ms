(
global myCui
global SelByString_Floater
global myString
global myObjs = #()


rollout SelByString_Roll "Select by String" width:265 height:38
(
	edittext edt1 "Select by String" pos:[16,8] width:223 height:17
	on edt1 entered text do
	(
			myString = text as string
			for i = 1 to objects.count do(
		
		myName = objects[i].name
		
		myPattern = "*"+myString+"*"
		if matchPattern myName pattern:myPattern == true then (append  myObjs objects[i])
		
		
		)
		
		select myObjs
		)
)

--if SelByString_Floater != undefined then closeRolloutFloater SelByString_Floater
--SelByString_Floater = newRolloutFloater "SelByString" 300 55
			--addRollout SelByString_Roll SelByString_Floater
			createdialog SelByString_Roll
			
)

cui.RegisterDialogBar SelByString_Roll
cui.DockDialogBar SelByString_Roll #cui_dock_top 