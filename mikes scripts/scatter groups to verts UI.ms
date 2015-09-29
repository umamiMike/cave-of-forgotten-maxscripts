
global myRoll
global my_floater
global myscatterobj
global Leaders
global myname = "Scatter"

rollout myRoll "Scatter Selected groups or Objects to Verts" width:269 height:169
(
	button collect_b "collect the groups to distribute" pos:[8,8] width:195 height:24
	pickbutton scatterto_pck "pick the obj to scatter to" pos:[8,40] width:195 height:24
	button scat_b "Scatter em!" pos:[8,105] width:195 height:24
	edittext name_t "Scatter" pos:[8,72] width:195 height:24
	progressBar pb1 "ProgressBar" pos:[8,144] width:269 height:16


	on collect_b pressed do
	(
			Leaders = for o in selection where ((o.parent == undefined or isopengroupmember o) and (not isOpenGroupHead o)) collect o
			collect_b.caption = "You Have Selected "+Leaders.count as string + " Groups"
			
			)
	on scatterto_pck picked obj do
	(
			myscatterobj = copy obj
			scatterto_pck.caption = obj.name + "  " +  obj.vertices.count as string
			convertToMesh myscatterobj
		)
	on scat_b pressed do
	(
	mynum = myscatterobj.vertices.count
			for i = 1 to mynum  do
			(
			myran = Random 1 Leaders.count
			maxOps.CloneNodes Leaders[myran]  offset: [15,0,0] expandHierarchy:false cloneType:#copy newNodes:&Temp
			
			grouphead = for m in Temp where ((m.parent == undefined or isopengroupmember m) and (not isOpenGroupHead m)) collect m
			grouphead.pos = myscatterobj.vertices[i].pos
			grouphead.name = myname + "_"+ i as string
			myRoll.pb1.value = 100*i/mynum
			)
			myRoll.pb1.value = 0
		)
	on name_t entered text do
		myname = text
)












if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "Scatter groups or Objects to Verts" 300 200
			addRollout myRoll my_floater
			 
