
--[[--

“时间模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeXianshiView = class("FightModeXianshiView", FightModeBaseView)

function FightModeXianshiView:ctor()
	FightModeXianshiView.super.ctor(self)
	self.curLeftTime = self.modeConfig.limitTime
end

function FightModeXianshiView:initUI()
	FightModeXianshiView.super.initUI(self)
	self.labelTime = cc.uiloader:seekNodeByName(self.ui, "labelTime")
	-- self.labelTime:setColor(cc.c3b(255, 0, 4))
end

function FightModeXianshiView:refreshUI()
	
end

function FightModeXianshiView:onFightStart(event)
	local timeStr   =  self:getTimeStr(self.curLeftTime)
	self.labelTime:setString(timeStr)	

	--timeSch
	self.timeSchAction = self:schedule(handler(self, self.decreaseTime), 1.0)
end

function FightModeXianshiView:onFightRelive(event)
	transition.resumeTarget(self)
end

function FightModeXianshiView:onFightEnd(event)
	transition.pauseTarget(self)
end

function FightModeXianshiView:onFightPause(event)
	local isPause = event.isPause
	if isPause then 
		transition.pauseTarget(self)
	else
		transition.resumeTarget(self)
	end
end

function FightModeXianshiView:decreaseTime()
	self.curLeftTime = self.curLeftTime - 1
	if self.curLeftTime == 0 then 
		transition.removeAction(self.timeSchAction)
		self:onTimeEnd()
	end
	local timeStr = self:getTimeStr(self.curLeftTime)
	self.labelTime:setString(timeStr)
end

function FightModeXianshiView:onTimeEnd()
	self.fightMode:willWin({type = 
		self.fightMode.kModeTypes["xianShi"]})
end

function FightModeXianshiView:getTimeStr(time)
	-- local minutes = math.floor(time / 60)
	-- if minutes <  10 then 
	-- 	minutes = "0" .. minutes
	-- end

	-- local seconds = time % 60 
	-- if seconds < 10 then 
	-- 	seconds = "0" .. seconds
	-- end
	-- return minutes .. ":" .. seconds
	return time
end

return FightModeXianshiView
