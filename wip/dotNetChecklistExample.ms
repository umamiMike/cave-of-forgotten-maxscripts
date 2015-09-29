try destroyDialog listview_rollout catch()
rollout listview_rollout " Task List" width:400 height:300
(
	editText etTaskName "" width:150 offset:[-5,5] across:3
	button btnAdd "Add" offset:[5,3]
	button btnRemove "Remove" offset:[-5,3]
	dotNetControl dncTaskList "System.Windows.Forms.ListView" pos:[3,45] width:380 height:250
 
	local dn_listitem = dotNetClass "System.Windows.Forms.ListViewItem"
 
	on listview_rollout open do
	(
	    dncTaskList.View = (dotNetClass "System.Windows.Forms.View").Details
	    	dncTaskList.BorderStyle = dncTaskList.BorderStyle.FixedSingle
		    dncTaskList.FullRowSelect = true
		    dncTaskList.GridLines = true
			dncTaskList.CheckBoxes = true
			colums_arr = #(#(" ", 50), #("Task", 176))
			for i in colums_arr do (dncTaskList.Columns.Add i[1] i[2])
	)
 
	on btnAdd pressed do
	(
		if etTaskName.text != "" do
		(
			local new_item = dotNetObject dn_listitem ""
			new_item.SubItems.Add etTaskName.text
			new_item.Checked = false
			dncTaskList.Items.Add new_item
			new_item = undefined
		)
	)
 
	on btnRemove pressed do
	(
		selected_count = dncTaskList.SelectedItems.Count - 1
		for index = selected_count to 0 by -1 do
			dncTaskList.Items.Remove dncTaskList.SelectedItems.Item[index]
	)
)
createDialog listview_rollout