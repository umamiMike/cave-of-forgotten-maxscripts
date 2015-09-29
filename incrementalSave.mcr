-- Incremental Save v0.5 - (c) 2003 M. Breidt (martin@breidt.net)
--
-- This code is released under "Quote ware" license:
--      If you use this tool in a production environment with a group of more than two people,
--      or have used it in the past under such conditions, then you are obliged to tell 
--      me (martin@breidt.net) about it and allow me to list that project title and your 
--      company name as a reference on my website http://scripts.breidt.net
--
-- Synopsis:
-- Incremental Save is a macroscript for 3dsmax R4+ that serves as a replacement to the
-- default incremental saving routine of 3dsmax (the button labeled with '+' next to the
-- filename in the 'Save As' dialog). 
-- The problem with the default routine is that your latest file will always have a 
-- different filename. This kills all XRef setups or batch processing of files since
-- the filenames always change :(
--
-- Incremental Save will always save the latest version of your 3dsmax scene to the same
-- file name and move the old version to a new file with an increasing numbering scheme. 
-- This will allow you to always use the same filename for the latest version of a scene.
--
-- Example: Your current scene is called 'shot06-comp.max'. If you invoke the 
-- IncrementalSave macro, the old file 'shot06-comp.max' will be renamed to 
-- 'shot06-comp_V-001.max' and the new version will be called 'shot06-comp.max' again. 
-- Next time you use IncrementalSave, the saved file will be named again 'shot06-comp.max', 
-- and the second version will be named 'shot06-comp_V-002.max' etc.
--
-- Installation:
-- Copy this file to the UI\Macroscripts directory of your 3dsmax installation (e.g. 
-- 'C:\3dsmax5\UI\Macroscripts\') and restart 3dsmax. 
-- You will find a new action in the 'MB Tools' category named 'Incremental Save'.
-- Assign a shortcut to this action (how about Alt-Ctrl-S?) and/or create a new menu item 
-- for the 'File' menu. You can also add this action to a quad if you like.
-- It is recommended to keep the original 'Save' and 'Save As' entries. You never know...
--
-- Usage:
-- Install this macroscript as hotkey, menu item or quad; use as you would use the normal 
-- 'save' function. If you press CTRL when invoking the macroscript, you will get a dialog
-- in which you can customize the IncrementalSave parameters. You can adjust whether old
-- files will be stored in a subdirectory or not, what extension the subdirectory should
-- get, what suffix will be inserted into the scene file name right before the version
-- number, and how many digits (padding) the version number will have. There is also an
-- option whether you want to add file comments upon each save, and whether you want to
-- print debug information to the MAXScript listener (most likely, you don't want that).
--
-- Warning: 
-- Use this script at your own risk. I do not accept any responsibility for data loss
-- caused by this script. Test it thoroughly before using it in production - and 
-- please report any problems.
--
-- History:
-- v0.5 - added global persistent variables to store parameters 
--        if ALT is pressed at macro start, the user can customize the parameters in a 
--        dialog: subdirectory on/off, subdir extension, version prefix, number padding
-- v0.4 - old files will be moved into subdirectory 'filename.bak'
-- v0.3 - better file saving checks; script will no longer modify read-only filesm, as 
--        requested by Jim Jagger; experimental file comment functionality (disabled by
--        default, set 'do_comments = true' to enable
-- v0.2 - first public release

macroScript incrementalSave 
category:"MB Tools"
buttonText:"Incremental Save"
toolTip:"Incremental Save"
(
	comment_txt = ""			-- stores current file properties' comment text
	
	fn padNumber nr padLen = (
	-- pads number 'nr' to a fieldwidth of 'padLen' with leading zeros and returns this string
		local n = (nr as string)
		for i = 1 to (padLen - n.count) do n = "0" + n
		return n
	)
	
	fn isNumber str = (
	-- returns true if 'str' can be converted to float
		local val = undefined
		try (val = str as float) catch return false
		return (val!=undefined)
	)
	
	fn verifiedSaveFile fName = (
	-- will save current scene under filename 'fname' and do some file checks; fName should include extensions
		local minFileSize = 10000		-- minium size in bytes for a normal scene
		if (saveMaxFile fName) then (
			-- saveMaxFile reported success
			-- now verify saved file; could use getFileSize fName but that's 3dsmax R5 only
			if not (doesFileExist fName) then (
				-- file not found!
				messageBox "File not found after saving! Re-save normally!" title:"IncrementalSave Error #2" beep:true
				setSaveRequired true
				return false
			) else (
				-- file exists, now check for size > 0 bytes
				local size = 0
				try (
					local bs = fOpen fName "rb"			-- open saved file as binary stream
					fseek bs 0 #seek_end				-- seek to end of file
					size = ftell bs						-- get file position (at eof)
					fClose bs							-- close file handle
				) catch (
					messageBox "Error while verifying file size! Re-save normally!" title:"IncrementalSave Error #5" beep:true
					setSaveRequired true
					return false
				)
				if (size < minFileSize) then (			-- anything smaller than 10,000 Bytes is considered corrupt; an empty file has 54k with compression=on
					messageBox "File size too small, propably corrupt! Re-save normally!" title:"IncrementalSave Error #6" beep:true
					setSaveRequired true
					return false					
				) else (
					format "Scene saved successfully as %\n" fName		-- everything ok! :)
					return true
				)
			) -- end of size check
		) else (
			-- saveMaxFile did return false
			messageBox "File could not be saved! Re-save normally!" title:"IncrementalSave Error #1" beep:true
			setSaveRequired true
			return false
		)
	)

	rollout fileCommentDialog "File Comments" (
		editText cmtTxt fieldWidth:400 height:100 text:comment_txt
		button ok_b "OK" width:100
		
		on ok_b pressed do (
			comment_txt = cmtTxt.text
			destroyDialog fileCommentDialog
		)
	)

	on execute do (
	
		persistent global incrementalSave_debug
		if incrementalSave_debug==undefined then incrementalSave_debug = false
		
		persistent global incrementalSave_doSubDir		-- store old versions in subdirectory?
		if incrementalSave_doSubDir==undefined then incrementalSave_doSubDir = true
		
		persistent global incrementalSave_subDirExt		-- extension for subdirectory
		if incrementalSave_subDirExt==undefined then incrementalSave_subDirExt = ".bak"
		
		persistent global incrementalSave_padLen		-- size of number padding; 3 will produce "001", "002" etc.
		if incrementalSave_padLen==undefined then incrementalSave_padLen = 3

		persistent global incrementalSave_sepSym		-- separation symbol between base filename and numbers
		if incrementalSave_sepSym==undefined then incrementalSave_sepSym = "_V-"

		persistent global incrementalSave_doCmt			-- set this to 'true' if you want to add file comments upon save
		if incrementalSave_doCmt==undefined then incrementalSave_doCmt = false

		local cont = true				-- user wants to continue?
		local saveName = undefined		-- filename to save under

		-- parameter dialog UI definition
		rollout paramRO "IncrementalSave v0.5" (
			checkbox subDir_c "Save old files in subdirectory" checked:incrementalSave_doSubDir
			edittext ext_t "Subdirectory suffix: " text:incrementalSave_subDirExt enabled:incrementalSave_doSubDir fieldWidth:50 align:#right
			edittext sep_t "Version number prefix: " text:incrementalSave_sepSym fieldWidth:50 align:#right
			
			label l1 "Version number padding:" across:2 align:#left
			spinner pad_s range:[2,10,incrementalSave_padLen] type:#integer fieldWidth:42 align:#right

			checkbox cmt_c "Add file comments on save" checked:incrementalSave_doCmt
			checkbox debug_c "Print debug information" checked:incrementalSave_debug
			
			group "File name example:" (
				label prev ""
			)
						
			button close_b "OK" width:60
			
			fn updatePreview = (
				-- update preview text
				local newTxt = "myScene"
				if incrementalSave_doSubDir then newTxt += (incrementalSave_subDirExt + "\\" + newTxt)
				newTxt += incrementalSave_sepSym
				for i = 2 to incrementalSave_padLen do newTxt += "0"
				newTxt += "1.max"
				prev.text = newTxt
			)
			on paramRO open do updatePreview()
			on subDir_c changed val do (
				incrementalSave_doSubDir = ext_t.enabled = val
				updatePreview()
			)
			on ext_t changed val do (
				incrementalSave_subDirExt = val
				updatePreview()
			)
			on sep_t changed val do (
				incrementalSave_sepSym = val
				updatePreview()
			)
			on pad_s changed val do (
				incrementalSave_padLen = (val as integer)
				updatePreview()
			)
			on cmt_c changed val do incrementalSave_doCmt = val
			on debug_c changed val do incrementalSave_debug = val
			on close_b pressed do destroyDialog paramRO
		) -- end rollout paramRO 

		-- start with a message
		format "IncrementalSave v0.5 - (c) 2003 M. Breidt (martin@breidt.net)\n"
		if keyboard.altPressed then createDialog paramRO 200 200 modal:true -- open parameter dialog if CTRL is pressed

		if not getSaveRequired() then (										-- check whether there were any changes to the scene
			cont = queryBox "Scene has not been changed.\nSave anyway?" title:"IncrementalSave"
		)
		
		if cont then (
			if incrementalSave_doCmt then (
				local propNo = fileProperties.findProperty #summary "Comments"
				if propNo > 0 then comment_txt = fileProperties.getPropertyValue #summary propNo else comment_txt = ""
				CreateDialog fileCommentDialog modal:true width:435 height:140
				fileProperties.addProperty #summary "Comments" comment_txt
			)
			if maxFileName=="" then (										-- new file, prompt for name
				if ((saveName = getMAXSaveFileName())!=undefined) then (	-- prompt for filename; undefined if user cancels action
					verifiedSaveFile saveName
				) else (
					format "Cancelled by user. Scene NOT saved!\n"
				)
			) else (					
				-- current 3dsmax scene already has file name		
				saveName = (maxFilePath + maxFilename)
				if not doesFileExist saveName then (						-- check whether current scene file still exists
					-- scene has a filename, but file no longer exists; re-save normally
					verifiedSaveFile saveName
				) else (
					-- scene has a filename and file exists, so ***save incrementally***
					local wildCard = ""		-- string for wildcard characters
					local newNr = 1			-- start with file version 001
					local sepPos = 0		-- position of separation character in string
					local numStr = ""		-- detected file number as string
					local files = #()		-- array of files that match wildcard

					local baseName = undefined			-- scene base name, without extension, without path
					local subDirName = undefined		-- full path of subdirectory that stores backup files
					local newSaveName = undefined		-- full path of new filename (incl. new version no.)
					local currentSaveName = undefined	-- full path of current scene file

					baseName = getFilenameFile maxFileName						-- store base name of scene
					
					if incrementalSave_doSubDir then (
						-- check for subdirectory
						subDirName = (maxFilePath + basename + incrementalSave_subDirExt )	-- store full subdirectory path
						if incrementalSave_debug then format "subDirName = %\n" subDirName
					
						if not doesFileExist subDirName then (							
							-- create subdirectory if it doesn't exist
							if not (makeDir subDirName) then (
								-- error! could not create directory! fallback: save into base directory
								subDirName = maxFilePath
								format "Could not create subdirectory, using base path % instead\n" subDirName
							)
						)
						saveName = subDirName + "\\" + baseName					-- store complete scene filename, with subdir but without extension
					) else saveName = (maxFilePath + baseName)	-- no subdir stored
					
					for i = 1 to incrementalSave_padLen do ( append wildCard "?" )				-- build wildcard string from padSize
					if incrementalSave_debug then format "wildCard = %\n" wildCard
					files = getFiles (saveName + incrementalSave_sepSym + wildCard + ".max")	-- find all files that match the wildcard...
					sort files													-- ... and sort them
					if incrementalSave_debug then format "files = %\n" files
										
					if files.count > 0 then (
						-- one or more files found that match wildcard
						do (
							local f = files[files.count]						-- use last file, thanks to sorting
							f = subString f 1 (f.count - 4)						-- remove extension, use all but the last 4 characters
							sepPos = (findString f incrementalSave_sepSym)		-- find separation character in string
							numStr = subString f (sepPos + incrementalSave_sepSym.count) (f.count - sepPos - 1 + incrementalSave_sepSym.count)	-- use all characters behind the separation char
							deleteItem files files.count
						) while (files.count > 0) and (not isNumber numStr)
						if (isNumber numStr) then (							
							newNr = (numStr as integer) + 1						-- increment filenr by one
							if incrementalSave_debug then format "newNr = %\n" newNr
						) else (
							format "Error! Searched through files and did not find number!\n"
						)
					) -- if files.count > 0
					-- now build file name for current scene
					newSaveName = saveName + incrementalSave_sepSym + (padNumber newNr incrementalSave_padLen) + ".max"
					currentSaveName = maxFilepath + maxFilename
	
					if not (getFileAttribute currentSaveName #readonly) then (  -- check for read-only file
						if (renameFile currentSaveName newSaveName) then (		-- move current scene file to versioned filename with new number
							-- move was successful
							if verifiedSaveFile currentSaveName then (			-- save new scene file with the same name
								format "Old version saved as %\n" newSaveName
							)
						) else ( -- rename failed
							messageBox "Renaming current scene file failed for some reason!\nScene not saved! Aborting." title:"IncrementalSave Error #3" beep:true
							format "Moving % to % failed!\n" currentSaveName newSaveName
							setSaveRequired true
						) 
					) else ( -- file has read-only flag
						messageBox ("File " + currentSaveName + ".max" + " is read-only!\nScene not saved! Aborting.") title:"IncrementalSave Error #4" beep:true
					)
				) -- else (maxFileName=="")
			) -- else (file exists)
		) -- if cont
	) -- on execute
) -- macroscript
