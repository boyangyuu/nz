local LayerColor_BLACK = cc.c4b(0, 0, 0, 200)

local FightResultFailPopup = class("FightResultFailPopup", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function FightResultFailPopup:ctor()
    print("function FightResultFailPopup:ctor()")
    self:initUI()
    audio.stopMusic(false)
    self:playSound()
    self:setNodeEventEnabled(true)
end

function FightResultFailPopup:onEnter()
    self:initGuide()

    local guide = md:getInstance("Guide")
    local fight = md:getInstance("Fight")
    local groupId,levelId = fight:getCurGroupAndLevel()
    local isWillGuide =  groupId == 1 and levelId == 4
    if isWillGuide then guide:check("fightRelive") end
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
    self.btnRevive = cc.uiloader:seekNodeByName(self, "btnrevive")

    local armature = ccs.Armature:create("ydfh")
    armature:setPosition(180,60)
     self.btnRevive:addChild(armature)
    -- addChildCenter(armature,  self.btnRevive)
    armature:getAnimation():play("ydfh" , -1, 1)

    btnback:setTouchEnabled(true)
    addBtnEventListener(btnback, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBackHome()
        end
    end)
     self.btnRevive:setTouchEnabled(true)
    addBtnEventListener( self.btnRevive, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickRelive()
        end
    end)
end

function FightResultFailPopup:onCancelGoldGift()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("resurrection",{payDoneFunc = handler(self,self.payReliveDone)},
     "战斗失败页面_原地复活取消土豪")
end

function FightResultFailPopup:onClickRelive()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("goldGiftBag",{payDoneFunc = handler(self,self.payReliveDone),
        deneyBuyFunc = handler(self,self.onCancelGoldGift), isNotPopup = true},
     "失败页面_点击复活按钮")
end

function FightResultFailPopup:onClickBackHome()
    local buyModel = md:getInstance("BuyModel")
    local fight  = md:getInstance("Fight")
    fight:doGiveUp()

    local groupId,levelId = fight:getCurGroupAndLevel()
    ui:closePopup("FightResultFailPopup")
    local isBoughtWeapon = buyModel:checkBought("weaponGiftBag")
    if groupId == 0 and levelId == 0 then
        ui:changeLayer("HomeBarLayer",{groupId = 1})
        return
    end
    if isBoughtWeapon then
        ui:changeLayer("HomeBarLayer",{groupId = groupId})
    else
        ui:changeLayer("HomeBarLayer",{groupId = groupId,popWeaponGift = true})
    end
end

function FightResultFailPopup:payReliveDone()
    local fight = md:getInstance("Fight")
    fight:doRelive()
    local src = "res/Music/bg/bjyx.wav"
    audio.playMusic(src, true)
end

function FightResultFailPopup:initGuide()
    local fight = md:getInstance("Fight")
    local guide = md:getInstance("Guide")
    local groupId,levelId = fight:getCurGroupAndLevel()
    local isGuided        = guide:isDone("fightRelive")
    local isWillGuide =  groupId == 1 and levelId == 4 and not isGuided 
    if isWillGuide == false then return end

    --add guide
    guide:addClickListener({
        id = "fightRelive_relive",
        groupId = "fightRelive",
        rect = self.btnRevive:getBoundingBox(),
        endfunc = function (touchEvent)
            self:payReliveDone()
        end
    })     
end

return FightResultFailPopup