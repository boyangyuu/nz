local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {600},
				property = {
					type = "jin",
					placeName = "place13",  
					id = 20,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {15},					
				property = {
					placeName = "place7",   
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0},
				pos = {20},					
				property = {
					placeName = "place6",   
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {40},					
				property = {
					placeName = "place5",   
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {20},					
				property = {
					placeName = "place8",   
					id = 5,
					startState = "",
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0},
				pos = {25},					
				property = {
					placeName = "place9",   
					id = 5,
					startState = "",
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0.5,0.7,0.9},
				pos = {125,250,333},					
				property = {
					placeName = "place1",   
					id = 5,
					startState = "",
					type = "dao",
					missileId = 6,
					missileType = "daodan",                      
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0.5},
				pos = {300},					
				property = {
					placeName = "place4",   
					id = 5,
					startState = "",
					type = "dao",
					missileId = 6,
					missileType = "daodan",                      --10个
				},
			},
	
		
		},
	},
	{
		enemys = {
			{
				time = 2,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {10,90,170,250,330,410,490,570,630,710},
				property = {
					type = "jinbi",
					placeName = "place3",  
					speed = 2,                                                    --2*60 / s   每秒移动60像素(右斜)
					id = 13,
				},
			},
			{
				time = 4,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place4",  
					speed = 3,                                                    --左斜
					id = 14,
				},
			},
			{
				time = 12,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place10",  
					speed = 3,                                                    --右斜
					id = 13,
				},
			},
			{
				time = 17,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place4",  
					speed = 3,                                                    --横
					id = 14,
				},
			},
			{
				time = 17.5,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place10",  
					speed = 3,                                                    --左斜
					id = 13,
				},
			},
			{
				time = 10,
				num = 10,
				delay = {0, 1.5, 3.0,5.0,9.0,13.5,15,20,25,28},
				pos = {450,750,650,700,800, 1000,800,350,666,888},                                    
				                                                                          -- 黄气球
				property = {
					type = "jinbi",
					placeName = "place11", 
					speed = 5, 
					id = 15,
				},
			},
			{
				time = 3,
				num = 10,
				delay = {0, 3.0, 6.0,7.0,9.0,16.5,20.0,24,28,30},
				pos = {500,900,650,720,690, 400,800,650,430,740},
				property = {
					type = "jinbi",
					placeName = "place4", 
					speed = 4.5, 
					id = 14,
				},
			},
			                                                                                 -- 背景散飞蓝气球
			{
				time = 11,
				num = 10,
				delay = {1, 3.7, 5.4,7,8.7,9.5,14.2,16,21,26},
				pos = {750,450,600,380,800,550,750,350,870,666},
				property = {
					type = "jinbi",
					placeName = "place10",  
					speed = 3.5,
					id = 13,
				},
			},                                                                                -- 背景散飞绿气球
			{
				time = 18,
				num = 5,
				delay = {1, 4, 7,11,15},
				pos = {400, 500, 350, 300, 550},
				property = {
					type = "jinbi",
					placeName = "place4",  
					speed = 3.5,
					id = 14,
				},
			},
			{
				time = 19,
				num = 5,
				delay = {1, 4, 7,11,15},
				pos = {40, 50, 55, 280, 300},
				property = {
					type = "jinbi",
					placeName = "place11",  
					speed = 3.5,
					id = 13,
				},
			},
			{
				time = 23.5,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place4",  
					speed = 3,                                                    --左斜
					id = 13,
				},
			},
			{
				time = 29,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place10",  
					speed = 3,                                                    --横
					id = 14,
				},
			},
			{
				time = 30,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place4",  
					speed = 3,                                                    --右斜
					id = 13,
				},
			},
			{
				time = 34,
				num = 12,
				delay = {0,0,0,0.7,0.7,0.7,0.7,0.7,1.4,1.4,1.4,2.1},
				pos = {650,750,850,550,650,750,850,950,650,750,850,750},                                    
				                                                                          -- 心形绿气球
				property = {
					type = "jinbi",
					placeName = "place10", 
					speed = 3, 
					id = 13,
				},
			},
			{
				time = 38,
				num = 6,
				delay = {1,1.5,1.8,2.0,2.5,3},
				pos = {780,660,830,550,666,888},                                    
				                                                                          -- 黄气球
				property = {
					type = "jinbi",
					placeName = "place11", 
					speed = 5, 
					id = 15,
				},
			},
			{
				time = 41,
				num = 12,
				delay = {0,0,0,0.7,0.7,0.7,0.7,0.7,1.4,1.4,1.4,2.1},
				pos = {650,750,850,550,650,750,850,950,650,750,850,750},                                    
				                                                                          -- 心形金气球
				property = {
					type = "jinbi",
					placeName = "place10", 
					speed = 3, 
					id = 15,
				},
			},
		},
	},
	{
		enemys = {
			
		},
	},	
	
}




--enemy的关卡配置                                                    黄金mp5满级135难度对应怪物属性
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=16,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=375,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=562,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=20000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=375,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=936,fireRate=180,fireCd=4,speed=40,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=3744,fireRate=180,fireCd=5,speed=35,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=60,hp=562,fireRate=30,speed=100,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=10000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=10000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=20000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=3},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="renzb",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=12500},  
	--盾兵BOSS         --type = "jin",
	{id=20,image="dunbing",demage=18,hp=50000,fireRate=60,fireCd= 3 ,speed= 80, scale = 2.6,
	weak1=3},                           
}

--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "boss01", --图片名字
		hp = 10000,
		demage = 3,
		fireRate = 400,
		walkRate = 200,
		saoFireOffset = 0.4, 		--扫射时间间隔
		saoFireTimes = 10, 			--扫射次数
		demageScale = {weak1 = 2, weak2 = 3, weak3 = 3},	--弱点伤害倍数
		
		skilltrigger = {   			--技能触发(可以同时)
			moveLeftFire = {
				0.95, 0.50,
			},
			moveRightFire = {
				0.85, 0.30,
			},
			daoDan = {
				0.80, 0.70, 0.50, 0.20,
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
		getMoveLeftAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
			local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
			local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
			local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,

		getMoveRightAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
			local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
			local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
			local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,
	},
}

local mapId = "map_1_5"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {26,}   --黄武激活所需杀人个数

end
return waveClass