myLookat = $.modifiers[1].gizmo.transform.rotation.controller
myLookat.constraints.appendTarget $camera01 50.0

myLookat = $.modifiers[1].gizmo.transform.rotation.controller

myLookat.constraints.appendTarget $camera01 50.0

$.modifiers[1].gizmo.transform.rotation.controller.upnode_axis  = 1


$.modifiers[1].gizmo.transform.rotation.controller.weight[1] = 100.0


$.modifiers[1].gizmo.transform.rotation.controller.target_axis = 2