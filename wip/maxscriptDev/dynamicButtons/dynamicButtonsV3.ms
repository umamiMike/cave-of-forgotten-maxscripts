--i need to get the width of the bbox of the objects on a 2d level, either xy 

--variables that can be changed
if myRoll != undefined then (destroyDialog myRoll)

axA = 1
AxB = 3

--variables NOT to change
rollMax = 600
selWidth = (selection.max - selection.min)[axA]
selHeight = (selection.max - selection.min)[axB]
rollWidth
rollHeight
myObs= selection as array
rollContent = ""
quote = ""
btnArray = #()
btnActArray = #()




-------------------FUNCTIONS------------------------------
fn setRollDims = (--sets rawselwidth an rawselheight
	
	ratio = 1/(SelWidth/SelHeight)
	
	if SelHeight < Selwidth then (
		rollWidth = rollMax
		rollHeight = (rollwidth * ratio) as integer
		) 
		
		else (
			rollHeight = rollMax
			rollWidth = (rollHeight * ratio) as integer
			
			)
)


function remap theVal high1 high2 = (
 returnVal = (high2 * theVal) /high1
     return returnVal
)


fn makeTheButtons index ob  = (
	buttonName = "Button" + index as string
	tX = map 
	tY = newY[index]
	quote = "\""
	myButton = "button " +  "button" + index as string + " " +quote+myObs[index].name as string +quote+ " pos:" + ([newX[index],rolldims[4] - newY[index]])  as string + " width:47 height:33\n" --(newX[index], newY[index]) 
	myRollButtons[index] = myButton
	)--end function makeTheButtons
	
fn buttonActions index = (
	buttonBegin = "on "
	buttonName = "Button" + index as string
	buttonMethod = " pressed do(\n"
	action = "select " + "$" + myObs[index].name as string
	buttonEnd = "\n)\n"
	together = buttonBegin + buttonName + buttonMethod + action + buttonEnd
	btnActArray[index] = together
	)
	

fn collectText theArray = (
	for i in theArray do (rollContent += i)
	)
	
--End the functions----------------------------------
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
	



myDialog = createDialog(execute doMe)