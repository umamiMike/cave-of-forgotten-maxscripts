fn mainLoop  = (
for i in selection do ( addXformMod i)
	
	
)

fn RanPickMinOrMax ob = ( -- return a position
	
	
	
)

fn addXformMod ob =  (
	delAllShutters ob
	myMinMax = nodeGetBoundingBox ob ob.transform
	ob.pos -= myMinMax[2]
	myMod = xform name:"shutterXform" 
	myMod.center = myMinMax[2]
	
	animateTheXform myMod
	addModifier ob myMod
	myMinMax
	
)

fn delAllShutters ob= (
	
	while ob.modifiers["shutterXform"] != undefined do (deletemodifier ob ob.modifiers["shutterXform"] )
	
	)
	
	
fn animateTheXform myMod = (
	with animate on (
	at time (currentTime) myMod.gizmo.scale = [1,1,0]
		at time (currentTime + 30) myMod.gizmo.scale = [1,1,1]
		
	)
	
	if currentTime != 0 do (deleteItem myMod.gizmo.scale.controller.keys 1)
	
	)