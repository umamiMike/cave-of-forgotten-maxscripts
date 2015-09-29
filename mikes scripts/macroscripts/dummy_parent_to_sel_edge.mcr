macroScript addDummyToEdge
	category:"Mikes"
	toolTip:"add dummy to selected edge"
	
(	
myhelp = dummy()
--myhelp.boxsize = 1
obj = $ --get selected object

edgeSel = getEdgeSelection obj --get selected Edges

--get Verts of selected Edges:

vertsSel = meshop.getVertsUsingEdge obj edgeSel as array

vert1 = vertsSel[1]
vert2 = vertsSel[2]

mypos = ($.verts[vert1].pos + $.verts[vert2].pos)/2
myvec = $.verts[vert2].pos - $.verts[vert1].pos

myhelp.pos = mypos
myhelp.dir = myvec

obj.parent = myhelp
myhelp.name = "Folder" + obj.name
subobjectLevel = 0

)