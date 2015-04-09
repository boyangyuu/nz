
--[[--

“战斗模式”的视图

]]
local FightMode   = import(".FightMode") 

local FightModeBaseView = class("FightModeBaseView", function()
    return display.newNode()
end)

function FightModeBaseView:ctor()
	--instance
	self.fightMode 	 = md:getInstance("FightMode")
	self.fight       = md:getInstance("Fight")

	--data
	self.modeConfig = self.fightMode:getModeConfig()
	self.modeType   = self.modeConfig.type

	--ui
	self:initUI()

	--events
 	cc.EventProxy.new(self.fight, self)
	 	:addEventListener(self.fight.FIGHT_START_EVENT  , handler(self, self.onFightStart))	 	
	 	:addEventListener(self.fight.FIGHT_START_EVENT  , handler(self, self.onShow))	 	
	 	:addEventListener(self.fight.FIGHT_WIN_EVENT	, handler(self, self.onFightEnd))	 	
	 	:addEventListener(self.fight.FIGHT_FAIL_EVENT	, handler(self, self.onFightEnd))	 	
	 	:addEventListener(self.fight.FIGHT_RELIVE_EVENT	, handler(self, self.onFightRelive))	 	
	 	:addEventListener(self.fight.PAUSE_SWITCH_EVENT	, handler(self, self.onFightPause))	 	

 	self:setVisible(false)
end

function FightModeBaseView:initUI()
	self.ui = cc.uiloader:load("res/Fight/fightLayer/fightMode/" 
		.. self.modeType .. ".ExportJson")
	self:addChild(self.ui)
end

function FightModeBaseView:onShow()
	self:setVisible(true)
end

function FightModeBaseView:onFightStart(event)
	assert(false, "must override me")
end

function FightModeBaseView:onFightEnd(event)
	assert(false, "must override me")
end

function FightModeBaseView:onFightRelive(event)
	assert(false, "must override me")
end

function FightModeBaseView:onFightPause(event)
	assert(false, "must override me")
end

function FightModeBaseView:refreshUI()
	assert(false, "must override me")
end

return FightModeBaseView