ob1 = selection[1]
ob2 = selection[2]
OnePos = ob1.pos
TwoPos = ob2.pos
animRange = 30

undo on
animate on(
	
at time (currentTime)(ob1.pos = OnePos)
)
	
for i = 1 to 3 do (
	
	myPos = TwoPos - (OnePos/i)
	print (OnePos)
	animate on(
	at time (currentTime + animRange/i) (ob1.pos[i] = myPos[i])
	)
	
)	
	animate on(
	at time (currentTime + animRange) (ob1.pos = TwoPos)
	)