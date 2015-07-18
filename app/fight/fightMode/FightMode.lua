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
	bossContest = "bossContest",
}

function FightMode:ctor(properties)
	FightMode.super.ctor(self, properties)
    local fightFactory = md:getInstance("FightFactory")
    self.fight = fightFactory:getFight()	
end

function FightMode:getModeConfig()
	local map 		 = md:getInstance("Map")
	local waveConfig = map:getCurWaveConfig()
	local modeConfig = waveConfig:getFightMode()
	assert(modeConfig, "modeConfig is nil")
	local type = modeConfig.type
	assert(FightMode.kModeTypes[type], "invalid type:" .. type)
	return modeConfig
end

function FightMode:willFail(failData)
	--result
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

    self.fight:willFail(2.0)
end

function FightMode:willWin(winData)
	--result
	local type = winData.type
	assert(FightMode.kModeTypes[type], "invalid type:" .. type)
	
    local fightFactory = md:getInstance("FightFactory")
    self.fight = fightFactory:getFight()
    scheduler.performWithDelayGlobal(handler(self.fight, self.fight.willWin), 1.0)    	
end

return FightMode