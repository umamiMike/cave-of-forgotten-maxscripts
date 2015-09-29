--THINGS TO ADD
--add selection TO a team
--remove selection FROM a team

--add a way to tell what teams a delegate is in
		--probably doing a search through all the teams
----



theCrowd = $crowd001 -- change to a pickbutton at some point

--variables exposed from functions for testing ...they can be deleted
array1 = #()
array2 = #()
returnArray  = #()

---rollout shit

if crowdWorkRoll != undefined then destroyDialog crowdWorkRoll



-- Functions --------------------
fn whatTeamsAmIon obj = (
	
	if classof obj ==  Delegate then (
		
		for i in theCrowd.teams do(
			theCondition = finditem theCrowd.teams[i].members obj
			print theCondition
			
			
		)
		
		)
	else ()
	
	
)

fn selectDelFromObj = (
select ( for i in selection where i.parent != undefined  and  classof i.parent == delegate collect i.parent)
	
)



fn addADelegate obj = (
	--this will add a crowd delegate to the center of the obj and parent the obj to the delegate
	thisDel = delegate position:obj.center
	obj.parent = thisDel
)

fn selOnlyDels = (
	
	myArray = ( for i in selection where classof i ==  Delegate  collect i)
		select myArray
)
 

fn subFromArray array1 array2 = (
	-- this will subtract all items from array2 which exist in array1
	tempArray = deepcopy array2
		for i in array1 do(
			v =  findItem tempArray i
			while v != 0 do (
			deleteItem	tempArray v
			v =  findItem tempArray i
				
			)
			
		)
		return tempArray
	
)

fn makeTeamDDList = (
	
	theDDlist = for i in theCrowd.teams collect i.name
		append theDDlist "selection"
		return theDDlist
)
--shit to define specifically for the UI stuff
ddList = makeTeamDDlist() --instantiated to make the items list for the rollouts

rollout crowdWorkRoll "CrowdControl" width:431 height:171
(

	dropdownList ddl1 "" pos:[56,12] width:146 height:21 items:ddList 
	dropdownList ddl2 "" pos:[244,12] width:146 height:21  items:ddList
	label lbl1 "Subtract" pos:[9,15] width:42 height:20
	label lbl2 "From" pos:[211,15] width:36 height:20
	button btn1 "->" pos:[398,12] width:27 height:20
	button btn3 "SelOnlyDels" pos:[16,76] width:75 height:22 toolTip:"This will take whatever selection you have in the scene and filter it to ONLY be Delegates"
	button btn6 "Make Dels" pos:[16,47] width:75 height:22 toolTip:"This will create a delegate for every object you select"
	on ddl1 selected sel do
	(
		print sel
		)
	on ddl2 selected sel do
	(
		print sel
		)
	on btn1 pressed do
	(
			if ddl1.selection != ddl2.selection do (
				if ddl1.selected != "selection" then
				(
		array1 = theCrowd.teams[ddl1.selection].members as array
		array2 = theCrowd.teams[ddl2.selection].members as array
		
				returnArray = subFromArray array1 array2
				
				theCrowd.teams[ddl2.selection].members = returnArray
				)--end if
				else (
							array1 = ( for i in selection where classof i ==  Delegate  collect i)
							array2 = theCrowd.teams[ddl2.selection].members as array
		
							returnArray = subFromArray array1 array2
				
				theCrowd.teams[ddl2.selection].members = returnArray
					
					
					)
				
			)
		--returnArray = #()
		
		)
	on btn3 pressed do
	(
			selOnlyDels()
		)
	on btn6 pressed do
	(
			for i in selection do (addADelegate i)
		)
)


createDialog crowdWorkRoll

