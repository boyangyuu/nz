local FightResultFailPopup = class("FightResultFailPopup", function()
    return display.newLayer()
end)

function FightResultFailPopup:ctor()
    self:initUI()
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

function FightResultFailPopup:deneyGoldGift()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("resurrection",{payDoneFunc = handler(self,self.payReliveDone)},
     "战斗失败页面_原地复活取消土豪")
end

function FightResultFailPopup:onClickRelive()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("goldGiftBag",{payDoneFunc = handler(self,self.payReliveDone),
        deneyBuyFunc = handler(self,self.deneyGoldGift)},
     "失败页面_点击复活按钮")
end

function FightResultFailPopup:onClickBackHome()
    local fight  = md:getInstance("Fight")
    fight:onGiveUp()

    local groupid,levelid = fight:getCurGroupAndLevel()
    ui:closePopup("FightResultFailPopup")
    local isBoughtWeapon = buyModel:checkBought("weaponGiftBag")
    if isBoughtWeapon == false and groupid == 1 and levelid == 3 then
        ui:changeLayer("HomeBarLayer",{groupId = groupid,popWeaponGift = true})
        return
    end
    if isBoughtWeapon then
        ui:changeLayer("HomeBarLayer",{groupId = groupid,popGoldGift = true})
    else
        ui:changeLayer("HomeBarLayer",{groupId = groupid,popWeaponGift = true})
    end
end

function FightResultFailPopup:payReliveDone()
    local fight = md:getInstance("Fight")
    fight:payReliveDone()
end

return FightResultFailPopup