local FightMode = class("FightMode", cc.mvc.ModelBase)

-- FightMode.START_ANIM_EVENT = "START_ANIM_EVENT"

function FightMode:ctor(properties)
	FightMode.super.ctor(self, properties)
end

function FightMode:getMode()
	local map 		 = md:getInstance("Map")
	local waveConfig = map: getCurWaveConfig()
	local type 		 = waveConfig:getFightModeType()
	assert(type, "type is nil")
	return type
end



return FightMode