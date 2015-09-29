-- I have stopped at getting the button position the getBtnPos function...I know it can be done...I just dont know how atm and I don't have it in me.

clearListener()
global myRollout

axA = 1
AxB = 3

try(destroyDialog myRollout)catch()

-- Function to collect the lights in the scene
fn get_objs = 
(
    objs = #()
    for i in selection do (
        append objs i
    )
    return objs
)

fn setRollDims = (--sets rawselwidth an rawselheight
	

rollMax = 600
	
selWidth = (selection.max - selection.min)[axA]
selHeight = (selection.max - selection.min)[axB]
	

	
	if SelHeight < Selwidth then (
		ratio = (SelHeight/SelWidth)
		rollWidth = rollMax
		rollHeight = (rollwidth * ratio) as integer
		) 
		
		else (
			ratio = (SelWidth/SelHeight)
			rollHeight = rollMax
			rollWidth = (rollHeight * ratio) as integer
			
			)
			
		return #(rollWidth,rollHeight)
)

-- fn getBtnPos obj rollDims = (
-- 	
-- 	selWidth = (selection.max - selection.min)[axA]
-- 	selHeight = (selection.max - selection.min)[axB]
-- 	
-- 	s
-- 	
-- 	remap obj posA 
-- 	
-- )


function remap theVal high1 high2 = (
 returnVal = (high2 * theVal) /high1
     return returnVal
)

fn createButtonsFromSelection = (
	theObjs = get_objs()
	roString = ""
	roString += "rollout myRollout \"Dynamic Rollout\" width:" + rollDims[1] as string + "\theight:" + rollDims[2] as string + " (\n\n"
	for i = 1 to theObjs.count do (
		
		theOb = theObjs[i]
		theOb.pos
		
		num = i as string
		roString += "\t-- Button " + num + "\n"
		roString += "\tbutton bn_" + num + " \"" + theObjs[i].name + "\"" + "  width:30 height: 30 \n"
		--roString += "\tcheckbox cb_" + num + " \"Active\" checked:" + "\n"    
		
		-- on button pressed
		roString += "\ton bn_" + num + " pressed do (\n"
		roString += "\t\tselect (getNodeByName " + "\"" + theObjs[i].name + "\"" + ")\n"
		roString += "\t)\n"
		
		-- on checkbox changed
		roString += "\ton cb_" + num + " changed val do (\n"
		roString += "\t\t(getNodeByName " + "\"" + theObjs[i].name + "\"" + ").on = val\n"
		roString += "\t)\n\n"
	)
	return roString
)


--first have to find position of object
--then Have to find 


rollDims = setRollDims()
roString = createButtonsFromSelection()

roString +=  ")\n"
-- End the Dialog String
-----------------------------------

-- This will execute the string to create a valid rollout definition
execute roString

-- Create the rollout
createDialog myRollout