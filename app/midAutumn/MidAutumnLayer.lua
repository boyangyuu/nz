local MidAutumnLayer = class("MidAutumnLayer", function()
    return display.newLayer()
end)

function MidAutumnLayer:ctor()
    self.midAutumnModel = md:getInstance("MidAutumnModel")
    self:loadCCS()
    self:initUI()
    self:setNodeEventEnabled(true)
    cc.EventProxy.new(self.midAutumnModel, self)
        :addEventListener(self.midAutumnModel.REFRESH_MOONCAKE_EVENT, handler(self, self.refreshUI))
end

function MidAutumnLayer:onEnter()
    self.midAutumnModel:getCouldPlayTimes()
end

function MidAutumnLayer:loadCCS()
    self.ui = cc.uiloader:load("MidAutumn/jierihuodong.json")
    self:addChild(self.ui)
end

function MidAutumnLayer:initUI()
    local btnJijia = cc.uiloader:seekNodeByName(self, "btnGet1")
    local btnGoldWeapon = cc.uiloader:seekNodeByName(self, "btnGet2")
    local btnHpBag = cc.uiloader:seekNodeByName(self, "btnGet3")
    local btnStart = cc.uiloader:seekNodeByName(self, "btnStart")
    self.alreadyGetNum = cc.uiloader:seekNodeByName(self, "alreadyGetNum")
    local alreadyNum = self.midAutumnModel:getAlreadyNum()
    self.alreadyGetNum:setString("x"..alreadyNum)

    btnJijia:onButtonClicked(function()
        self.midAutumnModel:exchangeMoonCake("jijia")
    end)
    btnGoldWeapon:onButtonClicked(function()
        self.midAutumnModel:exchangeMoonCake("goldWeapon")
    end)
    btnHpBag:onButtonClicked(function()
        self.midAutumnModel:exchangeMoonCake("hpBag")
    end)
    btnStart:onButtonClicked(function()
        self:startGame()
    end)
end

function MidAutumnLayer:refreshUI(event)
    local alreadyNum = self.midAutumnModel:getAlreadyNum()
    self.alreadyGetNum:setString("x"..alreadyNum)
end

function MidAutumnLayer:startGame()

    if self.midAutumnModel:isCanPlay() then
        self.midAutumnModel:addMidAutTimes()
        local fightData = {groupId = 80, levelId = 1,
            fightType = "normalFight"}
        ui:changeLayer("FightPlayer", {fightData = fightData})
    else
        ui:showPopup("commonPopup",
         {type = "style1", content = "今天的已经没有机会了，请明天再来尝试吧"},
         {opacity = 155})
        return
    end
end

return MidAutumnLayer