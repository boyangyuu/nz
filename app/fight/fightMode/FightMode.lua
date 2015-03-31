local FightMode = class("FightMode", cc.mvc.ModelBase)

-- FightMode.START_ANIM_EVENT = "START_ANIM_EVENT"

function FightMode:ctor(properties)
	FightMode.super.ctor(self, properties)
end

function FightMode:getModeConfig()
	local map 		 = md:getInstance("Map")
	local waveConfig = map:getCurWaveConfig()
	local modeConfig = waveConfig:getFightMode()
	assert(modeConfig, "modeConfig is nil")
	return modeConfig
end



return FightMode