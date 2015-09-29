
global myRoll
global my_floater
global myscatterobj
global Leaders
global myname
global SplineArray = #()
global grouphead
global mypathConstraint
global mySpline






rollout myroll "Scatter Groups to Splines" width:269 height:169
(
	button collect_b "collect the groups to distribute" pos:[8,42] width:198 height:34
	button scat_b "Scatter em!" pos:[183,84] width:74 height:50
	edittext name_t "object names" pos:[15,85] width:161 height:16
	progressBar pb1 "ProgressBar" pos:[8,144] width:248 height:16
	button SplineArray_btn "Splines to copy to" pos:[11,10] width:156 height:24


		
		function PathConstraintMaker = (
		
		myPathConstraint = Path_Constraint()
		myPathConstraint.percent.controller = Bezier_Float()
		myPathConstraint.path = mySpline
		myPathConstraint.follow = on

	)	
		
		
	on collect_b pressed do
	(
			Leaders = for o in selection where ((o.parent == undefined or isopengroupmember o) and (not isOpenGroupHead o)) collect o
			collect_b.caption = "You Have Selected"+Leaders.count as string + "Groups"
			
			)
	on scat_b pressed do
	(
		undo on(

			mynum = splineArray.count
			for i = 1 to splineArray.count  do
			(
			myspline = splineArray[i]
			PathConstraintMaker()
			myPos = getKnotPoint SplineArray[i] 1 1
			myran = Random 1 Leaders.count
			maxOps.CloneNodes Leaders[myran]  offset: [15,0,0] expandHierarchy:false cloneType:#copy newNodes:&Temp
			grouphead = for m in Temp where ((m.parent == undefined or isopengroupmember m) and (not isOpenGroupHead m)) collect m
			grouphead[1].pos = myPos
			grouphead[1].position.controller = myPathConstraint
			grouphead[1].position.controller.percent.controller.keys[1].time = currenttime
			grouphead[1].position.controller.percent.controller.keys[1].value = 100.0
			grouphead[1].position.controller.percent.controller.keys[2].time = currenttime + 30
			grouphead[1].position.controller.percent.controller.keys[2].value = 0.0
			grouphead[1].name =   myname + "_"+ i as string
			myRoll.pb1.value = 100*i/mynum
			)
		)	
		)
	on name_t entered text do
		myname = text
	on SplineArray_btn pressed do
	(
		SplineArray = #()
		for i = 1 to selection.count do
		(
			 if (classof selection[i] == splineShape) or ( classof selection[i] == line) then (append SplineArray selection[i])
			else ()
			--messagebox "Your objects must ALL be Splines"
		
		)
		SplineArray_btn.caption = SplineArray.count as string
		)
)












if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 300 200
			addRollout myRoll my_floater
			 
