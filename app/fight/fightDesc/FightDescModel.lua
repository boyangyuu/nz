local FightDescModel = class("FightDescModel", cc.mvc.ModelBase)

FightDescModel.START_ANIM_EVENT = "START_ANIM_EVENT"
FightDescModel.BOSSSHOW_ANIM_EVENT = "BOSSSHOW_ANIM_EVENT"
FightDescModel.WAVESTART_ANIM_EVENT = "WAVESTART_ANIM_EVENT"
FightDescModel.ENEMYINTRO_ANIM_EVENT = "ENEMYINTRO_ANIM_EVENT"
FightDescModel.GUNINTRO_ANIM_EVENT = "GUNINTRO_ANIM_EVENT"
FightDescModel.GOLDWAVE_ANIM_EVENT = "GOLDWAVE_ANIM_EVENT"

function FightDescModel:ctor(properties)
	FightDescModel.super.ctor(self, properties)
end

function FightDescModel:start(fightType)
	self:dispatchEvent({name = FightDescModel.START_ANIM_EVENT,fightType = fightType})
end

function FightDescModel:bossShow()
	self:dispatchEvent({name = FightDescModel.BOSSSHOW_ANIM_EVENT})
end

function FightDescModel:goldShow()
	self:dispatchEvent({name = FightDescModel.GOLDWAVE_ANIM_EVENT})
end

function FightDescModel:waveStart(waveNum) -- startWave
	self:dispatchEvent({name = FightDescModel.WAVESTART_ANIM_EVENT,waveNum = waveNum})
end

--敌人简介
function FightDescModel:showEnemyIntro(enemyId) -- showEnemyIntro
	print("enemyId", enemyId)
	self:dispatchEvent({name = FightDescModel.ENEMYINTRO_ANIM_EVENT,enemyId = enemyId})
end

--枪械简介
function FightDescModel:showGunIntro(gunData) -- showEnemyIntro
	assert(gunData, "gunData is nil")
	print("gunId", gunData.gunId)
	local function callfuncAdd()
		self:dispatchEvent({name = FightDescModel.ENEMYINTRO_ANIM_EVENT,
			gunId = gunId})
	end

	local function callfuncRemove()
		print("	local function callfuncRemove()")
	end

	self:performWithDelay(callfuncAdd, gunData.delay)
	self:performWithDelay(callfuncAdd, gunData.time)
end

return FightDescModel