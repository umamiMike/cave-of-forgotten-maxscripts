--random assignment or literal assignment


global myRoll
global my_floater
global myscatterobj
global Leaders
--global myname = "Scatter"
dummyArray = #()

rollout myRoll "Groups to Dummies" width:269 height:169
(
	button collect_b "collect the groups to distribute" pos:[9,7] width:198 height:34
	button scat_b "Scatter em!" pos:[12,85] width:195 height:50
	progressBar pb1 "ProgressBar" pos:[8,144] width:248 height:16
	button btn4 "Dummies to Scatter to" pos:[12,48] width:198 height:25


	on collect_b pressed do
	(
			Leaders = for o in selection where ((o.parent == undefined or isopengroupmember o) and (not isOpenGroupHead o)) collect o
			collect_b.caption = "You Have Selected "+Leaders.count as string + " Groups"
			
			)
	on scat_b pressed do
	(
	mynum = dummyArray.count
			for i = 1 to mynum  do
			(
			myran = Random 1 Leaders.count
			maxOps.CloneNodes Leaders[myran]  offset: [15,0,0] expandHierarchy:false cloneType:#copy newNodes:&Temp
			
			grouphead = for m in Temp where ((m.parent == undefined or isopengroupmember m) and (not isOpenGroupHead m)) collect m
			grouphead.pos = dummyArray[i].pos
			grouphead.name = "scat" + leaders[myran].name as string + "_"+ i as string
			grouphead.parent = dummyArray[i]
			dummyarray[i].name = "control" + leaders[myran].name as string + "_"+ i as string + "_Control"
			myRoll.pb1.value = 100*i/mynum
			)
		)
	on btn4 pressed do
	(
		dummyArray = #()
			for i = 1 to selection.count do(
			myobj = selection[i]
			if classof myobj == Dummy then (append dummyArray myobj)
			)
			btn4.caption = dummyArray.count as string + " Dummies selected"
			
		)
)











if my_floater != undefined then closeRolloutFloater my_floater
my_floater = newRolloutFloater "Groups To Dummies" 300 200
			addRollout myRoll my_floater
			 
