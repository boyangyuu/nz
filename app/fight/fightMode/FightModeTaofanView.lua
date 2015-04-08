
--[[--

“时间模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeTaofanView = class("FightModeTaofanView", FightModeBaseView)

function FightModeTaofanView:ctor()
	FightModeTaofanView.super.ctor(self)

	--instance
	self.curTaoNum = 0
	self.label   = nil
	self.isPause = false

 	cc.EventProxy.new(self.fightMode, self)
	 	:addEventListener(self.fightMode.FightMODE_TAOFAN_TAO_EVENT,
	 		 handler(self, self.OnTaofanTao))	 	
end

function FightModeTaofanView:refreshUI()
	local label = cc.uiloader:seekNodeByName(self.ui, "label") 
	local str   = self:getLabelStr()
	label:setString(str)

	--action
	local actionScale1 = cc.ScaleTo:create(0.2, 3.0)
	local actionScale2 = cc.ScaleTo:create(0.1, 1.0)
	local seq = cc.Sequence:create(actionScale1, actionScale2) 
	label:runAction(seq)
end

function FightModeTaofanView:getLabelStr()
	local maxNum = self.modeConfig.limitNums
	local str = self.curTaoNum .. "/" .. maxNum
	return str
end

function FightModeTaofanView:onFightStart(event)
	local label = cc.uiloader:seekNodeByName(self.ui, "label") 
	local str   = self:getLabelStr()
	label:setString(str)
end

function FightModeTaofanView:OnTaofanTao(event)
	if self.isPause then return end
	self.curTaoNum = self.curTaoNum + 1
	self:checkTaofanLimit()
	self:refreshUI()
end

function FightModeTaofanView:checkTaofanLimit()
	if self.curTaoNum >= self.modeConfig.limitNums then 
		self.fightMode:willFail({type = "taoFan"})
	end
end

function FightModeTaofanView:onFightRelive(event)
	self.curTaoNum = 0
	self:refreshUI()
end

function FightModeTaofanView:onFightEnd(event)
	self.isPause = true
end

function FightModeTaofanView:onFightPause(event)

end


return FightModeTaofanView
