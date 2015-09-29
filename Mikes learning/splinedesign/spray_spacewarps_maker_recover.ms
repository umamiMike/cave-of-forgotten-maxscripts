-- make the particles

Global newWind
Global newDrag
Global newSpray


function MaketheParticles =
(
newWind = Wind ()
newDrag = Drag ()
newSpray = PCloud ()
newSpray.quantityMethod = 1
newSpray.Total_Number = 40
newSpray.isSelected = true
newSpray.viewPercent = 100
bindSpacewarp newSpray newWind
bindSpacewarp newSpray newDrag
)

MaketheParticles()

-- make the particles

function MaketheBranches =
(

branchSpray = PCloud ()
branchSpray.quantityMethod = 1
branchSpray.Total_Number = 10
branchSpray.isSelected = true
branchSpray.viewPercent = 100
bindSpacewarp newSpray newWind
bindSpacewarp newSpray newDrag
)

--MaketheBranches()