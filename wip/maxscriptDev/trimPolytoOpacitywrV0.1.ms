--Step 1:

p = Plane widthsegs:50 lengthsegs:50 wirecolor:blue --create a plane

convertTo p Editable_Poly --convert to EPoly

select p --select the plane

max modify mode --switch to modify panel

subObjectLevel = 4 --switch to Edge level

 

--Select faces where the bitmap color is pure white.

PolyToolsSelect.BitmapToSel "ELMLEAF.TGA" 1 white

 

--Step 2: Select faces where color is black.

PolyToolsSelect.BitmapToSel "ELMLEAF.TGA" 1 black

 
