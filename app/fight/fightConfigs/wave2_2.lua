local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 

		
			{
				time = 3,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 3,	
				num = 5,
				pos = {325,420,510,770,900},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 3,
				num = 3,
				delay = {2.0,2.5,3},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},			
			{
				time = 15,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 15,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 15,
				num = 3,
				delay = {2.8,2.5,3},
				pos = {200,380,560},
				property = { 
					placeName = "place2" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			{
				time = 20,
				num = 5,
				delay = {0.8,1.5,2.1,2.6,3},
				pos = {50,120,250,410,510},
				property = { 
					placeName = "place2" ,
					type = "dao",      --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 22,
				num = 2,
				delay = {0.8,1.5},
				pos = {50,120},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollright",	
				},                                                          
			},	
			{
				time = 22,
				num = 1,
				delay = {0.8},
				pos = {550},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollleft",	
				},                                                          --30
			},	

		},
	},

	{
		enemys = {

		    {
				time = 3,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 3,	
				num = 5,
				pos = {325,420,510,770,900},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 3,
				num = 3,
				delay = {2.0,2.5,3},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},

			{
			    
				time = 7,
				num = 1,
				pos = {450},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		                                    --持续时间			
				},
			},	
			{
				time = 15,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 15,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 15,
				num = 3,
				delay = {2.8,2.5,3},
				pos = {200,380,560},
				property = { 
					placeName = "place2" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			{
			    
				time = 20,
				num = 1,
				pos = {550},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 23.0,		                                    --持续时间			
				},
			},	
			{
			    
				time = 22,
				num = 1,
				pos = {850},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 20.0,		                                    --持续时间			
				},
			},	
			{
				time = 21,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place4",  
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
				time = 3,
				num = 5,
				delay = {0.1,0.2,0.3,0.2,0.1},
				pos = {330,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 3,	
				num = 5,
				pos = {325,420,510,770,900},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 3,
				num = 5,
				delay = {2.0,2.5,3,2.5,2.0},
				pos = {380,680,960,720,888},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾 15
					id = 8,
				},
			},

			
			{
				time = 22,
				num = 10,
				delay = {0.1,0.2,0.3,0.4,0.5,0.60,0.4,0.3,0.2,0.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},

			{
				time = 25,
				num = 1,
				delay = {1.6},
				pos = {670},
				property = { 
					placeName = "place11" ,
					type = "jin",                  --近boss 15                                
					id = 16,
				},
			},
			{
				time = 26,
				num = 4,
				delay = {0.8,1.5,2.6,3},
				pos = {50,120,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",      --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 28,
				num = 2,
				delay = {0.8,1.5},
				pos = {50,120},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollright",	
				},                                                          
			},	
			{
				time = 28,
				num = 3,
				delay = {0.8,1.2,1.6},
				pos = {490,560,590},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollleft",	
				},                                                          --90
			},	
			
			
		},
	},	
	
}




--enemy的关卡配置                                                    白银难度对应怪物属性
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=16,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=375,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=375,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=562,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=562,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=375,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=936,fireRate=180,fireCd=4,speed=60,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=3744,fireRate=180,fireCd=5,speed=30,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=60,hp=562,fireRate=30,speed=120,
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
	{id=16,image="jinzhanb",demage=120,hp=20000,fireRate=60,fireCd=2,speed=40,scale = 3.0,
	weak1=3},                                                               --scale = 3.0,  近战走到屏幕最近放缩比例


}



local mapId = "map_1_6"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {300}   --黄武激活所需杀人个数
end
return waveClass