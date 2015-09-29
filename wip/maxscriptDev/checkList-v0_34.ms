--******************************************************************************
--*  Check List 0.34                 for Max 4.2                               *
--*  by Ofer Zelichover (c) 12/2001                                            *
--*  www.tdp.nu/ofer   ;   ofer_z@hotmail.com                                  *
--*                                                                            *
--*  based on idea by Jeremy Pearson                                           *
--******************************************************************************
--*  You may use this script freely as you see fit.                            *
--*  You may use parts or the script as a whole in your own scripts.           *
--*  (it would be nice if you give me a credit if you do so ;))                *
--******************************************************************************
--*  This script comes with no waranty!                                        *
--*  Although I tried this script and couldn't find any problems with it, I can*
--*  in no way be held responsible for any kind of loss or damage, whether     *
--*  direct or indirect, due to the use of this script.                        *
--*                                                                            *
--*  ********************************************************************      *
--*  *** IF YOU DON'T LIKE THE ABOVE STATEMENT, DON'T USE THIS SCRIPT ***      *
--*  ********************************************************************      *
--*                                                                            *
--*  **** This script was written for max 4.2 and wasn't tested on other ****  *
--*  **** versions of max.                                               ****  *
--*                                                                            *
--*  If you find any bugs in this script, please let me know.                  *
--******************************************************************************
--* Description                                                                *
--* -------------                                                              *
--* Creates a "todo" check list that saves with the max scene.                 *
--*                                                                            *
--******************************************************************************
--* History, Status and Known issues                                           *
--* ----------------------------------                                         *
--* created : 20/12/2001                                                       *
--* update: 21/12/2001 ver 0.2                                                 *
--*   - fixed major scope bugs that wouldn't start the script.                 *
--* update: 21/12/2001 ver 0.3                                                 *
--*   - added edit and multiple delete items features.                         *
--* update: 21/12/2001 ver 0.31                                                *
--*   - major change: no more sturct usage (it can't be saved as persistent    *
--*     global), from here on just an array of arrays.                         *
--* update: 21/12/2001 ver 0.32                                                *
--*   - fixed a bug that caused an error when checking/unchecking the check box*
--* update: 09/01/2002 ver 0.34                                                *
--*   - fixed a bug that didn't erase the list when openning a new file. by    *
--*     adding some callbacks.                                                 *
--*     thanks to Mathieu Huet for sending that bug.                           *
--*                                                                            *
--* Known issues:                                                              *
--*  this is a W.I.P more fault checking and features are needed.              *
--*                                                                            *
--*Need to add:                                                                *
--*                                                                            *
--******************************************************************************
--* Isntallation:                                                              *
--* --------------                                                             *
--*    put:                                                                    *
--*        checkList-v0_34.ms          - anywhere                              *
--*                                                                            *
--*   after you run the script you will find it in the customize user interface*
--*   under "Os Tools" category.                                               *
--*                                                                            *
--******************************************************************************


macroScript checkList
	category:"Os Tools"
	tooltip:"Check List 0.34"
	buttontext:"CheckList"
(
-- Global variables declerations
---------------------------------
	global checkListFloater
	persistent global checkListItems

	
-- Local variables declerations
---------------------------------
	global checkList 
	local checkListControl	

-- rollout declerations
--------------------------
	rollout editCheckListItems "Edit Items" 
	(		
		listBox edList ""
		edittext edEditLine ""
		button edOK "OK" width:80 across:2
		button edCancel "Cancel" width:80
		
		on editCheckListItems open do (
			edList.items = for i in checkListItems collect i[1]
			edList.selection = 0
		)
		
		on edList selected value do (
			edEditLine.text = edList.items[value]
		)
		
		on edEditLine changed value do (
			local tmpArr = edList.items
			tmpArr[edList.selection] = value
			edList.items = tmpArr
		)
		on edEditLine entered value do (
			local tmpArr = edList.items
			tmpArr[edList.selection] = value
			edList.items = tmpArr
		)
		
		on edOK pressed do (
			for i = 1 to checkListItems.count do
				checkListItems[i][1] = edList.items[i]
			destroyDialog editCheckListItems
		)

		on edCancel pressed do (
			destroyDialog editCheckListItems
		)		
	)-- end editCheckListItems rollout

--------------------------------------------------------------------------

	rollout delCheckListItems "Delete Items" 
	(
		label delLbl01 "Select the items to delete." align:#center
		label delLbl02 "You can select multiple items" align:#center
		label delLbl03 "using then CTRL key" align:#center
		multilistBox delList ""
		button delOK "Delete" width:80 across:2
		button delCancel "Cancel" width:80
		
		on delCheckListItems open do (
			delList.items = for i in checkListItems collect i[1]
			delList.selection = #{}
		)

		on delOK pressed do (
			for i = checkListItems.count to 1 by -1 where (delList.selection[i]) do
				deleteItem checkListItems i
			destroyDialog delCheckListItems
		)

		on delCancel pressed do (
			destroyDialog delCheckListItems
		)		
	)-- end delCheckListItems rollout

--------------------------------------------------------------------------

	rollout checkListControl ""
	(
	
	-- checkListControl GUI
	-----------------------------
		button clAdd "Add Item" width:80 across:3
		button clEdit "Edit Items" width:80 
		button clDel "Delete Items" width:80
		button clClose "Close" width:244
		
	-- checkListControl functions
	------------------------------------
		fn createCheckListRollout = (
			execStr = "rollout checkList \"Items\" \n"
			execStr += "( \n"
			for i = 1 to checkListItems.count do (
				local txt = try(checkListItems[i][1])catch("")
				local stat = try(checkListItems[i][2] as string)catch("false") 
				execStr += "\tcheckbox clItem_" + i as string + " \"" + txt + "\" checked:" + stat + " \n"
				execStr += "\ton clItem_" + i as string + " changed state do checkListItems[" + i as string + "][2]=state \n"
			)
			execStr += ") \n"
			execute execStr
		) -- end create check list rollout fn

		fn inputTextBox &val title:"Enter Text" txt:"" = (
			global returnVal
			global inputTextBoxRO
			global tmpVal
			local textStr = filterString txt "\n\r"
			
			-- define the rollout
			execStr = "rollout inputTextBoxRO \"" + title + "\" (\n"
			for i = 1 to textStr.count do
				execStr += "\tlabel lbl_" + i as string + " \"" + textStr[i] + "\" align:#left\n"
			execStr += "\tedittext textVal \"\" text:\"" + val as string + "\" offset:[0,5] align:#center\n"
			execStr += "\tbutton bnOK \"OK\" width:70 across:2 offset:[0,10] align:#center\n"
			execStr += "\tbutton bnCancel \"Cancel\" width:70 offset:[0,10] align:#center\n\n"
			execStr += "\ton bnOK pressed do (\n"
			execStr += "\t\ttmpVal=textVal.text\n"
			execStr += "\t\treturnVal = true\n"
			execStr += "\t\ttry (destroyDialog inputTextBoxRO)catch()\n"
			execStr += "\t)\n"
			execStr += "\ton bnCancel pressed do (\n"
			execStr += "\t\treturnVal = false\n"
			execStr += "\t\ttry (destroyDialog inputTextBoxRO)catch()\n"
			execStr += "\t)\n"
			execStr += ")"
	
			execute execStr
	
			local windowWidth = amax (for i in textStr collect (getTextExtent i)[1] as integer)
			if (windowWidth+=30)<180 then windowWidth = 180
			try (destroyDialog inputTextBoxRO)catch()
			createDialog inputTextBoxRO width:windowWidth modal:true
	
			if returnVal then val = tmpVal
			returnVal
		)
	
		fn updateGUI = (
			try(removeRollout checkList checkListFloater)catch()
			try(removeRollout checkListControl checkListFloater)catch()
			createCheckListRollout()
			addRollout checkList checkListFloater
			addRollout checkListControl checkListFloater
		)
		
		fn addListItem = (
			local itemText = ""
			if (inputTextBox &itemText title:"Add New Item" txt:"Enter item text:") then (
				if itemText=="" then itemText = ("Task number "+(checkListItems.count+1) as string)
				append checkListItems #(itemText, false)
				updateGUI()
			)
		)
		
		fn editListItems = (
			createDialog editCheckListItems width:200 modal:true
			updateGUI()
		)
		
		fn delListItem = (
			createDialog delCheckListItems width:200 modal:true
			updateGUI()
		)
		
		fn done = (
			try(destroyDialog editCheckListItems)catch()
			try(removeRollout checkList checkListFloater)catch()
			try(removeRollout checkListControl checkListFloater)catch()
			try(closeRolloutFloater checkListFloater)catch()
		)
	
	-- checkListControl event handlers
	------------------------------------
		on clAdd pressed do addListItem()
		on clEdit pressed do editListItems()
		on clDel pressed do delListItem()
		on clClose pressed do done()
		
	)-- end rollout checkListControl
-----------------------------------------------------------------

-- macro script functions
---------------------------
-- create callbacks
	fn createCallbacks = (
		callbacks.addScript #filePreOpen "persistents.remove #checkListItems;checkListItems=undefined" id:#checkListCallbacks persistent:true
		callbacks.addScript #systemPreNew "persistents.remove #checkListItems;checkListItems=undefined" id:#checkListCallbacks persistent:true
		callbacks.addScript #systemPreReset "persistents.remove #checkListItems;checkListItems=undefined" id:#checkListCallbacks persistent:true
	)	
	
-- delete callbacks
	fn deleteCallbacks = (
		try(callbacks.removeScripts id:#checkListCallbacks)catch()
	)
	
-- initialize macroScript
--------------------------
	on execute do (
		deleteCallbacks()
		createCallbacks()
		persistent global checkListItems
		if checkListItems == undefined then checkListItems = #()
		try(closeRolloutFloater checkListFloater)catch()
		checkListControl.createCheckListRollout()
		checkListFloater = newRolloutFloater "Check List 0.34" 300 300
		addRollout checkList checkListFloater
		addRollout checkListControl checkListFloater
	)	

)-- end macroScript