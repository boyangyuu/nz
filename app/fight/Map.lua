 --[[--

“map”的实体

]]

--includes

local Map = class("Map", cc.mvc.ModelBase)
--events
Map.EFFECT_LEI_BOMB_EVENT = "EFFECT_LEI_BOMB_EVENT"
Map.EFFECT_SHAKE_EVENT 	  = "EFFECT_SHAKE_EVENT"
Map.EFFECT_JUSHAKE_EVENT 	  = "EFFECT_JUSHAKE_EVENT"

Map.MAP_ZOOM_OPEN_EVENT   = "MAP_ZOOM_OPEN_EVENT"
Map.MAP_ZOOM_RESUME_EVENT = "MAP_ZOOM_RESUME_EVENT"
Map.GUN_OPEN_JU_EVENT	  = "GUN_OPEN_JU_EVENT"
Map.GUN_CLOSE_JU_EVENT    = "GUN_CLOSE_JU_EVENT"

function Map:ctor()
    Map.super.ctor(self)
    self.isJuAble = true
    self.isOpenJu_ = false
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

function Map:setIsOpenJu(isOpenJu_)
	self.isOpenJu = isOpenJu_
	if self.isOpenJu then 
		self:dispatchEvent({name = Map.GUN_OPEN_JU_EVENT})	
	else
		self:dispatchEvent({name = Map.GUN_CLOSE_JU_EVENT})
		local fight = md:getInstance("Fight")
		fight:dispatchEvent({name = fight.FIGHT_RESUMEPOS_EVENT})
	end
end

function Map:getIsOpenJu()
	return self.isOpenJu
end

function Map:setIsJuAble(able)
	self.isJuAble = able
end

function Map:getIsJuAble()
	return self.isJuAble
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
	local notmove = self.curWaveCfg:getIsNotMoveMap()
	return notmove
end

function Map:getMapBgNode()
	return self.mapBgNode 
end

function Map:setMapBgNode(mapBgNode)
	self.mapBgNode = mapBgNode
end

return Map