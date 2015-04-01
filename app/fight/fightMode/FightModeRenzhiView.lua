
--[[--

“时间模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeRenzhiView = class("FightModeRenzhiView", FightModeBaseView)

function FightModeRenzhiView:ctor()
	FightModeRenzhiView.super.ctor(self)
	self.curSaveNum = 0
	self.labelSave  = nil

 	cc.EventProxy.new(self.fightMode, self)
	 	:addEventListener(self.fightMode.FightMODE_RENZHI_SAVE_EVENT  ,
	 		 handler(self, self.OnRenzhiSave))	 	

end

function FightModeRenzhiView:refreshUI()
	local labelSave = cc.uiloader:seekNodeByName(self.ui, "labelSave") 
	local str   	= self:getLabelStr()
	labelSave:setString(str)
end

function FightModeRenzhiView:getLabelStr()
	local maxNum = self.modeConfig.saveNums
	local str = "解救人质 " .. self.curSaveNum .. "/" .. maxNum
	return str
end

function FightModeRenzhiView:onFightStart(event)
	self:refreshUI()
end

function FightModeRenzhiView:OnRenzhiSave(event)
	self.curSaveNum = self.curSaveNum + 1
	self:checkRenzhiLimit()
	self:refreshUI()
end

function FightModeRenzhiView:checkRenzhiLimit()
	if self.curSaveNum >= self.modeConfig.saveNums then 
		self.fightMode:willWin()
	end
end

function FightModeRenzhiView:onFightRelive(event)
	
end

function FightModeRenzhiView:onFightEnd(event)
	
end

return FightModeRenzhiView
