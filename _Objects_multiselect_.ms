-------------------------------------------------------------------------------
-- Obj MultiSelect.ms
-- by DeKo (www.deko.lt)
-- v 1.0
-- tested using Max 8.0 SP3
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description:
-- Simple obj multiselect

-------------------------------------------------------------------------------
global ObjListType = $*
rollout SimpleObjMngr "Objects Selector"
(
    dropdownList ClassCombo "" items:#("All", "Geometry", "Helpers", "Space Warps", "Lights", "Cameras")  width: 175
	MultiListBox mlb "Scene objects:" items:(for o in ObjListType collect o.name) height: (SimpleObjMngr.height / 16)
	Button Refresh_Btn "Refresh" width:60 height:25 align:#left
	
	
	function getNodeByListItem i = (
		return getNodeByName (mlb.items[i]);
	)
	
	
	on mlb selected val do (
		if (findItem mlb.selection val)==0
			then deselect (getNodeByListItem val)
			else selectMore (getNodeByListItem val);
	)
	
	on Refresh_Btn pressed do 
	(
	 max select none
	 mlb.items = #(); --append empty massive
	 mlb.items = for o in ObjListType collect o.name
	 
	 mlb.caption = "Scene objects: " + ObjListType.count as string + " / " + $*.count as string
	)

	on ClassCombo selected i do
	(
	
		case i of 
		(
		1: ObjListType = objects
		2: ObjListType = geometry
		3: ObjListType = helpers
		4: ObjListType = SpaceWarps 
		5: ObjListType = lights
		6: ObjListType = cameras
		)
	 max select none
	 mlb.items = #();
	 mlb.items = for o in ObjListType collect o.name
	 
	 mlb.caption = "Scene objects: " + ObjListType.count as string + " / " + $*.count as string
	
	)
	
)

CreateDialog SimpleObjMngr 200 455 pos: [15,110] style: #(#style_titlebar, #style_border, #style_sysmenu, #style_minimizebox) --#style_toolwindow
SimpleObjMngr.mlb.items