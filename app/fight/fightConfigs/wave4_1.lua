local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{
		enemys = { 
			{
				time = 1,	
				num = 4,
				pos = {180,250,320,450,},
				delay = {0,1.5,0.8,2,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},

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
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {250},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 1,	
				num = 2,
				pos = {250,350},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 3,	
				num = 3,
				pos = {850,770,700},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},

						-- 以上是第一波第一批 11
			
			{
				time = 5,	
				num = 3,
				pos = {250,350,400},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 3,
				pos = {900,750,600},
				delay = {0,0.6,1.3},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.2,0.9},
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
				time = 9,	
				num = 2,
				pos = {880,950},
				delay = {0,0.6},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},

									-- 以上是第一波第二批 21

			{
				time = 5,	
				num = 3,
				pos = {220,370,300},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
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
				time = 7,
				num = 2,
				delay = {0.2,0.9},
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
				time = 9,	
				num = 3,
				pos = {800,910,980},
				delay = {0,0.6,1.4},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
		                                     	-- 以上是第一波第三批 31
		},
	},	
	{
		enemys = {                                           
		                                                                -- 第二波

			{
				time = 1,
				num = 3,
				delay = {0, 0.6, 1.5},
				pos = {200,270,360,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1.5,
				num = 3,
				delay = {0, 0.8, 1.5},
				pos = {700,810,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 3,
				num = 3,
				delay = {0.2,0.9, 1.6},
				pos = {400,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 1.2,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},

			                                          -- 以上是第二波第一批 10
			{
				time = 6,	
				num = 8,
				pos = {300,350,400,450,550,600,700,850},
				delay = {0,0.7,2.1,1.4,2.8,0.7,1.7,1},
				property = { 
					type = "san",
					id = 4,
					enemyId = 1,
					placeName = "place2",
				},
			},	
			{
				time = 7,	
				num = 2,
				pos = {350,700},
				delay = {0.3,0.9},
				property = { 
					type = "san",
					id = 4,
					enemyId = 1,
					placeName = "place3",
				},
			},
			
                                              -- 以上是第二波第二批 20
			{
				time = 10,
				num = 3,
				delay = {0, 1.6, 0.9},
				pos = {180,250,330,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,
				num = 3,
				delay = {0, 1.3, 0.7},
				pos = {700,830,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 12,
				num = 3,
				delay = {0.2,1.3, 0.9},
				pos = {440,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 13,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
 			                                       -- 以上是第二波第三批    30  

		},

	},
	{
		enemys = { 
			{
				--descId = "yyc", --简介
				time = 2,
				num = 1,
				pos = {200},
				delay = {4},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		--持续时间			
				},
			},
			{
				time = 4,
				num = 2,
				pos = {450,800},
				delay = {0.5,2.0},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place11",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		                                    --持续时间			
				},
			},		
			{
				time = 6,
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
				num = 1,
				delay = {0.5},
				pos = {250},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {250,350},
				delay = {0,1.5,1.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 13,	
				num = 3,
				pos = {830,780,700},
				delay = {0,1.6,0.9},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},

						                                                       -- 以上是第三波第一批 11
			
			{
				time = 15,	
				num = 3,
				pos = {220,360,300},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 18,	
				num = 3,
				pos = {820,750,650},
				delay = {0,1.6,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 23,
				num = 2,
				delay = {0.2,0},
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
				time = 29,	
				num = 2,
				pos = {700,950},
				delay = {0,0.7},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},

									                                             -- 以上是第三波第二批 21

			{
				time = 35,	
				num = 3,
				pos = {190,450,300},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 38,	
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
				time = 37,
				num = 2,
				delay = {0.2,0.9},
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
				time = 39,	
				num = 3,
				pos = {760,910,980},
				delay = {0,1.6,0.8},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
		                                                                            	-- 以上是第三波第三批 31
		},
	},	
	{                                                                                    --第四波
		enemys = { 
			{
				time = 2,
				num = 2,
				pos = {200,550},
				delay = {0.5,4.0},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		--持续时间
					--demageScale = 2                    --伤害翻1.5倍		

				},
			},

			{
				time = 4,
				num = 2,
				pos = {350,700},
				delay = {0.2,3.0},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place11",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		                                    --持续时间			
				},
			},	

			{
				time = 6,
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
					--demageScale = 2                    --伤害翻1.5倍
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0.5},
				pos = {250},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
			        --demageScale = 2                    --伤害翻1.5倍
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {250,450},
				delay = {0,1.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},

			{
				time = 13,	
				num = 3,
				pos = {820,760,550},
				delay = {0,1.6,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},

			-- 			                                                       -- 以上是第四波第一批 11
			
			{
				time = 15,	
				num = 3,
				pos = {250,450,330},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},		
			{
				time = 18,	
				num = 3,
				pos = {850,750,680},
				delay = {0,0.6,1.3},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},
			{
				time = 23,
				num = 2,
				delay = {0.2,0.9},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
					--demageScale = 2                    --伤害翻1.2倍
				},
			},	
			{
				time = 29,	
				num = 2,
				pos = {800,950},
				delay = {0,0.6},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},

			-- 						                                             -- 以上是第四波第二批 21

			{
				time = 35,	
				num = 3,
				pos = {250,350,430},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},		
			{
				time = 38,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},
			{
				time = 37,
				num = 2,
				delay = {0.2,0.9},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
					--demageScale = 2                    --伤害翻1.2倍
				},
			},	
			{
				time = 39,	
				num = 3,
				pos = {700,840,980},
				delay = {0,0.6,1.3},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},
		                                                                            	-- 以上是第四波第三批 31
		},
	},	

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=21,hp=20000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=20000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=28,hp=211,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=633,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=1000,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=30000,fireRate=180,fireCd=4,speed=40,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=100000,fireRate=180,fireCd=5,speed=35,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=20000,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=200000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=200000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=100000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=3},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=50000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=12500},  
	--盾兵BOSS         --type = "jin",
	{id=20,image="dunbing",demage=21,hp=90000,fireRate=60,fireCd= 3 ,speed= 80, scale = 2.6,
	weak1=3},                           
}



local limit = 10   				--此关敌人上限

local mapId = "map_1_2"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.goldLimits = {75,160,250}  --黄武激活所需杀人个数
end

return waveClass
