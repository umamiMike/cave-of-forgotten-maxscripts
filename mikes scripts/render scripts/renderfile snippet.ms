--myMainArray



mypath = getsavepath caption "where is it?" initialDir: (getDir #renderOutput)
mySel = $ as array

if mypath != undefined do(
		for i = 1 to 5 do(
		

	
	
		myname = mypath +"testola"+i as string + ".tif"
		
		render activecamera outputfile:myname
		)

)