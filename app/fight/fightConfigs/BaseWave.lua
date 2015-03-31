local BaseWave = class("BaseWave", cc.mvc.ModelBase)

function BaseWave:getWaves(waveIndex)
	waveIndex = tonumber(waveIndex)
	return self.waves[waveIndex] 
end

function BaseWave:getConfigById(id)
	for i,enemy in ipairs(self.enemys) do
		if id == enemy.id then 
			return enemy
		end
	end
	assert(false, "no id in this waveConfig", id)
end

function BaseWave:getEnemys(id)
	id = tonumber(id)
	return self:getConfigById(id)
end

function BaseWave:getBoss(id)
	id = tonumber(id)
	assert(self.bosses[id], "config in wave is nil! id is: "..id)	
	return self.bosses[id] 
end

function BaseWave:getMapId()
	return self.mapId
end

function BaseWave:getIsNotMoveMap()
	return self.isNotMoveMap or false
end

function BaseWave:getRenzhiLimit()
	return self.renzhiLimit
end

function BaseWave:getEnemyNumLimit()
	return self.limit or 10
end

function BaseWave:getFightMode()
	if self.fightMode == nil then 
		self.fightMode = {
			type 	  = "puTong",
		}
	end
	assert(self.fightMode, "self.fightMode is nil")
	return self.fightMode
end

return BaseWave
