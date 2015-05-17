local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				pos = {450},
				delay = {0},                         -- 飞机
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
				time = 4,	
				num = 3,
				pos = {300,600,900},                                 -- 空投盾兵
				delay = {0,1,0.5},
				property = {
					placeName = "place2",
					type = "jin",
					startState = "san",
					id = 9,
				},
			},
			{
				time = 6,
				num = 1,
				pos = {300,},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
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
				time = 8,
				num = 3,
				delay = {0,0.5,1},
				pos = {100,500,1000},
				property = { 
					placeName = "place1" ,
					id = 4,
					type = "juji",                    --狙击             
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place2" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
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
					id = 9,
				},
			},
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
				time = 3,
				num = 2,
				delay = {0,1},
				pos = {100,1000},
				property = { 
					placeName = "place1" ,
					id = 4,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place2" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 14,
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
				time = 18,
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
				time = 22,
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
					id = 9,
					startState = "san",
				},
			},
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
				time = 3,
				num = 2,
				delay = {0,1},
				pos = {100,1000},
				property = { 
					placeName = "place1" ,
					id = 4,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place2" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 14,
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
				time = 18,
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
				time = 22,
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

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于5  怪物数据
local enemys = {

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=30,hp=25000, rollRate=180,rollCd=3,fireRate= 60, fireCd = 6,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=5000,
	weak1=1},

	--盾兵         --type = "jin",
	{id=9,image="dunbing",demage=25,hp=50000,fireRate=180,fireCd=6,speed=35, scale = 1.9,--scale = 3.0,  近战走到屏幕最近放缩比例
	weak1=2, weak4=3,},

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=20,hp=25000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=100000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=100000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=5000, weak1=1}, 

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=5000, speed=80,
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

		--type 	  = "renZhi",
		--saveNums  = 3,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass