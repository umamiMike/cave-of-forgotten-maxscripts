
if tRoll != undefined do destroyDialog tRoll


rollout tRoll "thisRollYo" width:175 height:268
(
	
	slider sld1 "" pos:[0,75] width:200 height:25 type:#integer
	bitmap bmp1 "Bitmap" pos:[13,17] width:148 height:30
	button btn1 "Button" pos:[10,148] width:149 height:23
	

	spinner tRange "" pos:[118,125] width:42 height:16
	on sld1 buttonup do
	(
	print "did it"
	
	)
	on btn1 pressed do
	(
	--do it
		--m = selectBitmap caption:"Open the Diffuse Image..."
		myBitmap = bitmap 400 50 color:red
		rci = rolloutCreator "myRollout" "My Rollout" width:400
	rci.begin()
		rci.addControl #button #myButton "My Button"
		rci.addControl #slider #mySlider "mySlider" paramStr:"pos:[0,25] width:400"
		rci.addControl #bitmap  #thisbitmap "some shit" paramStr:"bitmap:( bitmap 400 50 color:red)"
	rci.addHandler #myButton #pressed filter:on codeStr:"MessageBox @Isn't this cool@ title:@Wow@"
	rci.addHandler #mySlider #buttonup filter:on codeStr:"MessageBox @Isn't this cool@ title:@Wow@"
	createDialog (rci.end())
	)
)

createDialog tRoll