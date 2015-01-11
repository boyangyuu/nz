
local className = "com/anqu/vibratortest/Vibrate"

local Vibrate = class("Vibrate")

function Vibrate:ctor()
	
end

function MainScene:vibrate(time)
	local args = {time}
	local sig = "(I)V"
	luaj.callStaticMethod(className,"vibrator", args, sig)
end

function MainScene:vibratorAndParthen(param)
	local sig = "(IIIII)V"
	luaj.callStaticMethod(className,"vibratorAndParthen", param, sig)
end

function MainScene:cancelVibtrate()
	luaj.callStaticMethod(className,"cancelVibtrator")
end

return Vibrate