-- Overscan 0.2 - (c) 2005 Martin Breidt (martin@breidt.net)
-- Useage: Run this script with an active camera view.
--
-- Adjust render image width and height and the script will adjust
-- render resolution and camera focal length so that your previous
-- camera view will be retained, but zoomed in/out
-- This can be useful if you need to render additional pixels to the
-- sides of the image without changing the perspective
--
-- The conversion forumla is based on a webforum posting by Graham Calhoun
--
-- New in 0.2: Option to keep original camera; old resolution is stored; relative values for sizes

rollout os_ro "New Image Dimensions" (
	label l1 "Old size: " offset:[8,0] across:3
	label startRes "" offset:[10,0]
	button resetRes "Update" width:40 height:14 offset:[18,-2] tooltip:"Use current render size as reference"
	
	spinner xres_s "New Width:  " range:[-10000,10000,1] type:#integer width:105 align:#left
	spinner yres_s "New Height: " range:[-10000,10000,1] type:#integer width:105 align:#left
	
	checkbutton relB "rel" offset:[60,-38] width:20 height:30 tooltip:"Use numbers as relative values added to the current render size"

	checkbox newCamCheck "Copy Camera" checked:false align:#center offset:[0,5]

	button go_b " Apply Overscan " tooltip:"Modify/create camera and adjust render settings to match desired resolution"

	local currentXres, currentYres

	on resetRes pressed do (
		relB.checked = false
		xres_s.value = currentXres = renderWidth
		yres_s.value = currentYres = renderHeight
		startRes.text = ( (currentXres as string) + " x " + (currentYres as string) )  
	)

	on relB changed state do (
		if state then (
			xres_s.value -= currentXres
			yres_s.value -= currentYres
		) else (
			xres_s.value += currentXres
			yres_s.value += currentYres
		)
	)

	on go_b pressed do (
		local cam = getActiveCamera()
		if (cam!=undefined) then (
			undo "Overscan" on (
				renderSceneDialog.close()				-- need to close dialog to make changes stick
				-- if newCam.checked then cam = copy cam	-- create copy of camera
				local newCam
				if newCamCheck.checked then (
					-- create copy of camera
					if not (maxOps.cloneNodes cam newNodes:&newCam) then throw "Overscan: error! cannot copy camera"
					newCam[1].name = (cam.name + "_overscan" + (xres_s.value as string) + "x" + (yres_s.value as string))
					
					cam = newCam[1]
				)
				local xres = xres_s.value
				local yres = yres_s.value
				if relB.checked then (
					xres += currentXres
					yres += currentYres
				)
				
				local aw_h = getRendApertureWidth() * 0.5
				local old_f = aw_h / (tan (cam.fov*0.5))
				local new_f = old_f * (renderWidth/(xres as float))
				cam.fov = 2 * atan (aw_h / new_f)
				-- set new render resolution
				renderWidth = xres		-- no undo possible
				renderHeight = yres		-- no undo possible
				viewport.setCamera cam
			)
		) else (
			messageBox "Active viewport is not a camera viewport"
		)
	)
	on os_ro open do (
		xres_s.value = currentXres = renderWidth
		yres_s.value = currentYres = renderHeight
		startRes.text = ( (currentXres as string) + " x " + (currentYres as string) )
	)
)

rollout about_ro "About..." (
	label l0 "© 2005 M. Breidt"
	label l1 "This tool takes the camera from the" align:#left
	label l2 "currently active viewport and ad-" align:#left
	label l3 "justs the focal length such that" align:#left
	label l35 "when rendering a new image with" align:#left
	label l4 "new width/height, the old image" align:#left
	label l5 "will be a sub-/superimage of the" align:#left
	label l6 "new without changing the perspec-" align:#left
	label l7 "tive. Useful, if you need extra" align:#left
	label l8 "space at the edges of your image." align:#left
)

try (
	-- close existing rolloutFloater
	closeRolloutFloater overscanDialog
) catch ()
overscanDialog = newRolloutFloater "overscan 0.2" 200 166
addRollout os_ro overscanDialog
addRollout about_ro overscanDialog rolledUp:true
