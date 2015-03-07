local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0.3,1.0},
				pos = {300,550},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 5,
				num = 1,
				delay = {0.5},
				pos = {360},
				property = {
					placeName = "place5",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place11",  
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				
				time = 11,
				num = 1,
				delay = {0},
				pos = {50},
				property = {
					placeName = "place10",  
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				
				time = 17,
				num = 2,
				delay = {0.3,1.6},
				pos = {90,280},
				property = {
					placeName = "place16",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 21,
				num = 2,
				delay = {0.6,1.1},
				pos = {300,500},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",                                         --10
				},
			},
			
			
		},
	},

	{
		enemys = {

			{
				time = 3,
				num = 1,
				delay = {4},
				pos = {500},
				property = {
					placeName = "place11",  
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},
			}, 
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {50},
				property = {
					placeName = "place10",  
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 9,
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
				time = 12,
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
				time = 15,
				num = 1,
				delay = {0},
				pos = {666},
				property = {
					placeName = "place5",  
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
					startState = "rollright",
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0},
				pos = {600},
				property = {
					placeName = "place5",  
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 21,
				num = 1,
				delay = {0},
				pos = {95},
				property = {
					placeName = "place3",  
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 24,
				num = 1,
				delay = {0.4},
				pos = {195},
				property = {
					placeName = "place14",  
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},
			}, 
			{
				time = 27,
				num = 1,
				delay = {0.4},
				pos = {80},
				property = {
					placeName = "place12",  
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},
			}, 
			{
				time = 30,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 2,
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
				time = 3,
				num = 1,
				pos = {700},
				delay = {0.5},                         -- 飞机          
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place17",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		                                    --持续时间			
				},
			},
			{
				time = 10,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {100,230,300,450,480},					
				property = {
					placeName = "place11",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 15,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {380,490,570,660,700},					
				property = {
					placeName = "place9",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			
			
		},
	},

}



--enemy的关卡配置                                   普通难度 狙击枪350*1.2伤害          dps大于等于3
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=12,hp=924,walkRate=120,walkCd=2,rollRate=180,rollCd=4,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=924,walkRate=120,walkCd=2,rollRate=180,rollCd=4,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=12,hp=350,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=924,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=1386,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=350,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=936,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=3744,fireRate=180,fireCd=5,speed=35,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=60,hp=562,fireRate=30,speed=100,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=4620, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2.0,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=10000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=1,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=1,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=1,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=20000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=2},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=12500},                             
}





local mapId = "map_1_4"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {75,160,250}   --黄武激活所需杀人个数
end
return waveClass