renderSceneDialog.close()
FileName = getfilenamefile rendOutputFilename
FilePath = getfilenamepath rendOutputFilename
FileXtn = getfilenametype rendOutputFilename
mycam = getActiveCamera()
myNewName = mycam.name
rendOutputFilename = FilePath + myNewName+FileXtn
renderSceneDialog.open()