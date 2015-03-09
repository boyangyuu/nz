local FightResultFailPopup = class("FightResultFailPopup", function()
    return display.newLayer()
end)

function FightResultFailPopup:ctor()
    self:initUI()
    -- self:popUpGift()
end

function FightResultFailPopup:popUpGift()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self,self.payReliveDone)}, "战斗结算页面_点击复活按钮")
end

function FightResultFailPopup:initUI()
    --loadCCS
    cc.FileUtils:getInstance():addSearchPath("res/FightResult/fightResultAnim")
    local controlNode = cc.uiloader:load("fightResultFail.ExportJson")
    self:addChild(controlNode)

    local btnback = cc.uiloader:seekNodeByName(self, "btnback")
    local btnrevive = cc.uiloader:seekNodeByName(self, "btnrevive")
    local rolepanel = cc.uiloader:seekNodeByName(self, "role")
    local roleimg = display.newSprite("#role_anqi.png")

    local armature = ccs.Armature:create("ydfh")
    armature:setPosition(180,60)
    btnrevive:addChild(armature)
    -- addChildCenter(armature, btnrevive)
    armature:getAnimation():play("ydfh" , -1, 1)

    roleimg:scale(1.33)
    addChildCenter(roleimg, rolepanel)
    btnback:setTouchEnabled(true)
    addBtnEventListener(btnback, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBackHome()
        end
    end)
    btnrevive:setTouchEnabled(true)
    addBtnEventListener(btnrevive, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickRelive()
        end
    end)
end

function FightResultFailPopup:onClickRelive()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("resurrection", 
        {payDoneFunc = handler(self,self.payReliveDone)}, 
        "战斗失败页面_点击原地复活")
end

function FightResultFailPopup:onClickBackHome()
    local fight  = md:getInstance("Fight")
    fight:onGiveUp()

    local groupid,levelid = fight:getCurGroupAndLevel()
    ui:closePopup("FightResultFailPopup")
    ui:changeLayer("HomeBarLayer",{groupId = groupid})    
end

function FightResultFailPopup:payReliveDone()
    local fight = md:getInstance("Fight")
    fight:payReliveDone()
end

return FightResultFailPopup