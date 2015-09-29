if myRoll != undefined then destroydialog myRoll

rollout myRoll "rolloutname" width:200 height:150
(
button btn1 "NameMe" pos: [8,8] width:(myRoll.width/3) height:24
button btn2 "Do It" pos:[8,36] width:(myRoll.width/3) height:24
edittext edt1 "caption for field" pos:[8,72] fieldwidth: 90 width:190 height:16
on btn1 pressed do ()
on btn2 pressed do ()
on edt1 changed do()
)

createDialog myRoll