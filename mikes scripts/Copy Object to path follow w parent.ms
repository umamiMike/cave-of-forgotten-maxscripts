global mydummy
global mypath
global myobj

rollout pathroll "Put object on path" width:196 height:180
(
	pickbutton pathbtn "pick the path" pos:[8,7] width:127 height:21
	pickbutton objbtn "pick the object" pos:[8,32] width:127 height:21
	button DoBtn "do it" pos:[8,59] width:127 height:24
	button splanchorbtn "spline anchor" pos:[8,113] width:175 height:24
	button mvprntbtn "move to dummy and be parented" pos:[8,143] width:175 height:24
	label lbl1 "Various Tools" pos:[9,90] width:78 height:21
		
		

				
	on pathbtn picked obj do
	(
		mypath = pathbtn.object
		)
	on objbtn picked obj do
	(
		myobj = objbtn.object
				
	)
	on DoBtn pressed do
	( 
	undo on(
		mypathconstraint =  Path_Constraint ()
		mypathconstraint.follow = true
		mypathconstraint.axis = 1
		mypathconstraint.path = mypath
		mypathconstraint.constantVel = on
		mypathconstraint.allowUpsideDown = on
	
		mydummy = Point()
		mydummy.center = myobj.pos
		mydummy.size = myobj.max[1] - myobj.min[1]
		myobj = copy myobj
		myobj.pos = mydummy.center
		myobj.parent = mydummy
		mydummy.pos.controller = mypathconstraint 
		mydummy.pos.controller.percent.controller = bezier_float ()
	
		select mydummy
		)
		
		
		
		)
	on splanchorbtn pressed do
	(for i = 1 to selection.count do
				(	if classof selection[i] == Line then (
				mySpline = selection[i]
				myPos = getKnotPoint mySpline 1 1
				mySpline.pivot = myPos
				)
				)
		)
	on mvprntbtn pressed do
	(myobj.pos = mydummy.center
	myobj.rotation = mydummy.rotation
		myobj.parent = mydummy
		
		)
)if myFloater != undefined then closeRolloutFloater myFloater
myFloater = newRolloutFloater "Copy Obj's path follow w Parent" 212 208
			addRollout pathroll myFloater