fn getSpeedOfObject obj = (
	
	currentTime

time1 = at time (currentTime - 15f) obj.position
time2 = at time (currentTime + 15f) obj.position
	
	theDistance = distance time1 time2
	
	return theDistance/30
	
)