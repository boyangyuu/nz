local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				descId = "qiufan",               --简介
				time = 2,
				num = 1,
				delay = {4},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
							{
							pos = 500,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},											
					},									
				},
			},
	
			-- {
			-- 	time = 10,
			-- 	num = 1,
			-- 	delay = {0.5},
			-- 	pos = {0},
			-- 	property = {
			-- 		type = "taofan_qiu", 
			-- 		placeName = "place5",
			-- 		id = 4,
			-- 		startState = "enterright", --从屏幕左侧进入
			-- 		data = {
			-- 			direct = "left", --向右逃跑
			-- 			{
			-- 				pos = 700,  --第一次藏身处 移动 600
			-- 				time = 2,   --隐藏时间 3s	
			-- 			},																
			-- 		},									
			-- 	},
			-- },
			{
				time = 10,
				num = 5,
				delay = {0,0.7,1.4,2.1,2.8},
				pos = {0,0,0,0,0},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
																						
					},									
				},
			},
			{
				time = 20,
				num = 5,
				delay = {0,0.7,1.4,2.1,2.8},
				pos = {0,0,0,0,0},
				property = {
					type = "taofan_qiu", 
					placeName = "place3",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
																						
					},									
				},
			},
			-- {
			-- 	time = 11,	                                               --金武奖励箱子
			-- 	num = 1,
			-- 	pos = {900},
			-- 	delay = {0},
			-- 	property = { 
			-- 		type = "awardSan",
			-- 		id = 19,
			-- 		award = "goldWeapon",     --黄金武器
			-- 		--award = "coin",                        --金币
			-- 		--award = "shouLei",        --手雷
			-- 		--award = "healthBag",                 --医疗包
			-- 		value = 1,
			-- 		placeName = "place2",
			-- 	},
			-- },		
			{
				time = 23,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
																		
					},									
				},
			},
                
		},
	},
	{
		enemys = { 
			{ 
				time = 3,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {400,600,800},
				property = { 
					type = "taofan_qiu",
					placeName = "place3",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "left", --向左逃跑
											
					},
				},
			},

			{
				time = 8,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑						
					},									
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterright", --从屏幕左侧进入
					data = {
						direct = "left", --向右逃跑
																	
					},									
				},
			},
                               
		},
	},	
	{
		enemys = { 
			{
				time = 3,
				num = 2,
				delay = {0.5,1.5},
				pos = {0,0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入  逃犯
					data = {
						direct = "right", --向右逃跑
												
					},									
				},
			},	
			{ 
				time = 12,
				num = 2,
				pos = {450,850},
				delay = {2,0},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向左逃跑
											
					},
				},
			},
			{ 
				time = 12,
				num = 2,
				pos = {350,600,},
				delay = {3,1,},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "left", --向右逃跑
											
					},
				},
			},

		},
	},
	
}

--enemy的关卡配置                                        青铜镶嵌 MP5伤害80  dps大于等于2 怪物数据
local enemys = {


	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=5,hp=255, weak1=2, weak4= 4,},

	-- 金武箱子奖励  type = "awardSan",
	{id=19,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

}



local mapId = "map_1_2"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "taoFan",
		limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass