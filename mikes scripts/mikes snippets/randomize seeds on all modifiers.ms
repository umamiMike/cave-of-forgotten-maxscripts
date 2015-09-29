--filter  mods in selected objects

global myMods = #()
for i = 1 to selection.count do
(	for k = 1 to selection[i].modifiers.count do
			(
			if hasproperty selection[i].modifiers[k] "seed" == true then (append myMods selection[i].modifiers[k]) else ()
			)
			
			)

for i = 1 to mymods.count do
(mymods[i].seed = random 0 5000)