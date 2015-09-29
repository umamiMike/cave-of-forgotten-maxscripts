/*
Name: 'PEN_Attribute_Holder 2'

Created By: Paul Neale
Company: PEN Productions Inc.
E-Mail: pen_productions@yahoo.com
Start Date: Jan 21 2002
Purpose:For storing CA's and saveing presets for them.
Max version 8x

Disclaimer:
This script has not been fully tested. Use at your own risk.
Any damage caused by this script is not the responsibility of the author or PEN Productions.

Usage:
	-Place this script in the scripts/startup dir and restart Max.
	-The modifier "PEN_Attribute_Holder 2" will show up in the modifier drop down list.
	-Add the modifier to any object in Max and add CA's to this modifier.
	-"Key All" button will key all CA's that have been added to the modifier but only if the animate button is turned on.
	-"Reset All" button will reset all CA's to the value of 0.
	-To add a preset for the CA's Add a new name to the "Name" field and press the "Add" button.
	-To apply a preset to the CA's select the desired preset from the "Presets" drop down list.
	-You can also save, load and merge presets for use on other "PEN_Attribute_Holder 2" modifiers.
 
Updated:
	July 04 2002
	-Updated to Max5
	-Repaired bug in Presets when there were more then 20 CA's.
	-Updated Author Rollout.
	Sept. 24 2002 Ver:2.01
	-Added copy and paste buttons.
	Nov 17 2002 V:2.02
	-Updated to work with any number of Ca Definitions
	-It is no longer name dependant.
	-Duplicate names can't be used.
	Nov 19 2003 V:2.04
	-Added fn for opening rollouts outside of modifier
	-Removed Author rollout and replaced it with a menu.
	-Moved Add/Delete/Save/Load/Merge buttons to menu.
	-Rearranged interface again to keep it small.
	January 06 2004 V:2.05
	-Fixed bug when deleting a preset and the drop down list would show blank. 
	August 11 2005 V:2.06 !!!This is a Max 8 version only. 
	-Larry fixed a bug that was allowing the menu system to work. There was a code fix so a change had to be
		made in the way that it was called. 
	
Bugs:

ToDo:
	-Sort presets a-z
	-Support for all Ca's
	-Move name field to floating window to make the interface more compact.

*/
global PENCopyPaste_vr = #()

plugin modifier 'PEN_Attribute_Holder 2'
	name:"PEN_Attribute_Holder 2"
	classID:#(0x9004a801, 0xa7617106)
	version:2
(
	--Locals
	local Names = #(), Values = #(), updatePresets_fn, presets_R
	
	parameters control_P 
	(
		presetName_str type:#stringTab tabSize:0 tabSizeVariable:true
		preset_str type:#stringTab tabSize:0 tabSizeVariable:true
	)
	parameters optionsP rollout:presets_R
	(
		rampOn type:#boolean ui:rampOn_Cb default:true animatable:false
	)
	
	----------------------------------------------Get the Ca deffinitions
	Fn getCaAttributes_fn =
	(
		caDefs = #()
		caSubs = #()
		
		--Get the Defs
		caNum = (custAttributes.count this)
		for x = 1 to caNum do
		(
			append caDefs (custAttributes.get this x)
		)
		
		--Get the Ca's in the Defs
		for x = 1 to cadefs.count do
		(
			for y = 1 to caDefs[x].numsubs do
			(
				append caSubs caDefs[x][y]
			)
		)
		caSubs
	)
		
	-------------------------------------------------------writePreset
	FN addPreset_fn =
	(
		local presetName = presets_R.presetName_et.text
		local ss = stringStream ""
		
		if presetName != "" do
		(
			ca = getCaAttributes_fn()
			format "%" "#(" to:ss
			for x = 1 to ca.count do
			(
				format "%" ca[x].value to:ss
				format "%" (if x == ca.count then (")")else (",")) to:ss
			)
			append presetName_str presetName 
			append preset_str (ss as string)
		)
		presets_R.presetName_et.text = ""
		updatePresets_fn()
--		print presetName_str
--		print preset_str
	)-- end writePreset_fn
	
	-----------------------------------------------------deletes a preset
	FN deletePreset_fn delNum =
	(
		CNTobj = (refs.dependents this)[1]
		
		deleteItem presetName_str delNum
		deleteItem preset_str delNum
		
		updatePresets_fn()
	)--end deletePreset_fn

	------------------------------------------------------saves presets to file
	FN savePre_fn =
	(
		fileName = getsavefileName caption:"Save Presets to:" filename:(this.name + ".cps")\
			types:"Character Presets Store          .cps|*.cps|All          *.*|*.*|"
	
		if fileName != undefined do							--Check for path
		(
			savedFile = createFile fileName					--Create the file
			close savedFile
			openedFile = openFile fileName mode:"a"
			
			for x = 1 to presetName_str.count do						--Format data to file
			(
				format "%" "**Name> " to:openedFile
				format "%%%\n" "\"" presetName_str[x] "\"" to:openedFile
				format "%" "**Value> " to:openedFile
				format "%%%\n" "\"" preset_str[x] "\"" to:openedFile
			)
			close openedFile
		)
		
	)-- end savePre_fn

	-----------------------------------------------------load presets
	FN loadPre_fn =
	(
		presetName_str = #()
		preset_str = #()
		
		fileName = getopenfileName caption:"Load Presets:" \
			types:"Character Presets Store          .cps|*.cps|All          *.*|*.*|"
		
		if fileName != undefined do
		(
			openedFile = openFile fileName mode:"r"
			while (not (eof openedFile)) do
			(
				str = (readLine openedFile)
				if (filterString str ">")[1] == "**Name" do
				(
					append presetName_str (filterString str ">\" ")[2]
				)
				if (filterString str ">")[1] == "**Value" do
				(
					append preset_str (filterString str ">\" ")[2]
				)
			)
--			print presetName_str
--			print preset_str
			close openedFile
			
			updatePresets_fn()
		)
		
	)-- end loadPre_fn

	--------------------------------------------------------merge presets
	FN mergePre_fn =
	(
		fileName = getopenfileName caption:"Merge Presets:" \
			types:"Character Presets Store          .cps|*.cps|All          *.*|*.*|"
		
		if fileName != undefined do
		(
			openedFile = openFile fileName mode:"r"
			while (not (eof openedFile)) do
			(
				str = (readLine openedFile)
				if (filterString str ">")[1] == "**Name" do
				(
					append presetName_str (filterString str ">\" ")[2]
				)
				if (filterString str ">")[1] == "**Value" do
				(
					append preset_str (filterString str ">\" ")[2]
				)
			)
--			print presetName_str
--			print preset_str
			close openedFile
			
			updatePresets_fn()
		)
	
	)--end mergePre_fn

	-----------------------------------------------------upper case function
	Fn uppercase_fn inStr =
	(
		local upper, lower, outStr
		Upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		lower = "abcdefghijklmnopqrstuvwxyz" 		
		outStr = inStr
		for i = 1 to outStr.count do
		(
			j = findString lower outStr[i]
			if j != undefined do
			(
				outStr[i] = upper[j]
			)
		)
		outStr
	)
	
	------------------------------------------------Check for duplicate names
	Fn dupNameCheck_fn inStr =
	(
		isDup = false
		for x in presetName_str do
		(
			if (uppercase_fn x) == (uppercase_fn inStr) do
			(
				isDup = true
				exit loop
			)
		)
		if isDup == false then 
		(
			addPreset_fn()
		)else
		(
			messageBox "Duplicate Name has been entered" Title:"Error"
		)
	)

	-------------------------------------------------------- updates preset info
	FN updatePresets_fn =									
	(
		presetName_ar = #()
		for x in presetName_str do (append presetName_ar x)
		presets_R.presets_ddl.items = presetName_ar
		presets_R.presets_ddl.selection=1
	)--end updatePresets_fn 
	
	--Menus
	fn menus =
	(
		rcMenu menuBar
		(
			local modInst --Local instance of the scripted modifier
			--menuItem clearPresets "Clear Presets"
			menuItem addPreset "Add Preset"
			menuItem deletePreset "Delete Selected Preset"
			menuItem clearPresets "Delete All Presets"
			menuItem savePreset "Save Presets"
			menuItem loadPreset "Load Presets"
			menuItem mergePreset "Merge Presets"
			
			seperator sep02
			
			subMenu "Help"
			(
				menuItem help "Help!"
				menuItem email "Email Author"
				seperator helpSep01 
				menuItem version "Author/Version Number..."
			)
			on addPreset picked do
			(
				modInst.dupNameCheck_fn modInst.presets_R.presetName_et.text
			)
			on deletePreset picked do
			(
				if queryBox "Do you want to delete the selected preset?" then
				(
					delNum = modInst.presets_R.presets_ddl.selection
					try(modInst.deletePreset_fn delNum)catch()
				)
			)
			on clearPresets picked do
			(
				if queryBox "Do you want to delete all the presets?" then
				(
					modInst.presetName_str = #()
					modInst.preset_str = #()
					modInst.presets_R.presets_ddl.items = #()
				)
			)
			on savePreset picked do
			(
				modInst.savePre_fn()
			)
			on loadPreset picked do
			(
				modInst.loadPre_fn()
			)
			on mergePreset picked do
			(
				modInst.mergePre_fn()
			)
			on help picked do
			(
				shellLaunch "http://paulneale.com" ""
			)
			on email picked do
			(
				shellLaunch "mailTo:info@paulneale.com.com" ""
			)
			on version picked do
			(
				str = "Created By: Paul Neale \nCompany: PEN Productions Inc. \nVersion: 2.06 \nUpdated: August 11 2005"
				messageBox str title:"Author/Version"
			)
			
			on menuBar open do
			(
				modInst=this --This is a code fix for Max 8. 
			)
		)
		--!!!Larry fixed a bug and this stoped working. The above open event corrects this. 
		--menuBar.modInst=this --get the modifier and create an instance for the menu because of scope and contex issues.
		menuBar --Return the menu
	)
		
	rollout presets_R "Presets"
	(
		local btWs = 27, btWl = 65, btHeight = 18
		
		group "Manage Presets:"
		(
			edittext presetName_et "Name:" fieldWidth:90 align:#left
			button optionsBt "<" width:15 pos:[140,23] toolTip:"Add, subtract, delete and save/load presets"
		)

		dropDownList presets_ddl "Presets:"
		slider rampCa_Sl "0%           Ramp:        100%" range:[0,1,0] scale:.01 width:130 --across:2
		checkButton rampOn_Cb "" highLightColor:[0,255,0] width:15 height:15 offset:[70,-25] toolTip:"Use Ramp slider for setting poses."
		
		button keyAll_bt "Key All" width:65 across:2 toolTip:"Key all attributes"
		button resetall_bt "Reset All" width:65 toolTip:"Reset all attributes to 0"
		
		button copyPose_bt "Copy" width:btWl height:btHeight across:2 toolTip:"Copy existing values of Custom Attributes."
		button pastePose_bt "Paste" width:btWl height:btHeight toolTip:"Paste copied values of Custom Attributes."
		
--		button test "test"
		on test pressed do (print (refs.dependents this))
		
		on optionsBt pressed do
		(
			menuSys=menus()
			popUpMenu menuSys rollout:presets_R
		)

		on copyPose_bt pressed do
		(
			PENCopyPaste_vr = #()
			ca = getCaAttributes_fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(append PENCopyPaste_vr ca[x].value)catch()
				)
			)
		)
		
		on pastePose_bt pressed do
		( 			ca = getCaAttributes_fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = PENCopyPaste_vr[x])catch()
				)
			)
		)
		
		on keyAll_bt pressed do
		(
			ca = getCaAttributes_fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = ca[x].value)catch()
				)
			)
		)
		
		on resetAll_bt pressed do
		(
			ca = getCaAttributes_fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = 0)catch()
				)
			)
		)
		
		on presets_ddl selected i do
		(
			if rampOn_Cb.checked == false then
			(
				ca = getCaAttributes_fn()
				vals = (execute preset_str[i])
				if ca.count > 0 do
				(
					for x = 1 to ca.count do
					(
						try(ca[x].value = vals[x])catch()
					)
				)
			)			
		)
		
		local curVals = #()
		on rampCa_Sl buttonDown do
		(
			ca = getCaAttributes_fn()
			if ca.count > 0 then
			(
				for x in ca do
				(
					append curVals x.value
				)
			)
		)
		on rampCa_Sl changed val do
		(
			ca = getCaAttributes_fn()
			vals = if presets_ddl.items.count > 0 then (execute preset_str[presets_ddl.selection])else("")
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = curVals[x] + ((vals[x] - curVals[x]) * val))catch()--
				)
			)			
		)
		on rampCa_Sl buttonUp do
		(
			rampCa_Sl.value = 0
			curVals = #()
		)
		
----------------------------------------------------------Save presets	
		on addPre_bt pressed do 		
		(
			dupNameCheck_fn presetName_et.text
		)
		on deletePre_bt pressed do
		(
			delNum = presets_ddl.selection
			try(deletePreset_fn delNum)catch()
		)
		
		on savePre_bt pressed do
		(
			savePre_fn()
		)
		
		on loadPre_bt pressed do
		(
			loadPre_fn()
		)
		
		on mergePre_bt pressed do
		(
			mergePre_fn()
		)
		
		on presets_R open do
		(
			updatePresets_fn()
		)--end on open
		
	)-- end presets_R


	on update do
	(
		if version == 1 then
		(
			print "Version 1 updated"
		)
	)--end on update	

	fn rollouts = (#(presets_R))
)--end Plugin


-----------------------tests-------------








