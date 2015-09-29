

if selByStringRoll != undefined then (destroydialog selByStringRoll)
global myCui
global SelByString_Floater
global myString
global myObjs = #()
global selByStringRoll
mySel
--function SelMyObsFromList

rollout selByStringRoll "Select by String" width:265 height:200
(
	edittext edt1 "Select by String" pos:[16,8] width:223 height:17
	MultilistBox lbx1 "MultiListBox" pos:[10,40] width:240 height:9
	
	
	
	
	on edt1 entered text do
	(
		myObjs = #()
		selByStringRoll.lbx1.items = #()
			myString = text as string
			for i = 1 to objects.count do(
		
		myName = objects[i].name
		
		myPattern = "*"+myString+"*"
		if matchPattern myName pattern:myPattern == true then (append  myObjs objects[i])
		
		
		lbx1.items = for i in myObjs collect i.name
		)
		

		)
		
		on lbx1 selectionEnd  do (
			mySel =  lbx1.selection
			print mySel
			--myItems = for  i in mysel do (
			--select (for i in myobjs[test]
			clearSelection()
			for i in mySel do (
				selectMore myObjs[i]
				)
			
		)
)

--if SelByString_Floater != undefined then closeRolloutFloater SelByString_Floater
--SelByString_Floater = newRolloutFloater "SelByString" 300 55
			--addRollout selByStringRoll SelByString_Floater
			

createdialog selByStringRoll
			


