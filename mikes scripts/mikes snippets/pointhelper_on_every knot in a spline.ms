myspline = $

mysplineNum = numSplines myspline -- the number of splines in the shape

for i = 1 to mysplineNum do( --cycle through every spline in the shape

Knotcount = numKnots myspline i --find the number of knots in the spline

	 for x = 1 to Knotcount do --cycle through the knots in the spline
		(
		myknot = getKnotPoint myspline i x
		myPoint = Point()
		myPoint.pos = myknot
		)
	
)	