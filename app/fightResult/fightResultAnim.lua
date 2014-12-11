local FightResultAnim = class("FightResultAnim", function()
	return display.newLayer()
end)

function FightResultAnim:ctor()
	self:loadCCS()
	self:playAnim()
end

function FightResultAnim:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/fightResult/fightResultAnim")
	local controlNode = cc.uiloader:load("fightResult.ExportJson")
    self:addChild(controlNode)

    local animLayer = cc.uiloader:seekNodeByName(self, "animlayer")

    local src = "res/fightResult/anim/renwuwc/renwuwc.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    self.armature = ccs.Armature:create("renwuwc")
    addChildCenter(self.armature, animLayer)
end

function FightResultAnim:playAnim()
	self.armature:getAnimation():play("renwuwc" , -1, 0)
end

return FightResultAnim