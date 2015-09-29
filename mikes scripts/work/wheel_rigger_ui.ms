
global WheelRigRoll
global  WheelRig_floater
global myPath


rollout WheelRigRoll "rolloutname" width:225 height:101
(
	pickbutton PathPck "Pick The Path" pos:[11,7] width:104 height:26
	button DoBtn "Do It" pos:[14,44] width:102 height:27


	on PathPck picked obj do
	(
		if classof obj == Line then (  
		myPath = obj
		PathPck.caption = obj.name
	 )
	 else
	 (messagebox "Object must be a path"
	 pathPck.caption = "Pick a Path"
	 )
		
		)
	on DoBtn pressed  do(
	
	if classof $ == Cylinder then 
	(
	myPath = $.parent
	myRad = $.radius
	mypercent = myparent.pos.controller[2].controller.percent
	
	$.rotation.controller[2].controller[3].controller  = float_script()
     $.rotation.controller[2].controller[3].controller.addNode  "self" $
	$.rotation.controller[2].controller[3].controller.addNode "Parent"  myparent
	 $.rotation.controller[2].controller[3].controller.script = 
     
     "mypercent = parent.pos.controller[2].controller.percent

-((mypercent*pi)/(pi*(self.radius)))
"
)

else (messagebox "Not A Cylinder!")
	
	)
)






if WheelRig_floater != undefined then closeRolloutFloater WheelRig_floater
WheelRig_floater = newRolloutFloater "Wheel Rig Floater" 300 150
			addRollout WheelRigRoll WheelRig_floater
			 
