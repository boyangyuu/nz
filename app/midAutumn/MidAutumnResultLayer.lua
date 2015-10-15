local MidAutumnResultLayer = class("MidAutumnResultLayer",function()
    return display.newLayer()
end)

function MidAutumnResultLayer:ctor(properties)
    self.properties = properties
    self.midAutumnModel = md:getInstance("MidAutumnModel")
    self:loadCCS()
    self:initUI()
    self:setNodeEventEnabled(true)
end

function MidAutumnResultLayer:onEnter()
    local rwwc   = "res/Music/ui/rwwc.wav"
    audio.playSound(rwwc,false)
end

function MidAutumnResultLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/BossMode/ResultLayer")
    local controlNode = cc.uiloader:load("bossResultLayer_1.ExportJson")
    self:addChild(controlNode,100)
end

function MidAutumnResultLayer:getAwards()
    local awardTable = self.midAutumnModel:getInfo()
    return awardTable
end

function MidAutumnResultLayer:initUI()
    local layerBtn = cc.uiloader:seekNodeByName(self, "layerBtn")
    local labelReward = cc.uiloader:seekNodeByName(self, "reward")
    local labelGold = cc.uiloader:seekNodeByName(self, "labelGold")
    labelReward:setVisible(false)

    self.awardsTable = self:getAwards()
    local numTable = {}
    numTable["num1"] = cc.uiloader:seekNodeByName(self, "num1")
    numTable["num2"] = cc.uiloader:seekNodeByName(self, "num2")
    numTable["num3"] = cc.uiloader:seekNodeByName(self, "num3")
    numTable["num4"] = cc.uiloader:seekNodeByName(self, "num4")
    local waveNum    = cc.uiloader:seekNodeByName(self, "waveNum")
    waveNum:setVisible(false)

    for k,v in pairs(numTable) do
        v:setVisible(false)
    end

    local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan.ExportJson"
    manager:addArmatureFileInfo(src)
    local plist = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan0.plist"
    local png   = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan0.png"
    display.addSpriteFrames(plist, png)

    local armature = ccs.Armature:create("wxboss_jiesuan")
    armature:setPosition(569,320)
    self:addChild(armature)
    armature:getAnimation():play("kaishi" , -1, 0)

    for i=1,#self.awardsTable do
        local award = self.awardsTable[i]
        dump(award)
        for k,v in pairs(award) do
            numTable["num"..i]:setString("X"..v)
            local icon = "icon_"..k..".png"
            local skinIcon = ccs.Skin:createWithSpriteFrameName(icon)
            armature:getBone("icon_"..i):addDisplay(skinIcon, 1)
            armature:getBone("icon_"..i):changeDisplayWithIndex(1, true)
        end
    end


    armature:getAnimation():setMovementEventCallFunc(
        function (armatureBack,movementType,movementId)
            if movementType == ccs.MovementEventType.complete then
                armature:getAnimation():play("chixu" , -1, 1)
                for k,v in pairs(numTable) do
                    v:setVisible(true)
                end
                labelReward:setVisible(true)
                labelGold:setString(LanguageManager.getStringForKey("string_hint24")..self.properties.goldValue..LanguageManager.getStringForKey("string_hint334"))
                layerBtn:setTouchEnabled(true)
                addBtnEventListener(layerBtn, function(event)
                    if event.name == 'began' then
                        return true
                    elseif event.name == 'ended' then
                        self:onClickBtnGet()
                    end
                end)
            end
        end)
end

function MidAutumnResultLayer:onClickBtnGet()
    local userModel = md:getInstance("UserModel")
    local propModel = md:getInstance("PropModel")

    for i=1,#self.awardsTable do
        local award = self.awardsTable[i]
        for k,v in pairs(award) do
            if k == "healthBag" then
                propModel:addProp("hpBag",v)
            elseif k == "lei" then
                propModel:addProp("lei",v)
            elseif k == "money" then
                userModel:addMoney(v)
            elseif k == "moonCake" then
                self.midAutumnModel:addMoonCakeNum(v)
            end
        end
    end

    ui:closePopup("MidAutumnResultLayer")

    --closefunc
    if self.properties["closeFunc"] then
        self.properties["closeFunc"]()
    end
end

return MidAutumnResultLayer