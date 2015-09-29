
--a wip
-- using the attach animation constraint, doesn't work fully.
global myattach = Attachment()
global myobj
global myscatter
mylist = position_list()
rollout scatterattachRoll "Untitled" width:162 height:300
(
	pickbutton attobtn "object to attach to" pos:[9,8] width:108 height:25
	pickbutton scatobjbtn "PickButton" pos:[10,48] width:117 height:29
	button dobtn "scatter em" pos:[11,93] width:115 height:26
	on attobtn picked obj do
	(
		myattach.node = attobtn.object
		attobtn.text = attobtn.object.name
		myscatter = attobtn.object

		)
	on scatobjbtn picked obj do
	(
		myobj = scatobjbtn.object
		)
	on dobtn pressed  do
(
		undo on
				(
				for i = 1 to myscatter.verts.count do
					(
						myscatObj = instance myobj
						
						for y = 0 to 100 do
						animate on
						(
						 at time y (myscatObj.pos = myscatter.verts[i].pos)
						 )
					)
	
				)
)
)




if attachscatter_floater != undefined then closeRolloutFloater attachscatter_floater
attachscatter_floater = newRolloutFloater "attach and scatter" 265 300
			addRollout scatterattachRoll  attachscatter_floater
