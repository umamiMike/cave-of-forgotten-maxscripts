(
fn formatTextBox tb =
(
tb.multiline = true
tb.wordwrap = true
tb.acceptsreturn = true
tb.scrollbars = (dotnetclass "System.Windows.Forms.ScrollBars").vertical
)

rollout textBoxRollout "Text Box"
(
dotnetcontrol tb "System.Windows.Forms.TextBox" width:290 height:300 align:#center
button printText "Print Text"

on tb KeyPress sender event do
case event.keychar of
(
("\r"):(event.keychar = "\n") --replace returns with newlines
)

on printText pressed do print tb.text

on textBoxRollout open do formatTextBox tb
)
createdialog textBoxRollout width:300
)
