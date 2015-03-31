
--[[--

“时间模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeRenzhiView = class("FightModeRenzhiView", FightModeBaseView)

function FightModeRenzhiView:ctor()
	FightModeRenzhiView.super.ctor(self)
	self.curSaveNum = 0
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
	
end

function FightModeRenzhiView:onFightRelive(event)
	
end

function FightModeRenzhiView:onFightEnd(event)
	
end

return FightModeRenzhiView
