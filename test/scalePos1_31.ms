--******************************************************************************
--*                                                                            *
--*  Scale Position 1.3                                                        *
--*  by Ofer Zelichover (c) 10/2001                                            *
--*  www.oferz.f2s.com ;   ofer_z@hotmail.com                                  *
--*                                                                            *
--******************************************************************************
--*  You may use this script freely as you see fit.                            *
--*  You may use parts or the script as a whole in your own scripts.           *
--*  (it would be nice if you give me a credit if you do so ;))                *
--******************************************************************************
--*  This script comes with no waranty!                                        *
--*  Although I tried this script and couldn't find any problems with it, I can*
--*  in no way be held responsible for any kind of loss or damage, whether     *
--*  direct or indirect, due to the use of this script.                        *
--*                                                                            *
--*  ********************************************************************      *
--*  *** IF YOU DON'T LIKE THE ABOVE STATEMENT, DON'T USE THIS SCRIPT ***      *
--*  ********************************************************************      *
--*                                                                            *
--*  **** This script was written for max 4.2 and wasn't tested on other ****  *
--*  **** versions of max.                                               ****  *
--*                                                                            *
--*  If you find any bugs in this script, please let me know.                  *
--******************************************************************************
--* Description                                                                *
--* -------------                                                              *
--* This utility scales the position of the selected objects using an object   *
--* or the selection center as the center of the scale.                        *
--*                                                                            *
--******************************************************************************
--* History, Status and Known issues                                           *
--* ----------------------------------                                         *
--* changed : v1.1 5/9/2001                                                    *
--* fixed few minor bugs, add ability to use scaled object's center or pivot   *
--* point.                                                                     *
--*                                                                            *
--* changed : v1.2 2/10/2001                                                   *
--* added undo (only one level of undo for now)                                *
--* added support for coordinate systems                                       *
--*                                                                            *
--* changed : v1.3 24/11/2001                                                  *
--* scalePos now uses max's undo system                                        *
--* removed reference coordinate system, since it was not working properly.    *
--*                                                                            *
--* Known issues:                                                              *
--* - need to fix the use of reference system.                                 *
--*                                                                            *
--*                                                                            *
--* Need to add:                                                               *
--*                                                                            *
--******************************************************************************
--* Isntallation:                                                              *
--* --------------                                                             *
--*    put:                                                                    *
--*          scalePos1_3.ms        - anywhere                                  *
--*                                                                            *
--******************************************************************************



utility scalePos "Scale Position" (

-- Local Variable Declerations
-------------------------------
	local prevPos = #()
	local scaleAxes = [1.0,1.0,1.0]
	local seperator = "------------------------------------"
	local coordSysItems = #("Screen","World","Parent","Local","Grid",seperator,"Pick",seperator)
	local cpos = selection.center
	local undoEnabled = false
	local prevCoordsys = 2
	local dragSipnnerMode = false
	local prevScalePerValue = 100.0

-- GUI
-------
	group "Scale Center: " (
		radiobuttons cntr labels:#("Center of Selection","Object:")
		pickbutton cntrObj "Pick Center of Scale:" enabled:false tooltip:"Pick the object that will be the center point for scaling." message:"Pick the object that will be the center point for scaling."
	)
	
	group "Scale Reference: " (
		label lbl01 "Use scaled object's:" align:#left
		radiobuttons relative labels:#("Pivot Point","Center")
--		label lbl02 "Reference Coordinate System: " align:#left offset:[-5,5] enabled:false
--		dropdownlist coordSysList "" items:coordSysItems selection:2 enabled:false
	)
	
	group "Scale Axes: "(
		checkbutton scaleX "X" checked:true across:3
		checkbutton scaleY "Y" checked:true
		checkbutton scaleZ "Z" checked:true
	)
	
	group "Distance Percentage: " (
		spinner scalePer range:[0.01,100000,100] type:#float scale:0.01 align:#center
	)

	group "About: " (
		label txt1 "Scale Position 1.3"
		label txt2 "Written by Ofer Zelichover."
		label txt3 "(c) 2001."
		
	)

-- Functions
--------------
	fn boolToInt bool = (if bool then return 1 else return 0)

	fn centerObj =(
		if cntrObj.object != undefined then (
			cntrObj.caption = cntrObj.object.name
			return cntrObj.object.pos
		)
		else return selection.center
	)

	fn changeCenter n =(
		case n of (
			1: (cpos = selection.center; cntrObj.enabled=false)
			2: (cpos = centerObj(); cntrObj.enabled=true)
		)
	)

	fn savePos = (
		local posArr = #()
		for o in selection do
			case relative.state of (
				1:	append posArr o.pos
				2:	append posArr o.center
			)
		posArr
	)
	
	fn scalePos origPos Cent Percent axes &pos= (
		local per = ((Percent - 100.0)/100.0)
		pos = origPos
		pos+=((origPos - Cent) * Per * axes)
	)

	fn rePos scaleDist cpos axes= (
		for i=1 to selection.count do (
			case relative.state of (
				1:	(scalePos prevPos[i] cpos scaleDist axes &selection[i].pos)
				2:	(scalePos prevPos[i] cpos scaleDist axes &selection[i].center)
			)
		)
	)

	fn saveUndo = (
		disableSceneRedraw()
		local newPos = savePos()
		for i=1 to selection.count do (
			case relative.state of (
				1:	(selection[i].pos=prevPos[i])
				2:	(selection[i].center=prevPos[i])
			)
		)
		undo "Scale Position" on (
			for i=1 to selection.count do (
				case relative.state of (
					1:	(selection[i].pos=newPos[i])
					2:	(selection[i].center=newPos[i])
				)
			)
		)
		enableSceneRedraw()
	)

-- Event Handlers
-------------------
	on cntr changed state do (changeCenter cntr.state)

	on cntrObj picked obj do (
		if obj != undefined then (
			flashNodes #(obj)
			cpos = centerObj()
		)
	)
	
	on scaleX changed state do scaleAxes.x = (boolToInt scaleX.state)
	on scaleY changed state do scaleAxes.y = (boolToInt scaleY.state)
	on scaleZ changed state do scaleAxes.z = (boolToInt scaleZ.state)
	
	on scalePer buttondown do (
		prevPos=savePos()
		changeCenter cntr.state
		dragSipnnerMode = true
		flagForeground selection true
	)
	on scalePer buttonup do (
		if dragSipnnerMode then (
			saveUndo()
			scalePer.value=100
		)
		dragSipnnerMode = false
		flagForeground selection true
	)
	on scalePer entered do (
		try(
			if prevScalePerValue!=scalePer.value and NOT dragSipnnerMode then (
				prevPos=savePos()
				changeCenter cntr.state
				rePos scalePer.value cpos scaleAxes
				saveUndo()
				scalePer.value=100
				dragSipnnerMode = false
			)
		)catch()
	)
	on scalePer changed value do (if dragSipnnerMode then rePos scalePer.value cpos scaleAxes)

) -- End of Utility

