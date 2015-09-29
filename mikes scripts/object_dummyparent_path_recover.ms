
global mypath
global myobj

rollout pathroll "Untitled" width:239 height:189
(
	pickbutton pathbtn "pick the path" pos:[4,7] width:127 height:21
	pickbutton objbtn "pick the object" pos:[3,32] width:127 height:22
	button dobtn "do it" pos:[11,161] width:129 height:22
	button splanchorbtn "spline anchor" pos:[10,125] width:72 height:24
	button btn9 "move to dummy and be parented" pos:[5,58] width:168 height:22
		
		
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
		mypathconstraint.axis = 1
		mypathconstraint.path = mypath
		mypathconstraint.constantVel = on
		mypathconstraint.allowUpsideDown = on

		mydummy = dummy()
		mydummy.center = myobj.pos
		mydummy.boxsize = myobj.max - myobj.min
		mydummy.pos.controller = mypathconstraint 
		mydummy.pos.controller.percent.controller = bezier_float ()
		
		myobj = copy myobj
		myobj.pos = mydummy.center
		myobj.parent = mydummy
		select mydummy
		)
		
		
		
		)
	on splanchorbtn pressed do
	(for i = 1 to selection.count do
				(	
				mySpline = selection[i]
				myPos = getKnotPoint mySpline 1 1
				mySpline.pivot = myPos
				)
		)
	on btn9 pressed  do
(
	
	)
)if myFloater != undefined then closeRolloutFloater myFloater
myFloater = newRolloutFloater "paths yo" 265 300
			addRollout pathroll myFloater