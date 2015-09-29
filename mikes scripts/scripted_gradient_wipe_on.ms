for i = 1 to selection.count do
(

myMat = StandardMaterial()
myGradramp = Gradient_Ramp ()
myMat.opacityMap = myGradramp
myMat.opacitymap.coordinates.W_Angle = -90
myGradramp.coordinates.blur = 0.01
myGradramp.coordinates.U_Tiling = 0.5
myGradramp.coordinates.V_Offset = -0.5
myGradramp.gradient_ramp.flag__3.color = white
myGradramp.gradient_ramp.flag__2.color = white
myGradramp.gradient_ramp.flag__3.position = 50.0
selection[i].mat = myMat
fadetime = 30

animate on
		
				(
				at time 0f (myGradramp.coordinates.V_Offset = -0.5)
				at time (currentTime) (myGradramp.coordinates.V_Offset = -0.5)
				at time (currentTime + fadetime) (myGradramp.coordinates.V_Offset = 0.5)
				
				
				
				
				)
deleteKey myGradramp.coordinates.V_Offset.keys 1
selection[i].mat.showInViewport = true

)
