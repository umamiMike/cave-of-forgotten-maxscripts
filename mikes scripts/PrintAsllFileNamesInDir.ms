myfiles = #()
myPath = getSavePath caption:"Open em"
	typeOfFile = "/*.*"
	myFiles = (getFiles (myPath+typeOfFile)) as array
	
	
	for i = 1 to myFiles.count do (print (getFileNameFile myFiles[i]))