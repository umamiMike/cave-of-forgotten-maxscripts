--oscillator script
-- 

myWaveform = Waveform_Float ()
setTimeRange myWaveform 0f 1200f
myFloatlist = float_list ()
$.pos.controller.Z_Position.controller = myFloatlist
myFloatlist.Available.controller = myWaveform


