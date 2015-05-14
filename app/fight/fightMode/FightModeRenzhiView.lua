
--[[--

“时间模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeRenzhiView = class("FightModeRenzhiView", FightModeBaseView)

function FightModeRenzhiView:ctor()
	FightModeRenzhiView.super.ctor(self)
	self.curSaveNum = 0

 	cc.EventProxy.new(self.fightMode, self)
	 	:addEventListener(self.fightMode.FightMODE_RENZHI_SAVE_EVENT  ,
	 		 handler(self, self.OnRenzhiSave))	 	
end

function FightModeRenzhiView:initUI()
	FightModeRenzhiView.super.initUI(self)
	self.label = cc.uiloader:seekNodeByName(self.ui, "labelSave")
	self.label:setColor(cc.c3b(0, 255, 235))
end

function FightModeRenzhiView:refreshUI()
	local label = cc.uiloader:seekNodeByName(self.ui, "labelSave") 
	local str   	= self:getLabelStr()
	label:setString(str)

	--action
	local actionScale1 = cc.ScaleTo:create(0.2, 3.0)
	local actionScale2 = cc.ScaleTo:create(0.1, 1.0)
	local seq = cc.Sequence:create(actionScale1, actionScale2) 
	label:runAction(seq)
end

function FightModeRenzhiView:getLabelStr()
	local maxNum = self.modeConfig.saveNums
	local str = self.curSaveNum .. "/" .. maxNum
	return str
end

function FightModeRenzhiView:onFightStart(event)
	local label = cc.uiloader:seekNodeByName(self.ui, "labelSave") 
	local str   	= self:getLabelStr()
	label:setString(str)
end

function FightModeRenzhiView:OnRenzhiSave(event)
	self.curSaveNum = self.curSaveNum + 1
	self:checkRenzhiLimit()
	self:refreshUI()
end

function FightModeRenzhiView:checkRenzhiLimit()
	if self.curSaveNum >= self.modeConfig.saveNums then 
		self.fightMode:willWin({type = self.fightMode.kModeTypes["renZhi"]})
	end
end

function FightModeRenzhiView:onFightRelive(event)
	
end

function FightModeRenzhiView:onFightEnd(event)
	
end

-- function FightModeRenzhiView:onFightPause(event)

-- end

return FightModeRenzhiView
