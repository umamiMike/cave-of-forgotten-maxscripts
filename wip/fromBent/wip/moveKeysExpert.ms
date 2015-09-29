try (destroydialog moveKeysRoll) catch()

--vars exposing for testing
fromKeysString
fromKeysObj
toTimeString
theMove





rollout moveKeysRoll "Move The Keys" width:352 height:72
(
	editText edt1 "From" pos:[16,8] width:211 height:16
	editText edt2 "To" pos:[16,40] width:211 height:16
	button moveKeysButton "Move The Keys" pos:[256,16] width:80 height:32
	
	
	on moveKeysButton pressed  do
(
	
	fromKeysString = edt1.text
	fromKeysObj = execute(fromKeysString)
	toTimeString = edt2.text
	theMove = "moveKeys "+ fromKeysString +" " + toTimeString --not right
	try (execute theMove) catch(messagebox ("it didna work capn" + ))
	
	)
)

createDialog moveKeysRoll
