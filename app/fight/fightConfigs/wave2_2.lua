local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 2,	
				num = 5,
				pos = {420,510,700,900,1050},
				delay = {0.5,2,0,0.5,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 6,
				num = 3,
				delay = {0.1,0.5,1.2},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0,1.1,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},			
			{
				time = 14,
				num = 3,
				delay = {0.1,0.6,1},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",                 --爆
					id = 9,	
				},
			},
			{
				time = 18,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.1,0.6,1.5,1.8,0.8},
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 19,
				num = 3,
				delay = {0,1.0,1.5},
				pos = {250,410,510},
				property = { 
					placeName = "place2" ,
					type = "dao",      --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 20,
				num = 3,
				delay = {0,0.5,1},
				pos = {300,370,440},
				property = { 
					placeName = "place3" ,
					id = 1,
					startState = "rollright",	
				},                                                          
			},	
			{
				time = 21,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {700,900,1100},
				property = { 
					placeName = "place4" ,
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 21,
				num = 2,
				delay = {0,0.6},
				pos = {380,560},
				property = { 
					placeName = "place4" ,
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},

	{
		enemys = {
		    
			{
				time = 2,	
				num = 5,
				pos = {420,560,700,880,990},
				delay = {1.4,0.6,0,1,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 6,
				num = 3,
				delay = {0.5,0,1.3},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0.5,0,1.2},
				pos = {300,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},		
			{
				time = 14,
				num = 3,
				delay = {0.1,0.9,1.7},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 18,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.2,0.9,1.8,2.5,3.3},
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 22,
				num = 3,
				delay = {0.2,1.0,1.8},
				pos = {200,380,560},
				property = { 
					placeName = "place2" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			{
				time = 27,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},                                                                            --60
			},	
			{
				time = 29,
				num = 4,
				delay = {0,0.7,1.4,1.8},
				pos = {600,500,400,300},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},                                                                            --60
			},	
		},
	},

	{
		enemys = {
		    {   
		    	descId = "feiji", --简介
				time = 3,
				num = 1,
				pos = {670},
				delay = {3},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},
			{
				time = 8,
				num = 4,
				delay = {0.5,1,0,1.5},
				pos = {480,680,850,1050},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 12,	
				num = 5,
				pos = {355,420,510,770,900},
				delay = {0,0.9,0.5,0.6,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 16,
				num = 5,
				delay = {0.1,0.9,1.7,2.5,3.1},
				pos = {350,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 17,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 19,
				num = 3,
				delay = {0.5,1.5,1},
				pos = {220,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 20,
				num = 2,
				delay = {0.5,1},
				pos = {250,320},
				property = { 
					placeName = "place3" ,
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},                                                          
			},	
			{
				time = 20,
				num = 2,
				delay = {0.5,1},
				pos = {980,1100},
				property = { 
					placeName = "place4" ,
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},                                                          
			},
			{
				time = 22,
				num = 3,
				delay = {0.5,1,0},
				pos = {450,560,690},
				property = { 
					placeName = "place4" ,
					id = 1,
					startState = "rollright",	
				},                                                          --90
			},
			-- {
			-- 	descId = "yyc", --简介
			-- 	time = 2,
			-- 	num = 1,
			-- 	pos = {200},
			-- 	delay = {4},                            -- 吉普车
			-- 	property = {
			-- 		type = "jipu" ,
			-- 		id = 12,
			-- 		placeName = "place12",
			-- 		missileId = 6,
			-- 		missileType = "daodan",
			-- 		missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
			-- 		startState = "enterleft",
			-- 		lastTime = 30.0,		--持续时间			
			-- 	},
			-- },	
			
			
		},
	},	
	
}




--enemy的关卡配置                                                    青铜镶嵌 MP5伤害85  dps大于等于2 远程2近战3 怪物数据 
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=8,hp=428,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=428,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=428,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=571,walkRate=120,walkCd=2,fireRate=240,fireCd=4,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=12,hp=150,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵  近战兵到身前的比例
	{id=7,image="jinzhanb",demage=9,hp=857,fireRate=180,fireCd=3,speed=60,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=9,hp=4284,fireRate=180,fireCd=3,speed=40, scale = 1.8,--盾兵到身前的比例
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=15,hp=571,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=12800, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=3.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=12800,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=8,hp=20000,fireRate=180,fireCd=3,speed=40,scale = 3.0,
	weak1=3},                                                               --scale = 3.0,  近战走到屏幕最近放缩比例


}



local mapId = "map_1_6"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {1000}   --黄武激活所需杀人个数
end
return waveClass