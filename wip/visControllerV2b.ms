--Current bugaboo with time is subdividing large selectiuns into animating on in a certain amount of time.  
-- with the current setup time is in frames and if you have more objects than time it wont work right eg if you want to fade up all 300 objects in 60 frames 60/300 makes them all start at the same time
--i have to move into ticks or normalized time or something AND figure out how to set the time accordingly

if makeVisRoll != undefined do (destroyDialog makeVisRoll)


fn makeVisibilityController ob = (--called by makeVisUi
	
	ob.visibility =  bezier_float()
	myScript = float_script()
	myScript.addTarget "start" ob.modifiers["conts"].start.controller
	myScript.addTarget "hold" ob.modifiers["conts"].hold.controller
	
	theScriptString = "fn remapVal v l1 h1 l2  h2 = (l2 + (v - l1) * (h2 - l2) / (h1 - l1)) \n"
	theScriptString += "max = (start + hold) \n"
	theScriptString += "fv = remapVal f start max 0.0 1.0 \n"
	theScriptString += "case of( \n"
	theScriptString += "(f <= (start + hold) and f > start):fv \n"
	theScriptString += "(f > (start + hold)):1.0 \n"
	theScriptString += "default:0.0)"

	myScript.script = theScriptString

	ob.visibility.controller = myScript
	
	ob
	)

	
	
	
function makeVisUi ob = (
myMod = EmptyModifier name:"conts"
	addModifier ob myMod

speedAndStartCA = attributes conts
(
	
	parameters PRM_SpeedAndStart rollout:conts
		(
			hold type:#float ui:holdSpn default: 30
			start type:#float ui:startSpn default: 0 
		
		)
	rollout conts "speed and start" width:162 height:48
	(
		spinner holdSpn "hold" pos:[51,6] width:99 height:16 range:[-1000,1000,100]
		spinner startSpn "start" pos:[59,27] width:90 height:16 range:[-10000,10000,0]
		--button bitchButton "Bitch" pos:[8,9] width:21 height:12
		
		
		
	)

)

custAttributes.add myMod speedAndStartCA baseobject:false
 -- adds the rollout and attributes if it doesnt already exist

myMod.conts.hold.controller = bezier_float()--need to add these so they actually animate
myMod.conts.start.controller = bezier_float()

makeVisibilityController ob
)

fn deleteControlRig ob = (
	
	
	ob.visibility.controller =  bezier_float()
	ob.visibility.controller.value = 1.0
	for m in ob.modifiers do (if m.name == "conts" do deleteModifier ob m)
	
	
	)

fn fadeSelUpInTime obArray TR = (--TR is
	print (obArray)
	print(TR)
	cnt = obArray.count
	timeDisplayMode = #frameTicks
	timeFromNow = (currentTime + TR)
	now = currentTime
	TR = (timeFromNow - now)
	print ("time from now: " + timeFromNow as string)
	print ("now: " + now as string)
	print ("TR: " + TR as string) 
	obArray[1].modifiers["conts"].start = now
	for i = 2 to obArray.count do (

	thisStart = now + ((TR/cnt)*(i-1))
		
	obArray[i].modifiers["conts"].start = thisStart


		)	
			timeDisplayMode = #frames
	)
	

fn makeVisUiForObArray obArray = (
	with redraw off(
	for i in obarray do (makeVisUi i)
	)--end redraw
	
	)
	
	
fn startToCurrentTime ob = (ob.baseobject.speedAndstart.start = currentTime)
fn changeSpeed ob val = (ob.baseobject.speed = val) 
	
	
	fn snippetsForVisCont = (
		
		for i in selection do (print i.speedAndStart.start)
		for i in selection do (i.start = 5)
		for i in selection do (i.speedAndStart.start = 10.5)
		for i = 1 to selection.count do (selection[i].modifiers["conts"].start = i*.2)--simple  icremente
		fadeSelUpInTime $ 30
		
		for i in selection do (deleteControlRig i)
		for i = 2 to selection.count do (selection[i].speedAndStart.start = i*2)--increment with mult
				for i = 2 to selection.count do (selection[i].modifiers["conts"].start += random -10 10)--randomize start from current
						for i = 2 to selection.count do (selection[i].speedAndStart.speed += random -10 10)--randomize start from current
			for i = 1 to selection.count do (selection[i].modifiers["conts"].hold = random .1 12.0)
		)
	
rollout makeVisRoll "Umami_visControllerTool" width:260 height:209
(
	
	button makeForSelBtn "Make Vis UI control Rig for Selection" pos:[8,40] width:248 height:18
	button delRigBtn "Delete Vis UI Control Rig of Selection" pos:[6,9] width:250 height:24
	spinner fadeUpSpn "" pos:[8,72] width:56 height:16 range:[0,999999,0]
	button btn6 "fade value" pos:[72,72] width:58 height:14 toolTip:"governs how long each one takes to fade up from its start time.  eg 1.0 = 1 frame "
	spinner startTimeSpn "" pos:[8,96] width:56 height:16 range:[0,999999,0]
	button startTimeBtn "startTime" pos:[72,96] width:58 height:14 toolTip:"sets the start time of all selected objects.  if set to 1 it will begin at frame 1 and fade up "
	button toCurrentTimeBtn "toCurrentTime" pos:[144,96] width:88 height:14 toolTip:"quick set the start time of all selected objects to the current slider time "
	spinner fadetimeSpn "" pos:[8,120] width:56 height:16 range:[0,999999,30]
	button fadeInTimeBtn "fade in time" pos:[80,120] width:112 height:14
	on makeForSelBtn pressed do
	(
			makeVisUiForObArray selection
			
		)
	on delRigBtn pressed do
	(
			for i in selection do (try (deleteControlRig i)catch()
			
			)
		)
	on btn6 pressed do
	(for i in selection do (
		
		try (i.modifiers["conts"].hold = fadeUpSpn.value)catch()
			
		) 
		
		)
	on startTimeBtn pressed do
	(for i in selection do (
		
		try (i.modifiers["conts"].start = startTimeSpn.value)catch()
			
		) 
		
		)
	on toCurrentTimeBtn pressed do
	(for i in selection do (
		
		try (i.modifiers["conts"].start = currentTime)catch()
			
		) 
		
		)
	on fadeInTimeBtn pressed do
	(
		theseObs = selection as array
		print(fadetimeSpn.value)
		try (fadeSelUpInTime theseObs fadetimeSpn.value)catch(print "it didnt work")
			
		
		
		)
)
		
createDialog makeVisRoll		
--for i in selection do (startToCurrentTime i)
	--for i in selection do (changeSpeed i 20)