/*
	Copyright (c) 2010, Laurent "MrPingouin" CHEA
	All rights reserved.

	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
	- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	- Neither the name of LAURENTCHEA.COM nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
	THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS 
	BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
	STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
	OF SUCH DAMAGE.

*********************************************************************************************************

	MrPingouin's Fast Positioning Tool 0.1
	contact@laurentchea.com
	http://www.laurentchea.com
	
	dec 2010

	This scripts performs basic random transformations on objects, but it does it an interactive way.
	It can randomize :
		- position
		- rotation
		- scale
	And it has two more functions :
		- attract / repulse nodes from a centerNode
		- quick put objects on a groundNode
		
	TODO :
	
		- Add a "strictly positive" on the attract repulse tool.
*/


g_app_name = "Fast Positioning Tool"
g_app_version = "0.1"

struct MovingNode
(
	_node,
	_initialPos,
	_centerNode,
	_initVector,
	_lastAttraction,
	
	function create obj = 
	(
		local mn = MovingNode()
		mn._node = obj
		return mn
	),
	
	function init centerNode = (
		_initialPos = _node.pos
		_centerNode = centerNode
		_initVector = _node.pos - _centerNode.pos
		_lastAttraction = 0.0
	),
	
	function evaluateDistance ratio doFade stayPositive fade_radius = 
	(
		local actualDistance = length(_node.Pos - _centerNode.pos)
		
		local influence = 0.0
		
		if doFade == true then
		(
			if actualDistance < fade_radius then
				influence = 1.0 - (actualDistance / fade_radius)
		)
		else
			influence = 1.0
		
		local direction = _lastAttraction - ratio
		_lastAttraction = ratio
		
		local newPos = _node.pos + (direction * _initVector) * influence
		
-- 		if stayPositive == true then
-- 		(
-- 			if direction <= ratio then
-- 			(
-- 				if length(newPos - _centerNode.pos) > length(_node.pos - _centerNode.pos) then
-- 					_node.pos = newPos
-- 			)
-- 			else
-- 				_node.pos = newPos
-- 		)
-- 		else
		
		_node.pos = newPos
		
	),
	
	function resetPos =
	(
		_node.pos = _initialPos
	)
)

struct AttractRepulseApp 
(
	_centerNode,
	_movingNodes,
	_gizmo,
	
	function createApp = 
	(
		local ns = AttractRepulseApp()
		return ns
	),
	
	function setMovingNodes nodesArray  = 
	(
		_movingNodes = #()

		for obj in nodesArray do
		(
			if obj != _centerNode then
			(
				local mn = movingNode.create obj
				append _movingNodes mn
			)
			else
			(
				local strError = "Center node \"" + _centerNode.name + "\" is part of selected objects.\nIt will be ignored."
				messageBox strError
			)
		)
	),
	
	function initMovingNodes = 
	(
		for mn in _movingNodes do
			mn.init _centerNode
	),
	
	function attractRepulse ratio doFade stayPositive fade_radius = 
	(
		for mn in _movingNodes do
			mn.evaluateDistance ratio doFade stayPositive fade_radius
	),
	
	function setCenterNode obj = 
	(
		_centerNode = obj
	),
	
	function resetNodes = 
	(
		for mn in _movingNodes do
			mn.resetPos()
	),
	
	function createGizmo radius = 
	(
		_gizmo = sphere()
		_gizmo.radius = radius
		_gizmo.pos = _centerNode.pos
		_gizmo.xray = true
	),
	
	function setGizmoRadius radius =
	(
		_gizmo.radius = radius
	),
	
	function deleteGizmo =
	(
		delete _gizmo
	)
)

struct randomPRSnode 
(
	_node,
	_pos,
	_posDirections,
	_rotDirections,
	_scaDirections,
	_rot,
	_scale,
	_randomRatio,
	
	function create node =
	(
		local n = randomPRSnode()
		n._node = node
		return n
	),
	
	function newRatioSeed = (
		_randomRatio = random 0.0 1.0
	),
	
	function init = 
	(
		try
		(
			_pos = _node.position
			_rot = _node.rotation
			_scale = _node.scale
			
			_posDirections = [1,1,1]
			_rotDirections = [1,1,1]
			_scaDirections = 1
			
			local directions = [-1,1]
			
			for i = 1 to 3 do
			(
				_posDirections[i] = directions[(random 1 2)]
				_rotDirections[i] = directions[(random 1 2)]
			)
			
			_scaDirections = directions[(random 1 2)]
			newRatioSeed()
		)
		catch
		(
			messagebox (getCurrentException())
		)
	),
	
	function evaluatePos x y z strictlyPositive =
	(
		if strictlyPositive == true then
		(
			x = _randomRatio * x
			y = _randomRatio * y 
			z = _randomRatio * z
		)
		else
		(
			x = _randomRatio * x / 2 * _posDirections[1]
			y = _randomratio  * y /2 * _posDirections[2]
			z = _randomratio  * z /2 * _posDirections[3]
		)
		
		_node.position = _pos + [x,y,z]
	),
	
	function evaluateRot x y z strictlyPositive =
	(
		local tmpPos = copy _node.pos
		_node.rotation = _rot
	
		if strictlyPositive == true then
		(
			x = _randomRatio * x
			y = _randomRatio * y
			z = _randomRatio * z
		)
		else
		(
			x = _randomRatio * x / 2 * _rotDirections[1]
			y = _randomRatio * y / 2 * _rotDirections[2]
			z = _randomRatio * z / 2 * _rotDirections[3]
		)
		
		in coordsys local	rotate _node (eulerAngles x y z)
		_node.pos = copy tmpPos
	),
	
	function evaluateScale x y z strictlyPositive =
	(
		if strictlyPositive == true then
		(
			x = _randomRatio * x
			y = _randomRatio * y
			z = _randomRatio * z
		)
		else
		(
			x = _randomRatio * x / 2 * _scaDirections
			y = _randomRatio * y / 2 * _scaDirections
			z = _randomRatio * z / 2 * _scaDirections
		)
		_node.scale = _scale + [x,y,z]
	),
	
	function resetPRS = 
	(
		_node.position = [0,0,0]
		_node.rotation = _rot
		_node.position = _pos
		_node.scale = _scale
	)
)

struct RandomPRSapp
(
	_nodes,
	
	function createApp =
	(
		local r = RandomPRSapp()
		return r
	),
	
	function evaluatePos x y z strictlyPositive =
	(
		for n in _nodes do
			n.evaluatePos x y z strictlyPositive
	),
	
	function evaluateRot x y z strictlyPositive= 
	(
		for n in _nodes do
			n.evaluateRot x y z strictlyPositive
	),
	
	function evaluateScale x y z strictlyPositive  = 
	(
		for n in _nodes do
			n.evaluateScale x y z strictlyPositive 
		),
	
	function initNodes nodes= 
	(
		_nodes = #()
		for n in nodes do
		(
			local prsNode = randomPRSnode n
			append _nodes prsNode
			prsNode.init()
		)
	),
	
	function resetNodes = 
	(
		for n in _nodes do
			n.resetPRS()
	),
	
	function newRatioSeed = 
	(
		for n in _nodes do
			n.newRatioSeed()
	)
)

struct putNodesToGroundApp
(
	function createApp = 
	(
		local app = putNodesToGroundApp()
		return app
	),
	
	function putNodeToGround obj groundObj &rm followSurface = 
	(
		local orig_Z = obj.pos.z
		obj.pos.z = 1000
		
		local theHitsCount = rm.intersectRay obj.pos [0,0,-1] false
		
		if theHitsCount > 0 then
		(
			obj.pos.z -= (rm.getHitDist 1)
			
			if followSurface == true then
			(
				local faceNormal = -(rm.getHitNormal 1)
				
				a = acos (dot faceNormal obj.dir)
				
				worldUpVector = [0,0,1]
				rightVector = normalize (cross worldUpVector faceNormal) 
				upVector = normalize (cross rightVector faceNormal)
				local pos = obj.pos
				
				theMatrix = matrix3 rightVector upVector faceNormal pos
				
				in coordsys theMatrix
				(
					rotate obj (eulerangles a 0 0)
				)
			)
		)
		else
		(
			format "missed, theHitsCount == %\n" theHitsCount
			obj.pos.z = orig_Z
		)
	),
	
	function process ground nodes dig followSurface  = 
	(
		rm = RayMeshGridIntersect()
		rm.Initialize 100
		rm.addNode ground
		rm.buildGrid()
		
		for n in nodes do
		(
			putNodeToGround n ground &rm followSurface 
			n.pos.z -= dig
		)
	)
)

rollout AttractRepulse_R "Attract / Repulse" 
(
	
	local ns = undefined

	checkbox doFade_cb "Use attenuation" align:#right checked:false enabled:false
	--checkbox stayPositive_cb "Strictly positive" checked:true
	
	spinner fade_spn "Att. radius :" type:#worldUnits range:[0,1000.0,40.0] enabled:false 
	spinner attraction_spn "Force :" type:#worldUnits range:[-1000.0,1000.0,0.0] enabled:false
	
	pickbutton getCenterNode_pb "Pick center node" align:#right
	checkbutton cbtn_operate "Operate" enabled:false across:2 align:#right
	button reset_btn "Reset" enabled:false align:#right
	
	on AttractRepulse_R open do
	(
		ns = AttractRepulseApp()
	)
	
	on getCenterNode_pb picked obj do
	(
		if obj != undefined then
		(
			ns.setCenterNode obj
			getCenterNode_pb.text = obj.name
			cbtn_operate.enabled = true
		)
	)
	
	on doFade_cb changed state do
	(
		if cbtn_operate.state == true then
			fade_spn.enabled = state
	)
	
	on cbtn_operate changed state do
	(
		-- Dirty trick : 0 PRS transformation, to set it in the undo history
		undo "Attrace Repulse" on 
		(
			move selection [0,0,0]
			rotate selection (eulerangles 0 0 0)
			scale selection [1,1,1]
		)
		
		if state == true then
		(
			ns.setMovingNodes (selection as array)
			ns.initMovingNodes()
		)
		else
		(
			attraction_spn.value = 0.0
		)
		
		doFade_cb.enabled = state
		fade_spn.enabled = doFade_cb.state
		attraction_spn.enabled = state
		reset_btn.enabled = state
	)
	
	on attraction_spn changed val do with undo off
	(
		ns.attractRepulse val doFade_cb.checked false fade_spn.value 
	)
	
	on attraction_spn buttonup cancelled do
	(
		if cancelled == true then
		(
			ns.resetNodes()
		)
	)
	
	on reset_btn pressed do
	(
		ns.resetNodes()
	)
	
	on fade_spn buttondown do with undo off
	(
		ns.createGizmo fade_spn.value
	)
	
	on fade_spn changed val do with undo off
	(
		ns.setGizmoRadius val
	)
	
	on fade_spn buttonup do with undo off
	(
		ns.deleteGizmo()
	)
)

rollout randomPRS_R "PRS"
(
	local posRange = [-1000.0, 1000.0,0]
	local rotRange = [-360.0,360.0,0]
	local scaRange = [-100.0,100.0,0]
	
	local prsApp = undefined
	
	group "Position"
	(
		spinner pos_x_spn "X : " type:#worldUnits range:posRange fieldwidth:40 across:3 enabled:false
		spinner pos_y_spn "Y : " type:#worldUnits range:posRange fieldwidth:40 enabled:false
		spinner pos_z_spn "Z : " type:#worldUnits range:posRange fieldwidth:40 enabled:false
		checkbox pos_strictPositive "Strictly positive" checked:false enabled:false
	)
	
	group "Rotation"
	(
		spinner rot_x_spn "X : " type:#float range:rotRange fieldwidth:40 across:3 enabled:false
		spinner rot_y_spn "Y : " type:#float range:rotRange fieldwidth:40 enabled:false
		spinner rot_z_spn "Z : " type:#float range:rotRange fieldwidth:40 enabled:false
		checkbox rot_strictPositive "Strictly positive" checked:false enabled:false
	)
	
	group "Scale"
	(
		spinner sca_x_spn "X : " type:#float range:scaRange fieldwidth:40 across:3 enabled:false
		spinner sca_y_spn "Y : " type:#float range:scaRange fieldwidth:40 enabled:false
		spinner sca_z_spn "Z : " type:#float range:scaRange fieldwidth:40 enabled:false
		checkbox sca_strictPositive "Strictly positive" checked:false enabled:false across:2
		checkbox sca_allAxis_cb "All Axis" checked:true enabled:false
	)
	
	checkbutton operate_cbtn "Operate" across:3
	button reset_btn "Reset" enabled:false
	button seed_btn "New seed" enabled:false
	
	
	on randomPRS_R open do
	(
		prsApp = RandomPRSapp.createApp()
	)
	
	on operate_cbtn changed state do
	(
		-- We perform a  0-move, 0-rotate and 0-scale to get the PRS values in the undo history
		undo "Random PRS" on 
		(
			move selection [0,0,0]
			rotate selection (eulerangles 0 0 0)
			scale selection [1,1,1]
		)
		
		if state == true then
		(
			prsApp.initNodes (selection as array)
		)
		else
		(
			pos_x_spn.value = pos_y_spn.value = pos_z_spn.value = 0
			rot_x_spn.value = rot_y_spn.value = rot_z_spn.value = 0
			sca_x_spn.value = sca_y_spn.value = sca_z_spn.value = 0
		)
		
		pos_x_spn.enabled = pos_y_spn.enabled = pos_z_spn.enabled = pos_strictPositive.enabled = state
		rot_x_spn.enabled = rot_y_spn.enabled = rot_z_spn.enabled = rot_strictPositive.enabled = state
		sca_x_spn.enabled = sca_strictPositive.enabled = sca_allAxis_cb.enabled = state
		reset_btn.enabled = state
		seed_btn.enabled = state
	)
	
	on pos_x_spn changed val do with undo off
	(
		prsApp.evaluatePos pos_x_spn.value pos_y_spn.value pos_z_spn.value pos_strictPositive.checked
	)
	
	on pos_y_spn changed val do with undo off
	(
		prsApp.evaluatePos pos_x_spn.value  pos_y_spn.value pos_z_spn.value pos_strictPositive.checked
	)
	
	on pos_z_spn changed val do with undo off
	(
		prsApp.evaluatePos pos_x_spn.value  pos_y_spn.value pos_z_spn.value pos_strictPositive.checked
	)
	
	on rot_x_spn changed val do with undo off
	(
		prsApp.evaluateRot rot_x_spn.value rot_y_spn.value rot_z_spn.value rot_strictPositive.checked
	)
	
	on rot_y_spn changed val do with undo off
	(
		prsApp.evaluateRot rot_x_spn.value rot_y_spn.value rot_z_spn.value rot_strictPositive.checked
	)
	
	on rot_z_spn changed val do with undo off
	(
		prsApp.evaluateRot rot_x_spn.value rot_y_spn.value rot_z_spn.value rot_strictPositive.checked
	)
	
	on sca_x_spn changed val do with undo off
	(
		if sca_allAxis_cb.checked == true then
			sca_y_spn.value = sca_z_spn.value = sca_x_spn.value
		prsApp.evaluateScale sca_x_spn.value sca_y_spn.value sca_z_spn.value sca_strictPositive.checked
	)
	
	on sca_y_spn changed val do with undo off
	(
		if sca_allAxis_cb.checked == true then
			sca_x_spn.value = sca_z_spn.value = sca_y_spn.value
		prsApp.evaluateScale sca_x_spn.value sca_y_spn.value sca_z_spn.value sca_strictPositive.checked
	)
	
	on sca_z_spn changed val do with undo off
	(
		if sca_allAxis_cb.checked == true then
			sca_y_spn.value = sca_x_spn.value = sca_z_spn.value
		prsApp.evaluateScale sca_x_spn.value sca_y_spn.value sca_z_spn.value sca_strictPositive.checked
	)
	
	on reset_btn pressed do
	(
		prsApp.resetNodes()
		pos_x_spn.value = pos_y_spn.value = pos_z_spn.value = 0.0
		rot_x_spn.value = rot_y_spn.value = rot_z_spn.value = 0.0
		sca_x_spn.value = sca_y_spn.value = sca_z_spn.value = 0.0
	)
	
	on sca_allAxis_cb changed state do
	(
		sca_y_spn.enabled = sca_z_spn.enabled = not state
	)
	
	on pos_strictPositive changed state do
	(
		prsApp.evaluatePos pos_x_spn.value  pos_y_spn.value pos_z_spn.value pos_strictPositive.checked
	)
	
	on rot_strictPositive changed state do
	(
		prsApp.evaluateRot rot_x_spn.value rot_y_spn.value rot_z_spn.value rot_strictPositive.checked
	)
	
	on sca_strictPositive changed state do
	(
		prsApp.evaluateScale sca_x_spn.value sca_y_spn.value sca_z_spn.value sca_strictPositive.checked
	)
	
	on seed_btn pressed do
	(
		prsApp.newRatioSeed()
		prsApp.evaluatePos pos_x_spn.value pos_y_spn.value pos_z_spn.value pos_strictPositive.checked
		prsApp.evaluateRot rot_x_spn.value rot_y_spn.value rot_z_spn.value rot_strictPositive.checked
		prsApp.evaluateScale sca_x_spn.value sca_y_spn.value sca_z_spn.value sca_strictPositive.checked
	)
)

rollout putToGround_R "Set nodes to ground"
(
	pickbutton getGroundObj_pb "Pick ground" across:2 
	spinner dig_spn "Dig : " type:#worldUnits range:[-100.0,100.0,0] offset:[0,2] fieldwidth:60
	checkbox followSurfaceNormals_cb "Follow surface normals" checked:false
	local app = undefined
	
	on putToGround_R open do
	(
		app = putNodesToGroundApp.createApp()
	)
	
	on getGroundObj_pb picked obj do 
	(
		if obj != undefined then
		(
			undo "Set nodes to ground" on
			(
				app.process obj (selection as array) dig_spn.value followSurfaceNormals_cb.checked
			)
		)
	)
)


nf = newRolloutFloater (g_app_name + " " + g_app_version)  250 485

addRollout randomPRS_R nf
addRollout putToGround_R nf
addRollout AttractRepulse_R  nf