
if isProperty $ "speedAndStart" == false do (

speedAndStartCA = attributes speedAndStart
(
	
	parameters PRM_SpeedAndStart rollout:SpeedAndStartRoll
		(
		speed type:#float ui:speedSpn default: 100.0
			start type:#Integer ui:startSpn default: 0 
		
		)
	rollout SpeedAndStartRoll "speed and start"
	(
		spinner speedSpn "speed"
		spinner startSpn "start"
		)

)

custAttributes.add $ speedAndStartCA baseobject:true) -- adds the rollout and attributes if it doesnt already exist
$.speed.controller = bezier_float()
$.start.controller = bezier_float()
pathDefScript = float_script()
pathDefScript.addTarget "start" $.start.controller
pathDefScript.addTarget "speed" $.speed.controller
pathDefScript.script = "(f-start)/100*(speed/100)"

myDefMod = spacePathDeform()

myDefMod.percentAlongPath.controller = pathDefScript
addModifier $ myDefMod

scaleScript = scale_script()
scaleScript.addTarget "percentAlongPath" $.modifiers[1].percentAlongPath.controller

theScriptString = "scale = percentAlongPath/100 \n"
theScriptString += "if percentAlongPath >= 100 or percentAlongPath <= 10 then (scale = 0) else (scale = 1) \n"
theScriptString += "[scale,scale,scale]"

scaleScript.script = theScriptString




$.scale.controller = scaleScript