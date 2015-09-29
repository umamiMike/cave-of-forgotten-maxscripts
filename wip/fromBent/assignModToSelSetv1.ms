-- add a way to put the modifier in a certain point in the stack of an object
-- add an option for off in viewport or off altogether
-- add a test routine to NOT add the modifier IF the object already has one of that name
myModifier

myobjs = collectTheObjects()

function collectTheObjects = (for i in objects where i.modifiers.count > 0 collect i)
function collectTheObjectNames= (for i in objects where i.modifiers.count > 0 collect i.name)

myObjNames = collectTheObjectNames()
	
myOb = undefined
myModifier = undefined
dupMods = undefined

mySelSetNames = for i in 1 to selectionsets.count collect selectionsets[i].name as string

fn ChangeType = 	(
	theType = 	case copy_type.state of (
				1: "Copy "
				2: "Instance "
				3: "Reference " )
			)

			
if modController != undefined  then destroydialog modController

rollwidth = 550
rollHeight = 330
spacer = 8

rollout modController "modifier controller" width:rollwidth height:rollHeight
(
	button assignModToSelBtn "add Mod to Sel Set" pos:[355,445] width:97 height:31
	
	listbox objLb "Object to use" pos:[8,9] width:185 height:5 items:myObjNames
	radiobuttons copy_type  pos:[180+16,10] width: 60 height: 30 columns:1 labels:#("copy", "instance", "reference")	
	listbox selStLb "selectionSets" pos:[357,9] width:185 height:6 items:mySelSetNames
	listbox modsLb "Mods in Object" pos:[10,109] width:185 height:6

	edittext edt1 "nameOfMod" pos:[190,86] width:157 height:16
	button findDupModBtn "findDupMods" pos:[90,224] width:97 height:31
	
	listbox dupModsLb "Duplicate Mods" pos:[357,133] width:185 height:5

	
	button delModsBtn "Delete Dup Mods" pos:[92,271] width:97 height:31
		
		
		
	button addModtoSelectedBtn "add Mod to Selected" pos:[(rollwidth/2.4),150] width:105 height:31
	button addModChildrenBtn "addModToChildrenAsGroup" pos:[(rollwidth/2.7),188] width:135 height:31
	
	
	on assignModToSelBtn pressed do
	(
			
			try (for i in mySelSet do (
				localMod = copy myModifier
				if edt1.text != undefined then (localMod.name = edt1.text)
				addmodifier i localMod)) catch()
				objLb.items = collectTheObjectNames()
				myobjs = collectTheObjects()
			)
			
	on assignModToSelBtn pressed do
			(
			
			try (for i in mySelSet do (
				localMod = copy myModifier
				if edt1.text != undefined then (localMod.name = edt1.text)
				addmodifier i localMod)) catch()
				objLb.items = collectTheObjectNames()
				myobjs = collectTheObjects()
			)
			
	on copy_type changed state do(changeType())
			
	on addModtoSelectedBtn pressed do(
			
			try (
				for i in selection do (
				localMod = copy myModifier
				--if edt1.text != undefined  then (localMod.name = edt1.text)
				addmodifier i localMod
					)) 
				catch()
				--objLb.items = collectTheObjectNames()
				--myobjs = collectTheObjects()
				)
				
				on addModChildrenBtn pressed do(
							thisModifier = copy myModifier
							modPanel.addModToSelection thisModifier
							
					
					)
			
			
	on objLb doubleClicked sel do
	(
		myOb = myObjs[sel]
		select myOb
		modsLb.items = for i in myOb.modifiers collect i.name
		)
	on modsLb doubleClicked sel do
	(
		myModifier = myOb.modifiers[sel]
		edt1.text = myModifier.name
		
		)
	on selStLb doubleClicked sel do
	(
		select selectionsets[sel]
		mySelSet = selectionsets[sel]
		)
	on edt1 entered text do
	(
			modName = text
			try($.modifiers[text].name = modName as string)catch()
		)
	on findDupModBtn pressed do
	(
			dupMods = for i in objects where i.modifiers[edt1.text]  != undefined collect i.name
				dupModsLb.items = dupMods
			)
	on dupModsLb doubleClicked sel do
	(
		--myModifier = myOb.modifiers[sel]
		
		)
	on delModsBtn pressed do
	(
		
		localObs = for i in objects where i.modifiers[edt1.text]  != undefined 	collect i
				for i in localObs do(
					theModtoDelete = i.modifiers[edt1.text]
			deletemodifier	i theModToDelete	
					dupmods = #()
					objLb.items = collectTheObjectNames()
					)
	)
	
)

createDialog modController