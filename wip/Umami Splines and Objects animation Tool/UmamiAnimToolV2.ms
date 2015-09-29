if obPathControlRoll != undefined do (destroyDialog obPathControlRoll)

tempArray = #()

fn changePathOfObject ob thePath = (
	ob.modifiers["Path_Deform_Binding"].path = thePath
	ob.transform = thePath.transform
	ob.parent = thePath
	
)




fn alignToOwnPath ob  = (
	thePath = ob.modifiers["Path_Deform_Binding"].path
	ob.transform = thePath.transform
	ob.parent = thePath
	
)

fn makeVisibilityController ob = (
	
	ob.visibility =  bezier_float()
	myScript = float_script()
	myScript.addTarget "percentAlongPath" ob.modifiers[1].percentAlongPath.controller
	
	theScriptString = "myP = percentAlongPath/10 \n"
	theScriptString += "case of ( \n"
	theScriptString += "(percentAlongPath < 10): 0+myP \n"
	theScriptString += "(percentAlongPath > 90): ((10-myP)) \n"
	theScriptString += "default:1)"
myScript.script = theScriptString

ob.visibility.controller = myScript
	
	ob
	)

function makeDefOb ob = (
if isProperty ob.baseobject "speedAndStart" == false do (

speedAndStartCA = attributes speedAndStart
(
	
	parameters PRM_SpeedAndStart rollout:SpeedAndStartRoll
		(
		speed type:#float ui:speedSpn default: 100.0 
			start type:#Integer ui:startSpn default: 0 
		
		)
	rollout SpeedAndStartRoll "speed and start" width:162 height:48
	(
		spinner speedSpn "speed" pos:[51,6] width:99 height:16 range:[-1000,1000,100]
		spinner startSpn "start" pos:[59,27] width:90 height:16 range:[-1000,1000,0]
		
	)

)


if custAttributes.get ob 1 != undefined do (custAttributes.delete ob 1)

custAttributes.add ob speedAndStartCA baseobject:false) -- adds the rollout and attributes if it doesnt already exist

ob.speedAndStart.speed.controller = bezier_float()
ob.speedAndStart.start.controller = bezier_float()

thePath = undefined
if classof ob.modifiers[1] == SpacePathDeform do (
	thePath = ob.modifiers[1].path
	deleteModifier ob 1
)


pathDefScript = float_script()
pathDefScript.addTarget "start" ob.speedAndStart.start.controller
pathDefScript.addTarget "speed" ob.speedAndStart.speed.controller
pathDefScript.script = "(f-start)/100*(speed/100)"
myDefMod = spacePathDeform()
myDefMod.percentAlongPath.controller = pathDefScript

addModifier ob myDefMod
try (changePathOfObject ob thePath) catch()

scaleScript = scale_script()
scaleScript.addTarget "percentAlongPath" ob.modifiers[1].percentAlongPath.controller
theScriptString = "scale = percentAlongPath/100 \n"
theScriptString += "if percentAlongPath >= 100 or percentAlongPath <= 1 then (scale = 0) else (scale = 1) \n"
theScriptString += "[scale,scale,scale]"

scaleScript.script = theScriptString




ob.scale.controller = scaleScript

makeVisibilityController ob
)




function createArrayFromSelItems theItems = (
	theItemArray = #()
	
	for i in theItems do (
		
		execute ("myOb = $'"+ i + "'")
		append theItemArray myOb
	
	)
	theItemArray
)

function makeCopiesWithStartOffset ob copies offset = (
copiesArray = #()
	for i = 1 to copies do (
		theCopy = maxOps.clonenodes ob newnodes:&balls
		
		append copiesArray balls
		)
		
		for i = 1 to copiesArray.count do (
			copiesArray[i][1].speedAndStart.start += i*offset
			)
	return copiesArray
	
)

fn rotatePathDistort ob rot = (
	if classof ob.modifiers[1] == SpacePathDeform do (
		
		ob.modifiers[1].rotation += rot
		
		)
	
	
	)


fn sortByStartTime val1 val2 = (
	
	tVal1 = val1.value
	tVal2 = val2.value
	
case of
(
(tval1 < tval2): -1
(tval1 > tval2): 1
default: 0
)
	
	)
	
	
	
	-------------------------SPLINE GROW FUNCTIONS
	
	fn makeSplinesFromSelection myArray= (
	
	selSetArray = #()
	
	for i in myArray do
	
				(
				myIndex = findItem myArray i
				mySpline = i
				myPathDef = makeDeform mySpline
				myObj = SplineMake i 
				myObj.name = i.name + "_growPath"
				myPos = getKnotPoint mySpline 1 1
				myObj.transform = mySpline.transform
				--myObj.parent = mySpline
				myObj.isSelected = true
				myObj.pivot = mypos

				append SelSetArray myObj
					
					

				)
selectionSets["SplineGrow"] = SelSetArray
select selSetArray
)


fn SplineMake baseShape = (--used in makeSplinesFromSelection
myLength = curvelength baseShape 1
		ss = splineshape()
		addNewSpline ss
		for i = 1 to (mylength as integer) by (myLength as integer/50) do
			(
			addKnot ss 1 #smooth #curve [0,0,i]
			)
			updateshape ss
			myobj = ss
)

function makeDefOb ob = (
if isProperty ob.baseobject "speedAndStart" == false do (

speedAndStartCA = attributes speedAndStart
(
	
	parameters PRM_SpeedAndStart rollout:SpeedAndStartRoll
		(
		speed type:#float ui:speedSpn default: 100.0 
			start type:#Integer ui:startSpn default: 0 
		
		)
	rollout SpeedAndStartRoll "speed and start" width:162 height:48
	(
		spinner speedSpn "speed" pos:[51,6] width:99 height:16 range:[-1000,1000,100]
		spinner startSpn "start" pos:[59,27] width:90 height:16 range:[-1000,1000,0]
		
	)

)


if custAttributes.get ob 1 != undefined do (custAttributes.delete ob 1)

custAttributes.add ob speedAndStartCA baseobject:false) -- adds the rollout and attributes if it doesnt already exist

ob.speedAndStart.speed.controller = bezier_float()
ob.speedAndStart.start.controller = bezier_float()

thePath = undefined
if classof ob.modifiers[1] == SpacePathDeform do (
	thePath = ob.modifiers[1].path
	deleteModifier ob 1
)


pathDefScript = float_script()
pathDefScript.addTarget "start" ob.speedAndStart.start.controller
pathDefScript.addTarget "speed" ob.speedAndStart.speed.controller
pathDefScript.script = "(f-start)/100*(speed/100)"
myDefMod = spacePathDeform()
myDefMod.Stretch.controller = pathDefScript

addModifier ob myDefMod
try (changePathOfObject ob thePath) catch()

scaleScript = scale_script()
scaleScript.addTarget "percentAlongPath" ob.modifiers[1].percentAlongPath.controller
theScriptString = "scale = percentAlongPath/100 \n"
theScriptString += "if percentAlongPath >= 100 or percentAlongPath <= 1 then (scale = 0) else (scale = 1) \n"
theScriptString += "[scale,scale,scale]"

scaleScript.script = theScriptString




ob.scale.controller = scaleScript

makeVisibilityController ob
)





	
rollout obPathControlRoll "object path control" width:471 height:343
(
	
		

	GroupBox grp1 "Basic Operations" pos:[5,5] width:276 height:333
	
	button BTNcollectPaths "collect Paths" pos:[18,21] width:120 height:19 toolTip:"Select splines and hit the button to add to the window below.  Initially it will collect all splines in the scene."
	
	multiListBox pathsBx "" pos:[18,45] width:120 height:20
	multiListBox arrowsBx "" pos:[146,45] width:120 height:20
	
	button defObBtn "collect DeformObs" pos:[146,21] width:120 height:19 toolTip:"Select objects that have been made an arrow byt the Make Object an Arrow Button"
	button makeObBtn "Make Object an Arrow" pos:[27,300] width:234 height:20 toolTip:"if a path is selected it will attach it to that path"
	button rePathObsBtn "randomizeObsToPaths" pos:[24,270] width:237 height:24 toolTip:"Randomly Distributes selected objects in the right column to selected items in the LEFT column"
	
	

	
	-----
	
	GroupBox grp2 "Copy object tools" pos:[289,12] width:157 height:82	
	
	button makeCopiesBtn "copy Object with Offset" pos:[306,74] width:120 height:16
	spinner numOfCopiesSpn "" pos:[306,28] width:64 height:16 range:[0,100,10] type:#integer
	label lbl1 "# of copies" pos:[380,28] width:54 height:17
	
	spinner TimeOffsetSpn "" pos:[311,50] width:64 height:16 range:[0,100,10] type:#integer
	label lbl2 "time offset " pos:[380,50] width:62 height:17
	
	spinner rotSpn "" pos:[364,134] width:45 height:16 range:[-360,360,90] scale:1
	label lbl5 "rotateAmt" pos:[303,135] width:56 height:12 toolTip:"ShitAss Cock"

	

	
	
	
	
	------
	
	GroupBox grp11 "animation timing manipulation" pos:[289,111] width:167 height:117
	
	spinner speedSpn "" pos:[364,155] width:45 height:16 range:[-1000,1000,0] scale:1
	label lbl12 "Speed" pos:[303,157] width:43 height:12

	

	
	spinner startTimeSpn "" pos:[364,177] width:45 height:16 range:[-10000,10000,0] scale:1
	label lbl13 "Start Time" pos:[303,176] width:56 height:12

	

	
	spinner timeOffsetSpn2 "" pos:[365,200] width:45 height:16 range:[-100,100,0] type:#integer
	label lbl39 "time offset " pos:[299,199] width:56 height:17
	button rotBtn "X" pos:[415,135] width:14 height:14
	
			
			
			
	
	button BTNsplineFromSpline "Make spline from spline" pos:[324,282] width:120 height:32 toolTip:"Helpful for growing splines.  Will make spline that looks exactly like the current spline growing along the iteslf"
	
	
	
	--Basic Operation UI Functionality------------------
	
	on BTNcollectPaths pressed do (pathsBx.items = for i in selection where superClassof i == shape collect i.name)
	
	on obPathControlRoll open do
	(  --messageBox("This is tits")
					pathsBx.height = 200
					arrowsBx.height = 200
					pathsBx.items = for i in objects where superClassof i == shape collect i.name
					arrowsBx.items = for i in objects where classof i.modifiers[1] == SpacePathDeform collect i.name
					)
					
					

	on defObBtn pressed do
		(arrowsBx.items = for i in selection where classof i.modifiers[1] == SpacePathDeform collect i.name)
	on makeObBtn pressed do
	(
				pathNames = for i in pathsBx.selection collect pathsBx.items[i]
				pathObs = createArrayFromSelItems pathNames
				
				for i in selection do (
					makeDefOb i
					--changePathOfObject i pathObs[1]
		
		)--do some shit
		)
		
		
	on rePathObsBtn pressed do
	(
				selNames = for i in arrowsBx.selection collect arrowsBx.items[i]
				defObs = createArrayFromSelItems selNames
				
				pathNames = for i in pathsBx.selection collect pathsBx.items[i]
				pathObs = createArrayFromSelItems pathNames
				
				print (pathObs)
				print (defObs)
				
				for i in defObs do (
					changePathOfObject i pathObs[random 1 pathObs.count]
					)
				)--end rePathObsBtn
	on makeCopiesBtn pressed do
	(undo on (
			for i in selection where classof i.modifiers[1] == SpacePathDeform do (tempArray = makeCopiesWithStartOffset i numOfCopiesSpn.value timeOffsetSpn.value)
			)
	)
	on rotSpn changed val do
		(undo on ())
	on speedSpn changed val do
		(undo on ( for i in selection where classof i.modifiers[1] == SpacePathDeform do (i.speedAndStart.speed = val)))
	on speedSpn buttonup do
	(
		--speedSpn.value = 0
		)
	on startTimeSpn changed val do
		(undo on (for i in selection where classof i.modifiers[1] == SpacePathDeform do (i.speedAndStart.start = val)))
	on startTimeSpn buttonup do
	(
		--startTimeSpn.value = 0
		)
	on timeOffsetSpn2 changed val do
	(undo on (
		obs = for i in  selection  where classof i.modifiers[1] == SpacePathDeform collect i.speedAndStart.start.controller
		qsort obs sortByStartTime 
		tempArray = obs
		for i = 1 to obs.count do (
			obs[i].value += val*(i-1)
			print i)
		)--end undo
		
	)--end btnFn
	on timeOffsetSpn2 buttonup do
		(timeOffsetSpn2.value = 0)
	on rotBtn pressed do
		(undo on(for i in selection where classof i.modifiers[1] == SpacePathDeform do (i.modifiers[1].rotation += rotSpn.value)))
	on BTNsplineFromSpline pressed do
					(
					pathNames = for i in pathsBx.selection collect pathsBx.items[i]
					pathObs = createArrayFromSelItems pathNames
					makeSplinesFromSelection pathObs
				
				)
)

createDialog obPathControlRoll
