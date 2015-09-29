
global WireWorkRoll
global WireWorkFloater
Global MasterObj
Global SlaveObj

global myExpression




rollout WireWorkRoll "WireWork" width:300 height:128
(
	pickbutton btn1 "Pick The Master Object" pos:[8,8] width:184 height:24
	pickbutton btn2 "Pick the Slave Object" pos:[10,39] width:182 height:22
	edittext edt1 "Expression" text:" " pos:[8,72] width:184 height:17
	button btn3 "Button" pos:[8,96] width:184 height:24



	on btn1 picked obj do
	(
	MasterObj = btn1.object
	btn1.caption = MasterObj.name
	
	)
	on btn2 picked obj do
	(

	SlaveObj = btn2.object
	btn2.caption = SlaveObj.name
	myExpression = "Y_Rotation*$'" + SlaveObj.name as string +"'.modifiers[\"attribute Holder\"].testAttrib.animationTrack/10"
	
	)
	
	
	on edt1 entered text do
	(myExpression = edt1.text
	)
	on btn3 pressed do
	(  --Make some objects and add a blank modifier to the box 

  eM=emptyModifier()
  addModifier SlaveObj eM 
   
  --Create the defintion for the custom attribute 
  def=attributes testAttrib 
  ( 
     --Parameter block to store the tracks of animation 
     parameters testP rollout:testR 
     ( 
  	  --A track of animation 
  	  --Look under scripted plugins for the types that can be used. 
  	  animationTrack type:#float UI:mySpinner 
     ) 
     --The rollout that will show up in the modifier panel.  
     rollout testR "test" 
     ( 
  	  --The spinner that is connected to the animationTrack 
  	  spinner mySpinner "Attrribute Holder" 
     ) 
  ) 
   
  --Add the definition to the emptyModifier 
  custAttributes.add eM def 
		
	paramWire.connect MasterObj.rotation.controller[#Y_Rotation] SlaveObj.rotation.controller[#Y_Rotation] myExpression
		
		
		)
)


if WireWorkFloater != undefined then closeRolloutFloater WireWorkFloater

WireWorkFloater = newRolloutFloater "Wire Work" 300 150
			addRollout WireWorkRoll WireWorkFloater
			 
