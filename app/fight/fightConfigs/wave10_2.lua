local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 2,
				num = 1,
				pos = {450},
				delay = {0.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place11",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		                                    --持续时间	
					--demageScale = 1.5          --伤害翻1.5倍		
				},
			},
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
				time = 5,
				num = 3,
				delay = {0,1.5,1},
				pos = {350,660,950},
				property = { 
					placeName = "place1" ,
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",                --导弹
				},
			},
			
			{
				time = 7,	
				num = 10,
				pos = {200,270,330,400,450,550,600,680,850,940},    -- 伞
				delay = {0,0.7,2.1,1.4,2.8,0.7,1.7,1,3,3.5},
				property = {
					placeName = "place2",
					type = "common"
					startState = "san",
					id =  1,
				},
			},
		},
	},	
	{
		enemys = { 
			{
				time = 2,
				num = 1,
				pos = {500},
				delay = {0.1},                            -- 吉普车
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
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {300,900},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
			{
				time = 7,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,
					--demageScale = 1.5                    --伤害翻1.5倍	
				},
			},
			{
				time = 12,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,
					--demageScale = 1.5                    --伤害翻1.5倍	
				},
			},
		},
	},	
	{
		enemys = { 
			{
				time = 2,	
				num = 2,
				pos = {290,750},
				delay = {0.1,0.6},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 6,	
				num = 2,
				pos = {450,900},
				delay = {0.1,1},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {200,500},
				delay = {0.1,1},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 14,	
				num = 2,
				pos = {400,1050},
				delay = {0.1,0.6},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 18,	
				num = 2,
				pos = {250,690},
				delay = {0.1,0.6},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},
	},

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=24,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=28,hp=2000,
	weak1=3},
                                                           
	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=3000,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=24,hp=30000,fireRate=180,fireCd=4,speed=40,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=30,hp=70000,fireRate=180,fireCd=5,speed=40,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=5000,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=1,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=100000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=100000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=200000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=3},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=50000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=3},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=5000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=20000},  

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=20,hp=5000, speed=120,
	weak1=1},
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