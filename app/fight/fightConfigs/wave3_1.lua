local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "xiaorz", --简介
				time = 2,	
				num = 1,
				pos = {300},
				delay = {4},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 6,	
				num = 1,
				pos = {800},
				delay = {0},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},
	},
	{
		enemys = {
			{
				time = 2,	
				num = 1,
				pos = {900},
				delay = {0.1},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 3,	
				num = 1,
				pos = {250},
				delay = {0.1},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 4,	
				num = 1,
				pos = {600},
				delay = {0.1},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 5,	
				num = 1,
				pos = {400},
				delay = {0.1},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
		},
	},
	{
		enemys = {
			{
				time = 2,
				num = 3,
				delay = {0,1,0.5},
				pos = {300,600,900},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
			{
				time = 4,	
				num = 1,
				pos = {900},
				delay = {0.1},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 6,	
				num = 1,
				pos = {250},
				delay = {0.1},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 8,	
				num = 1,
				pos = {600},
				delay = {0.1},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 10,	
				num = 1,
				pos = {400},
				delay = {0.1},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 12,	
				num = 1,
				pos = {690},
				delay = {0.1},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 14,	
				num = 1,
				pos = {230},
				delay = {0.1},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
	
		},
	},
		
}


--enemy的关卡配置                                                     M4A1 5级白银镶嵌   1枪伤害621  dps大于等于2  怪物数据
local enemys = {

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=10,hp=10000,fireRate=180,fireCd=5,speed=35, weak1=2},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=8,hp=7000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=4.0, 
	shanRate = 120, shanCd = 4, chongRate = 180, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=8,hp=600},
                           
}



local limit = 10   				--此关敌人上限

local mapId = "map_1_2"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass
