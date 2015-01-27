local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 4,
				pos = {0,50,150,250},
				delay = {0,2,4,6},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 4,	
				num = 4,
				pos = {0,100,200,300},
				delay = {0,2,4,6},
				property = { 
					placeName = "place2",
					id = 4,
					type = "dao",
					missileId = 5,
					missileType = "lei",
				},
			},		
			{
				time = 5,	
				num = 4,
				pos = {0,200,400,300},
				delay = {1,2,3,4},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},	

		},
	},	
	{
		enemys = {
			{
				time = 3,
				num = 3,
				delay = {0,2,4},
				pos = {0,300,150},
				property = {
					placeName = "place4",
					type = "jin",
					id = 2,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0,2, 4},
				pos = {0,250,400},	
				property = { 
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 5,
				num = 3,
				delay = {0,2,4},
				pos = {0,200,100},					
				property = {
					placeName = "place6",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 8,	
				num = 3,
				pos = {0,100, 300},
				delay = {0,2, 4},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place1",
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {0,100, 250},
				delay = {0,2,4},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place2",
				},
			},	
			{
				time = 10,	
				num = 5,
				pos = {0,50,150,250,100},
				delay = {0,1,2,3,4},
				property = { 
					placeName = "place6",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 5,
				pos = {0,50,150,250,100},
				delay = {0,1,2,3,4},
				property = { 
					placeName = "place2",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 5,
				pos = {0,50,150,250,100},
				delay = {0,1,2,3,4},
				property = { 
					placeName = "place4",
					id = 1,
				},
			},
		},


	},
	
}

--enemy的关卡配置
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=4,hp=195,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=195,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=5,hp=1,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=260,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=260,walkRate=180,walkCd=2,fireRate=300,fireCd=6,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=12,hp=85,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=6,hp=365,fireRate=180,fireCd=5,speed=60,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=5,hp=1000,fireRate=240,fireCd=5,speed=30,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=30,hp=365,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=8888, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=6000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=30, fireCd=4.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30

	--boss召唤第一波自爆兵        --type = "bao",
	{id=16,image="zibaob",demage=10,hp=65,fireRate=30,speed=120,
	weak1=3},
	--boss召唤第二波自爆兵        --type = "bao",	
	{id=17,image="zibaob",demage=30,hp=195,fireRate=30,speed=120,
	weak1=3},	

}



local mapId = "map_1_2"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	-- self.goldLimits = {3, 50, 90}   --黄武激活所需杀人个数
end

return waveClass