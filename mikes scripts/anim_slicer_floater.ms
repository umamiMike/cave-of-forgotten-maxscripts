





rollout sliceRoll "animslicer" width:225 height:101
(
	button btn5 "Do The Shit" pos:[136,61] width:76 height:31
	spinner spn1 "slice dimension" pos:[101,7] width:124 height:16 range:[1,3,1] type:#integer
	button btn9 "delete the shit" pos:[13,62] width:81 height:26
global slicedim
global mymax
global mymin
global mycenter
global myrot = 2

	spinner spn5 "angle" pos:[160,30] width:75 height:16 enabled:true range:[1,3,2] type:#integer
	on btn5 pressed do
	(
	undo on
		(
		for i = 1 to selection.count do
		(
		myobj = selection[i]
		myslice = SliceModifier ()
		myslice.Slice_Type = 2
		
		mycap = Cap_Holes ()
		
		angleArray = #(eulerAngles 0 0 0 , eulerAngles 90 90 0 , eulerAngles 90 90 90)
		
		
		objtrans = myobj.transform
		mysliceplane = myslice.slice_plane
		mymin = myobj.min
		mymax = myobj.max
		mydim = mymax - mymin
		mycenter = myobj.center
		addmodifier myobj myslice
		addmodifier myobj mycap
		
		myslice.slice_plane.rotation = eulertoquat (angleArray[myrot])
		
		
		animate on
		(
		at time 0f (mysliceplane.pos = [mydim[slicedim]/2,0,0])
		at time 20f (mysliceplane.pos = [-mydim[slicedim]/2,0,0])
		)
		)
		
		)
		
	)
	on spn1 changed val do
	(
	 slicedim = spn1.value
	)
	on btn9 pressed do
	(
			for i = 1 to selection.count do
			(
			myobj = selection[i]
			deletemodifier myobj 2
			deletemodifier myobj 1
			
			)
		)
	on spn5 changed val do
	(
	myrot = spn5.value
	)
)


animslice_floater = newRolloutFloater "animslicer" 300 150
			addRollout sliceRoll animslice_floater
