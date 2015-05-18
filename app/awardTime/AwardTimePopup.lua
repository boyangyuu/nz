local AwardTimeConfig = import(".AwardTimeConfig")
local AwardTimePopup = class("AwardTimePopup", function()
	return display.newLayer()
end)

function AwardTimePopup:ctor()
	self.awardTimeModel = md:getInstance("AwardTimeModel")
	self:loadCCS()
end

function AwardTimePopup:loadCCS()
    local time = self.awardTimeModel:getRemainTime()
    print("time", time)	
    
end

return AwardTimePopup