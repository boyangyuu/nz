local Fight   = import(".Fight") 

local BossFight = class("BossFight", Fight)
function BossFight:ctor(properties)
	dump(properties, "properties")
	BossFight.super.ctor(self, properties)
end

function BossFight:startFightResult()
    ui:showPopup("FightResultPopup",{},{anim = false})
end

return BossFight