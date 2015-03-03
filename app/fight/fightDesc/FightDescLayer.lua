local FightDescConfig = import(".FightDescConfig")
local FightDescLayer = class("FightDescLayer", function()
	return display.newLayer()
end)

function FightDescLayer:ctor()
    self.model = md:getInstance("FightDescModel")

    cc.EventProxy.new(self.model, self)
        :addEventListener(self.model.START_ANIM_EVENT, handler(self, self.onFightStart))
        :addEventListener(self.model.BOSSSHOW_ANIM_EVENT, handler(self, self.onBossStart))
        :addEventListener(self.model.WAVESTART_ANIM_EVENT, handler(self, self.onWaveStart))
        :addEventListener(self.model.ENEMYINTRO_ANIM_EVENT, handler(self, self.onShowEnemyIntro))

	self:loadCCS()
    self:setTouchSwallowEnabled(false)
end

function FightDescLayer:loadCCS()
	local controlNode = cc.uiloader:load("res/CommonPopup/animLayer/animLayer_1.ExportJson")
    self:addChild(controlNode)
    self:setVisible(false)
    self.animPanl = cc.uiloader:seekNodeByName(self, "animPanl")
end

function FightDescLayer:onFightStart(event)
    self:setVisible(true)
    local armature = ccs.Armature:create("renwuks")
    armature:getAnimation():setMovementEventCallFunc(
        function ( armatureBack,movementType,movementId ) 
            if movementType == ccs.MovementEventType.loopComplete then
                armature:removeFromParent()
                armature = nil
                self:setVisible(false)
            end
        end)
    addChildCenter(armature, self.animPanl)
    armature:getAnimation():play("renwuks" , -1, 1)
    local letsgo   = "res/Music/ui/letsgo.wav"
    audio.playSound(letsgo,false)
end

function FightDescLayer:onBossStart(event)
    self:setTouchSwallowEnabled(true)
    self:setVisible(true)
    local armature = ccs.Armature:create("qiangdicx")
    armature:getAnimation():setMovementEventCallFunc(
        function ( armatureBack,movementType,movementId ) 
            if movementType == ccs.MovementEventType.loopComplete then
                armature:removeFromParent()
                armature = nil
                self:setVisible(false)
            end
        end)
    addChildCenter(armature, self.animPanl)
    armature:getAnimation():play("qiangdicx" , -1, 1)

    --sound
    local soundSrc  = "res/Music/fight/qdcx.wav"
    self.audioId =  audio.playSound(soundSrc,false)    
end

function FightDescLayer:onWaveStart(event)
    self:setVisible(true)
    armature = ccs.Armature:create("direnlx")
    armature:getAnimation():setMovementEventCallFunc(
        function ( armatureBack,movementType,movementId ) 
            if movementType == ccs.MovementEventType.loopComplete then
                armature:removeFromParent()
                armature = nil
                self:setVisible(false)
            end
        end)
    addChildCenter(armature, self.animPanl)
    local animName = "direnlx"..event.waveNum
    armature:getAnimation():play(animName , -1, 1)
end

function FightDescLayer:onShowEnemyIntro(event)

    self:setVisible(true)
    local controlNode = cc.uiloader:load("res/CommonPopup/animLayer/animLayer_2.ExportJson")
    self:addChild(controlNode)
    local enemyID = event.enemyId
    self:initEnemyIntro(enemyID)
    self:runAction(transition.sequence({cc.DelayTime:create(3), cc.CallFunc:create(function()
        controlNode:removeFromParent()
        self:setVisible(false)
    end)}))

end

function FightDescLayer:initEnemyIntro(enemyID)
    local descConfig = FightDescConfig.getConfig(enemyID)
    dump(descConfig)
    local title = cc.uiloader:seekNodeByName(self, "title")
    local name = cc.uiloader:seekNodeByName(self, "name")
    local namea = cc.uiloader:seekNodeByName(self, "namea")
    local spc = cc.uiloader:seekNodeByName(self, "spc")
    local skill1 = cc.uiloader:seekNodeByName(self, "skill1")
    local skill2 = cc.uiloader:seekNodeByName(self, "skill2")
    local skill3 = cc.uiloader:seekNodeByName(self, "skill3")
    local weakness = cc.uiloader:seekNodeByName(self, "weakness")
    local playanim = cc.uiloader:seekNodeByName(self, "playanim")
    local describe = cc.uiloader:seekNodeByName(self, "describe")
    title:setString(descConfig.title) 
    describe:setString(descConfig.describe) 
    -- describe:speak()
    name:setString(descConfig.name) 
    namea:setString(descConfig.name) 
    spc:setString(descConfig.spc) 
    weakness:setString(descConfig.weakness)
    skill1:setString(descConfig.skill[1])
    skill2:setString(descConfig.skill[2])
    skill3:setString(descConfig.skill[3])

    local bossjjarm = ccs.Armature:create("bossjj")
    local contentsize = playanim:getContentSize()
    bossjjarm:setPosition(contentsize.width/2,contentsize.height/2-20)
    playanim:addChild(bossjjarm)
    bossjjarm:getAnimation():play("bossjj", -1, 1)

    local armature = ccs.Armature:create(enemyID)
    addChildCenter(armature, playanim)
    armature:getAnimation():play(descConfig.playanim , -1, 1)

end

return FightDescLayer