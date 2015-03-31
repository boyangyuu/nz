
--[[--

“时间模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeTaofanView = class("FightModeTaofanView", FightModeBaseView)

function FightModeTaofanView:ctor()
	--instance
end

function FightModeTaofanView:refreshUI()
	local labelTime = cc.uiloader:seekNodeByName(self.ui, "labelTime") 
	local time 	    =  self.modeConfig.limitTime
	local timeStr   =  self:getTimeStr(time)
	labelTime:setString(timeStr)
end

function FightModeTaofanView:onFightStart(event)
	
end

return FightModeTaofanView
