local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {

			{
				descId = "hs", --简介
				time = 2,
				num = 1,
				pos = {600},                               
				delay = {4},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place4",
					startState = "enterleft", 
					lastTime = 7,                       -- 人质离开时间
					                    			     -- 人质
				},
			},
	
            {
				time = 12,	
				num = 4,
				pos = {200,250,300,350,},
				delay = {0,0.5,0.8,1,},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 14,	
				num = 2,
				pos = {300,350},
				delay = {0.5,1},
				property = { 
					placeName = "place1",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 16,
				num = 2,
				delay = {0.2,1},
				pos = {550,800},
				property = { 
					placeName = "place3",
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 18,
				num = 3,
				delay = {0.2,1,1.5},
				pos = {190,230,250},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 20,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 22,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 24,
				num = 3,
				delay = {0.5,1,2.5},
				pos = {190,230,250},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 26,
				num = 1,
				delay = {1},
				pos = {230},
				property = { 
					placeName = "place10",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 28,	
				num = 3,
				pos = {200,300,350,},
				delay = {0,0.5,1,},
				property = { 
					placeName = "place2",
					startState = "rollright",                                          --第一波20个怪
					id = 1,
				},
			},
			
		},
	},
	
	{
		enemys = {

			{
				time = 2,
				num = 2,
				pos = {230,650},                               
				delay = {0.4,1.5},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place10",
					startState = "enterleft", 
					lastTime = 7,                       -- 人质离开时间
					                    			   -- 人质
				},
			},
			{
				time = 2,
				num = 1,
				pos = {500},                               
				delay = {0.5},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place11",
					startState = "enterleft", 
					lastTime = 7,                       -- 人质离开时间
					                    			   -- 人质
				},
			},
 
			
			{
				time = 3,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,350,400,600},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 7,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,400,600,700},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 9,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {300,500,550,600,1000},					
				property = {
					placeName = "place10",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place5",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 17,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place8",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 20,	
				num = 2,
				pos = {180,200},
				delay = {0.5,1},
				property = { 
					placeName = "place11",
					startState = "rollright",                                    
					id = 1,
				},
			},

		},
	},
                                                                                       --第二波20个怪
	{
		enemys = {
 
			{
			    descId = "feiji", --简介
				time = 2,
				num = 1,
				pos = {450},
				delay = {4},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place15",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 20.0,		                                    --持续时间			
				},
			},
			{
				time = 12,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,350,400,600},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 14,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,400,600,700},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 16,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {300,500,550,600,1000},					
				property = {
					placeName = "place10",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 20,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 22,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place5",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 24,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 26,	
				num = 2,
				pos = {180,200},
				delay = {0.5,1},
				property = { 
					placeName = "place11",
					startState = "rollright",                                          --第二波20个怪
					id = 1,
					-- demageScale = 2                    --伤害翻2倍

				},
			},
		},
	},
	{
		enemys = {

			{
				time = 2,
				num = 4,
				pos = {230,550,600,750},                               
				delay = {0.4,0.9,1.5,2},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place10",
					startState = "enterleft", 
					lastTime = 5,                       -- 人质离开时间
					                    			   -- 人质
				},
			},
			{
				time = 2,
				num = 3,
				pos = {300,450,750},                               
				delay = {0.4,0.9,1.4},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place4",
					startState = "enterleft",
					lastTime = 5,                       -- 人质离开时间 
					                    			   -- 人质
				},
			},
			{
				time = 2,
				num = 3,
				pos = {400,460,600},                               
				delay = {0.2,1.5,4},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place11",
					startState = "enterleft", 
					lastTime = 5,                       -- 人质离开时间
					                    			   -- 人质
				},
			},

	    },		
	}
}
--enemy的关卡配置
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=12,hp=327,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=218,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=15,hp=1,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=327,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=436,walkRate=180,walkCd=2,fireRate=180,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=9,hp=545,fireRate=180,fireCd=3,speed=60,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=12,hp=1090,fireRate=180,fireCd=4,speed=40,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=30,hp=436,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 2.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=120,rollCd=2.0, speakRate =60,speakCd = 2.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=8888, walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=180, fireCd=5.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=6000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=180, fireCd=5.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30


	

}

local mapId = "map_1_5"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.renzhiLimit = 1   		--杀死人质上限
	-- self.goldLimits = {3, 50, 90}   --黄武激活所需杀人个数

end

return waveClass