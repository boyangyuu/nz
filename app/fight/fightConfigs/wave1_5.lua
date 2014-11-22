local waveClass = class("wave1_5", cc.mvc.ModelBase)
local waves = {
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 5,
				place = "place1",
				pos = {10,110,210,310,410},
				delay = {0,0.3,0.6,0.5,0.8},
				property = { 
					id = "1",
				},
			},
						{
				time = 4,	
				num = 3,
				place = "place3",
				pos = {100,200,300},
				delay = {0,0,0},
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},		
			{
				time = 5,	
				num = 3,
				place = "place2",
				pos = {200,100,300},
				delay = {0.3,0.3,0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 1,
				place = "place4",
				pos = {25},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				place = "place5",
				pos = {40},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				place = "place6",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 10,	
				num = 1,
				place = "place7",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 13,	
				num = 1,
				place = "place8",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 13,	
				num = 1,
				place = "place9",
				pos = {30},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
			{
				time = 16,	
				num = 1,
				place = "place10",
				pos = {10},
				delay = {0.3},
				property = { 
					id = 1,
				},
			},		
		
		},
	},
	{
		enemys = {
			{
				time = 2,
				num = 5,
				place = "place1",
				delay = {0.3, 0.6},
				pos = {10, 200, 50, 100, 90},
				property = { 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 3,
				num = 5,
				place = "place2",
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 200, 50, 100, 90},	
				property = { 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 2,
				num = 5,
				place = "place2",
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},					
				property = { 
					id = 1,
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 10,
				num = 5,
				place = "place1",
				delay = {0.3, 0.6, 0.9, 1.2, 1.5},
				pos = {10, 20, 50, 100, 60},
				property = { 
					startState = "rollright",
					id = 1,
				},
			},					
		},
	},		
}
waves = {
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
		fireRate = 200,			--开火速度
		walkRate = 200, 		--移动速度
		fireOffset = 0.3,		--开火间隔
		demageScale = {weak1 = 2.0, weak2 = 3.0, weak3 = 3.0}, --伤害倍率
		
		skilltrigger = {   --技能触发(可以同时)
			ksMove = {		--快速移动 全屏导弹
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