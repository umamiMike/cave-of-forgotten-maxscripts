macroScript Fade_Keys
	category:"Mikes"
	toolTip:"Fade Keys"
	
(

global endFrame = 10
global fadetime = 5

fn fadeOut = 
(
for i = 1 to selection.count do
		(
		selection[i].visibility = bezier_float()
		animate on
		
				(
				at time 0f ($.visibility.controller.value = 1)
				at time (currentTime) ($.visibility.controller.value = 1)
				at time (currentTime + fadetime) ($.visibility.controller.value = 0)
				at time (currentTime + endFrame-fadetime) ($.visibility.controller.value = 0)
				at time (currentTime + endFrame) ($.visibility.controller.value = 1)
				
				
				
				)
				deleteKey selection[i].visibility.controller.keys 1
		)
)

fn fadeIn = 

(
for i = 1 to selection.count do
		(
		selection[i].visibility = bezier_float()
		animate on
		
				(
				at time 0f ($.visibility.controller.value = 0)
				at time (currentTime) ($.visibility.controller.value = 0)
				at time (currentTime + fadetime) ($.visibility.controller.value = 1)
				at time (currentTime + endframe-fadetime) ($.visibility.controller.value = 1)
				at time (currentTime + endframe) ($.visibility.controller.value = 0)
				
				
				
				)
				deleteKey selection[i].visibility.controller.keys 1
		)
)



rollout fade_rollout "fader" width:162 height:300
(
	button fadeOutbtn "fade em out" pos:[8,8] width:128 height:16
	button fadeInbtn "Fade em In" pos:[8,32] width:128 height:16
	spinner spn1 "End Frame" pos:[16,56] width:120 height:16 range:[0,100,10] type:#integer
	spinner spn2 "fade time" pos:[16,80] width:120 height:16 range:[0,100,5] type:#integer
	on fadeOutbtn pressed do
		fadeout()
	on fadeInbtn pressed do
		fadeIn()
	on spn1 changed val do
		endFrame = val
	on spn2 changed val do
		fadeTime = val
)
fade_floater = newRolloutFloater "Fader Keys" 265 265
		addRollout fade_rollout fade_floater

)