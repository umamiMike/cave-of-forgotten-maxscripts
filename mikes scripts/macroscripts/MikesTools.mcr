macroScript MikesTools Icon:#("umamiIcons",4)

	category:"Mikes"
	toolTip:"MikesTools"
(
global volselmap
global near_time = -10
global far_time = 10
global fadetime = 5
global mikeTools_floater
fn fadeOut = 
(
undo on
(	
	myArray = selection as array

	for i = 1 to myArray.count do
			(
			
			myArray[i].visibility = bezier_float()
			animate on
			
					(
					at time 0f (myArray[i].visibility.controller.value = 1)
					at time (currentTime) (myArray[i].visibility.controller.value = 1)
					at time (currentTime + fadetime) (myArray[i].visibility.controller.value = 0)
					)
					
					deleteKey myArray[i].visibility.controller.keys 1
			)
)
)

fn fadeIn = 

(
myArray = selection as array
undo on 
(
	for i = 1 to myArray.count do
			(
			
			myArray[i].visibility = bezier_float()
			animate on
			
					(
					at time 0f (myArray[i].visibility.controller.value = 0)
					at time (currentTime) (myArray[i].visibility.controller.value = 0)
					at time (currentTime + fadetime) (myArray[i].visibility.controller.value = 1)
					)
					deleteKey myArray[i].visibility.controller.keys 1
			)
	)
)



function myRandom = (
	undo on
	(
	
	for i = 1 to selection.count do(
		movekeys selection[i] (random near_time far_time) #selection
		)
	)
)

function springFunction = ( 

undo on (
			mySpringPosController = SpringPositionController ()	
			for i = 1 to selection.count do (
				selection[i].pos.controller = mySpringPosController 
				
				)
		)
)

rollout spring_Rollout "Add Springs to Selection" width:162 height:48
(
	button btn3 "add spring to selection" pos:[9,5] width:136 height:29


	on btn3 pressed  do
		(
				springFunction()
				
				)
)


rollout randomKeymov_Rollout "Random Key Mover" width:162 height:300
(
	button ranBtn "Move Em Randomly" pos:[8,64] width:146 height:18
	spinner lowspn "Low" pos:[16,40] width:56 height:16 range:[-100,0,-10] type:#integer
	spinner hispn "Hi" pos:[88,40] width:67 height:16 range:[0,100,5] type:#integer
	label lbl1 "set time range" pos:[8,16] width:144 height:16
	button btn2 "cascade em" pos:[10,89] width:143 height:19
	on ranBtn pressed do
		myRandom()
	on lowspn changed val do
		near_time = val
	on hispn changed val do
		far_time = val
	on btn2 pressed do
	( undo on 
		(
		myArray = selection as array
		for i = 2 to myArray.count do
			(
			myobj = myArray[i]
			mycount= far_time
			movekeys myobj  ((i-1) * mycount)
			)
		)
	)
)
rollout fade_rollout "fader" width:162 height:300
(
	button fadeOutbtn "fade em out" pos:[8,8] width:128 height:16
	button fadeInbtn "Fade em In" pos:[8,32] width:128 height:16
	spinner spn2 "fade time" pos:[13,55] width:120 height:16 range:[0,100,5] type:#integer
	on fadeOutbtn pressed do
		fadeout()
	on fadeInbtn pressed do
		fadeIn()
	on spn2 changed val do
		fadeTime = val
)

rollout simpleBtnRoll "Simple Buttons" width:162 height:184
(
	button boxmodebtn "box mode" pos:[8,8] width:64 height:24
	button trajbtn "Trajectory" pos:[6,72] width:66 height:24
	button btn5 "Seethru" pos:[6,40] width:66 height:24
	button splanchorbtn "spline anchor" pos:[80,8] width:72 height:24
	button applydiffbtn "apply and show diffuse" pos:[4,104] width:141 height:22
	button namefromdiff_btn "object name from diffusemap" pos:[6,131] width:141 height:22
		
	on boxmodebtn pressed do
	(
		myArray = selection as array
		for i = 1 to myarray.count do
		
		(
		if myarray[i].boxmode == on
		then myarray[i].boxmode = off
		else	myarray[i].boxmode = on
		)
		
	)
	on trajbtn pressed do
	(
			myArray = selection as array
				for i = 1 to myarray.count do
				
				(
				if myarray[i].showTrajectory== on
				then myarray[i].showTrajectory= off
				else	myarray[i].showTrajectory= on
				)

	)
	on btn5 pressed do
	(
			myArray = selection as array
			for i = 1 to myarray.count do
			
			(
			if myarray[i].xray == on
			then myarray[i].xray = off
			else myarray[i].xray = on
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
	on applydiffbtn pressed do
	(
		$.mat.diffusemap.apply = on
		MatEditor.Open()
		meditmaterials[medit.GetActiveMtlSlot()] = $.mat.diffusemap
		$.mat.diffusemap.viewImage()

		
		)
	on namefromdiff_btn pressed do (
				
				for i = 1 to selection.count do 
				(
					if selection[i].mat.diffusemap != undefined do
						(
						selection[i].name = getfilenamefile selection[i].mat.diffusemap.filename
						
						)
				
				
				)
	
	)
)
global volselmap

rollout volselRoll "volselpush yo" width:162 height:300
(
	mapButton btn1 "select the map" pos:[8,6] width:135 height:22
	button btn2 "do it" pos:[11,41] width:134 height:25
	on btn1 picked texmap do
		volselmap = btn1.map
	on btn2 pressed  do
		(
			mypush = push()
myVolSel = Volumeselect()
myVolSel.level = 1
myVolSel.volume = 4
myVolSel.texture = volselmap
 

addmodifier $ myVolSel
addmodifier $ mypush
meditmaterials[medit.GetActiveMtlSlot()] = volselmap
			)
			)


if mikeTools_floater != undefined then closeRolloutFloater mikeTools_floater
mikeTools_floater = newRolloutFloater "MikesTools" 265 600
			addRollout spring_rollout mikeTools_floater
			addRollout randomKeymov_Rollout mikeTools_floater
			addRollout fade_rollout mikeTools_floater
			addRollout simpleBtnRoll mikeTools_floater
			addRollout volselRoll mikeTools_floater

)
