
global mypath
global myobj

rollout pathroll "Untitled" width:162 height:129
(
	pickbutton pathbtn "pick the path" pos:[10,10] width:127 height:21
	pickbutton objbtn "pick the object" pos:[10,43] width:127 height:22
	button dobtn "do it" pos:[12,82] width:129 height:22
	on pathbtn picked obj do
	(
		mypath = pathbtn.object
		)
	on objbtn picked obj do
	(
		myobj = objbtn.object
				
	)
	on dobtn pressed do
	( 
	undo on(
		mypathconstraint =  Path_Constraint ()
		mypathconstraint.follow = true
		mydummy = dummy()
		mydummy.center = myobj.pos
		mydummy.boxsize = myobj.max - myobj.min
		myobj.parent = mydummy
		mydummy.pos.controller = mypathconstraint 
		mypathconstraint.path = mypath
		
		select mydummy
		)
		
		)
)

if myFloater != undefined then closeRolloutFloater myFloater
myFloater = newRolloutFloater "paths yo" 265 300
			addRollout pathroll myFloater