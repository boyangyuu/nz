local BaseWave = class("BaseWave", cc.mvc.ModelBase)

function BaseWave:getWaves(waveIndex)
	waveIndex = tonumber(waveIndex)
	return self.waves[waveIndex] 
end

function BaseWave:getEnemys(id)
	id = tonumber(id)
	dump(self.enemys, "self..enemys")
	assert(self.enemys[id], "config in wave is nil! id is: "..id)
	return self.enemys[id]
end

function BaseWave:getBoss(id)
	id = tonumber(id)
	assert(self.bosses[id], "config in wave is nil! id is: "..id)
	return self.bosses[id] 
end
return BaseWave
