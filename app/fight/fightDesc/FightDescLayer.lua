local FightDescConfig = import(".FightDescConfig")
local FightDescLayer = class("FightDescLayer", function()
	return display.newLayer()
end)

function FightDescLayer:ctor()
    self.model = md:getInstance("FightDescModel")

    cc.EventProxy.new(self.model, self)
        :addEventListener(self.model.START_ANIM_EVENT, handler(self, self.start))
        :addEventListener(self.model.BOSSSHOW_ANIM_EVENT, handler(self, self.bossShow))
        :addEventListener(self.model.WAVESTART_ANIM_EVENT, handler(self, self.waveStart))
        :addEventListener(self.model.ENEMYINTRO_ANIM_EVENT, handler(self, self.enemyIntro))

	self:loadCCS()
end

function FightDescLayer:loadCCS()
	local controlNode = cc.uiloader:load("res/CommonPopup/animLayer/animLayer_1.ExportJson")
    self:addChild(controlNode)
    self:setVisible(false)
    self.animPanl = cc.uiloader:seekNodeByName(self, "animPanl")
end

function FightDescLayer:playAnim(animName)
    self.armature:getAnimation():play(self.animName , -1, 1)
end

function FightDescLayer:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID == self.animName then
            armatureBack:pause()
            self:setVisible(false)
        end
    end
end

function FightDescLayer:refreshLayer()
    self:setVisible(true)
    self.animPanl:removeAllChildren()
end

function FightDescLayer:start(event)
    self:refreshLayer()
    local armature = ccs.Armature:create("renwuks")
    armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(armature, self.animPanl)
    -- self:playAnim("renwuks")
    self.animName = "renwuks"
    armature:getAnimation():play(self.animName , -1, 1)
end

function FightDescLayer:bossShow(event)
    self:refreshLayer()
    local armature = ccs.Armature:create("qiangdicx")
    armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(armature, self.animPanl)
    self.animName = "qiangdicx"
    armature:getAnimation():play(self.animName , -1, 1)
end

function FightDescLayer:waveStart(event)
    self:refreshLayer()
    armature = ccs.Armature:create("direnlx")
    armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(armature, self.animPanl)
    self.animName = "direnlx"..event.waveNum
    armature:getAnimation():play(self.animName , -1, 1)
end

function FightDescLayer:enemyIntro(event)
    self:refreshLayer()
    local controlNode = cc.uiloader:load("res/CommonPopup/animLayer/animLayer_2.ExportJson")
    self:addChild(controlNode)
    local enemyID = event.enemyId
    self:initEnemyIntro(enemyID)
end

function FightDescLayer:initEnemyIntro(enemyID)

end

return FightDescLayer