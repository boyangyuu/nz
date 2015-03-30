
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

	--ui
	self:initUI()
end

function FightModeView:initUI()
	self.ui = cc.uiloader:load("res/Fight/fightMode/fightDun/fightDun.ExportJson")
	self:addChild(self.ui)	
end



return FightModeView