local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightMode = class("FightMode", cc.mvc.ModelBase)

FightMode.FightMODE_TIPS_EVENT		  = "FightMODE_TIPS_EVENT"
FightMode.FightMODE_RENZHI_SAVE_EVENT = "FightMODE_RENZHI_SAVE_EVENT"
FightMode.FightMODE_TAOFAN_TAO_EVENT  = "FightMODE_TAOFAN_TAO_EVENT"

FightMode.kModeTypes = {
	xianShi = "xianShi",
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
	assert(FightMode.kModeTypes[type], "invalid type:" .. type)

	--tips
	local animName
	if failData.type == "renZhi" then 
    	self:dispatchEvent({name = FightMode.FightMODE_TIPS_EVENT , 
	    	animName = "wusharz"})
	elseif failData.type == "taoFan" then
		self:dispatchEvent({name = FightMode.FightMODE_TIPS_EVENT , 
	    	animName = "taofantp"})
	end

    --fight
    local fight = md:getInstance("Fight")
    fight:willFail(2.0)
end

function FightMode:willWin(winData)
	local type = winData.type
	assert(FightMode.kModeTypes[type], "invalid type:" .. type)
    local fight = md:getInstance("Fight")
    scheduler.performWithDelayGlobal(handler(fight, fight.willWin), 2.0)    	
end

return FightMode