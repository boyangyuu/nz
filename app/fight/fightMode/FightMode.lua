local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightMode = class("FightMode", cc.mvc.ModelBase)

FightMode.FightMODE_TIPS_EVENT		  = "FightMODE_TIPS_EVENT"
FightMode.FightMODE_RENZHI_SAVE_EVENT = "FightMODE_RENZHI_SAVE_EVENT"


FightMode.kModeTypes = {
	xianShi = "xianshi",
	renZhi  = "renZhi",
	taoFan  = "taoFan",
	puTong  = "puTong",
}

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

function FightMode:willFail(failData)
	local type = failData.type

	--tips
    self:dispatchEvent({name = FightMode.FightMODE_TIPS_EVENT , 
    	failType = type})

    --fight
    local fight = md:getInstance("Fight")
    scheduler.performWithDelayGlobal(handler(fight, fight.doFail), 1.5)    	
end

function FightMode:willWin(winData)
	-- local type = winData.type
    -- self:dispatchEvent({name = FightMode.FightMODE_TIPS_EVENT , 
    -- 	failType = type})

    local fight = md:getInstance("Fight")
    scheduler.performWithDelayGlobal(handler(fight, fight.doWin), 3.0) 
end

return FightMode