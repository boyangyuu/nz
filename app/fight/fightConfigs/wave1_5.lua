local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{
		enemys = { 
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {20},
				property = {
					placeName = "place20",  
					startState = "",
					id = 1,
				},
			},
		},
	},
	{
		enemys = { 
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {360},
				property = {
					placeName = "place5",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place11",  
					startState = "",
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {400},
				property = {
					placeName = "place3",  
					startState = "rollright",
					id = 1,	
				},
			},	
		},
	},
	{
		enemys = {
			
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {50},
				property = {
					placeName = "place10",  
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {116},
				property = {
					placeName = "place6",  
					startState = "",
					id = 1,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {100},
				property = {
					placeName = "place2",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {666},
				property = {
					placeName = "place5",  
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
					startState = "rollleft",
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {760},
				property = {
					placeName = "place5",  
					id = 1,
					startState = "rollleft",
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0},
				pos = {570},
				property = {
					placeName = "place3",  
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 19,
				num = 1,
				delay = {0},
				pos = {650},
				property = {
					placeName = "place9",  
					id = 1,
					startState = "rollleft",
				},
			},
			{
				time = 20,
				num = 1,
				delay = {0},
				pos = {50},
				property = {
					placeName = "place5",  
					id = 1,
					startState = "rollright",
				},
			},
		},
	}, 
	-- {
	-- 	enemys = {
	-- 		{
	-- 			descId = "zpbing",               --简介
	-- 			time = 3,
	-- 			num = 1,
	-- 			delay = {4},
	-- 			pos = {500},
	-- 			property = {
	-- 				placeName = "place11",  
	-- 				type = "dao",
	-- 				id = 2,
	-- 				missileId = 3,
	-- 				missileType = "daodan",
	-- 			},
	-- 		},
	-- 	},
	-- },

}
--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=220,walkRate=180,walkCd=1,rollRate=240,rollCd=1,fireRate=240,fireCd=4,
	weak1=3},

	--导弹兵
	{id=2,image="zpbing",demage=0,hp=1150,walkRate=120,walkCd=2.0,fireRate=180,fireCd=4,
	weak1=3},		

	--导弹
	{id=3,image="daodan",demage=8,hp=1,
	weak1=3},

	--手雷兵
	{id=4,image="shouleib",demage=0,hp=220,walkRate=180,walkCd=2,rollRate=360,rollCd=5,fireRate=420,fireCd=5,
	weak1=3},	
	--手雷
	{id=5,image="shoulei",demage=4,hp=1,
	weak1=3,},	
}
local mapId = "map_1_4"



local limit = 10    				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass