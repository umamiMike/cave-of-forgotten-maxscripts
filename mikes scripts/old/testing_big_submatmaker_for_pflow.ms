mat = meditmaterials[1]

for i = 2 to mat.numsubs do

(

mat.materiallist[i] = copy mat.materiallist[1]
mat.materiallist[i].diffusemap.starttime = i*200 

)