local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 

			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0.5,1.6},
				pos = {250,560},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 4,	
				num = 2,
				pos = {250,450},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0.5},
				pos = {200},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向左逃跑
						{
							pos = 300,  --
							time = 3,	 --隐藏时间 3s													
						},	
						{
							pos = 300,  --
							time = 4,	 --隐藏时间 4s													
						},											
					},		
				},
			},
			{
				time = 11,	
				num = 3,
				pos = {730,800,920},
				delay = {0,0.5,0.8},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 3,
				pos = {250,430,510},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 12,	
				num = 3,
				pos = {600,710,900},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 12,
				num = 2,
				delay = {0.5,1.0},
				pos = {250,400},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 13,	
				num = 2,
				pos = {800,950},
				delay = {0,0.6},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 14,	
				num = 3,
				pos = {250,330,410},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 15,	
				num = 3,
				pos = {1000,750,550},
				delay = {0,0.6,1.1},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 16,
				num = 2,
				delay = {0.5,0},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 17,	
				num = 3,
				pos = {820,910,980},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},                                                                            	-- 以上是第三波第三批 30
		},
	},
	{
		enemys = { 
			{
				time = 1,	
				num = 4,
				pos = {200,350,400,550,},
				delay = {0,0.5,0.8,1,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {600,800},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{ 
				time = 1,
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
						{
							pos = -200,  --第一次藏身处 移动 -200 
							time = 3,	 --隐藏时间 3s													
						},	
						{
							pos = -600,  --第2次藏身处 移动 - 600
							time = 4,	 --隐藏时间 4s																							
						},					
					},
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0.5},
				pos = {335},
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
					data = {
							direct = "right",
								{
								pos = 800,  --第一次藏身处 移动 200
								time = 2,   --隐藏时间 3s	
						},						
					},									
				},
			},

			{
				time = 3,	
				num = 3,
				pos = {250,350,500},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 4,	
				num = 3,
				pos = {980,850,650},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {250,370,480},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 6,	
				num = 3,
				pos = {1030,930,790},
				delay = {0,0.6,1.6},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0.5},
				pos = {335},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterright", --从屏幕左侧进入
					data = {
							direct = "left", --向右逃跑
								{
								pos = 400,  --第一次藏身处 移动 600
								time = 2,   --隐藏时间 3s	
							},						
						},	
					data = {
							direct = "left",
								{
								pos = 700,  --第一次藏身处 移动 200
								time = 2,   --隐藏时间 3s	
						},						
					},									
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.5,0},
				pos = {350,600},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 8,	
				num = 2,
				pos = {1000,850},
				delay = {0,0.6},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {250,350,480},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 9,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 9,
				num = 2,
				delay = {0.5,0},
				pos = {250,600},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 9,	
				num = 1,
				pos = {980},
				delay = {0,},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},                                  	-- 以上是第一波第三批 30
		},
	},	
	{
		enemys = {                                           
		                                                                -- 第二波
			{
				time = 1,
				num = 3,
				delay = {0, 0.6, 1.4},
				pos = {290,380,450,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 2,
				num = 3,
				delay = {0, 0.7, 1.4},
				pos = {750,850,1000},	
				property = { 
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 3,
				num = 3,
				delay = {0,0.7, 1.4},
				pos = {450,550,650},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},	
			{
				time = 4,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},                                         -- 以上是第二波第一批 10
			{
				time = 8,	
				num = 3,
				pos = {350,550,750},
				delay = {0,0.5,1.0},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place4",
				},
			},                                 
			{
				time = 8,
				num = 3,
				delay = {0, 0.6, 1.4},
				pos = {260,340,430,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 9,
				num = 3,
				delay = {0, 1.4, 0.7},
				pos = {770,850,970},	
				property = { 
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 2,
				delay = {0.2,1.0},
				pos = {550,700},					
				property = {
					placeName = "place3",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 8,
				pos = {300,350,400,450,550,600,700,850},
				delay = {3.5,3,2.5,2,1.5,1,0.5,0},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place2",
				},
			},	                                       -- 以上是第二波第三批    30
		},
	},
	
}

--enemy的关卡配置                                        青铜镶嵌 MP5伤害80  dps大于等于2 怪物数据
local enemys = {
	--普通兵        type = "common",                           140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage= 4,hp=403,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1= 2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=403,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1= 2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=21,hp=5000, weak1=1},

                                                          
	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=8888,walkRate=60,walkCd=1,fireRate=120,fireCd=2,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=150,
	weak1=1},	



}



local mapId = "map_1_2"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		type 	  = "taoFan",
		limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass