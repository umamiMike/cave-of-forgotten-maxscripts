myobjs = collectTheObjects()

function collectTheObjects = (for i in objects where i.modifiers.count > 0 collect i)
myObjNames = collectTheObjectNames()

function collectTheObjectNames= (for i in objects where i.modifiers.count > 0 collect i.name)
	
myOb = undefined
myModifier = undefined
dupMods = undefined

mySelSetNames = for i in 1 to selectionsets.count collect selectionsets[i].name as string


if modController != undefined  then destroydialog modController

(
rollout modController "modifier controller" width:480 height:329
	button assignModToSelBtn "add Mod to Sel Set" pos:[355,289] width:97 height:31
	listbox objLb "Object to use" pos:[8,9] width:167 height:5 items:myObjNames
	listbox modsLb "Mods in Object" pos:[10,109] width:167 height:5
	listbox selStLb "selectionSets" pos:[288,11] width:167 height:3 items:mySelSetNames
	edittext edt1 "nameOfMod" pos:[190,86] width:157 height:16
	button findDupModBtn "findDupMods" pos:[90,224] width:97 height:31
	listbox dupModsLb "Duplicate Mods" pos:[230,133] width:167 height:5
	
	
	
	button delModsBtn "Delete Dup Mods" pos:[92,271] width:97 height:31
	on assignModToSelBtn pressed do
	(
			
			try (for i in mySelSet do (
				localMod = copy myModifier
				if edt1.text != undefined then (localMod.name = edt1.text)
				addmodifier i localMod)) catch()
			objLb.items = collectTheObjectNames()
				myobjs = collectTheObjects()
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
		
	on edt1 entered text do(
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