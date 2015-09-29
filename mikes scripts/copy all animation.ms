global mybase
global myobjs

rollout objRepRoll "Untitled" width:162 height:300
(
	button srcBtn "source selection" pos:[10,7] width:138 height:23
	button doitbtn "do it" pos:[16,73] width:118 height:27
	button copytobtn "objects to copy to" pos:[12,42] width:139 height:22
	
				
	on srcBtn pressed do
	(mybase = selection as array
		
		)
	on doitbtn pressed do
	(
	undo on
	(
	for i = 1 to myobjs.count do
		(
		myran = random 1 mybase.count
		myobjs[i].baseobject = copy mybase[myran].baseobject
	    myobjs[i].mat =  mybase[myran].mat
		)
		)
	)
	on copytobtn pressed do
	(
	myobjs = selection as array
		
		)
)


if ObjRepFloater!= undefined then closeRolloutFloater ObjRepFloater 

global ObjRepFloater = newRolloutFloater "Umami OBJ Replacer" 265 300
			addRollout objRepRoll  ObjRepFloater 


