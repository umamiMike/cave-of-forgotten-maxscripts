

(
 
 
	struct temp
	(
		fn Arr2VerbatimStringArray arr = --converts an array of strings into a string containing the the array with its sstrings and verbatim @s 
		(
			local res = "#("
			for i = 1 to arr.count do
			(
				item = arr[i]
 
				res +=  "@\"" + item + "\""
				if i < arr.count do res += ", "
			)
			res += ")"
			return res
		)--END Arr2VerbatimStringArray FN
 
		,
 
		fn gIs Category Key File:"Settings" =  --gIs #newTestCategoy #newKey  --gets a string value from the registry
		(
 
			local type, val, key1
 
			registry.createKey HKEY_CURRENT_USER ("Software\\INToolsCompact\\"+File as string + "\\" + Category as string) accessRights:#all newKeyCreated:&newKeyCreated key:&key1
 
			registry.queryValue key1 (Key as string) type:&type value:&val
 
			val
		)
		,
 
		fn sIs Category Key Val File:"Settings" del:false = --sIs #newTestCategoy #newKey #muhahahaharrrr file:settings --del:true  --saves a string to the registry
		(
			try(
				local newKeyCreated , key1
 
				registry.createKey HKEY_CURRENT_USER ("Software\\INToolsCompact\\"+File as string + "\\" + Category as string) accessRights:#all newKeyCreated:&newKeyCreated key:&key1
 
				if not del then
				(
					registry.setvalue key1 (Key as string) #REG_SZ (Val as string)
				)
				else
				(
					registry.deleteKey key1
				)
			)catch(	print (registry.getLastError())	)
		)
 
		,
 
		fn getMainToolsMenu = --searches and returns the ToolsMenu in the Main menu bar
		(
			local mainMenu = menuMan.getMainMenuBar()
			local toolsMenu
			for i = 1 to 10 do
			(
				local fileMenu = (mainMenu.getItem i).getSubMenu()
				if (fileMenu.getTitle()) == "&Tools" do
				(
					toolsMenu   = fileMenu
				)
			)
			return toolsMenu
		)--END getMainToolsMenu FN
 
		,
 
		fn isSameMat mat1 mat2 = --checks if the 2 supplied materials have the same settings
		(
			local equal = true
 
			if equal AND classOf mat1 != classOf mat2 do equal = false
			if equal do
			(
				local mat1PropNames = getPropNames mat1 ; local mat2PropNames = getPropNames mat2
 
				if mat1PropNames.count != mat2PropNames.count do equal = false
				if equal do
				(
					for i = 1 to mat1PropNames.count while equal do
					(
						if (getProperty mat1 mat1PropNames[i]) as string != (getProperty mat2 mat2PropNames[i]) as string do
						(
							equal = false
						)
					)
				)
			)
			return equal
		)--END isSameMat FN
 
		,
 
		fn drawtext text:"" pos:[0,0] mPos:mouse.pos = --function to draw the screenText and check if mouse is hovering, does not update the screen after drawing
		(
			local mouseOverText = false
			local te = gw.getTextExtent text
			local b1 = Box2 pos.x pos.y te.x te.y
			local b2 = Box2 pos.x (pos.y-te.y) te.x te.y
 
			gw.setTransform(Matrix3 1)
 
			if contains b2 mouse.pos do
			(
				mouseOverText = true
			)
 
			gw.wText [pos.x, pos.y, 0] text color:(if not mouseOverText then color 150 180 210 else color 177 88 22)
			gw.enlargeUpdateRect b1 --b1 --#whole
 
			return mouseOverText
		)--END drawtext FN
 
		,
 
		fn makeGridImg size greySpacing bgColor:((GetUIColor 41)*255) gridColor:(color 200 200 200) show:false = --creates a bitmap with grid on it
		(
			local img = bitmap size.x size.y color:bgColor ;
 
			if greySpacing > 0 do ;
			(
				local colorArr = for x = 1 to size.x collect if mod x greySpacing == 0 AND x != size.x AND x != 1 then gridColor else bgColor ;
				local colorArr2 = for x = 1 to size.x collect gridColor ;
 
				for y = 0 to size.y-1 do if mod y greySpacing == 0 AND y != size.y AND y != 0 then setPixels img [0,y] colorArr2 else setPixels img [0,y] colorArr ;
			)
			if show do display img ;
			return img ;
		)--END makeGridImg FN		
 
		,
 
		fn makeButtonImg size type:#default show:false = --creates a bitmap looking like a button
		(
 
			local bgColor = case type of 
			(
				#default : 
				(
					(colorMan.getColor #background)*255
				)
 
				#pressed : 
				(
					(colorMan.getColor #itemHilight )*255
				)
 
				#disabled : 
				(
					(colorMan.getColor #background)*200
				)
			)
 
			local img = bitmap size.x size.y color:bgColor ;
 
			local colorArr = for x = 1 to size.x collect if x <= 1 then ((colorMan.getColor #hilight)*255) else if x >= size.x then ((colorMan.getColor #shadow )*255) else bgColor ;
			local colorArr2 = for x = 1 to size.x collect ((colorMan.getColor #hilight)*255)  ; 	--top edge
			local colorArr3 = for x = 1 to size.x collect ((colorMan.getColor #shadow )*255)  ; 	--bottom edge
 
			for y = 0 to size.y-1 do 
			(
				if y <= 0 then setPixels img [0,y] colorArr2 else if y >= size.y-1 then setPixels img [0,y] colorArr3 else setPixels img [0,y] colorArr ;
				for i = 1 to colorArr.count do colorArr[i] *=1.02
			)
 
			if show do display img ;
			return img ;
		)--END makeButton FN
 
		,
 
		fn lineUpBMPs img1 img2 type:#horz = --lines up the 2 supplied images in a row, usefull for custom button bitmaps î
		(
			local img 
			if img1 != undefined AND img2 != undefined AND img1.width == img2.width AND img1.height == img2.height do
			(
				case type of
				(
					#horz : 
					(
						img = bitmap (img1.width*2) img1.height color:orange
 
						for y = 1 to img1.height do
						(
							local img1Pixels = getpixels img1 [0,y-1] img1.width
							local img2Pixels = getpixels img2 [0,y-1] img1.width
 
							local colArr = for x = 1 to (img1.width*2) collect
							(
								if x <= img1.width then img1Pixels[x] else img2Pixels[x-img1.width]
 
							)
 							setPixels img [0,y-1] colArr
						)
					)
				)
			)
			return img
		)--END lineUpBMPs FN
 
		,
 
		fn makeProgressBarImg size percent tColor:((colorMan.getColor #itemHilight )*255) bgColor:green borderColor:((colorMan.getColor #shadow )*255)  show:false = --creates a bitmap looking lke a progressBar
		(
			local img = bitmap size.x size.y color:bgColor ;
 
			local colorArr = for x = 1 to size.x collect if x == 1 OR x == size.x then borderColor else if x > (size.x*(percent/100.0)) then bgColor else tColor * (x/(size.x*(percent/100.0))) ; 
			local colorArr2 = for x = 1 to size.x collect borderColor ; 
 
			for y = 0 to size.y-1 do if y == 0 OR y == size.y-1 then setPixels img [0,y] colorArr2 else setPixels img [0,y] colorArr ;
			if show do display img ; 
			return img ;
		)--END makeProgressBar FN
 
		,
 
		fn isPointInVol obj pos = --checks if supplied position is inside supplied mesh object
		(
			if superclassOf obj == geometryClass do ;
			(
				local tMesh = obj.mesh; local nVerts=tMesh.numverts; local isInVol = true ;
				for v = 1 to nVerts while isInVol do if asin (dot (getNormal tMesh v) (normalize(((getVert tMesh v)*obj.transform) - pos))) <= 0.0 do isInVol = false ;
				tMesh = nVerts = vPos = undefined ;
				return isInVol ;
			)
		)--END isPointInVol FN
 
		,
 
		fn pointLineProj pA pB pC = --gets the closest point on a line to a point in space
		( 
			local vAB=pB-pA ; local vAC=pC-pA ; local d=dot (normalize vAB) (normalize vAC) ;
			return (pA+(vAB*(d*(length vAC/length vAB)))) ;
		)
		,
		fn isPointInSpline obj pos thickness = --checks if supplied position is inside the (spline + supplied radius)
		(
			if superclassOf obj == shape do ;
			(
				local InSpline = false ; local objTM = obj.transform ; local obj = copy obj ; convertToSplineShape obj ; obj.transform = matrix3 1 ; local nKnots = numKnots obj ;
				for i = 1 to nKnots-1 while not inSpline do ( local closestPoint = pointLineProj ((getKnotPoint obj 1 i) *objTM) ((getKnotPoint obj 1 (i+1)) *objTM) pos ; if (distance closestPoint pos) - thickness/2.0 < thickness/2.0 do InSpline = true) ;
				delete obj ;
				return InSpline ;
			)
		)--END isPointInSpline FN
 
 
	)--END STRUCT
 
 
 
 
)

