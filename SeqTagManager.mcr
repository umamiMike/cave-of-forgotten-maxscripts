macroScript SeqTagManager
	category:"Umami"
	toolTip:"SeqTag Manager"

(
local seq_span_arr = #()
local seq_name_arr = #()
local all_keys = #()
local id_arr = #()
rollout seq_roll "Sequence\Tag Manager" width:435 height:485
(
	groupBox grp1 "Sequences:" pos:[5,5] width:210 height:355
	listBox seq_list "" pos:[10,20] width:200 height:13
	editText sq_name "Sequence Name:" pos:[10,210] width:200 height:20 labelontop:true
	spinner sp_start "Start:" pos:[25,260] width:80 height:16 range:[-50000,50000,0] type:#integer scale:1
	spinner sp_range "Span:" pos:[125,260] width:85 height:16 range:[-50000,50000,0] type:#integer scale:1
	spinner sp_end "End: " pos:[25,285] width:80 height:16 range:[-50000,50000,0] type:#integer scale:1
	button add_but "Add Sequence" pos:[30,310] width:160 height:20
	button rem_but "Remove Sequence" pos:[30,335] width:160 height:20
	button edit_but "Replace" pos:[115,285] width:95 height:15 enabled:false
	checkbox zero_check "Start from frame 0" pos:[50,400] checked:true
	button all_but "Show All Frames" pos:[30,370] width:160 height:25
	label lbl1 "*double click to set" pos:[110,200] width:95 height:20
	groupbox grp2 "" pos:[5,360] width:210 height:60
	groupbox grp3 "" pos:[5,420] width:210 height:60
	button savebut "Save Sequences" pos:[30,430] width:160 height:20
	button loadbut "Load Sequences" pos:[30,455] width:160 height:20
	
	-------------------About-------------------
	label lbl_ver "v1.0 13/02/2007" pos:[285,460] width:100 height:15
	button about_but "i" pos:[410,460] width:15 height:15 tooltip:"Credits"
	groupBox grp_about "" pos:[220,450] width:210 height:30
	
	-------------------Tag Manager-------------------
	groupbox grp5 "Tags:" pos:[220,5]across:2 width:210 height:355
	multilistbox mlx "" pos:[225,20] width:200 height:12
	label lbl2 "Selected: 0 Tags" align:#right pos:[225,190]
	label lbl3 "*double click to set" pos:[335,190] width:93 height:20
	editText tg_name "New Tag Name:" pos:[225,210] width:200 height:20 labelontop:true
	spinner tag_time "Tag Time:" pos:[225,260] type:#integer range:[-25000,25000,0] width:70 align:#left
	button get_time "][" pos:[332,260] width:16 height:16 tooltip:"Get current time"
	button add_tag "Add New Tag" width:160 height:30 pos:[240,290]
	button name_tag "Replace" width:70 height:15 pos:[355,260]
	button del_tag "Delete Tag" width:160 height:30 pos:[240,325]
	button buto "Send to render" width:160 height:30 pos:[240,375] tooltip:"Queue selected tag frames"
	groupbox grp6 "" pos:[220,360] width:210 height:60
	groupbox grp7 "" pos:[220,420] width:210 height:35
	button del_all "Remove All Tags" pos:[240,430] width:160 height:20
	


on about_but pressed do messagebox "Seq\Tag Manager v1.0 \n \n Nikolay Tashev \n niki.tashev@treality.com \n 13.02.2007"
	
on sp_start changed value do
	(
	sp_end.value = (sp_start.value + sp_range.value)
	)
on sp_end changed value do
	(
	sp_range.value = (sp_end.value - sp_start.value)
	)
on sp_range changed value do
	(
	sp_end.value = (sp_start.value + sp_range.value)
	)

on add_but pressed do
	(
	edit_but.enabled = false
	if sq_name.text == "" then messagebox "Enter sequence name"
		else
		(
		tmp_span = [sp_start.value, sp_end.value]
		append all_keys tmp_span[1]
		append all_keys tmp_span[2]
		tmp_txt = (sq_name.text + ": " + (tmp_span[1] as integer) as string + " - " + (tmp_span[2] as integer) as string + " [" + (sp_range.value as integer) as string + "]")
		append seq_span_arr tmp_span
		append seq_name_arr sq_name.text
		seq_list.items = append seq_list.items tmp_txt
		fileProperties.addProperty #custom ("Seq_" + sq_name.text) (tmp_span as string)
		sp_start.value = sp_end.value + 1
		all_but.enabled = true
		)
	)
	
on rem_but pressed do
	(
	if seq_span_arr.count != 0 then
		(
		ind = seq_list.selection
		k1 = findItem all_keys seq_span_arr[ind][1]
		deleteItem all_keys k1
		k2 = findItem all_keys seq_span_arr[ind][2]
		deleteItem all_keys k2
		fileProperties.deleteProperty #custom ("Seq_" + seq_name_arr[ind])
		deleteItem seq_span_arr ind
		deleteItem seq_name_arr ind
		seq_list.items = deleteItem seq_list.items ind
		print all_keys
		if all_keys.count == 0 do (all_but.enabled = false; savebut.enabled = false)
		)
	)

on seq_list doubleclicked itm do
	(
	animationRange = interval seq_span_arr[itm][1] seq_span_arr[itm][2]
	/*sq_name.text = seq_name_arr[itm] as string
	sp_start.value = seq_span_arr[itm][1]
	sp_end.value = seq_span_arr[itm][2]
	sp_range.value = (sp_end.value - sp_start.value)*/
	)

on seq_list selected itm do
	(
	sq_name.text = seq_name_arr[itm] as string
	sp_start.value = seq_span_arr[itm][1]
	sp_end.value = seq_span_arr[itm][2]
	sp_range.value = (sp_end.value - sp_start.value)
	edit_but.enabled = true
)


on edit_but pressed do
	(
	ind = seq_list.selection
	k1 = findItem all_keys seq_span_arr[ind][1]
	k2 = findItem all_keys seq_span_arr[ind][2]
	tmp_span = [sp_start.value, sp_end.value]
	all_keys[k1] = tmp_span[1]
	all_keys[k2] = tmp_span[2]
	fileProperties.deleteProperty #custom ("Seq_" + seq_name_arr[ind])	--summary edit: Delete	
	tmp_txt = (sq_name.text + ": " + (tmp_span[1] as integer) as string + " - " + (tmp_span[2] as integer) as string)
	seq_span_arr[ind] = tmp_span
	seq_name_arr[ind] = sq_name.text
	seq_list.items[ind] = tmp_txt
	seq_list.items = seq_list.items
	fileProperties.addProperty #custom ("Seq_" + sq_name.text) (tmp_span as string) --summary edit: Add New
	)

on seq_roll open do
	(
	------------
	ft = FrameTagManager
	num = ft.gettagcount()
	for i = 1 to num do
		(
		Tname = ft.getNameById i as string
		Tid = ft.GetTagId i
		Ttime = ft.geTTimeById i as string
		mlx.items = append mlx.items (Tname + "-> Frame:" + (replace Ttime Ttime.count 1 ""))
		append id_arr tid
		)
	name_tag.enabled = false
	buto.enabled = false
	------------
	all_but.enabled = false
	savebut.enabled = false
	ind = fileProperties.getNumProperties #custom
	if ind > 0 do
		(
		savebut.enabled = true
		all_but.enabled = true
		for i = 1 to ind do
			(
			try (
			s = fileProperties.getPropertyName #custom i
			if matchpattern s pattern:"Seq_*" == false do continue
			sum_txt = replace s 1 4 "" 
			sum_val = execute (fileProperties.getPropertyValue #custom i)
			--tmp_span = [sum_val[1], sum_val[2]]
			tmp_txt = (sum_txt + ": " + (sum_val[1] as integer) as string + " - " + (sum_val[2] as integer) as string + " [" + ((sum_val[2] - sum_val[1]) as integer) as string + "]")
			append seq_span_arr sum_val
			append seq_name_arr sum_txt
			seq_list.items = append seq_list.items tmp_txt
			append all_keys sum_val[1]
			append all_keys sum_val[2]
			) catch()
			)
		) 

	)
	
on all_but pressed do
	(
	if zero_check.state == true then	
		(
		animationRange = interval 0 (amax all_keys)
		)
	else 
		(
		animationRange = interval (amin all_keys) (amax all_keys)	
		)
	)
	
on savebut pressed do
	(
	try 
		(
		f = maxfilename
		f2 = replace f (f.count-3) 4 ""
		)
		catch ( f2 = "")
	outname = getSaveFileName "Save frame sequences" \
				types:"Sequence Manager Data (*.seq)|*.seq|" filename:(f2 + ".seq")
	if outname != undefined and seq_name_arr.count != 0 do
		(
		outfile = createfile outname
		format "----Sequence Manager %----\n\n" lbl_ver.text to:outfile
		format "[Total Sequences] \n % \n--------------\n \n" seq_name_arr.count to:outfile
		format "[Sequences:] \n \n"  to:outfile
		for i = 1 to seq_name_arr.count do
			(
			format "% \n % \n--------------\n" seq_name_arr[i] seq_span_arr[i] to:outfile
			)
		format "\nCreated from file: %%\n" maxfilepath maxfilename to:outfile
		format "--SeqMan written by Nikolay Tashev jazko@mail.bg" to:outfile
		close outfile
		)
	)
on loadbut pressed do
	(
	inname = getOpenFileName "Load frame sequences" \
			types:"Sequence Manager Data (*.seq)|*.seq|"
	if inname != undefined do
		(
		ind = fileProperties.getNumProperties #custom
		if ind > 0 do
			(
			for i = 1 to ind do
				(
				try (fileProperties.deleteProperty #custom ("Seq_" + seq_name_arr[i])) catch()
				)
			)
		seq_span_arr = #()
		seq_name_arr = #()
		all_keys = #()
		seq_list.items = #()
		infile = openfile inname
		skipToString infile "[Total Sequences]"
		skipToNextLine infile
		lim = readValue infile
		skipToString infile "[Sequences:]"
		skiptonextline infile
		skiptonextline infile
		print lim
		for i = 1 to lim do
			(
			seq_name = readLine infile
			seq_span = execute (readLine infile)
			--print (seq_name + ": " + seq_span as string)
			skiptonextline infile
			append all_keys seq_span[1]
			append all_keys seq_span[2]
			tmp_txt = (seq_name + ": " + (seq_span[1] as integer) as string + " - " + (seq_span[2] as integer) as string + " [" + ((seq_span[2] - seq_span[1]) as integer) as string + "]")
			append seq_span_arr seq_span
			append seq_name_arr seq_name
			seq_list.items = append seq_list.items tmp_txt
			fileProperties.addProperty #custom ("Seq_" + seq_name) (seq_span as string)
			)
		if seq_name_arr.count != 0 do savebut.enabled = true
		close infile
		)
	)
	
	--------------Tag Controls-------------
on mlx doubleclicked itm do
	(
	ft = FrameTagManager
	sliderTime = ft.getTimeById itm
	)
	
on mlx selected itm do
	(
	bit2arr = mlx.selection as array
	lbl2.text = "Selected: " + bit2arr.count as string + " Tags"
	buto.enabled = true
	)
	
on mlx selectionEnd do 
	(
	bit2arr = mlx.selection as array
	if bit2arr.count == 1 then
		(
		tg_name.text = FrameTagManager.GetNameByID bit2arr[1] as string
		Tframe = FrameTagManager.GetTimeByID bit2arr[1] as string
		tag_time.value = execute (replace TFrame Tframe.count 1 "")
		name_tag.enabled = true
		)
	else name_tag.enabled = false
	)	
	
on add_tag pressed do
	(
	if tg_name.text == "" then messagebox "Enter tag name" else (
		FrameTagManager.CreateNewTag tg_name.text tag_time.value
		mlx.items = append mlx.items (tg_name.text + "-> Frame:" + tag_time.value as string)
		)
	)
	
on del_tag pressed do
	(
	bit2arr = mlx.selection as array
	print bit2arr
	if bit2arr.count == 1 do
		(
		FrameTagManager.deleteTag bit2arr[1]
		mlx.items = deleteItem mlx.items bit2arr[1]
		)
	)
on del_all pressed do 
	(
	FrameTagManager.ResetFrametags()
	mlx.items = #()
	)

on get_time pressed do
	(
	tag_time.value = sliderTime
	)

on name_tag pressed do
	(
	ft = FrameTagManager
	bit2arr = mlx.selection as array
	if bit2arr.count == 1 do
		(
		ft.SetNameByID bit2arr[1] tg_name.text
		ft.SetTimeByID bit2arr[1] tag_time.value
		mlx.items[bit2arr[1]] = (tg_name.text + "-> Frame:" + tag_time.value as string)
		mlx.items = mlx.items
		)
	)

on buto pressed do
	(
	bit2arr = mlx.selection as array
	if bit2arr.count != 0 do
		(
		if renderSceneDialog.isOpen() do renderSceneDialog.close()
		ss = ""
			for v in mlx.selection do
				(
				Tframe = FrameTagManager.GetTimeByID v
				s2 = Tframe as string
				s3 = replace s2 (s2.count) 1 ""
				ss+= s3 + ", "
				)	
			rendPickupFrames = (replace ss (ss.count-1) 2 "")
			rendTimeType = 4
			renderSceneDialog.open()
		)
	)


)


createdialog seq_roll
)
