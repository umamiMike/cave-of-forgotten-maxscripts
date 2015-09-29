/*
SpiroTube V1.5
*/
Preset default array:
#("Name",#(integer <Segments>, string <xFunction>, string <yFunction>, string <zFunction>, float <m>, float <n>, float <p>, float <q>, float <h>, float <t>, float <frequency>, string <CustomFunction>),#(boolean <useSegments>, boolean <useXfunction>, boolean <useYfunction>, boolean <useZfunction>, boolean <useM>, boolean <useN>, boolean <useP>, boolean <useQ>, boolean <useH>, boolean <useT>, boolean <useFrequency>, boolean <useCustomFunction>))

fn rotateVector v1 v2 amount=
(
	/*
	Thanks to 
	http://www.blitzbasic.com/Community/posts.php?topic=57616
	*/
	x=v1[1]
	y=v1[2]
	z=v1[3]
	u=v2[1]
	v=v2[2]
	w=v2[3]
	a=amount
	
	ux=u*x
	uy=u*y
	uz=u*z
	vx=v*x
	vy=v*y
	vz=v*z
	wx=w*x
	wy=w*y
	wz=w*z
	sa=Sin(a)
	ca=Cos(a)
	x=u*(ux+vy+wz)+(x*(v*v+w*w)-u*(vy+wz))*ca+(-wy+vz)*sa
	y=v*(ux+vy+wz)+(y*(u*u+w*w)-v*(ux+wz))*ca+(wx-uz)*sa
	z=w*(ux+vy+wz)+(z*(u*u+v*v)-w*(ux+vy))*ca+(-vx+uy)*sa
	result=normalize[x,y,z]
	result
)
fn getPresets=
(
	ans=false
	fileName=getMAXIniFile()
	if fileName !=undefined then
	(
		Settings=execute (getINISetting fileName "SpiroTube" "Presets")
		if classof Settings ==array then
			ans=Settings
		else
			messagebox "Unable to load presets" title:"SpiroTube"
	)
	else
		messagebox "Unable to get Max Ini file." title:"SpiroTube"
	
	return ans
)
fn getPreset pos=
(
	ans=false
	fileName=getMAXIniFile()
	if fileName !=undefined then
	(
		Settings=execute (getINISetting fileName "SpiroTube" "Presets")
		if classof Settings ==array then
			ans=Settings[pos]
		else
			messagebox "Unable to load presets" title:"SpiroTube"
	)
	else
		messagebox "Unable to get Max Ini file." title:"SpiroTube"
	
	return ans
)
fn savePreset preset pos=
(
	ans=false
	fileName=getMAXIniFile()
	if fileName !=undefined then
	(
		Settings=execute (getINISetting fileName "SpiroTube" "Presets")
		if classof Settings !=array do
		(
			Settings=#( )
			pos=1
		)
		Settings[pos]=preset
		Settings=Settings as string
		ans=setINISetting fileName "SpiroTube" "Presets" Settings
		if ans==false do
		(
			messagebox "Unable to save presets" title:"SpiroTube"
		)
	)
	else
		messagebox "Unable to get Max Ini file." title:"SpiroTube"
	
	return ans
)
fn savePresets presets=
(
	ans=false
	fileName=getMAXIniFile()
	if fileName !=undefined then
	(
		Settings=execute (getINISetting fileName "SpiroTube" "Presets")
		
		Settings=presets as string
		ans=setINISetting fileName "SpiroTube" "Presets" Settings
		if ans==false do
		(
			messagebox "Unable to save presets" title:"SpiroTube"
		)
	)
	else
		messagebox "Unable to get Max Ini file." title:"SpiroTube"
	
	return ans
)
fn setPreset preset obj=
(
	ans=false
	fileName=getMAXIniFile()
	if fileName !=undefined then
	(
		Settings=execute (getINISetting fileName "SpiroTube" "Presets")
		if classof Settings ==array do
		(
			curSettings=Settings[preset]
			if curSettings !=undefined do
			(
				ans=true
				if curSettings[3][1]==true do
					obj.segments=curSettings[2][1]
				if curSettings[3][2]==true do
					obj.xFunction=curSettings[2][2]
				if curSettings[3][3]==true do
					obj.yFunction=curSettings[2][3]
				if curSettings[3][4]==true do
					obj.zFunction=curSettings[2][4]
				if curSettings[3][5]==true do
					obj.m=curSettings[2][5]
				if curSettings[3][6]==true do
					obj.n=curSettings[2][6]
				if curSettings[3][7]==true do
					obj.p=curSettings[2][7]
				if curSettings[3][8]==true do
					obj.q=curSettings[2][8]
				if curSettings[3][9]==true do
					obj.h=curSettings[2][9]
				if curSettings[3][10]==true do
					obj.t=curSettings[2][10]
				if curSettings[3][11]==true do
					obj.RegularFrequency=curSettings[2][11]
				if curSettings[3][12]==true do
					obj.custom=curSettings[2][12]
			)
		)
	)
	else
		messagebox "Unable to get Max Ini file." title:"SpiroTube"
	
	return ans
)
rollout SpiroTubePreset "Preset editor" width:176 height:152
(	
	local obj
	
	on SpiroTubePreset close do
	(
		deleteallchangehandlers ID:#STP1
		deleteallchangehandlers ID:#STP2
	)
	
	groupBox quickEdit "Quick editor" pos:[8,0] width:160 height:112
	dropDownList presetSel "" pos:[16,16] width:144 height:21
	editText presetName "Name: " pos:[16,40] width:144 height:16
	checkbox quickSet "Settings" pos:[16,64] width:144 height:16
	checkbox quickMeshSet "Mesh settings" pos:[16,88] width:144 height:16
	button save1 "Save" pos:[8,120] width:72 height:24
	button advanced1 "Advanced" pos:[96,120] width:72 height:24
	
	GroupBox advancedEdit "Advanced settings" pos:[8,152] width:160 height:304
	
	spinner Segments "" pos:[64,168] width:96 height:16 type:#integer range:[3,9999,0]
	checkbox useSegments "Seg.:" pos:[16,168] width:48 height:16
	
	checkbox useX "X" pos:[16,192] width:24 height:16
	edittext xFunction "" pos:[40,192] width:120 height:16
	checkbox useY "Y" pos:[16,216] width:24 height:16
	edittext yFunction "" pos:[40,216] width:120 height:16
	checkbox useZ "Z" pos:[16,240] width:24 height:16
	edittext zFunction "" pos:[40,240] width:120 height:16
	
	spinner m "" pos:[48,264] width:112 height:16 type:#float range:[-99999,99999,0]
	checkbox useM "M" pos:[16,264] width:32 height:16
	spinner n "" pos:[48,288] width:112 height:16 type:#float range:[-99999,99999,0]
	checkbox useN "N" pos:[16,288] width:32 height:16
	spinner p "" pos:[48,312] width:112 height:16 type:#float range:[-99999,99999,0]
	checkbox useP "P" pos:[16,312] width:32 height:16
	spinner q "" pos:[48,336] width:112 height:16 type:#float range:[-99999,99999,0]
	checkbox useQ "Q" pos:[16,336] width:32 height:16
	spinner h "" pos:[48,360] width:112 height:16 type:#float range:[-99999,99999,0]
	checkbox useH "H" pos:[16,360] width:32 height:16
	spinner t "" pos:[48,384] width:112 height:16 type:#float range:[-99999,99999,0]
	checkbox useT "T" pos:[16,384] width:32 height:16
	
	spinner frequency "" pos:[64,408] width:96 height:16
	checkbox useFrequency "Freq.:" pos:[16,408] width:48 height:16
	edittext custom "" pos:[64,433] width:96 height:15
	checkbox UseCustom "Cust.:" pos:[16,432] width:48 height:16
	
	button reset1 "Reset" pos:[8,464] width:72 height:24
	button remove1 "Remove" pos:[96,464] width:72 height:24
	
	on quickSet changed state do
	(
		useX.state=state
		useY.state=state
		useZ.state=state
		useM.state=state
		useN.state=state
		useP.state=state
		useQ.state=state
		useH.state=state
		useT.state=state
	)
	on quickMeshSet changed state do
	(
		useSegments.state=state
		useFrequency.state=state
		UseCustom.state=state
	)
	on reset1 pressed do
	(
		if querybox "Warning, this will reset all presets to defaults. Continue?" title:"SpiroTube" do
		(
			preset1=#("Torus", #(50, "M*cos(360.0*I/segments)", "M*sin(360.0*I/segments)", "H", 40, 0, 0, 0, 0, 0, 3, " "), #(true, true, true, true, true, false, false, false, true, false, false, false))
			preset2=#("Knot", #(360, "M*cos(P*I)+N*cos(Q*I)", "M*sin(P*I)+N*sin(Q*I)", "H*sin(T*I)", 15, 20, 1, 3, 4.5, 4, 4, ""), #(true, true, true, true, true, true, true, true, true, true, true, false, false))
			preset3=#("Helix", #(100, "(((m*(segments-i))+(p*i))/segments)*cos((n*360.0)*i/segments)", "(((m*(segments-i))+(p*i))/segments)*sin((n*360.0)*i/segments)", "((h as float)/segments)*i", 40, 5, 10, 3, 100, 4, 15, ""), #(true, true, true, true, true, true, true, true, true, true, false, false))
			defaultPresets=#(preset1, preset2, preset3)
			savePresets defaultPresets
			
			--Reseting preset list
			presets=getPresets()
			if presets !=false do
			(	
				newArr=#( )
				for i=1 to presets.count do
				(
					newArr[i]=presets[i][1]
				)
				newArr[newArr.count+1]="New..."
				presetSel.items=newArr
				presetSel.selection=newArr.count
				presetName.text="New..."
				
				segments.value=obj.segments
				xFunction.text=obj.xFunction
				yFunction.text=obj.yFunction
				zFunction.text=obj.zFunction
				m.value=obj.m
				n.value=obj.n
				p.value=obj.p
				q.value=obj.q
				h.value=obj.h
				t.value=obj.t
				frequency.value=obj.RegularFrequency
				custom.text=obj.custom
				useSegments.state=false
				useX.state=true
				useY.state=true
				useZ.state=true
				useM.state=true
				useN.state=true
				useP.state=true
				useQ.state=true
				useH.state=true
				useT.state=true
				useFrequency.state=false
				useCustom.state=false
				
				quickSet.state=true
				quickMeshSet.state=false
			)
		)
	)
	on remove1 pressed do
	(
		curSel=presetSel.selection
		if curSel==presetSel.items.count then
		(
			messagebox "Please select preset to remove from list" title:"SpiroTube"
		)
		else
		(
			curPresets=getPresets()
			curPresets=deleteItem curPresets presetSel.selection
			
			savePresets curPresets
			
			--Reseting preset list
			presets=getPresets()
			if presets !=false do
			(	
				newArr=#( )
				for i=1 to presets.count do
				(
					newArr[i]=presets[i][1]
				)
				newArr[newArr.count+1]="New..."
				presetSel.items=newArr
				presetSel.selection=newArr.count
				presetName.text="New..."
				
				segments.value=obj.segments
				xFunction.text=obj.xFunction
				yFunction.text=obj.yFunction
				zFunction.text=obj.zFunction
				m.value=obj.m
				n.value=obj.n
				p.value=obj.p
				q.value=obj.q
				h.value=obj.h
				t.value=obj.t
				frequency.value=obj.RegularFrequency
				custom.text=obj.custom
				useSegments.state=false
				useX.state=true
				useY.state=true
				useZ.state=true
				useM.state=true
				useN.state=true
				useP.state=true
				useQ.state=true
				useH.state=true
				useT.state=true
				useFrequency.state=false
				useCustom.state=false
				quickSet.state=true
				quickMeshSet.state=false
			)
		)
	)
	on save1 pressed do
	(
		newPreset=#( )
		newPreset[1]=PresetName.text
		newPreset[2]=#( )
		newPreset[2][1]=Segments.value
		newPreset[2][2]=xFunction.text
		newPreset[2][3]=yFunction.text
		newPreset[2][4]=zFunction.text
		newPreset[2][5]=m.value
		newPreset[2][6]=n.value
		newPreset[2][7]=p.value
		newPreset[2][8]=q.value
		newPreset[2][9]=h.value
		newPreset[2][10]=t.value
		newPreset[2][11]=frequency.value
		newPreset[2][12]=custom.text
		newPreset[3]=#( )
		newPreset[3][1]=useSegments.state
		newPreset[3][2]=useX.state
		newPreset[3][3]=useY.state
		newPreset[3][4]=useZ.state
		newPreset[3][5]=useM.state
		newPreset[3][6]=usen.state
		newPreset[3][7]=usep.state
		newPreset[3][8]=useq.state
		newPreset[3][9]=useh.state
		newPreset[3][10]=uset.state
		newPreset[3][11]=useFrequency.state
		newPreset[3][12]=useCustom.state
		
		curPresets=getPresets()
		curPresets[presetSel.selection]=newPreset
		
		savePresets curPresets
		
		--Reseting preset list
		presets=getPresets()
		if presets !=false do
		(
			newArr=#( )
			for i=1 to presets.count do
			(
				newArr[i]=presets[i][1]
			)
			newArr[newArr.count+1]="New..."
			presetSel.items=newArr
			presetSel.selection=newArr.count
			presetName.text="New..."
			
			segments.value=obj.segments
			xFunction.text=obj.xFunction
			yFunction.text=obj.yFunction
			zFunction.text=obj.zFunction
			m.value=obj.m
			n.value=obj.n
			p.value=obj.p
			q.value=obj.q
			h.value=obj.h
			t.value=obj.t
			frequency.value=obj.RegularFrequency
			custom.text=obj.custom
			useSegments.state=false
			useX.state=true
			useY.state=true
			useZ.state=true
			useM.state=true
			useN.state=true
			useP.state=true
			useQ.state=true
			useH.state=true
			useT.state=true
			useFrequency.state=false
			useCustom.state=false
			quickSet.state=true
			quickMeshSet.state=false
		)
	)
	on SpiroTubePreset open do
	(
		obj=$
		when obj deleted ID:#STP1 do
		(
			destroydialog SpiroTubePreset
			deleteallchangehandlers ID:#STP1
			deleteallchangehandlers ID:#STP2
		)
		when select obj change ID:#STP2 do
		(
			destroydialog SpiroTubePreset
			deleteallchangehandlers ID:#STP1
			deleteallchangehandlers ID:#STP2
		)
		--Loading presets
		presets=getPresets()
		if presets !=false do
		(
			newArr=#( )
			for i=1 to presets.count do
			(
				newArr[i]=presets[i][1]
			)
			newArr[newArr.count+1]="New..."
			presetSel.items=newArr
			presetSel.selection=newArr.count
			presetName.text="New..."
			
			segments.value=obj.segments
			xFunction.text=obj.xFunction
			yFunction.text=obj.yFunction
			zFunction.text=obj.zFunction
			m.value=obj.m
			n.value=obj.n
			p.value=obj.p
			q.value=obj.q
			h.value=obj.h
			t.value=obj.t
			frequency.value=obj.RegularFrequency
			custom.text=obj.custom
			useSegments.state=false
			useX.state=true
			useY.state=true
			useZ.state=true
			useM.state=true
			useN.state=true
			useP.state=true
			useQ.state=true
			useH.state=true
			useT.state=true
			useFrequency.state=false
			useCustom.state=false
			
			quickSet.state=true
		)
	)
	on presetSel selected curSel do
	(
		if curSel==presetSel.items.count then
		(
			presetName.text="New..."
			segments.value=obj.segments
			xFunction.text=obj.xFunction
			yFunction.text=obj.yFunction
			zFunction.text=obj.zFunction
			m.value=obj.m
			n.value=obj.n
			p.value=obj.p
			q.value=obj.q
			h.value=obj.h
			t.value=obj.t
			Frequency.value=obj.RegularFrequency
			custom.text=obj.custom
			useSegments.state=false
			useX.state=true
			useY.state=true
			useZ.state=true
			useM.state=true
			useN.state=true
			useP.state=true
			useQ.state=true
			useH.state=true
			useT.state=true
			useFrequency.state=false
			useCustom.state=false
			quickSet.state=false
			quickMeshSet.state=false
		)
		else
		(
			curPreset=getPreset curSel
			if curPreset !=false do
			(
				presetName.text=curPreset[1]
				segments.value=curPreset[2][1]
				xFunction.text=curPreset[2][2]
				yFunction.text=curPreset[2][3]
				zFunction.text=curPreset[2][4]
				m.value=curPreset[2][5]
				n.value=curPreset[2][6]
				p.value=curPreset[2][7]
				q.value=curPreset[2][8]
				h.value=curPreset[2][9]
				t.value=curPreset[2][10]
				Frequency.value=curPreset[2][11]
				custom.text=curPreset[2][12]
				useSegments.state=curPreset[3][1]
				useX.state=curPreset[3][2]
				useY.state=curPreset[3][3]
				useZ.state=curPreset[3][4]
				useM.state=curPreset[3][5]
				useN.state=curPreset[3][6]
				useP.state=curPreset[3][7]
				useQ.state=curPreset[3][8]
				useH.state=curPreset[3][9]
				useT.state=curPreset[3][10]
				useFrequency.state=curPreset[3][11]
				useCustom.state=curPreset[3][12]
				quickSet.state=false
				quickMeshSet.state=false
			)
		)
	)
	on advanced1 pressed do
	(
		if SpiroTubePreset.height==152 then
			SpiroTubePreset.height=496
		else
			SpiroTubePreset.height=152
	)
)
rollout posEditor "Editor" height:256
(
	local obj
	label xLabel "X Function" align:#center
	editText X "" height:50 align:#left width:150
	
	label yLabel "Y Function" align:#center
	editText Y "" height:50 align:#left width:150
	
	label zLabel "Z Function" align:#center
	editText Z "" height:50 align:#left width:150
	
	checkbutton autoUpdate "Auto update" height:25 checked:true
	
	on autoUpdate changed state do
	(
		if state==true do
		(
			obj.xFunction=x.text
			obj.yFunction=y.text
			obj.zFunction=z.text
		)
	)
	
	on X changed text1 do
	(
		if autoUpdate.state==true do
			obj.xFunction=text1
	)
	on Y changed text1 do
	(
		if autoUpdate.state==true do
			obj.yFunction=text1
	)
	on Z changed text1 do
	(
		if autoUpdate.state==true do
			obj.zFunction=text1
	)
	
	on posEditor resized size do
	(
		posEditor.height=256
		x.width=size[1]-16
		y.width=size[1]-16
		z.width=size[1]-16
		autoUpdate.pos.x=(size[1]/2)-37
		xLabel.pos.x=(size[1]/2)-25
		yLabel.pos.x=(size[1]/2)-25
		zLabel.pos.x=(size[1]/2)-25
	)
	on posEditor close do
	(
		deleteAllChangeHandlers id:#STE1
		deleteAllChangeHandlers id:#STE2
		
		if autoUpdate.state==false do
		(
			if querybox "Save changes?" title:"SpiroTube" do
			(
				obj.xFunction=x.text
				obj.yFunction=y.text
				obj.zFunction=z.text
			)
		)
		obj.params.editor.checked=false
	)
	on posEditor open do
	(
		obj=$
		
		x.text=obj.xFunction
		y.text=obj.yFunction
		z.text=obj.zFunction
		x.pos.x=5
		y.pos.x=5
		z.pos.x=5
		x.pos.y-=3
		y.pos.y-=3
		z.pos.y-=3
		autoUpdate.pos.x=(posEditor.width/2)-37
		when obj deleted id:#STE1 do
		(
			destroydialog posEditor
			deleteAllChangeHandlers id:#STE1
			deleteAllChangeHandlers id:#STE2
		)
		when select obj change do
		(
			destroydialog posEditor
			deleteAllChangeHandlers id:#STE1
			deleteAllChangeHandlers id:#STE2
		)
	)
)
plugin simpleobject SpiroTube
name:"SpiroTube"
classID:#(0x7967d905, 0x24780e59)
category:"Extended Primitives"
(
	parameters Params rollout:Params
	(
		Radius type:#worldunits ui:Radius default:10
		Segments type:#integer ui:Segments1 default:35
		Sides type:#integer ui:Sides default:10
		Size type:#float ui:Size default:1
		xFunction type:#string ui:xFunction default:"m*cos(360.0*i/segments)"
		yFunction type:#string ui:yFunction default:"m*sin(360.0*i/segments)"
		zFunction type:#string ui:zFunction default:"0.0"
		autoUpdate type:#boolean ui:autoUpdate default:true
	)
	parameters Values rollout:Values
	(
		M type:#float ui:M default:50
		N type:#float ui:N default:0
		P type:#float ui:P default:0
		Q type:#float ui:Q default:0
		H type:#float ui:H default:0
		T type:#float ui:T default:0
	)
	parameters MeshSettings rollout:MeshSettings
	(
		Amount type:#worldunits ui:amount1 default:0
		UseRegular type:#boolean ui:UseRegular default:false
		RegularFrequency type:#float ui:RegularFrequency default:3
		RegularOffset type:#float ui:RegularOffset default:0
		UseDistance type:#boolean ui:UseDistance default:false
		UseCustom type:#boolean ui:UseCustom default:false
		Custom type:#string ui:Custom default:"Amount*cos(i)"
		RotateAmount type:#float ui: rotationAmount default:0
		Twist type:#float ui:TwistAmount default:0
		Bias type:#float ui:TwistBias default:0
		ConnectEnd type:#boolean ui:connectEnd default:true
		Align type:#boolean ui:Align default:true
		Smoothing type:#integer ui:SmoothingType default:1
	)
	rollout params "Parameters" width:160 height:208
	(
		spinner radius "Radius: " pos:[32,8] width:120 height:16 range:[0,100000,10] type:#worldunits
		spinner Segments1 "Segments: " pos:[16,32] width:136 height:16 range:[3,100000,360] type:#integer
		spinner sides "Sides: " pos:[40,56] width:112 height:16 range:[3,100000,10] type:#integer
		spinner size "Size: " pos:[40,80] width:112 height:16 range:[0,100000,1] type:#float
		edittext xFunction "" pos:[8,104] width:128 height:17
		edittext yFunction "" pos:[8,128] width:128 height:17
		edittext zFunction "" pos:[8,152] width:128 height:17
		colorPicker xTest "" pos:[136,104] width:16 height:16
		colorPicker yTest "" pos:[136,128] width:16 height:16
		colorPicker zTest "" pos:[136,152] width:16 height:16
		checkbox autoUpdate "Update" pos:[8,180] width:64 height:18 default:true
		checkButton editor "Large editor" pos:[72,176] width:80 height:24
		button createSpline "Create Spline" height:24
		
		on createSpline pressed do
		(
			global I=1
			global M=$.M
			global N=$.N
			global P=$.P
			global Q=$.Q
			global H=$.H
			global T=$.T
			global Segments=$.Segments
			
			xFail=false
			yFail=false
			zFail=false
			
			try (execute xFunction.text) catch (xFail=true)
			try (execute yFunction.text) catch (yFail=true)
			try (execute zFunction.text) catch (zFail=true)
			
			if xFail !=true do
				if (classof (execute xFunction.text)) !=float do
					xFail=true
			
			if yFail !=true do
				if (classof (execute yFunction.text)) !=float do
					yFail=true
			
			if zFail !=true do
				if (classof (execute zFunction.text)) !=float do
					zFail=true
			
			if xFail == false and yFail == false and zFail == false then
			(
				spline1=splineshape()
				spline1.name=uniquename "SpiroTube Spline"
				addnewspline spline1
				for k=1 to segments do
				(
					curPos=[0,0,0]
					pos1=(execute xFunction.text)
					pos2=(execute yFunction.text)
					pos3=(execute zFunction.text)
					addKnot spline1 1 #smooth #curve [pos1,pos2,pos3]
					I+=1
				)
				updateShape spline1
				select spline1
			)
			else
			(
				messagebox "Error with one or more of the functions." title:"SpiroTube"
			)
		)
		on editor changed state do
		(
			if state==true then
			(
				createdialog posEditor lockHeight:true style:#(#style_titlebar, #style_resizing, #style_sysmenu, #style_minimizebox, #style_maximizebox) 
			)
			else
			(
				destroydialog posEditor
			)
		)
		on params open do
		(
			global I=1 ; global M=1.0 ; global N=1.0; global P=1.0; global Q=1.0; global H=1.0; global T=1.0; global Segments=1
			xTest.color=(color 0 255 0)
			yTest.color=(color 0 255 0)
			zTest.color=(color 0 255 0)
			xFail=false
			yFail=false
			zFail=false
			try (execute xFunction.text) catch (xFail=true)
			try (execute yFunction.text) catch (yFail=true)
			try (execute zFunction.text) catch (zFail=true)
			
			if xFail==false do
				if (classof (execute xFunction.text)) != float do
					(xFail=true; xTest.color=(color 255 0 0))
			
			if yFail==false do
				if (classof (execute yFunction.text)) != float do
					(yFail=true; yTest.color=(color 255 0 0))
			
			if zFail==false do
				if (classof (execute zFunction.text)) != float do
					(zFail=true; zTest.color=(color 255 0 0))
		)
	)
	rollout values "Settings & Presets" width:160 height:216
	(
		spinner m "M: " pos:[32,8] width:120 height:16 range:[-100000,100000,0] type:#float
		spinner n "N: " pos:[33,32] width:119 height:16 range:[-100000,100000,0] type:#float
		spinner p "P: " pos:[35,56] width:117 height:16 range:[-100000,100000,0] type:#float
		spinner q "Q: " pos:[32,80] width:120 height:16 range:[-100000,100000,0] type:#float
		spinner h "H: " pos:[33,104] width:119 height:16 range:[-100000,100000,0] type:#float
		spinner t "T: " pos:[35,128] width:117 height:16 range:[-100000,100000,0] type:#float
		dropdownList presets "" pos:[8,152] width:144 height:21
		button presetEditor "Editor" pos:[8,184] width:64 height:24
		button reload "Reload" pos:[88,184] width:64 height:24
		on values open do
		(
			--Loading presets
			presetList=getPresets()
			if presetList !=false do
			(
				newArr=#( )
				for i=1 to presetList.count do
				(
					newArr[i]=presetList[i][1]
				)
				presets.items=newArr
			)
		)
		on presets selected sel do
		(
			setPreset sel $
		)
		on presetEditor pressed do
		(
			try (destroydialog SpiroTubePreset) catch()
			createdialog SpiroTubePreset
		)
		on reload pressed do
		(
			presetList=getPresets()
			if presetList !=false do
			(
				newArr=#( )
				for i=1 to presetList.count do
				(
					newArr[i]=presetList[i][1]
				)
				presets.items=newArr
			)
		)
	)
	rollout MeshSettings "Mesh settings"
	(
		GroupBox RadiusGroup "Radius deformation" pos:[8,0] width:144 height:184
		spinner amount1 "Amount: " pos:[38,16] width:106 height:16 range:[-100000,100000,0] type:#worldunits
		checkbox UseRegular "Regular" pos:[16,40] width:56 height:16
		spinner RegularFrequency "Frequency: " pos:[24,64] width:120 height:16 range:[0,100000,3] type:#float
		spinner RegularOffset "Offset: " pos:[43,88] width:101 height:16 range:[-100,100,0] type:#float
		checkbox UseDistance "Distance" pos:[16,112] width:64 height:16
		checkbox UseCustom "Custom" pos:[16,136] width:56 height:15
		edittext custom "" pos:[16,160] width:112 height:15
		colorPicker CustomTest "" pos:[128,160] width:16 height:16 enabled:false
		GroupBox RotationBox "Rotation" pos:[8,184] width:144 height:88
		spinner rotationAmount "Amount: " pos:[28,200] width:116 height:16 range:[-360,360,0]
		spinner twistAmount "Twist: " pos:[41,224] width:103 height:16 range:[-3600,3600,0]
		spinner twistBias "Bias: " pos:[47,248] width:97 height:16 range:[-100,100,0]
		checkbox ConnectEnd "Connect end" pos:[8,280] width:85 height:15
		checkbox align "Align" pos:[8,304] width:47 height:15
		RadioButtons SmoothingType "Smoothing" pos:[8,328] labels:#("All", "Sides", "Segments", "None") columns:2
		
		on MeshSettings open do
		(
			global I=1
			global amount=1.0
			CustomFail=false
			try (execute Custom.text) catch (CustomFail=true)
			if CustomFail==false then
				if classof (execute custom.text) !=float then
					(CustomFail=true; MeshSettings.CustomTest.color=(color 255 0 0))
				else MeshSettings.CustomTest.color=(color 0 255 0)
			else
				MeshSettings.CustomTest.color=(color 255 0 0)
			if UseRegular.state==false do
			(
				RegularFrequency.enabled=false
				RegularOffset.enabled=false
			)
			if UseCustom.state==false do
			(
				Custom.enabled=false
			)
			if ConnectEnd.state==false then
			(
				Align.enabled=true
			)
			else
			(
				Align.enabled=false
				Align.state=true
			)
		)
		on connectEnd changed state do
		(
			if state==false then
			(
				Align.enabled=true
			)
			else
			(
				Align.enabled=false
				Align.state=true
			)
		)
		on UseRegular changed state do
		(
			if state==false then
			(
				RegularFrequency.enabled=false
				RegularOffset.enabled=false
			)
			else
			(
				RegularFrequency.enabled=true
				RegularOffset.enabled=true
				UseDistance.state=false
				UseCustom.state=false
				Custom.enabled=false
			)
		)
		on UseDistance changed state do
		(
			if state==true do
			(
				UseRegular.state=false
				UseCustom.state=false
				RegularFrequency.enabled=false
				RegularOffset.enabled=false
				Custom.enabled=false
			)
		)
		on UseCustom changed state do
		(
			if state==false then
			(
				Custom.enabled=false
			)
			else
			(
				Custom.enabled=true
				UseRegular.state=false
				UseDistance.state=false
				RegularFrequency.enabled=false
				RegularOffset.enabled=false
			)
		)
	)
	on buildmesh do
	(
		global I=1
		global M=M
		global N=N
		global P=P
		global Q=Q
		global H=H
		global T=T
		global Segments=Segments
		
		Params.xTest.color=(color 0 255 0)
		Params.yTest.color=(color 0 255 0)
		Params.zTest.color=(color 0 255 0)
		
		xFail=false
		yFail=false
		zFail=false
		
		tX=xFunction
		tY=yFunction
		tZ=zFunction
		
		try (execute xFunction) catch (xFail=true)
		try (execute yFunction) catch (yFail=true)
		try (execute zFunction) catch (zFail=true)
		
		if xFail==false then
		(
			if (classof (execute xFunction)) != float do
			(
				Params.xTest.color=(color 255 0 0)
				tX="m*cos(360.0*i/segments)"
			)
		)
		else
		(
			Params.xTest.color=(color 255 0 0)
			tX="m*cos(360.0*i/segments)"
		)
		
		if yFail==false then
		(
			if (classof (execute yFunction)) != float do
			(
				Params.yTest.color=(color 255 0 0)
				tY="m*sin(360.0*i/segments)"
			)
		)
		else
		(
			Params.yTest.color=(color 255 0 0)
			tY="m*sin(360.0*i/segments)"
		)
		
		if zFail==false then
		(
			if (classof (execute zFunction)) != float do
			(
				Params.zTest.color=(color 255 0 0)
				tZ="0.0"
			)
		)
		else
		(
			Params.zTest.color=(color 255 0 0)
			tZ="0.0"
		)
		
		if autoUpdate==true do
		(
			Positions=#( )
			Vectors=#( )
			
			--Getting positions
			for j=1 to Segments do
			(
				I=j
				tempX=execute tX
				tempY=execute tY
				tempZ=execute tZ
				tempPos=[tempX,tempY,tempZ]*Size
				Positions[j]=tempPos
			)
			
			--Getting vectors
			--Start & End vector
			if Align==true then
			(
				Vectors[1]=normalize((Positions[1]-Positions[Positions.count])+(Positions[2]-Positions[1]))
				
				Vectors[Positions.count]=normalize((Positions[Positions.count]-Positions[Positions.count-1])+(Positions[1]-Positions[Positions.count]))
			)
			else
			(
				Vectors[1]=normalize(Positions[2]-Positions[1])
				
				Vectors[Positions.count]=normalize(Positions[Positions.count]-Positions[Positions.count-1])
			)
			--All other vectors
			for j=2 to segments-1 do
				Vectors[j]=normalize((Positions[j]-Positions[j-1])+(Positions[j+1]-Positions[j]))
			
			Vertices=#( )
			Faces=#( )
			Value1=1
			
			--Creating vertices for mesh
			RadiusType=0
			if UseRegular==true do RadiusType=1
			if UseDistance==true do RadiusType=2
			if UseCustom==true do RadiusType=3
			
			case RadiusType of
			(
				0:
				(
					for k=1 to segments do
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*k)*(((k as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-k+1.0))*((((segments-k+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[k]
						curVec=Vectors[k]
						curVector=cross [0,0,1] curVec
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*radius)
						)
					)
				)
				1:
				(
					for k=1 to segments do
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*k)*(((k as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-k+1.0))*((((segments-k+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[k]
						curVec=Vectors[k]
						curVector=cross [0,0,1] curVec
						curScale=Amount*cos(((RegularFrequency*360)*k/segments)+(RegularOffset*3.6))
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*(radius+CurScale))
						)
					)
				)
				2:
				(
					DistanceValue=0
					--Getting average distance
					for j=2 to segments-1 do
						DistanceValue+=((distance Positions[j] Positions[j+1])+(distance Positions[j] Positions[j-1]))/2
					DivideValue=segments-1
					if connectEnd==true do
					(
						DistanceValue+=((distance Positions[1] Positions[Positions.count])+(distance Positions[1] Positions[2]))/2
						DistanceValue+=((distance Positions[Positions.count] Positions[Positions.count-1])+(distance Positions[Positions.count] Positions[1]))/2
						DivideValue=segments
					)
					DistanceValue=DistanceValue/divideValue
					
					--Start vertices
					TV=1
					if connectEnd==true then
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*TV)*(((TV as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-TV+1.0))*((((segments-TV+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[1]
						curVec=Vectors[1]
						curVector=cross [0,0,1] curVec
						curScale=((distance curPos Positions[2])+(distance curPos Positions[Positions.count]))/2
						--curScale=curScale-(DistanceValue/2)
						curScale=curScale/distanceValue
						curScale=curScale*amount
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*(radius+CurScale))
						)
						TV+=1
					)
					else
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*TV)*(((TV as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-TV+1.0))*((((segments-TV+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[1]
						curVec=Vectors[1]
						curVector=cross [0,0,1] curVec
						curScale=(distance curPos Positions[2])
						curScale=curScale/distanceValue
						curScale=curScale*amount
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*(radius+CurScale))
						)
						TV+=1
					)
					--Middle vertices
					for k=2 to segments-1 do
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*TV)*(((TV as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-TV+1.0))*((((segments-TV+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[k]
						curVec=Vectors[k]
						curVector=cross [0,0,1] curVec
						curScale=((distance curPos Positions[k+1])+(distance curPos Positions[k-1]))/2
						curScale=curScale/distanceValue
						curScale=curScale*amount
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*(radius+CurScale))
						)
						TV+=1
					)
					--End vertices
					if connectEnd==true then
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*TV)*(((TV as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-TV+1.0))*((((segments-TV+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[Positions.count]
						curVec=Vectors[Positions.count]
						curVector=cross [0,0,1] curVec
						curScale=((distance curPos Positions[1])+(distance curPos Positions[Positions.count-1]))/2
						curScale=curScale/distanceValue
						curScale=curScale*amount
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*(radius+CurScale))
						)
					)
					else
					(
						if Bias >=0 then
							tempRotation=rotateAmount+(((twist*360.0)/segments as float)*TV)*(((TV as float)/(segments as float))^Bias)
						else
							tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-TV+1.0))*((((segments-TV+1.0) as float)/(segments as float))^(Bias*-1))
						
						curPos=Positions[Positions.count]
						curVec=Vectors[Positions.count]
						curVector=cross [0,0,1] curVec
						curScale=(distance curPos Positions[Positions.count-1])
						curScale=curScale/distanceValue
						curScale=curScale*amount
						for j=1 to sides do
						(
							tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
							
							Vertices[Vertices.count+1]=curPos+(tempVec*(radius+CurScale))
						)
					)
				)
				3:
				(
					cColor=MeshSettings.CustomTest.color
					--Making sure the custom function is usable
					CustomFail=false
					try (execute Custom) catch (CustomFail=true)
					if CustomFail==false then
						if classof (execute custom) !=float then
							(CustomFail=true; cColor=(color 255 0 0))
						else cColor=(color 0 255 0)
					else
						cColor=(color 255 0 0)
					if CustomFail==false then
					(
						global I=1
						global Amount=amount
						for k=1 to segments do
						(
							if Bias >=0 then
								tempRotation=rotateAmount+(((twist*360.0)/segments as float)*k)*(((k as float)/(segments as float))^Bias)
							else
								tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-k+1.0))*((((segments-k+1.0) as float)/(segments as float))^(Bias*-1))
							
							I=k
							curPos=Positions[k]
							curVec=Vectors[k]
							curVector=cross [0,0,1] curVec
							curScale=execute Custom
							for j=1 to sides do
							(
								tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
								
								Vertices[Vertices.count+1]=curPos+(tempVec*(radius+curScale))
							)
						)
					)
					else
					(
						for k=1 to segments do
						(
							if Bias >=0 then
								tempRotation=rotateAmount+(((twist*360.0)/segments as float)*k)*(((k as float)/(segments as float))^Bias)
							else
								tempRotation=rotateAmount+(((twist*360.0)/segments)*(segments-k+1.0))*((((segments-k+1.0) as float)/(segments as float))^(Bias*-1))
							
							curPos=Positions[k]
							curVec=Vectors[k]
							curVector=cross [0,0,1] curVec
							for j=1 to sides do
							(
								tempVec=normalize(rotateVector curVector curVec (((360.0/sides)*j)+tempRotation))
								
								Vertices[Vertices.count+1]=curPos+(tempVec*radius)
							)
						)
					)
				)
			)
			
			--Creating faces for mesh
			for k=1 to segments-1 do
			(
				for j=1 to sides-1 do
				(
					Faces[Faces.count+1]=[Value1,Value1+1,Value1+sides]+j-1
					Faces[Faces.count+1]=[Value1+1,Value1+sides+1,Value1+sides]+j-1
				)
				Faces[Faces.count+1]=[Value1,Value1+sides+sides-1,Value1+sides-1]
				Faces[Faces.count+1]=[Value1,Value1+sides,Value1+sides+sides-1]
				Value1+=sides
			)
			--End faces
			if connectEnd==true do
			(
				for j=1 to sides-1 do
				(
					Faces[Faces.count+1]=[Value1,Value1+1,1]+j-1
					Faces[Faces.count+1]=[Value1+1,2,1]+j-1
				)
				Faces[Faces.count+1]=[Value1+sides-1,Value1,sides]
				Faces[Faces.count+1]=[1,sides,value1]
			)
			setmesh mesh vertices:Vertices faces:Faces
			
			faceNum=1
			for k=1 to segments-1 do
			(
				for j=1 to sides-1 do
				(
					setEdgeVis mesh faceNum 2 false
					setEdgeVis mesh (faceNum+1) 3 false
					faceNum+=2
				)
				setEdgeVis mesh faceNum 1 false
				setEdgeVis mesh (faceNum+1) 3 false
				faceNum+=2
			)
			if connectEnd==true do
			(
				for j=1 to sides-1 do
				(
					setEdgeVis mesh faceNum 2 false
					setEdgeVis mesh (faceNum+1) 3 false
					faceNum+=2
				)
				setEdgeVis mesh faceNum 2 false
				setEdgeVis mesh (faceNum+1) 2 false
			)
			case smoothing of
			(
				1:
				(
					FaceNum=1
					for j=1 to ((segments-1)*sides)*2 do
					(
						setFaceSmoothGroup mesh faceNum 1
						FaceNum+=1
					)
					if connectEnd==true do
					(
						for j=1 to sides*2 do
						(
							setFaceSmoothGroup mesh faceNum 1
							FaceNum+=1
						)
					)
				)
				2:
				(
					FaceNum=1
					for k=1 to segments-1 do
					(
						curGroup=1
						for j=1 to sides-1 do
						(
							setFaceSmoothGroup mesh faceNum curGroup
							setFaceSmoothGroup mesh (faceNum+1) curGroup
							faceNum+=2
							curGroup+=1
							if curGroup==3 do curGroup=1
						)
						setFaceSmoothGroup mesh faceNum 4
						setFaceSmoothGroup mesh (faceNum+1) 4
						faceNum+=2
					)
					if ConnectEnd==true do
					(
						curGroup=1
						for j=1 to sides-1 do
						(
							setFaceSmoothGroup mesh faceNum curGroup
							setFaceSmoothGroup mesh (faceNum+1) curGroup
							faceNum+=2
							curGroup+=1
							if curGroup==3 do curGroup=1
						)
						setFaceSmoothGroup mesh faceNum 4
						setFaceSmoothGroup mesh (faceNum+1) 4
					)
				)
				3:
				(
					curGroup=1
					FaceNum=1
					for k=1 to segments-1 do
					(
						for j=1 to sides do
						(
							setFaceSmoothGroup mesh faceNum curGroup
							setFaceSmoothGroup mesh (faceNum+1) curGroup
							faceNum+=2
						)
						curGroup+=1
						if curGroup==3 do curGroup=1
					)
					if ConnectEnd==true do
					(
						for j=1 to sides do
						(
							setFaceSmoothGroup mesh faceNum 4
							setFaceSmoothGroup mesh (faceNum+1) 4
							faceNum+=2
						)
					)
				)
				4:
				(
					FaceNum=1
					for j=1 to ((segments-1)*sides)*2 do
					(
						setFaceSmoothGroup mesh faceNum 0
						FaceNum+=1
					)
					if connectEnd==true do
					(
						for j=1 to sides*2 do
						(
							setFaceSmoothGroup mesh faceNum 0
							FaceNum+=1
						)
					)
				)
			)
		)
	)
	tool create
	(
		on mousePoint click do
		(
			case click of
			(
				1: nodeTM.translation = gridPoint
				2: #stop
			)
		)
		on mouseMove click do
		(
			case click of
			(
				2: ( m = sqrt (gridDist.x^2 + gridDist.y^2) ; radius=m/10)
			)
		)
	)
)