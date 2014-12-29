local SoundManager = class("SoundManager",cc.mvc.ModelBase)

--保存layer
local Sound = {}
Sound["homeBarMusic"] 		 = "res/HomeBarLayer/homeBar.ogg"
Sound["startMusic"] 		 = "res/Start/start.ogg"

function SoundManager:ctor(properties)
    SoundManager.super.ctor(self, properties) 
	--instance
end

function SoundManager:preloadSound(soundId)
	audio.preloadSound(Sound[soundId])
end

function SoundManager:playMusic(soundId)
	audio.playMusic(Sound[soundId])
end

function SoundManager:playMusic(soundId)
	audio.playMusic(Sound[soundId])
end


return SoundManager

