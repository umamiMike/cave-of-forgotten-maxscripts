
global ScatHelpHeirarchyRoll
global  ScatHelpHeirarchyFloater

global myPickedObjs
global myScatObjs
global ParentObjToMe

rollout ScatHelpHeirarchyRoll "Scatter Parents" width:225 height:101
(
	button HelpPckBtn "Select Helper Heirarchy" pos:[6,7] width:143 height:24
	button scatObjsPckBtn "Objects to Scatter to" pos:[9,41] width:140 height:23




	button DoBtn "Do It" pos:[6,73] width:145 height:21
	
	on HelpPckBtn pressed do
	(
			myPickedObjs = selection as array
			HelpPckBtn.caption = myPickedObjs.count as string
			)
	on scatObjsPckBtn pressed do
	(
		myScatObjs = selection as array
		scatObjsPckBtn.caption = myScatObjs.count as string
		)
	
	
	on DoBtn pressed  do
(

undo on(
for i = 1 to myScatObjs.count do
			(
				maxOps.CloneNodes myPickedObjs newNodes: &new
				
					for i = 1 to new.count do(
					
					if new[i].children.count == 0 then (ParentObjToMe = new[i])
					if new[i].parent == undefined then (MainParent = new[i])
					
					)
					MainParent.pos = myScatObjs[i].pos
					MainParent.name = MainParent.name + "_" + myScatObjs[i].name
					myScatObjs[i].parent = ParentObjToMe
					ParentObjToMe.name =ParentObjToMe.name + "_" + myScatObjs[i].name
					




			)
	
	)
	
)	
	
)












if ScatHelpHeirarchyFloater != undefined then closeRolloutFloater ScatHelpHeirarchyFloater
ScatHelpHeirarchyFloater = newRolloutFloater "Scatter Helper Heirarchy" 225 125
			addRollout ScatHelpHeirarchyRoll ScatHelpHeirarchyFloater
			 
