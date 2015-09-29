for i = 1 to selection.count do
(
obj = selection[i]
obj.mat = copy obj.mat
obj.mat.name = obj.name + "_material"
)