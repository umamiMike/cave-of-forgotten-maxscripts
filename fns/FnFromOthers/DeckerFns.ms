-- 05.25.2k
-- DeckerFns.ms
-- Functions contributed to "Wad-O-Functions!" by Mark Decker (Markd@XAOS.com).
--
-- Function List:
--	checkHeap()
--	isKindof2()
--	polar()
--	polar()
--	circlePts()
--	forcePath()
--	remSpaces()
--	date6()
--
---------------------------------------------------------------------------------
-- checkHeap ensures that you have about 1MB of free space whenever you call it.

fn checkHeap =
(
if heapFree < 1000000 do
(
heapSize += 1000000 -- another meg please 
format "Slurp!\tTotal: %\n" heapSize
)
)
---------------------------------------------------------------------------------
-- Somebody (Larry?) gave me this extended version of isKindof, which gets
-- around limitations in classof when working with nurbs. Pass it an object
-- (node) and the class you're testing for (in my case, this was NURBSSurface).

fn isKindof2 obj class =
( 
local myClass=classof obj 
if myClass == class do return true 
if myClass == value do return false
isKindof2 myClass class
)
---------------------------------------------------------------------------------
-- I find polar coordinates very convenient for a lot of object creation stuff.
-- This one takes floats for azimuth, elevation, and radius, and returns a point3.

-- Special polar to rectangular converter limits elevation to +/- 90 degrees

fn polar az el r =
(
local px, py, pz
if el > 90.0 then el = 90.0
if el < -90.0 then el = -90.0
px = cos az * cos el * r
py = sin az * cos el * r
pz = sin el * r
[px, py, pz]
)
---------------------------------------------------------------------------------
-- Here's a different form of polar that takes its input as a point3 and treats 0,0 as straight up.
-- Convert from polar to rectangular coordinates.
-- Input Point3 contains [Azimuth, Elevation, Radius] respectively.
-- Az = El = 0 yields a point straight up Z.
fn polar pt =
(
[sin pt.y * pt.z,
sin pt.x * cos pt.y * pt.z, 
cos pt.x * cos pt.y * pt.z]
)
---------------------------------------------------------------------------------
-- circlePts creates an array of num points around a circle of radius cRadius,
-- with its center at ctrPt. The circle is in the xy plane. I used this to
-- create the circular cross section vertices for a vining, cylindrical object.

fn circlePts num cRadius ctrPt = 
(
local i, angle
local points = #()

angle = 360.0/ (num as float)
for i in 0 to (num - 1) do
(
append points ([cRadius * sin(i * angle) + ctrPt.x, 
cRadius * cos (i * angle) + ctrPt.y,
ctrPt.z])
)
points
)
---------------------------------------------------------------------------------
-- I created forcePath for a unified render dialog I created that among many
-- other things enforced studio file path and naming conventions on renders.
-- Given a file path, vPath, it checks the path and makes sure that all the
-- directories in it exist, creating them if necessary. It returns false if
-- for some reason it could not create the directories (no permissions, read
-- only device, etc.), otherwise true.

-- If any part of the supplied path does not exist, the rest will be created.
fn forcePath vPath =
(
local dirs, goodpath, success, lastDir, i, j
-- First separate path and remove trailing slash
dirs = filterString vPath "\\"
success = false
goodPath = dirs[1]
lastDir = dirs.count - 1
for i in 2 to lastDir do
(
goodPath += "\\" + dirs[i]
-- Test for the existence of the path to this point.
test = getDirectories goodPath
if test.count != 1 then
(
-- As soon as the test fails, we know we have to create the rest.
for j in i to lastDir do
(
format "Creating dir: %\n" goodPath
success = makeDir goodPath
if not success do return 3
goodPath += "\\" + dirs[j+1]
)
return true
)
else
success = true
)
success
)
---------------------------------------------------------------------------------
-- remSpaces just removes all the spaces from a string. Good for turning
-- element descriptions into filenames.

fn remSpaces str =
(
local strList = filterString str " "
local sub, result = ""
for sub in strList do result += sub
result
)
---------------------------------------------------------------------------------
-- date6 generates a 6 digit date string of the form yymmdd. Note that the
-- localtime function returns a date in the windows system format, which must
-- be set to month/day/year or similar formats with spaces or dashes as
-- seperators instead of slashes in order for this to work.

fn date6 = 
(
local sar, month, day, year, date
sar = filterstring localtime " /-"
if sar[3].count == 4 then
year = substring sar[3] 3 4
else
year = substring sar[3] 1 2

month = sar[1]
if month.count == 1 do month = "0" + month

day = sar[2]
if day.count == 1 do day = "0" + day

date = year + month + day 
)