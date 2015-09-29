mymat = meditmaterials[medit.GetActiveMtlSlot()]

myobjects = $ as array


for x = 1 to myobjects.count do
(
myobjects[x].mat = copy mymat
mymat.name = "awpanelmat" + x as string

)