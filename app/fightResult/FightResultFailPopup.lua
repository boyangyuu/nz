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
    local fightFactory =    md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    local groupId,levelId = fight:getCurGroupAndLevel()
    local isWillGuide =  groupId == 1 and levelId == 4
    if isWillGuide then guide:check("fightRelive") end
end

function FightResultFailPopup:playSound()
    local rwsb   = "res/Music/ui/rwsb.wav"
    audio.playSound(rwsb,false)
end

function FightResultFailPopup:initUI()
    --loadCCS
    cc.FileUtils:getInstance():addSearchPath("res/FightResult/fightResultAnim")
    local controlNode = cc.uiloader:load("fightResultFail.ExportJson")
    self:addChild(controlNode)

    local btnback = cc.uiloader:seekNodeByName(self, "btnback")
    self.btnRevive = cc.uiloader:seekNodeByName(self, "btnrevive")

    --add res
    local manager = ccs.ArmatureDataManager:getInstance()
    local ydfhsrc = "res/FightResult/anim/ydfh/ydfh.ExportJson"
    manager:addArmatureFileInfo(ydfhsrc)
    local plist = "res/FightResult/anim/ydfh/ydfh0.plist"
    local png   = "res/FightResult/anim/ydfh/ydfh0.png"
    display.addSpriteFrames(plist, png)
    
    local armature = ccs.Armature:create("ydfh")
    armature:setPosition(180,60)
    self.btnRevive:addChild(armature)

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

-- 保留，暂时不用
function FightResultFailPopup:onCancelGoldGift()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("relive",{payDoneFunc = handler(self,self.payReliveDone),isNotPopKefu = true},
     "战斗失败页面_原地复活取消土豪")
end

function FightResultFailPopup:onClickRelive()
    -- 保留，暂时不用
    -- local buyModel = md:getInstance("BuyModel")
    -- buyModel:showBuy("goldGiftBag",{payDoneFunc = handler(self,self.payReliveDone),
    --     deneyBuyFunc = handler(self,self.onCancelGoldGift), isNotPopup = true,isNotPopKefu = true},
    --  "失败页面_点击复活按钮")
    
    -- local buyModel = md:getInstance("BuyModel")
    -- buyModel:showBuy("relive",{payDoneFunc = handler(self,self.payReliveDone),isNotPopKefu = true},
    --  "战斗失败页面_点击复活按钮")
    self:payReliveDone()
end

function FightResultFailPopup:onClickBackHome()
    local fightFactory =     md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:doGiveUp()
    local result = fight:getResultData()
    ui:closePopup("FightResultFailPopup")
    ui:changeLayer("HomeBarLayer",{fightData = result})
end

function FightResultFailPopup:payReliveDone()
    local fightFactory =    md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:doRelive()
    local src = "res/Music/bg/bjyx.wav"
    audio.playMusic(src, true)
    ui:closePopup("FightResultFailPopup")
end

function FightResultFailPopup:initGuide()
    local fightFactory =    md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
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