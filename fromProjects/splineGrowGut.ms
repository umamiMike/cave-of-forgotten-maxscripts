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


fn SplineMake baseShape = (
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

--animate1 myObj


append SelSetArray myObj
	
	

)
selectionSets[splineGrowRoll.shapeNamesTxt.text] = SelSetArray
select selSetArray
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

rollout splineGrowRoll "Spline Grow" width:262 height:375
(
	
	button makeSplinesFromSelBtn "Make Splines From Spline" pos:[101,99] width:133 height:23
	button animate2Btn "animate2" pos:[89,240] width:145 height:24
	spinner stretchSpn "" pos:[68,185] width:51 height:16 range:[0,1,0.2]
	GroupBox grp1 "Animation" pos:[10,163] width:241 height:109
	GroupBox grp2 "Spline Creation" pos:[6,8] width:244 height:144
	label lbl1 "Stretch" pos:[24,185] width:46 height:17
	spinner animLengthSpn "" pos:[69,217] width:51 height:16 range:[0,1000,60] type:#integer scale:0.1
	label lbl2 "animLength" pos:[24,217] width:46 height:17
	spinner noOfKnotsSpn "" pos:[178,70] width:51 height:16 range:[0,1000,50] type:#integer
	label lbl3 "Number of Knots" pos:[86,72] width:86 height:17
	edittext shapeNamesTxt "" pos:[112,24] width:112 height:16
	label lbl13 "Shape Names" pos:[32,24] width:74 height:16
	
	
	spinner loSpn "" pos:[110,303] width:52 height:16 range:[-100,100,0.5]
	label lbl18 "Lo" pos:[122,286] width:24 height:18
	label lbl19 "Random Thickness" pos:[12,304] width:90 height:16
	spinner hispn "" pos:[169,303] width:52 height:16 range:[-100,100,0.2]
	label lbl20 "Hi" pos:[172,286] width:25 height:17
	button ranDoBtn "X" pos:[225,304] width:27 height:16


	spinner HeightSpn "" pos:[109,340] width:52 height:16 range:[-100,100,2]
	label lbl35 "Rect Spline" pos:[41,341] width:58 height:16
	spinner LenSpn "" pos:[168,340] width:52 height:16 range:[-100,100,2]
	label lbl37 "Height" pos:[112,322] width:51 height:17
	label lbl38 "Length" pos:[169,322] width:46 height:17
	button doRectBtn "X" pos:[225,340] width:27 height:16
	pickbutton pckObjBtn "x" pos:[13,49] width:20 height:20
	
	
	label pckLbl "Pick Obj to instance" pos:[35,51] width:97 height:17
	button doForObjBtn "Deform Objs from Sel" pos:[15,125] width:143 height:18
	on makeSplinesFromSelBtn pressed do
		try (makeSplinesFromSelection()) catch(messagebox "It didnt work")
	on animate2Btn pressed do
	(
			try (
			for i in selection do (animate2 i)
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
	on doForObjBtn pressed  do
		for i in selection do (makeDeformObj i
	
	
	)
)

createDialog splineGrowRoll

