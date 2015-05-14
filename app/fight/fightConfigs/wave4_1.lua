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
				time = 6,
				num = 1,
				pos = {350,},
				delay = {0,},                          -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},	
			{
				time = 7,	
				num = 10,
				pos = {200,270,330,400,450,550,600,680,850,940},    -- 伞
				delay = {0,0.7,2.1,1.4,2.8,0.7,1.7,1,3,3.5},
				property = {
					placeName = "place2",
					type = "common",
					startState = "san",
					id = 1,
				},
			},

		},
	},	
	{
		enemys = { 

			{
				time = 2,
				num = 1,
				pos = {450,},
				delay = {0,},                          -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 4,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 8,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,	
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
				time = 5,	
				num = 1,
				pos = {750},
				delay = {0.1},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 7,	
				num = 1,
				pos = {450},
				delay = {0.1},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 8,
				num = 1,
				pos = {550,},
				delay = {0,},                          -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 9,	
				num = 1,
				pos = {200},
				delay = {0.1},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 11,	
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
				time = 13,	
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


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于5  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=20,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2, weak4=3},
                                                        
	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=5000,
	weak1=1},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=70000,fireRate=180,fireCd=5,speed=35, scale = 2.0,
	weak1=2},                                                        --scale = 3.0,  近战走到屏幕最近放缩比例

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=100000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=60, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=100000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=5000, weak1=1},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=20,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=3.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=5000}, 

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=5000, speed=100,
	weak1=1},
}



local limit = 10   				--此关敌人上限

local mapId = "map_1_2"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass