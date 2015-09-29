myarray = selection as array

for i = 1 to myarray.count do(

mycont = myarray[i].position.controller[1]

selectkeys mycont (interval 141 500)
deletekeys mycont #selection

)