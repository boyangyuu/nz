local BaseWave = class("BaseWave", cc.mvc.ModelBase)

function BaseWave:getWaves(waveIndex)
	return self.waves[waveIndex] 
end

function BaseWave:getEnemys(id)
	assert(self.enemys[id], "config in wave is nil! id is: "..id)
	return self.enemys[id]
end

function BaseWave:getBoss(id)
	assert(self.bosses[id], "config in wave is nil! id is: "..id)
	return self.bosses[id] 
end
return BaseWave
