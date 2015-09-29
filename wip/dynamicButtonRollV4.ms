

fn createButtonsFromSelection = (
	myBitmap = render()
	theObjs = selection as array
	roString = ""
	roString += "rollout myRollout \"Dynamic Rollout\" width:" + renderWidth as string + "\theight:" +renderHeight as string + " (\n\n"
	roString += "imgTag theImage height:480 width:640 bitmap:myBitmap \n"
	
	for i = 1 to theObjs.count do (
		
		theOb = theObjs[i]
		obPos = get2dPos theOb
		num = i as string
		roString += "\t-- Button " + num + "\n"
		roString += "\tbutton bn_" + num + " \"" + theObjs[i].name + "\"" + "  width:30 height: 30  pos:" + obPos as string + "\n"
		--roString += "\tcheckbox cb_" + num + " \"Active\" checked:" + "\n"    
		
		-- on button pressed
		roString += "\ton bn_" + num + " pressed do (\n"
		roString += "\t\tselect (getNodeByName " + "\"" + theObjs[i].name + "\"" + ")\n"
		roString += "\t)\n"
		
		-- on checkbox changed
		roString += "\ton cb_" + num + " changed val do (\n"
		roString += "\t\t(getNodeByName " + "\"" + theObjs[i].name + "\"" + ").on = val\n"
		roString += "\t)\n\n"
		

	)
	roString +=  ")\n"
	roString += "createDialog myRollout\n"
	return roString
)

fn get2dPos obj =  (--returns the 2d coords of an object based on the render 
	screen_width=RenderWidth
	screen_height=RenderHeight
	back_vfb = bitmap screen_width screen_height
	front_vfb = bitmap screen_width screen_height
	thePos = (obj.position)* viewport.getTM()
	screen_origin = mapScreenToView [0,0] (thePos.z) [screen_width,screen_height]
	end_screen = mapScreenToView [screen_width,screen_height] (thePos.z) [screen_width,screen_height]
	world_size = screen_origin-end_screen
	x_aspect = screen_width/(abs world_size.x)
	y_aspect = screen_height/(abs world_size.y)
	return screen_coords = point2 (ceil(x_aspect*(thePos.x-screen_origin.x)) ) (ceil(-(y_aspect*(thePos.y-screen_origin.y) )))

)

doit = createButtonsFromSelection()
execute doit