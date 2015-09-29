rci = rolloutCreator "myRollout" "My Rollout" width:300 height: 300

rci.begin()

for i = 1 to 10 do(
	theButtonInfo = "#myButton" + i as string
	paramInfo = "pos: ["+i as string + "*3,10] width:90 height:20"
	--messageBox theButtonInfo
rci.addControl #button (execute theButtonInfo) "My Button" paramStr: paramInfo
)

--rci.addHandler #myButton #pressed filter:on codeStr:"MessageBox @Isn't this cool@ title:@Wow@"

createDialog (rci.end())

