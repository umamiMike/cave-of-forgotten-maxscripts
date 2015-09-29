-- fileInFN-v1_51.ms
-- 02.10.02, swami*, a.k.a. "codeWarrior()", swami@cfl.rr.com
-- Written for MAX r3.1 thru r4x.
--
--*****************************************************
-- HISTORY:
-- (Legend: M => Major change; m => minor change; B => Bug fix; (i) => info.)
--    - v1.50 (02.10.02):
--        (B) Fixed bug due to error in value of keyword parameter 'quite'.
--            Simply deleted it.
--    - v1.51 (02.10.02):
--        (M) Implemented new method of getting the most recent file (using 'jbFunctions').
--    - v1.40 (02.10.02):
--        (M) Modified code to run in debug mode where errors are NOT trapped by try/catch.
--        (M) Modified code to distinguish between 'file not found' and 'error on executing file'.
--    - v1.30 (01.23.02):
--        (m) Tidied up a little.
--    - v1.20 (02.26.01):
--        (m) Added optional argument to control the "standard error message."
--            This allows you to create your own, if desired.
--    - v1.10 (12.27.2k):
--        (m) Modified function to return 'true' is file successfully loaded;
--            and 'false' if not..
--    - v1.00 (12.15.2k):
--        (i) 1st release.
--*****************************************************

--------------------------
-- FUNCTION (fileInFN)
--
-- This function uses 'fileIn' to load the most recent script in a given directory.
-- Non-Encrypted (.ms) AND encrypted (.mse) scripts are considered.
-- Status/Results info is written to the Listener.
-- If an error is detected, a messagebox is displayed indicating the offending script.
-- Function return 'true' is file successfully loaded/executed; and 'false' if not.
-- This can be used to close the floater and abort the script, if necessary, or take whatever
-- actions are appropriate.
--
-- Note: 'fileInFN', 'fileIn', and 'include' canNOT be called from within an encrypted script.
--       This is a standard MAXScript limitation.

-- Start 'jbFunctions'...
-- Excerpted from 'jbFunctions.ms'
-- by John Burnette, foo@footools.com 
-- Available at http://www.footools.com/scripts.html
-- Details at http://www.footools.com/scripts/jbFunctionsDocs/index.html
--
-- List of Functions:
--    - dateAsPoint3()
--    - IsDateNewer()
--    - IsFileModNewer()
--    - IsFileCreateNewer()

global fileInFN

fn DateAsPoint3 dateStr = (
	try (
		local ar = filterString dateStr "/ "
		local pnt3 = [0,0,0]
		if (classOf ar == array) then (
			pnt3.x = ar[3] as integer
			pnt3.y = ar[1] as integer
			pnt3.z = ar[2] as integer

			-- Workaround for NT/W2K difference in localTime string
			if (pnt3.x < 2000) then pnt3.x += 2000

			return pnt3
		) else (
			return undefined
		)
	) catch ( undefined )
)

fn IsDateNewer dateStrA dateStrB =
(
	try
	(
		local dateA = DateAsPoint3 dateStrA
		local dateB = DateAsPoint3 dateStrB

		-- check for same date
		if (dateA == dateB) then
		(
			-- if same, compare seconds
			local secA = DateAsSeconds dateStrA
			local secB = DateAsSeconds dateStrB

			return (secA > secB)
		) else (
			-- if different, see which has the newer date
			if (dateA.x == dateA.x) then (
				if (dateA.y == dateA.y) then (
					return (dateA.z > dateB.z)
				) else (
					return (dateA.y > dateB.y)
				)
			) else (
				return (dateA.x > dateB.x)
			)
		)
	) catch ( undefined )
)

fn IsFileModNewer fPathA fPathB =
(
	local dateStrA = try (GetFileModDate fPathA) catch (return undefined)
	local dateStrB = try (GetFileModDate fPathB) catch (return undefined)

	IsDateNewer dateStrA dateStrB
)

fn IsFileCreateNewer fPathA fPathB =
(
	local dateStrA = try (GetFileCreateDate fPathA) catch (return undefined)
	local dateStrB = try (GetFileCreateDate fPathB) catch (return undefined)

	IsDateNewer dateStrA dateStrB
)
----- -- end 'jbFunctions'.


fn fileInFN fName fStr dbugMode:dbugMode =
(
local fArr, fCnt, fTMP, f, msg, tMsg

if dbugMode==undefined then dbugMode=false	-- Set local dbugMode to false if global 'dbugMode' is undefined.
											-- This allows the programmer to set debug mode at any time.

format ("FileIn:'" + fStr + "'...\n")
fArr	=getFiles fName
fCnt	=fArr.count
if fCnt!=0 then
(
	
--	f=fArr[fCnt]	-- Get file w/ highest # (i.e. most recent - according to alphabetical order).
					-- Legacy: This method did NOT always get the most recent file, even when the
					-- file numbering was 'correct.'

	-- Get most recently modified file (using 'jbFunctions').
	-- This handles the case where fname contains a wildcard (e.g. "c:\\test*.ms) so multiple files may be
	-- returned.
	fTMP=fArr[1]
	for i=2 to fArr.count do
	(
		if isFileModNewer fArr[i] fTMP then fTMP=fArr[i]
	)
	f=fTMP

	format "Attempting to load '%'...\n" f

	if NOT dbugMode then
	(
		-- We are here if error checking/handling is desired.
		try
		(
			fileIn f
			format "Loaded: '%'.\n" f
			
			true	-- => File FOUND and LOADED successfully.
		)
		catch
		(
			msg		="Error on executing '"+f+"'."
			tMsg	="File run error"
			format "%: %\n" tMsg msg
			messagebox msg title:tMsg

			false	-- => File NOT LOADED successfully.
		)
	)-- end 'if dbugMode'
	else
	(
		-- We are here if error checking/handling is NOT desired.
		-- DEBUG MODE!
		(
			fileIn f
			format "Loaded: '%'.\n" f

			true	-- => File FOUND and LOADED successfully.
		)
	
	)-- end 'else dbugMode'
)
else
(
	format "Attempting to load '%'...\n" f
	msg		="'"+fname+"' not found."
	tMsg	="File open error"
	format "%: %\n" tMsg msg
	messagebox msg title:tMsg

	false	-- => File NOT FOUND.
)


)-- end 'fileInFN()'

-- USAGE:
(
local runExample=false	-- Set =false, or =true to NOT run, or run the example.
						-- Must replace 'PutScriptPrefixHere*.ms*', 'PutScriptDescriptionHere'
						-- and 'theFloater' with the appropriate values.
						-- And, of course, 'theFloater' must exist.
if runExample then
(
	-- Attempt to load script...
	local dir=(getDir #scripts)	-- Change 'dir' to the desired directory.
								-- If no 'dir' is supplied, then MAX directories will be searched in the
								-- order defined in the MAXScriptHelp.
	
	local successful=fileInFN (dir+"\\PutScriptPrefixHere*.ms*") "PutScriptDescriptionHere"
	-- Note: Using the prefix of the script filename allows 'fileInFN' to find ALL versions of a script,
	--       then select the most recent file (by date).
	--       The '\\' and the two '*' MUST be included.
	--       If a specific script is desired, simply leave off the '*'.
	
	if NOT successful then
	(
		-- We are here if the script had an error or was not found.
		messagebox\
			"Software Failed to Load.\n\nPlease, check or install flagged support file(s) as detailed in the readme."\
			title:"Application Load Error"
		-- Take action if file load failed.
		closeRolloutFloater theFloater	-- Substitute 'theFloater' with the appropriate floater, or replace this line
										-- with an entirely different action.
	)
)-- end 'if runExample'
)-- end 'USAGE' block
--------------------------
--------------------------