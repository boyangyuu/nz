local FightDescModel = class("FightDescModel", cc.mvc.ModelBase)

FightDescModel.START_ANIM_EVENT = "START_ANIM_EVENT"
FightDescModel.BOSSSHOW_ANIM_EVENT = "BOSSSHOW_ANIM_EVENT"
FightDescModel.WAVESTART_ANIM_EVENT = "WAVESTART_ANIM_EVENT"
FightDescModel.ENEMYINTRO_ANIM_EVENT = "ENEMYINTRO_ANIM_EVENT"

function FightDescModel:ctor(properties)
	FightDescModel.super.ctor(self, properties)
end

function FightDescModel:start()
	self:dispatchEvent({name = FightDescModel.START_ANIM_EVENT})
end

function FightDescModel:bossShow()
	self:dispatchEvent({name = FightDescModel.BOSSSHOW_ANIM_EVENT})
end

function FightDescModel:waveStart(waveNum) -- startWave
	self:dispatchEvent({name = FightDescModel.WAVESTART_ANIM_EVENT,waveNum = waveNum})
end

--boss简介
function FightDescModel:showEnemyIntro(enemyId) -- showEnemyIntro
	print("enemyId", enemyId)
	self:dispatchEvent({name = FightDescModel.ENEMYINTRO_ANIM_EVENT,enemyId = enemyId})
end

return FightDescModel