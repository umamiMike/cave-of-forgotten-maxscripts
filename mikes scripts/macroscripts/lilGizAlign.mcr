macroScript liGizAlign
	category:"Mikes"
	toolTip:"Make a gizmo and align to selected object"
(
	mydummy = dummy()
	mydummy.transform = $.transform
	--mydummy.parent = $
	--$.parent = mydummy
	mydummy.name =  $.name+"_Dummy"
)
