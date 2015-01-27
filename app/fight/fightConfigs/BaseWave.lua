local BaseWave = class("BaseWave", cc.mvc.ModelBase)

function BaseWave:getWaves(waveIndex)
	waveIndex = tonumber(waveIndex)
	return self.waves[waveIndex] 
end

function BaseWave:getEnemys(id)
	id = tonumber(id)
	-- dump(self.enemys, "self.enemys")
	assert(self.enemys[id], "config in wave is nil! id is: "..id)
	-- dump(self.enemys[id], "self.enemys[id]")
	return self.enemys[id]
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

function BaseWave:getGoldLimit(goldIndex)
	if self.goldLimits == nil then 
		return 100000
	else
		return self.goldLimits[goldIndex] or 100000
	end
end

return BaseWave
