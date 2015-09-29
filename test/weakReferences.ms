sph=#()
for i = 1 to 3 do 
(
	s=sphere radius:10 pos:(random [-100,0,0] [0,0,0])
	append sph s
)
b=box pos:[40,0,0]

def=attributes nodeStore
(
	parameters nodesP rollout:nodesR
	(
		refNodes type:#maxObjectTab tabSize:0 tabSizeVariable:true
	)

	rollout nodesR "Nodes"
	(
		local btW=135, btW2=65
		listBox nodesListLb "Nodes:"
		pickButton addObject "Add Object" width:btW2 across:2
		button deleteObject "Delete" width:btW2
		
		group "Tests:"
		(
			button printRefNodes "Print refNodes" width:btW
			button printRefNodesNode "Print Nodes" width:btW
		)
		
		fn updateList=
		(
			nNames=for n in refNodes collect n.node.name
			nodesListLb.items=nNames
		)
		
		on addObject picked obj do
		(
			append refNodes (nodeTransformMonitor node:obj forwardTransformChangeMsgs:false)
			updateList()
		)
		on deleteObject pressed do
		(
			num=nodesListLb.selection
			if num>0 then
			(
				deleteItem refNodes num
				updateList()
			)
		)
		
		on printRefNodes pressed do
		(
			for n in refNodes do
			(
				print n
			)
		)
		on printRefNodesNode pressed do
		(
			for n in refNodes do
			(
				print n.node
			)
		)
		
		on nodesR open do
		(
			updateList()
		)
	)
)

ah=(EmptyModifier())
addModifier b ah
custAttributes.add ah def

for s in sph do
(
	obj=nodeTransformMonitor node:s forwardTransformChangeMsgs:false
	append b.modifiers[1].refNodes obj
)
select b