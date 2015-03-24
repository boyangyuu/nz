

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseBossView = import(".BaseBossView")
local FightConfigs = import("..fightConfigs.FightConfigs")
local SaosheBossView = class("SaosheBossView", BaseBossView)

function SaosheBossView:ctor(property)
	SaosheBossView.super.ctor(self, property) 
end

function SaosheBossView:playFire()
	self.armature:getAnimation():play("fire" , -1, 1) 
	self.enemy:hit(self.hero)	
end

function SaosheBossView:playSaoShe()
	self.armature:getAnimation():play("saoshe" , -1, 1)

	--持续开枪 0.1
	local fireOffset = self.config["saoFireOffset"]
	local fireTimes = self.config["saoFireTimes"]
	self:continueFire(fireTimes, fireOffset)
end

function SaosheBossView:playSkill(skillName)
	if skillName == "saoShe" then
		self:play("skill", handler(self, self.playSaoShe))
        return 
    end
    SaosheBossView.super.playSkill(self, skillName)
end

function SaosheBossView:continueFire(sumTimes, fireOffset)
	local sumTimes = sumTimes
	local handler = nil
	function saosheFire()
		if sumTimes == 0 then 
			scheduler.unscheduleGlobal(handler)
		end
		self.enemy:hit(self.hero)
		sumTimes = sumTimes - 1
	end
	handler =  scheduler.scheduleGlobal(saosheFire, fireOffset)
	self:addScheduler(handler)  
end

return SaosheBossView