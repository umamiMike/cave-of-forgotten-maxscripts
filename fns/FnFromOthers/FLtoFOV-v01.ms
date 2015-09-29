-- FLtoFOV-v01.ms
-- 10.23.2k, swami*, a.k.a. "codeWarrior()", swami@cfl.rr.com
--
-- This function converts Focal Length (in mm) to Field Of View (in degrees).
-- Returns "undefined" if an error occurs.
-- Direction: 1 => Horizontal (default)
--            2 => Vertical
--            3 => Diagonal
--
-- NOTE: The camera property '.fov' is the horizontal field of view, in degrees. Most often, one
-- wants to set the camera based on the lens' focal length. Use this function for that purpose.
-- The vertical and diagonal fov are provided for thoroughness.
--
fn FLtoFOV FL direction:1 =
(
	local span
	try
	(
		case direction of
		(
			1:	-- Horizontal.
			(
				span=getRendApertureWidth()							-- width.
			)
			2:	-- Vertical.
			(
				span=getRendApertureWidth()/getRendImageAspect()	-- height.
			)
			3:	-- Diagonal.
			(
				local width		=getRendApertureWidth()
				local height	=width/getRendImageAspect()
				span			=sqrt(width^2+height^2)				-- diagonal.
			)
		)
		local FOV=2.0*atan(0.5*span/FL)
	)
	catch (undefined)
)