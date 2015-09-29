-- make the particles
function MaketheParticles =
(
newWind = Wind ()
newDrag = Drag ()
newSpray = PCloud ()
newSpray.quantityMethod = 1
newSpray.Total_Number = 100
newSpray.isSelected = true
newSpray.viewPercent = 100
bindSpacewarp newSpray newWind
bindSpacewarp newSpray newDrag
)

MaketheParticles()