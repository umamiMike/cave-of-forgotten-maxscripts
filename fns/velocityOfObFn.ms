function getSpeedOfOb ob = (
	
	
	p1 = at time (currentTime) (ob.pos) ;
	p2 = at time (currentTime + 1 ) (ob.pos) ;

theVelocity = (distance p1 p2	) * framerate
return (theVelocity as string  +" " + (units.systemType as string) + "  per second")
	
	)