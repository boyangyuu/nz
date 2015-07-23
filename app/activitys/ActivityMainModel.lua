
local ActivityMainModel = class("ActivityMainModel", cc.mvc.ModelBase)
ActivityMainModel.SHOW_ACTIVITYMAIN = "SHOW_ACTIVITYMAIN"

function ActivityMainModel:ctor()
    ActivityMainModel.super.ctor(self) 
end

return ActivityMainModel