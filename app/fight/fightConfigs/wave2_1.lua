local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

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
				time = 3,
				num = 1,
				delay = {0.5},
				pos = {650},
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
				num = 3,
				pos = {720,800,980},
				delay = {0,0.6,1},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
		                                     	-- 以上是第一波第三批 32
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
					type = "san",
					id = 4,
					enemyId = 1,
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
					type = "san",
					id = 4,
					enemyId = 1,
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
				num = 3,
				delay = {0.2,1.0, 1.6},
				pos = {350,550,700},					
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
					type = "san",
					id = 4,
					enemyId = 1,
					placeName = "place2",
				},
			},		
 			                                       -- 以上是第二波第三批    31  
		},

	},
	{
		enemys = { 
			{
				descId = "zpbing",               --简介
				time = 3,
				num = 1,
				delay = {4},
				pos = {370},
				property = {
					placeName = "place13",  
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 8,
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
				time = 8,
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
				time = 9,	
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
				time = 9,	
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
				time = 10,	
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
				time = 11,	
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
			},
		                                                                            	-- 以上是第三波第三批 30
		},
	},	
	-- {                                                                                    --第四波
	-- 	enemys = { 
	-- 		{
	-- 			time = 2,
	-- 			num = 1,
	-- 			delay = {0.5},
	-- 			pos = {800},
	-- 			property = { 
	-- 				placeName = "place1",
	-- 				id = 2,
	-- 				startState = "rollleft",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 				--demageScale = 2                    --伤害翻1.5倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 3,
	-- 			num = 1,
	-- 			delay = {0.5},
	-- 			pos = {250},
	-- 			property = { 
	-- 				placeName = "place2",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 4,	
	-- 			num = 2,
	-- 			pos = {250,450},
	-- 			delay = {0,0.8},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 5,	
	-- 			num = 3,
	-- 			pos = {910,750,650},
	-- 			delay = {0,0.5,1},
	-- 			property = { 
	-- 				placeName = "place4",
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 6,	
	-- 			num = 3,
	-- 			pos = {250,350,440},
	-- 			delay = {0,0.5,1},
	-- 			property = { 
	-- 				placeName = "place1",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 7,	
	-- 			num = 3,
	-- 			pos = {800,750,650},
	-- 			delay = {0,0.6,1},
	-- 			property = {
	-- 				placeName = "place4", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 8,
	-- 			num = 2,
	-- 			delay = {0.5,0},
	-- 			pos = {250,900},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 9,	
	-- 			num = 2,
	-- 			pos = {780,950},
	-- 			delay = {0,0.6},
	-- 			property = {
	-- 				placeName = "place2", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 10,	
	-- 			num = 3,
	-- 			pos = {250,350,430},
	-- 			delay = {0,0.5,1},
	-- 			property = { 
	-- 				placeName = "place1",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 				-- demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 11,	
	-- 			num = 2,
	-- 			pos = {1000,750},
	-- 			delay = {0,0.5},
	-- 			property = {
	-- 				placeName = "place4", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				-- demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 12,
	-- 			num = 2,
	-- 			delay = {0.5,0},
	-- 			pos = {250,900},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 				-- demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 13,	
	-- 			num = 3,
	-- 			pos = {520,810,980},
	-- 			delay = {0,0.5,1},
	-- 			property = {
	-- 				placeName = "place2", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				-- demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 	                                                                            	-- 以上是第四波第三批 31
	-- 	},
	-- },	

	
}

--enemy的关卡配置                                        青铜镶嵌 MP5伤害80  dps大于等于2 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage= 4,hp=403,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1= 2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=403,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1= 2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=403,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=8888,walkRate=60,walkCd=1,fireRate=60,fireCd=2,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=150,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=3,hp=806,fireRate=120,fireCd=3,speed=60,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=4,hp=4030,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=10,hp=403,fireRate=30,speed=120,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=12000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=12000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},



}



local mapId = "map_1_2"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {1000}   --黄武激活所需杀人个数
end

return waveClass