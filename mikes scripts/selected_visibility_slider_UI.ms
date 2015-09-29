
global myRoll
global my_floater
global myscatterobj
global Leaders
global myname

rollout myroll "rolloutname" width:269 height:169
(
	button collect_b "collect the groups to distribute" pos:[9,7] width:198 height:34
	pickbutton scatterto_pck "pick the obj to scatter to" pos:[10,50] width:195 height:23
	button scat_b "Scatter em!" pos:[183,84] width:74 height:50
	edittext name_t "object names" pos:[15,85] width:161 height:16
	progressBar pb1 "ProgressBar" pos:[8,144] width:248 height:16



	on collect_b pressed do
		Leaders = for o in selection where ((o.parent == undefined or isopengroupmember o) and (not isOpenGroupHead o)) collect o
	on scatterto_pck picked obj do
	(
			myscatterobj = obj
			scatterto_pck.caption = obj.name
		)
	on scat_b pressed do
	(
			for i = 1 to myscatterobj.vertices.count do
			(
			myran = Random 1 Leaders.count
			maxOps.CloneNodes Leaders[myran]  offset: [15,0,0] expandHierarchy:false cloneType:#copy newNodes:&Temp
			
			grouphead = for m in Temp where ((m.parent == undefined or isopengroupmember m) and (not isOpenGroupHead m)) collect m
			grouphead.pos = myscatterobj.vertices[i].pos
			grouphead.name = myname + "_"+ i as string
			myRoll.pb1.value = 100*1/myscatterobj.vertices.count
			)
		)
	on name_t entered text do
		myname = text
)













if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "myFlotaerName" 300 150
			addRollout myRoll my_floater
			 
