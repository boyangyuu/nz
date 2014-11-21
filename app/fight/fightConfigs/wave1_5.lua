local waveClass = class("wave1_5", cc.mvc.ModelBase)

local waves = {
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 1,
				place = "place3",
				pos = {250},
				delay = {0.3},
				property = { 
					type = "boss",
					bossId = 1,
				},
			},		
		},
	},	
}

function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

return waveClass