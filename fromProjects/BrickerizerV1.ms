-- BrickerizerV1.ms
-- By Michael Little, www.maple3d.com 
-- Script to turn standard max boxes into brick walls.
-- 3ds max 4,5,6
------------------------------------------------------

fn BTotalf endty n m = (
	if endty == 1 then return ((n*m)as string)
	else return ((n*m - ceil (m/2) - (mod m 2))as integer)as string
	)

fn FillBrickPos i sg = (
	(1 + sg)/2 - sg * (mod (i + 1) 2)
)


rollout first "Brickerizer V1.0"
(
	group "Brick Properties"
	(
	Radiobuttons endtype "Wall End Type:" labels:#("Normal","in Boundery") align:#right
	spinner lendiv "# Across:" range:[1,50,5] align:#left fieldwidth:40 type:#integer offset:[0,-35]
	spinner heightdiv "# High:   " range:[1,50,5] align:#left fieldwidth:40 type:#integer
	spinner boffset "Brick Offset:" range:[-0.5,0.5,0.5] align:#left fieldwidth:30 offset:[-4,0]
	spinner mortfac "Mortar %:" range:[0,100,10] fieldwidth:40 offset:[0,-20] type:#integer
	label colchlab "Preset Colours:" offset:[22,5]
	dropdownlist colrchoice "" items:#("Red","Brown","Yellow","Blue","Green","Grey","Custom","Random") selection:2 height:9 width:80 align:#right offset:[0,-23]
	spinner randAmt "" range:[0,255,8] fieldwidth:35 align:#left type:#integer offset:[12,0]
	colorpicker col1 "Brick Colours Between:" color:(color 163 94 46) align:#right offset:[-70,-22]
	colorpicker col2 "and " color:(color 140 71 23) offset:[0,-25] align:#right
	)
	group "Wall Properties"
	(
	spinner wallln "Length:" range:[-99999999,99999999,1] align:#left fieldwidth:72 offset:[-2,0]
	spinner wallwh "Width :" range:[-99999999,99999999,1] align:#left fieldwidth:72
	spinner wallhi "Height:" range:[-99999999,99999999,1] align:#left fieldwidth:72
	checkbox Ejoin "Easy Join" offset:[122,-40]
	checkbox fillbrick "End Bricks" offset:[122,0]
	)
pickbutton pbox "Pick Box" offset:[0,0] tooltip:"Pick box to turn into a brick wall"
label btotallab "Brick total:" align:#left offset:[0,-20]
label btotal "25" align:#left offset:[55,-18]
checkbox delbox "Delete Box after" checked:true offset:[0,5]
button biz "BRICKERIZE" height:25 offset:[0,-25] enabled:false tooltip:"Create a brick wall"
HyperLink website "www.maple3d.com." hovercolor:(color 64 89 112) address:"http://www.maple3d.com" align:#right


local WallPos
local WHeight = 0
local WaWidth = 0
local WallLen = 0
local n = 5
local m = 5
local blen
local bhgt
local brickoffset = 0.5
local RandNum = 51
local Mortarfactor = 10
local BWall = #()
local HBrick,Brick,BrkThick,WallTM

fn WEndType Iinput = (
	if endtype.state == 1 then return n
	else return (n - mod Iinput 2)
	)

fn RandColour coli1 coli2 = (
if colrchoice.selection == 8 do return (Random Black White)
local rn = (random 0 RandNum)
local RedDif = (coli2.r - coli1.r)
local GrnDif = (coli2.g - coli1.g)
local BluDif = (coli2.b - coli1.b)
	RedCol = coli1.r + ((RedDif * rn)/RandNum)
	GrnCol = coli1.g + ((GrnDif * rn)/RandNum)
	BluCol = coli1.b + ((BluDif * rn)/RandNum)
	
	return (color RedCol GrnCol BluCol)
)

on endtype changed etypeval do (btotal.text = BTotalf (endtype.state)(n) (m))

on pbox picked pboxarg do
	(WallPos = pboxarg.pos;
	WHeight = pboxarg.height;
	WaWidth = pboxarg.width;
	WallLen = pboxarg.length;
	wallhi.value = pboxarg.height;
	wallln.value = pboxarg.length;
	wallwh.value = pboxarg.width;
	WallTM = pboxarg.objectTransform;
	biz.enabled = true;
	(if Ejoin.checked then (if wallln.value > wallwh.value then BrkThick = ((wallln.value/n)/2)
	else BrkThick = ((wallwh.value/n)/2))else (if wallln.value > wallwh.value then BrkThick = wallwh.value else BrkThick = wallln.value))
	)

on mortfac changed mfacval do
	Mortarfactor = mfacval
	
on lendiv changed val do
	(n = lendiv.value; (btotal.text = BTotalf (endtype.state) (n) (m)))

on heightdiv changed hval do
	(m = heightdiv.value; (btotal.text = BTotalf (endtype.state) (n) (m)))

on randAmt changed raval do
 RandNum = (raval + 1)
 
on Ejoin changed ejstate do
	(if Ejoin.checked then (if wallln.value > wallwh.value then BrkThick = ((wallln.value/n)/2)
	else BrkThick = ((wallwh.value/n)/2))else (if wallln.value > wallwh.value then BrkThick = wallwh.value else BrkThick = wallln.value))
	
on col1 changed coL1arg do
	colrchoice.selection = 7
	
on col2 changed coL2arg do
	colrchoice.selection = 7


on colrchoice selected colrarg do
	( case colrarg of
		(
		1: (col1.color = (color 172 84 67);col2.color = (color 140 42 23))
		2: (col1.color = (color 163 94 46);col2.color = (color 115 64 23))
		3: (col1.color = (color 182 177 52);col2.color = (color 129 125 23))
		4: (col1.color = (color 42 154 161);col2.color = (color 17 100 97))
		5: (col1.color = (color 51 161 42);col2.color = (color 17 100 23))
		6: (col1.color = (color 67 67 67);col2.color = (color 170 170 170))
		)
	)
			
on biz pressed do
	(clearSelection();BWall = #(); bhgt = (wallhi.value/m); Mortar = (bhgt*Mortarfactor/100);bhgt += (mortar/m); blen = (wallln.value/n); blspace = (blen - Mortar); bhspace = (bhgt - Mortar); bwth = (wallwh.value/n); bwspace = (bwth - Mortar);
	n = lendiv.value; m = heightdiv.value; brickoffset = (abs boffset.value); sg = (boffset.value/brickoffset);
	z = (WallPos.z - bhgt)
	if wallln.value > wallwh.value then (
		y = (-wallln.value/2 - blspace/2);
		For i = 1 to m do (
		if (fillbrick.checked) do (if (brickoffset >= 0.001) do (HBrick = (in Coordsys WallTM(Box length:((blen*(brickoffset))- Mortar) width:BrkThick height:bhspace rotation:(quat 0 0 0 1) pos:[0, y + blen * ((n + (0.5 + (sg*brickoffset/2)))*(1 - (FillBrickPos (i) (sg))) + (FillBrickPos (i) (sg))*(0.5 + (sg*brickoffset/2))), z + bhgt * i] wirecolor:(RandColour (col1.color) (col2.color)) prefix:"FillBrick"));
		));
		For j = 1 to (WEndType (i)) do
		(
		Brick = (in Coordsys WallTM(Box length:blspace width:BrkThick height:bhspace rotation:(quat 0 0 0 1) pos:[0, y + blen * (j + (mod i 2)*sg*brickoffset), z + bhgt * i] wirecolor:(RandColour (col1.color) (col2.color)) prefix:"Brick")); append BWall Brick
		)); try (if delbox.checked == true do delete pbox.object);catch())
		else (
		x = (-wallwh.value/2 - bwspace/2)
		For i = 1 to m do (
		if (fillbrick.checked) do (if (brickoffset >= 0.001) do (HBrick = (in Coordsys WallTM(Box length:BrkThick width:((bwth*(brickoffset))- Mortar) height:bhspace rotation:(quat 0 0 0 1) pos:[x + bwth * ((n + (0.5 + (sg*brickoffset/2)))*(1 - (FillBrickPos (i) (sg))) + (FillBrickPos (i) (sg))*(0.5 + (sg*brickoffset/2))),0, z + bhgt * i] wirecolor:(RandColour (col1.color) (col2.color)) prefix:"FillBrick"));
		));
		For j = 1 to (WEndType (i)) do
		(
		Brick = (in Coordsys WallTM(Box length:BrkThick width:bwspace height:bhspace rotation:(quat 0 0 0 1) pos:[x + bwth * (j + (mod i 2)*sg*brickoffset),0, z + bhgt * i] wirecolor:(RandColour (col1.color) (col2.color)) prefix:"Brick"));
		));try (if delbox.checked == true do delete pbox.object);catch())
	)
)

if Bizer != undefined do
				(
				closerolloutfloater Bizer
				)		
Bizer = newRolloutFloater "Brickerizer" 340 340 
addRollout first Bizer
			

