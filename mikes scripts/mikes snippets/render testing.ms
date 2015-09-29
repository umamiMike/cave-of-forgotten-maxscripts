for i = 1 to selection.count do (

myFile = "test"+i as string + ".tif"
render camera: selection[i] outputfile:myFile
)