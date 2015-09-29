--i need to get the width of the bbox of the objects on a 2d level, either xy 



myRollButtons = #()
myObs= selection as array
axA = 1
AxB = 3
selDims = [$.min[axA], $.max[axA],$.min[axB],$.max[axB]]
myX = for i in selection collect i.pos[axA]
myY= for i in selection collect i.pos[axB]
rollDims = [1 as integer,600 as integer,1 as integer,400 as integer]
rollContent = ""
newX = #()
newY = #()
btnActArray = #()
--getting

--0 function to determine the rollout dimensions

fn findRollDims = (
	
	selection.max - selection.min
	
)
-------------------FUNCTIONS------------------------------
fn remap theValX theValY index = (--remap a value from 1 range to another..as in from the world space to the rollout size
	
	--myVal = low2 + (theVal - low1) * (high2 - low2) / (high1 - low1)
	myValX = rollDims[1] + (theValX - selDims[1]) * (rollDims[2] - rollDims[1]) / (selDims[2] - seldims[1])
	myValY = rollDims[3] + (theValY - selDims[3]) * (rollDims[4] - rollDims[3]) / (selDims[4] - seldims[3])
	newX[index] = myValX as integer
	newY[index] = myValY as integer
)
fn makeTheButtons index ob  = (
		buttonName = "Button" + index as string
	tX = newX[index]
	tY = newY[index]
	   quote = "\""
		myButton = "button " +  "button" + index as string + " " +quote+myObs[index].name as string +quote+ " pos:" + ([newX[index],rolldims[4] - newY[index]])   as string + " width:47 height:33\n" --(newX[index], newY[index]) 
		myRollButtons[index] = myButton
	)
	
fn buttonActions index = (
	buttonBegin = "on "
	buttonName = "Button" + index as string
	buttonMethod = " pressed do(\n"
	action = "select " + "$" + myObs[index].name as string
	buttonEnd = "\n)\n"
	together = buttonBegin + buttonName + buttonMethod + action + buttonEnd
	btnActArray[index] = together
	
)
fn collectText theArray = ( -- puts  theArray myRollButtons all together in one long ass string, I think I need this for the final execute

	for i  in theArray do(
		rollContent += i
		
	)
	
)
-- i need to do the remapping somehow...going from the scene to the rollout width

--Program Flow---------------------
for i = 1 to myObs.count do (
	index = i --the index of an object in myObs
	obj = myObs[i] -- the Actual Object
	c = myX[i] as integer --
	d = myY[i] as integer
	remap  obj.pos[axA] obj.pos[axB] index

)
for i = 1 to myObs.count do (
	a = i --the index of an object in myObs
	b = myObs[i] -- the Actual Object
	
	makeTheButtons a b
	
	)
	for i = 1 to myObs.count do (
		
		buttonActions i
		
	)

collectText myRollButtons
collectText btnActArray

--making the rollout strings for executing
RollIn = "rollout myRoll \"My Roll\" width:"+(rollDims[2] as integer) as string + " height:" + (rollDims[4] as integer) as string+"\n(\n" --the rollout definition
RollEnd = "\n)"--end of the rollout
doMe = rollIn+RollContent+RollEnd --adds the strings together and is exectuted as code
	
	
	
destroyDialog myRoll
	myDialog = createDialog(execute doMe)