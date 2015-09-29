--
-- Created with Scripters Army Knife by Wahooney
--

-- Macroscript: Trajectory on/off
-- Created on 7/24/2006 2:12:53 AM with Scripters Army Knife by Wahooney

macroscript mcrTrajectoryonoff
	category:"Mikes"
	toolTip:"Trajectory On/Off"
	buttonText:"Mikes Traj On/Off"
(

	rollout roMyRollout "MyRollout" width:162 height:72
	(
		button btn1 "On" pos:[14,6] width:87 height:18
		button btn2 "Off" pos:[16,33] width:85 height:18
		
		on btn1 pressed  do
			$.showTrajectory = on
		on btn2 pressed  do
			$.showTrajectory = off
	)
	
createDialog roMyRollout 180 200


)
