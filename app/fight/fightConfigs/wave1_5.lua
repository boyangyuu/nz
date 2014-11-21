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
					configName = "BossConfig_1",
					index = 1, 
				},
			},		
		},
	},	
}


--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		animName = "boss1", --图片名字
		hp = 2000,
		demage = 50,
		fireRate = 200,
		walkRate = 200,
		fireOffset = 0.2,
		demageScale = {weak1 = 2, weak2 = 3, weak3 = 3},
		
		skilltrigger = {   --技能触发(可以同时)
			moveLeftFire = {
				0.95, 0.70,
			},
			moveRightFire = {
				0.65, 0.30,
			},
			daoDan = {
				0.90, 0.60, 0.50, 0.40,
			},
			saoShe = {
				0.65, 0.55,
			},
			weak2 = {
				0.70,
			},	
			weak3 = {
				0.30,
			},							
		},
	},

	--第二个boss
	{

	},
}

function waveClass:getWaves(waveIndex)
	return waves[waveIndex] 
end

function waveClass:getBoss(index)
	return bosses[index] 
end

return waveClass