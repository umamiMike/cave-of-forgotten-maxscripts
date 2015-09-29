--add functionality you would like to see here

-- create an array for every 
if ranObsRollout != undefined then destroyDialog ranObsRollout
myArray = selection as array
myArrayOfArrays = #()
numOfSelSets = 2 -- will be changed with UI
baseName = "RandomSets"
function makeTheArrays = 
	(
		myArrayOfArrays = #() -- for now declaring it here as well...not sure of the global problem
	for i = 1 to numOfSelSets do (
		thisArray = #()
		append myArrayOfArrays thisArray
		
		)
)


function createSelSets = ( 
	undo on
	
		for i = 1 to numOfSelSets do
	(
		myName = baseName + i as string
		selectionSets[myName] = myArrayOfArrays[i]
		
	
	)
)


function sortToArrays = (

	while myArray.count != 0 do
	(
		myRan = random 1 myArray.count
		myObj = myArray[myRan]
		if myArray.count == 1 then print myArrayOfArrays[random 1 numOfSelSets]
		append myArrayOfArrays[random 1 numOfSelSets] myObj
		deleteItem myArray myRan
		
	)
)

rollout ranObsRollout "Selected objects Random to Sel Sets" width:200 height:134
(
	button btn1 "Objects to Work on" pos:[17,67] width:150 height:23
	button btn2 "Create Selection Sets" pos:[16,103] width:150 height:23
	spinner spn1 "number of sel sets" pos:[52,7] width:90 height:16 range:[0,100,2] type:#integer
	editText edt1 "baseName" pos:[10,39] width:180 height:16 text:baseName
	
	on btn1 pressed do
	(
			myArray = selection as array 
			makeTheArrays()
			sortToArrays()
			)
			
	on btn2 pressed do
		(
			if myArrayOfArrays.count != 0 then createSelSets() else()
			myArrayOfArrays = #() -- reinit
			)
	on spn1 changed val do numOfSelSets = val
	on edt1 entered text do basename = text
)

createDialog ranObsRollout
