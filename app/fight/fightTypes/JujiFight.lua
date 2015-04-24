local Fight   = import(".Fight") 

local JujiFight = class("JujiFight", Fight)
function JujiFight:ctor(properties)
	JujiFight.super.ctor(self, properties)
end

return JujiFight