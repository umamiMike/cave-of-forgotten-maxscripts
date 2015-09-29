myPlane = $

h = myPlane.mat.diff_color_map.bitmap.height
w = myPlane.mat.diff_color_map.bitmap.width

renderwidth = w
renderheight = h

-- if w > h then (
-- 	myAsp = w/h as float
-- 	myPlane.width = myPlane.length*myAsp
-- 	)
-- else (
-- 	myAsp = w/h as float
-- 	myPlane.width = myPlane.length*myAsp
-- 	)

myCam = getActiveCamera()

-- 	myAngle = myCam.fov/2
-- 	
	
	
	
myPlane.transform = myCam.transform
in coordsys local myPlane.pos = [0,0,-myPlane.width]
	
myPlane.parent = myCam

	
	
myPlane.pivot = myCam.pos