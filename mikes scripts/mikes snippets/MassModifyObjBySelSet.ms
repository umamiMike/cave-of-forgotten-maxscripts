myObs = selectionSets["bagStack"]
undo on
for i = 1 to myObs.count do(
	if classof myObs[i]  != Dummy then (
	--myObs[i].modifiers["Noise"].seed = random 0 400
	--myProp = myObs[i].modifiers["VolSelMap"].gizmo.pos
	--myObs[i].modifiers["VolSelMap"].gizmo.pos = [myProp[1],myProp[2],myRan -100 100]
		myRanNum = 2
		myRanPos = [myRan -myRanNum myRanNum,myRan -myRanNum myRanNum,myRan -myRanNum 0]
		myPos = myObs[i].pos
		myObs[i].pos = myPos + myRanPos
--deletemodifier myObs[i] 1
	)
	
)

fn myRan myLow myHigh =  (
	
	random myLow myHigh
	
)
