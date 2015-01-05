
local AnimLayer = class("AnimLayer", function()
	return display.newLayer()
end)

function AnimLayer:ctor()
    self.animModel = md:getInstance("AnimModel")

    cc.EventProxy.new(self.animModel, self)
        :addEventListener(self.animModel.START_ANIM_EVENT, handler(self, self.start))
        :addEventListener(self.animModel.BOSSSHOW_ANIM_EVENT, handler(self, self.bossShow))
        :addEventListener(self.animModel.WAVESTART_ANIM_EVENT, handler(self, self.waveStart))
        :addEventListener(self.animModel.BOSSINTRO_ANIM_EVENT, handler(self, self.bossIntro))

	self:loadCCS()
end

function AnimLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/animLayer")
	local controlNode = cc.uiloader:load("animLayer_1.ExportJson")
    self:addChild(controlNode)
    self:setVisible(false)
    self.animPanl = cc.uiloader:seekNodeByName(self, "animPanl")
end

function AnimLayer:playAnim(animName)
    self.armature:getAnimation():play(self.animName , -1, 1)
end

function AnimLayer:animationEvent(armatureBack,movementType,movementID)
    if movementType == ccs.MovementEventType.loopComplete then
        armatureBack:stopAllActions()
        if movementID == self.animName then
            armatureBack:pause()
            self:setVisible(false)
        end
    end
end

function AnimLayer:refreshLayer()
    self:setVisible(true)
    self.animPanl:removeAllChildren()
end

function AnimLayer:start(event)
    self:refreshLayer()
    local armature = ccs.Armature:create("renwuks")
    armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(armature, self.animPanl)
    -- self:playAnim("renwuks")
    self.animName = "renwuks"
    armature:getAnimation():play(self.animName , -1, 1)
end

function AnimLayer:bossShow(event)
    self:refreshLayer()
    local armature = ccs.Armature:create("qiangdicx")
    armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(armature, self.animPanl)
    self.animName = "qiangdicx"
    armature:getAnimation():play(self.animName , -1, 1)
end

function AnimLayer:waveStart(event)
    self:refreshLayer()
    armature = ccs.Armature:create("direnlx")
    armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))
    addChildCenter(armature, self.animPanl)
    self.animName = "direnlx"..event.waveNum
    armature:getAnimation():play(self.animName , -1, 1)
end

function AnimLayer:bossIntro(event)
    self:refreshLayer()
    cc.FileUtils:getInstance():addSearchPath("res/CommonPopup/animLayer")
    local controlNode = cc.uiloader:load("animLayer_2.ExportJson")
    self:addChild(controlNode)
end

return AnimLayer