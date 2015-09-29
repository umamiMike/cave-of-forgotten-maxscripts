macroScript openExplorerFromMaxFileLoc
	category:"umami"
	toolTip:"loads a windows explorer window from the place of the current max file"
(
	qt = "\""
	myString = "\""+maxFilePath+"\""
	theRunString = "ShellLaunch " +qt+ "explorer.exe"+qt +"@"+myString
	execute(theRunString)
)
