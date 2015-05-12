
--[[--

“地图效果”的视图

]]

local FightRelivePopup = class("FightRelivePopup", function()
    return display.newLayer()
end)

function FightRelivePopup:ctor(property)

	--instance
	self.property = property
    -- cc.EventProxy.new(self.fightGun, self)
    --     :addEventListener(self.fightGun.HELP_START_EVENT, handler(self, self.onShow))
    self:loadCCS()
    self:setNodeEventEnabled(true) 
end

function FightRelivePopup:onEnter()
	self:onShow()
end

function FightRelivePopup:loadCCS()
    local manager = ccs.ArmatureDataManager:getInstance() 
	self.node = cc.uiloader:load("res/fight/fightLayer/fightTips/relive.ExportJson")
    self:addChild(self.node)    

    --btns
    local btn_relive = cc.uiloader:seekNodeByName(self.node, "btn_relive")
    btn_relive:onButtonClicked(function()
         self:onClickRelive()
    end)
    local btn_giveUp = cc.uiloader:seekNodeByName(self.node, "btn_giveUp")
    btn_giveUp:onButtonClicked(function()
         self:onClickGiveUp()
    end)
end

function FightRelivePopup:onClickRelive()
	print("function FightRelivePopup:onClickRelive()")
	self.property["onReliveFunc"]()
	self:close()
end

function FightRelivePopup:onClickGiveUp()
	print("function FightRelivePopup:onClickGiveUp()")	
	self.property["onGiveUpFunc"]()
	self:close()
end

function FightRelivePopup:onShow()
	local remainTimes = 5
	local labelTime = cc.uiloader:seekNodeByName(self.node, "labelTime")
	local labelCost = cc.uiloader:seekNodeByName(self.node, "labelNumCost")
	
	--cost
	local cost = self:getReliveCost()
	print("cost", cost)	
	labelCost:setString(cost)

	--time
	labelTime:setString(remainTimes)
	local function timeFunc()
		remainTimes = remainTimes - 1
		if remainTimes == 0 then 
			self:onClickGiveUp()
			return
		end
		labelTime:setString(remainTimes)
		print("remainTimes", remainTimes)
	end
	self:schedule(timeFunc, 1.0)
end

function FightRelivePopup:getReliveCost()
	local fightFactory = md:getInstance("FightFactory")
	local fight        = fightFactory:getFight()
	return fight:getReliveCost()
end

function FightRelivePopup:close()
	ui:closePopup("FightRelivePopup")
end

return FightRelivePopup