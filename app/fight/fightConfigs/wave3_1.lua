local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "xiaorz", --简介
				time = 3,	
				num = 1,
				pos = {600},
				delay = {4},
				property = {
					placeName = "place2" ,
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
				time = 2.5,	
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
				time = 3,	
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
				time = 4.5,	
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
				time = 5,	
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
				time = 5.5,	
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
				time = 6,	
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
				time = 6.5,	
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
			{
				time = 7,	
				num = 1,
				pos = {420},
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


--enemy的关卡配置                                                     黄金镶嵌M4A1满级1枪伤害621  dps大于等于6  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=21,hp=7000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=7000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=28,hp=621,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=7000,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=8000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=1000,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=21000,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=70000,fireRate=180,fireCd=5,speed=35,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=8000,fireRate=30,speed=120,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=1,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=70000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=70000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=2,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=2,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=2,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=100000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=2},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=7000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=12500},  
	--盾兵BOSS         --type = "jin",
	{id=20,image="dunbing",demage=21,hp=90000,fireRate=60,fireCd= 3 ,speed= 80, scale = 2.6,
	weak1=2},                           
}



local limit = 10   				--此关敌人上限

local mapId = "map_1_2"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
end

return waveClass
