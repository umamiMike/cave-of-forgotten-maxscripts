chamferBend = bend()
chamferBend.FromTo = on
chamferBend.BendTo = 0.75
chamferBend.BendFrom = 0
chamferBend.BendAxis = 1
chamferBend.bendDir = 90





--$.edgeChamfer = 0.25
--$.EditablePoly.buttonOp #Chamfer
--$.edgeChamfer = 0.125
--$.EditablePoly.buttonOp #Chamfer
--modPanel.setCurrentObject $.baseObject

modPanel.addModToSelection (chamferBend) ui:on

subobjectLevel = 0
 animate on
 
 (			at time 0f (chamferBend.BendAngle = 179)
 			at time (currentTime) (chamferBend.BendAngle = 179)
			at time (currentTime+30) (chamferBend.BendAngle = 0)
)