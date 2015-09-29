undo on 
myObjs = selection as array
for i = 1 to myObjs.count do(
	
myOb = myoBjs[i]
	
if i != 1 then actionMan.executeAction 0 "40182"  -- Views: Perspective User View
select myOb
actionMan.executeAction 0 "310"  -- Tools: Zoom Extents Selected
--hactionMan.executeAction 0 "40068"  -- Views: Camera View
macros.run "Lights and Cameras" "Camera_CreateFromView"
myCam = getActiveCamera()
myCam.target.pos = myOb.pos
myCam.target.parent = myOb
myCam.parent = myOb
myCam.name = myOb.name + "_Cam"
	
)
