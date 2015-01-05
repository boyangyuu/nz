local AnimModel = class("AnimModel", cc.mvc.ModelBase)

AnimModel.START_ANIM_EVENT = "START_ANIM_EVENT"
AnimModel.BOSSSHOW_ANIM_EVENT = "BOSSSHOW_ANIM_EVENT"
AnimModel.WAVESTART_ANIM_EVENT = "WAVESTART_ANIM_EVENT"
AnimModel.BOSSINTRO_ANIM_EVENT = "BOSSINTRO_ANIM_EVENT"

function AnimModel:ctor(properties)
	AnimModel.super.ctor(self, properties)
end

function AnimModel:start()
	self:dispatchEvent({name = AnimModel.START_ANIM_EVENT})
end

function AnimModel:bossShow()
	self:dispatchEvent({name = AnimModel.BOSSSHOW_ANIM_EVENT})
end

function AnimModel:waveStart(waveNum)
	self:dispatchEvent({name = AnimModel.WAVESTART_ANIM_EVENT,waveNum = waveNum})
end

--boss简介
function AnimModel:bossIntro(bossId)
	self:dispatchEvent({name = AnimModel.BOSSINTRO_ANIM_EVENT,bossId = bossId})
end

return AnimModel