--select the spline
--make the point parent and add the pathConstraint
-- if you need more segments adda  turbosmooth and turn smoothing groups off

fn mainLoop = (
	if classof $ == line then (
		if $.modifiers["Normalize_Spl"] == undefined do (addmodifier myPath (Normalize_Spl()))
	myPandP = makePointParentForRig()
	myPathDef = makeDeform myPandP[1] myPandP[2]
	makeBoxAndSetupRig myPathDef myPandP[1]
		
	)
	
	else (messagebox "please select a spline")
	
	
)



fn makePointParentForRig = (
myPath = $

myPos = getKnotPoint myPath 1 1
myPathDef = SpacePathDeform ()
myPathDef.path = myPath
myPathDef.Stretch = 0
myPoint = point()
myPathConstraint =  Path_Constraint()
myPathConstraint.percent.controller = bezier_float()
myPathconstraint.path = myPath


myPoint.position.controller = myPathConstraint
return #(myPath,myPoint)
)
	
fn makeDeform mySpline myPoint = (
	
myPathDef = SpacePathDeform ()
myFS = 	Float_Script()
--add target to myFS
myFS.addNode "control" myPoint 
myFS.script = "control.position.controller.percent/100.00"
	--add myFS to myPathDef
myPathDef.stretch.controller = myFS

myPathDef.path = mySpline
myPathDef.Stretch = 0

return myPathDef	
	
)




fn makeBoxAndSetupRig myPathDef myPath = (
	
myObj = box()
myObj.height = 0
myObj.width = 5
myObj.length = 2
myObj.heightsegs = 200
myObj.transform = myPath.transform
addModifier myObj myPathDef 
myObj.parent = myPath
myObj.isSelected = true

myObj.pivot = mypos
	myObj.height = curvelength myPath 1
	
	myHS = 	Float_Script()
	myHS.addNode "control" myPath 
	myHS.script = "curvelength myPath 1"
	
	
	myObj.height.controller = myHS
	return myObj
	--add some shit to make the box change height according to the length of the line if it changes
	--
	
)

-- AddTarget <&TSTR>Name <value>Target Offset:<time> Owner:<value>
--        Name is In parameter
--        Offset default value: 0f
--        Owner default value: undefined