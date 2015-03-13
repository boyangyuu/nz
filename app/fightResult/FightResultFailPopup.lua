local LayerColor_BLACK = cc.c4b(0, 0, 0, 200)

local FightResultFailPopup = class("FightResultFailPopup", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function FightResultFailPopup:ctor()
    self:initUI()
    audio.stopMusic(false)
    self:playSound()
end

function FightResultFailPopup:playSound()
    local rwwc   = "res/Music/ui/rwsb.wav"
    audio.playSound(rwwc,false)
end

function FightResultFailPopup:initUI()
    --loadCCS
    cc.FileUtils:getInstance():addSearchPath("res/FightResult/fightResultAnim")
    local controlNode = cc.uiloader:load("fightResultFail.ExportJson")
    self:addChild(controlNode)

    local btnback = cc.uiloader:seekNodeByName(self, "btnback")
    local btnrevive = cc.uiloader:seekNodeByName(self, "btnrevive")

    local armature = ccs.Armature:create("ydfh")
    armature:setPosition(180,60)
    btnrevive:addChild(armature)
    -- addChildCenter(armature, btnrevive)
    armature:getAnimation():play("ydfh" , -1, 1)

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
    local buyModel = md:getInstance("BuyModel")
    local fight  = md:getInstance("Fight")
    fight:onGiveUp()

    local groupid,levelid = fight:getCurGroupAndLevel()
    ui:closePopup("FightResultFailPopup")
    local isBoughtWeapon = buyModel:checkBought("weaponGiftBag")
    if groupid == 0 and levelid == 0 then
        ui:changeLayer("HomeBarLayer",{groupId = 1})
        return
    end
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
    fight:onRelive()
    local src = "res/Music/bg/bjyx.wav"
    audio.playMusic(src, true)
end

return FightResultFailPopup