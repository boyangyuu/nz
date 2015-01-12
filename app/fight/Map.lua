 --[[--

“map”的实体

]]

--includes

local Map = class("Map", cc.mvc.ModelBase)
--events
Map.EFFECT_LEI_BOMB_EVENT = "EFFECT_LEI_BOMB_EVENT"
Map.EFFECT_SHAKE_EVENT 	  = "EFFECT_SHAKE_EVENT"

Map.MAP_ZOOM_OPEN_EVENT   = "MAP_ZOOM_OPEN_EVENT"
Map.MAP_ZOOM_RESUME_EVENT = "MAP_ZOOM_RESUME_EVENT"



function Map:ctor()
    Map.super.ctor(self)
    self.isJu = false
    self:setCurWaveConfig()
end

function Map:setCurWaveConfig()
	local fightConfigs  = md:getInstance("FightConfigs")
	local fight = md:getInstance("Fight")
	local waveConfig = fightConfigs:getWaveConfig()
	self.curWaveCfg = waveConfig
end

function Map:getCurWaveConfig()
	return self.curWaveCfg 
end

function Map:setIsJu(isJu_)
	self.isJu = isJu_
end

function Map:getIsJu()
	return self.isJu
end

function Map:changeJuStatus()
	self.isJu = not self.isJu
	local fight = md:getInstance("Fight")
	local data = {gunView = not self.isJu }
	fight:dispatchEvent({name = fight.CONTROL_SET_EVENT,comps = data})
end

function Map:playEffect(name)
	if name == "shake" then
		print("function Map:playEffect(name)")
		self:dispatchEvent({name = Map.EFFECT_SHAKE_EVENT})
	else

	end
end

function Map:isNotMoveMap()
	return self.curWaveCfg:isNotMoveMap()
end

return Map