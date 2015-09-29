sceneDataCADef =attributes sceneDataCADef version:1 attribID:#(0x61e9ff5f, 0x63784819)
(
parameters main rollout:params
( note type:#string ui:et_note default:"")
rollout params "Scene Data Parameters"
( edittext et_note "Note: ")
)
 
thescene = (refs.dependents rootnode)[1]
rootNodeDataCA = undefined
if (custattributes.add rootnode sceneDataCADef) do
 rootNodeDataCA = rootnode.custAttributes[rootnode.custAttributes.count]
sceneDataCA = undefined
if (custattributes.add thescene sceneDataCADef) do
 sceneDataCA = thescene.custAttributes[thescene.custAttributes.count]
rootNodeDataCA.note
sceneDataCA.note
rootNodeDataCA.note = "rootnode"
sceneDataCA.note = "thescene"


rootNodeDataCA = undefined
if(rootnode.custAttributes.count != 0) do
 rootNodeDataCA = rootnode.custAttributes[rootnode.custAttributes.count]
sceneDataCA = undefined
if(thescene.custAttributes.count != 0) do
 sceneDataCA = thescene.custAttributes[thescene.custAttributes.count]