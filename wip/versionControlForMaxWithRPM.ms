/* 
INFO FROM FORUM 
2 ways off the top of my head: 
 
RPMData.setUICheckData 9 "newprefix" 
 
the UI won't update, though if RPM is open you can do 
 
rmpasses.rmshotname.text = "newprefix" 
 
to set the UI, or if the UI is open you can just do: 
rmpasses.rmshotname.entered "newprefix" 
  */
 /* 
http://www.scriptspot.com/3ds-max/scripts/incremental-save
  if maxFileName != "" then (
        max saveplus
        TheFile = maxFilePath + (trimRight (getFilenameFile maxFileName) "1234567890") + ".max"
        if doesFileExist TheFile do deleteFile TheFile
        copyFile (maxFilePath + maxFileName) TheFile
    ) else checkForSave()
   */
--a script to leverage rpmanager in versioning files, so the render location is always iterated and correct but the file name is always the same

fn saveIncrementalRaw = (
  if maxFileName != "" then (
        max saveplus
        TheFile = maxFilePath + (trimRight (getFilenameFile maxFileName) "1234567890") + ".max"
        if doesFileExist TheFile do deleteFile TheFile
        copyFile (maxFilePath + maxFileName) TheFile
    ) else checkForSave()
	
)

