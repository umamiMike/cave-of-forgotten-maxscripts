--Camera Map/Render calculator 0.9
--Glenn Cotter
--

--This helps you calculate the settings for camera, and ouput size changes.  (For when you need an exact pixel match.)
--It is assumed that you want to match the output of the two cameras.  
--In PhotoShop, use 'canvas size' to expand or crop an image.  Keep centered.



global camh



fn cammath =
(

		fc=camh.fcl.value as float
		fx=camh.frx.value as float
		fy=camh.fry.value as float
		
		tx=camh.tcx.value as float
		ty=camh.tcy.value as float
		
		sf=tx/fx --scale factor
	
		tc=fc/sf
		
		camh.labfcl.text=(fc as string)+"  mm"
		camh.labfrx.text=camh.frx.value as string
		camh.labfry.text=camh.fry.value as string
		
		camh.labtcl.text=(tc as string)+"  mm"
		camh.labtrx.text=camh.tcx.value as string
		camh.labtry.text=camh.tcy.value as string
)	

fn renmath =
(

		fc=camh.fcl.value as float
		fx=camh.frx.value as float
		fy=camh.fry.value as float
		
		ti=camh.tci.value as float
		
		
		sf=fc/ti --scale factor
	
		tw=(fx*sf) 
		th=(fy*sf) 
		
		tw=tw as integer
		th=th as integer
		
		camh.labfcl.text=(fc as string)+"  mm"
		camh.labfrx.text=camh.frx.value as string
		camh.labfry.text=camh.fry.value as string
		
		camh.labtcl.text=(ti as string)+"  mm"
		camh.labtrx.text=tw as string
		camh.labtry.text=th as string
)	
	


rollout camh "Camera Map/Render Calculator"

	--setting up input interface

(
	
	
	group "First Camera" 
	(
	label labc1 "A camera set at (in mm):" align:#left across:2
	spinner fcl "mm" range:[9,10000, 50] align:#right type:#float
	
	label labr1 "Set to render at:" align:#left across:2
	spinner frx "width" range:[1,99999, 720] align:#right type:#integer
	label labn "" align:#left across:2
	spinner fry "height" range:[1,99999, 560] align:#right type:#integer
	)
	
	label labset "SET:"
	
	group "New Canvas Size" 
	(

	spinner tcx "width" range:[1,99999, 2048] align:#right type:#integer
	spinner tcy "height" range:[1,99999, 1556] align:#right type:#integer
	
	--button to collect the values
	
	button calc "Calculate New Camera Settings"
	
	)
	label labor "OR:"
	
		
	group "New Camera, Keep Same Image Aspect" 
	(
	
	spinner tci "mm" range:[9,10000, 28] align:#right type:#float

	--button to collect the values
	
	button rend "Calculate New Output Settings"
	
	)

	
	------------------------------------------------------
	


	------------------------------------------------------
	--display the results of the calculations
	
	group "Compare Cameras/Output Size"
	(
	label labacam "A camera set at:" align:#left across:2
	
	label labfcl "mm" align:#right  
	
	label laby "Set to render at:" align:#left across:4 
	label labfrx "width" align:#right
	label labby "by" align:#right
	label labfry "height" align:#right
	
	label labspb ""
	
	label labbcam "Aligns with a camera set at:" align:#left across:2
	
	label labtcl "mm" align:#right  
	
	label labsr "Set to render at:" align:#left across:4 
	label labtrx "width" align:#right
	label labby2 "by" align:#right
	label labtry "height" align:#right
	
	
	)

on calc pressed do cammath()
on rend pressed do renmath()
)

rollout ab "About"
(
	label labab "This helps you calculate the settings for camera and ouput size"
	label lababb "changes, and need to have a pixel for pixel match."	
)

--------------------------------------	

-- create the rollout window and add the rollouts

if CamFloater != undefined do
				(
				closerolloutfloater CamFloater
				)		
CamFloater = newRolloutFloater "Camera Map/Render Helper" 330 550  

addRollout camh CamFloater
addRollout ab CamFloater
