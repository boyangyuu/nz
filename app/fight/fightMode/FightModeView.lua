
--[[--

“战斗模式”的视图

]]
local FightMode   = import(".FightMode") 

local FightModeView = class("FightModeView", function()
    return display.newNode()
end)

function FightModeView:ctor()
	--instance
	self.fightMode 	 = md:getInstance("FightMode")

	--data
	self.modeConfig = self.fightMode:getModeConfig()
	self.modeType   = self.modeConfig.type

	--ui
	self:initUI()

	--events
 	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, 
 		handler(self, self.tick))	
end

function FightModeView:tick(dt)
	self:refreshUI()
end

function FightModeView:initUI()
	self.ui = cc.uiloader:load("res/Fight/fightLayer/fightMode/" 
		.. self.modeType .. ".ExportJson")
	self:addChild(self.ui)
end

function FightModeView:refreshUI()
	local funStr = "refreshUI_" .. self.modeType
	self[funStr]()
end

function FightModeView:refreshUI_puTong()

end

function FightModeView:refreshUI_renZhi()
	
end

function FightModeView:refreshUI_xianShi()
	local labelTime = cc.uiloader:seekNodeByName(self.ui, "labelTime") 
	local time 	    =  self.modeConfig.limitTime
	local timeStr   =  self:getTimeStr(time)
	labelTime:setString(timeStr)

end

function FightModeView:refreshUI_taoFan()
	
end

function FightModeView:getTimeStr(time)
	local minutes = math.floor(time / 60) 
	if minutes < 10 then 
		minutes = "0" .. minutes
	end
	local seconds = time % 60
	if seconds < 10 then 
		seconds = "0" .. seconds
	end	
	return minutes .. ":" .. seconds 
end

return FightModeView