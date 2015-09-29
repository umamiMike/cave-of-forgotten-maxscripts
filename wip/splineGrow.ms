--TODO: button to make splines renderable or not...toggle?

try (destroydialog splineGrowRoll) Catch()

--global myLength
--global myob
NumberOfKnots = 60
StretchVar = .2
endFrame = 70
--easeFrames = calcEaseFrames()



fn calcEaseFrames = (
	(endFrame *.45) as integer
)

fn makeSplinesFromSelection = (
	
	myArray = selection as array
	selSetArray = #()
	
	for i in myArray do
	
				(
				myIndex = findItem myArray i
				mySpline = i
				myPathDef = makeDeform mySpline
				myObj = SplineMake i 
				myObj.name = splineGrowRoll.shapeNamesTxt.text +"_" + myIndex as string
				myPos = getKnotPoint mySpline 1 1
				myObj.transform = mySpline.transform
				addModifier myObj myPathDef 
				--myObj.parent = mySpline
				myObj.isSelected = true
				myObj.pivot = mypos

				append SelSetArray myObj
					
					

				)
selectionSets[splineGrowRoll.shapeNamesTxt.text] = SelSetArray
select selSetArray
)


fn SplineMake baseShape = (--used in makeSplinesFromSelection
myLength = curvelength baseShape 1
		ss = splineshape()
		addNewSpline ss
		for i = 1 to (mylength as integer) by (myLength as integer/NumberOfKNots) do
			(
			addKnot ss 1 #smooth #curve [0,0,i]
			)
			updateshape ss
			myobj = ss
)


fn makeDeform mySpline = (
	
myLength = curvelength mySpline 1

myPathDef = SpacePathDeform ()


myPathDef.path = mySpline
myPathDef.Stretch = 0

return myPathDef	
	
)

fn makeDeformObj mySpline = (
	
myObj = instance splineGrowRoll.pckObjBtn.object
myLength = curvelength mySpline 1
if hasproperty myObj "Height" do(myObj.Height = myLength)
myObj.transform = mySpline.transform
myPathDef = SpacePathDeform ()


myPathDef.path = mySpline
myPathDef.Stretch = 0
myPathdef.axis = 1
addModifier myObj myPathDef 
	
)



fn animate1 myobj = (
	
	myPathDef = myobj.modifiers["Path Deform Binding"]
	try(
		deletekeys myPathDef.Percent_along_path.controller #allKeys
		deletekeys myPathDef.Stretch.controller #allKeys
	)
	catch()
	
	now = currentTime
	animate on
		
	(
		at time now (myPathDef.Percent_along_path = 0)
		at time now (myPathDef.Stretch = .001)
		--at time (now + 29) (myPathDef.Percent_along_path = 50)
		at time (now + 29) (myPathDef.Stretch = 1)
		--at time (now + 80) (myPathDef.Percent_along_path = 100)
		--at time (now + 60) (myPathDef.Stretch = 1)
		--at time (now + 80) (myPathDef.Stretch = 0)
	)
	deleteKey myPathDef.stretch.controller 1
	deleteKey myPathDef.Percent_along_path.controller 1
)
fn animate2 myobj = (
	easeFrames = calcEaseFrames()
	myPathDef = myobj.modifiers["Path Deform Binding"]
	try(
		deletekeys myPathDef.Percent_along_path.controller #allKeys
		deletekeys myPathDef.Stretch.controller #allKeys
	)
	catch(messageBox "No Keys were Deleted...I dont know why really...")
	
	now = currentTime
	thickNess = myObj.thickness
	animate on
		
	(
		at time now (myPathDef.Percent_along_path = 0)
		at time now (myObj.thickness =  0)
		at time now (myPathDef.Stretch = .001)
		
		--at time (now + easeFrames) (myPathDef.Percent_along_path = 0)
		at time (now + easeFrames) (myPathDef.stretch = stretchVar)
		at time (now + 2)(myObj.thickness = thickNess)
		
		--at time (now + (endFrame - easeFrames)) (myPathDef.Percent_along_path = 100)
		at time (now + (endFrame - easeFrames)) (myPathDef.stretch = stretchVar)
			
		at time (now + endFrame) (myPathDef.Percent_along_path = 100)
		at time (now + endFrame - 2)(myObj.thickness = thickNess)
		at time (now + endFrame ) (myPathDef.stretch = .001)	
		at time (now + endFrame)(myObj.thickness = 0)

	)
	deleteKey myPathDef.stretch.controller 1
	deleteKey myPathDef.Percent_along_path.controller 1
	
	
)



fn ranSplineThickness myObj = (
	
	if myObj.render_thickness.keys == undefined then (
	
		Try(
		theThickness = calcThickness()
		myObj.render_rectangular = false
		myObj.thickness = theThickness
			)
	catch(It didnt work)
	
)

else  (
	theThickness = calcThickness()
	for i = 2 to  myObj.render_thickness.keys.count - 1 do (
		
	myObj.render_thickness.keys[i].value = theThickness
	)
)
	
)
fn calcThickness = (
	
	myRanFrom = splineGrowRoll.loSpn.value
	myRanTo = splineGrowRoll.hiSpn.value 
	theThickness = random myRanFrom myRanTo
	return theThickness
	
	)

fn ranSplineRectThickness myObj myRanFrom myRanTo Swidth Sheight = (

		myObj.render_rectangular = true
		myObj.render_width = Swidth + random myRanFrom myRanTo
		myObj.render_Length = SHeight + random myRanFrom myRanTo
	
)
fn makeRenderable myObj = (
	try(myObj.baseobject.render_renderable = not myObj.baseobject.render_renderable
		myObj.baseobject.render_displayRenderMesh = not myObj.baseobject.render_displayRenderMesh
		)catch()
	)
rollout splineGrowRoll "Spline Grow" width:576 height:497
(
	
	button makeSplinesFromSelBtn "Make Splines From Spline" pos:[99,77] width:133 height:23 toolTip:"For every spline you have selected it will create a spline that will grow on it."
	
	
	button animate2Btn "animate1" pos:[19,219] width:70 height:24
	spinner stretchSpn "" pos:[66,185] width:51 height:16 range:[0,1,0.2]
	GroupBox grp1 "Animation" pos:[6,168] width:241 height:94
	GroupBox grp2 "Spline Creation" pos:[336,17] width:244 height:136
	label lbl1 "Stretch" pos:[22,185] width:46 height:17
	spinner animLengthSpn "" pos:[174,184] width:51 height:16 range:[0,1000,60] type:#integer scale:0.1
	label lbl2 "animLength" pos:[129,184] width:46 height:17
	spinner noOfKnotsSpn "" pos:[176,51] width:51 height:16 range:[0,1000,50] type:#integer
	label lbl3 "Number of Knots" pos:[86,51] width:86 height:17
	edittext shapeNamesTxt "" pos:[115,28] width:112 height:16
	label lbl13 "Shape Names" pos:[37,30] width:74 height:16
	
	
	spinner loSpn "" pos:[106,416] width:52 height:16 range:[-100,100,0.5]
	label lbl18 "Lo" pos:[118,399] width:24 height:18
	label lbl19 "Random Thickness" pos:[8,417] width:90 height:16
	spinner hispn "" pos:[165,416] width:52 height:16 range:[-100,100,0.2]
	label lbl20 "Hi" pos:[168,399] width:25 height:17
	
	button ranDoBtn "X" pos:[221,417] width:27 height:16


	spinner HeightSpn "" pos:[105,454] width:52 height:16 range:[-100,100,2]
	label lbl35 "Rect Spline" pos:[37,455] width:58 height:16
	spinner LenSpn "" pos:[164,454] width:52 height:16 range:[-100,100,2]
	label lbl37 "Height" pos:[108,436] width:51 height:17
	label lbl38 "Length" pos:[165,436] width:46 height:17
	
	button doRectBtn "X" pos:[221,454] width:27 height:16 toolTip:"changes the selection of splines to rectangular and randomizes their dimensions"
	pickbutton pckObjBtn "x" pos:[402,113] width:20 height:20
	
	
	label pckLbl "Pick Obj to instance" pos:[426,116] width:97 height:17
	button doForObjBtn "Deform Objs from Sel" pos:[378,134] width:143 height:18
	button renderable "Toggle Renderable" pos:[16,371] width:73 height:21 enabled:true toolTip:"ADD A TOOLTIP"
	
	
	on makeSplinesFromSelBtn pressed do
		try (makeSplinesFromSelection()) catch(messagebox "It didnt work")
	
			
	on animate2Btn pressed do
	(
			try (
			for i in selection do (animate1 i)
			) 
			catch(messageBox "It didnt work hoss")
		)
	on stretchSpn changed val do
		stretchvar = val
	on animLengthSpn changed val do
		endFrame = val
	on noOfKnotsSpn changed val do
		numberOfKnots = val
	on ranDoBtn pressed do
	(
			for i in selection do(
				
				ranSplineThickness i
				
				)
			)
	on doRectBtn pressed do
	(
			for i in selection do(
				ranSplineRectThickness i  loSpn.value hiSpn.value lenSpn.value HeightSpn.value
				)
			)
	on pckObjBtn picked obj do
		pckLbl.caption = obj.name
	on doForObjBtn pressed do
		for i in selection do (makeDeformObj i
	
	
	)
	on renderable pressed do
	(for i in selection where superclassof i.baseobject == shape do (makeRenderable i)
		)
)

createDialog splineGrowRoll

