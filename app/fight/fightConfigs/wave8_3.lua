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
			{
				time = 11,	                                               --奖励箱子
				num = 1,
				pos = {300},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place3",
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
			{
				time = 11,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place3",
				},
			},
		},
	},	
	{
		waveType = "boss",                                      --强敌出现
		enemys = { 
			{
				descId = "boss01",  --简介
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place8",
					missileId = 22,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss         
				},
			},
			
		},
	},

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于5  怪物数据
local enemys = {

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=30,hp=40000, rollRate=180,rollCd=3,fireRate= 60, fireCd = 6,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=6000,
	weak1=1},

	--盾兵         --type = "jin",
	{id=9,image="dunbing",demage=25,hp=70000,fireRate=180,fireCd=6,speed=35, scale = 1.9,--scale = 3.0,  近战走到屏幕最近放缩比例
	weak1=2, weak4=3,},

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=20,hp=50000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=150000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=150000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=5000, weak1=1}, 

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=6000, speed=80,
	weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 

	--BOSS导弹          type = "missile",
	{id=22,image="daodan",demage=25,hp=6000, weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=23,image="daodan03",demage=25,hp=6000, weak1=1},           --打击者金武平均伤害5558

	--大黑导弹           type = "missile",
	{id=24,image="daodan02",demage=100,hp=10000, weak1=1},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=15,hp=50000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

}

	--boss的关卡配置
local bosses = {
	{
		image = "boss01", --图片名字          盾牌boss
		award = 50000,                   --boss产出金币数量
		hp = 250000,
		demage = 4,
		fireRate = 60,                  --0就不普通攻击了
		fireCd = 3,  		
		walkRate = 120,
		walkCd = 2,         --移动cd	
		wudiTime = 6 , 	
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射10下
		weak1 = 1.1,					--手  弱点伤害倍数
		weak2 = 1.1,					--腹  弱点伤害倍数
		weak3 = 1.1,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)


                                    
			wudi = {0.91,0.71,0.51,0.31,0.11                         --无敌
			},                                        

			saoShe = { 0.85, 0.70, 0.50, 0.30 , 0.10   --调用普通攻击的伤害  扫射
			}, 

			zhaohuan = {0.95, 0.65, 0.35},                           --召唤 

			moveLeftFire = {
				0.90, 0.60, 0.30, 
			},

			daoDan1 = {                                            --烟雾导弹
				0.99, 0.80, 0.75, 0.64, 0.55, 0.45, 0.34, 0.22, 0.15
			},


			weak1 = {
				0.70,0.50,0.10
			},	
			weak2 = {
				0.80,0.60,0.30
			},	
			weak3 = {
				0.90,0.40,0.20
			},

			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.70,
			},	
			demage400 = {  
				0.40,
			},							
		},
		
		daoDan1 = {
		    id = 23,                                 --烟雾导弹
			type = "dao_wu",
			timeOffset = 0.1,                        --导弹间隔时间 
            flyTime = 5.0,                           --导弹飞到脸前的时间 
            srcPoses = {
						cc.p(-75, -150), cc.p(0, 0), cc.p(75,-150),
			}, 
			offsetPoses = { 
						cc.p(-150, -300), cc.p(0, 0), cc.p(150,-300),
			},
		},


		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 0,	
				num = 2,
				pos = {350,950},
				delay = {0,0.5},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,              --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place2" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,              --回血百分比
					id = 26,
				},
			},
		},
		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 0,	
				num = 3,
				pos = {300,900,1100},
				delay = {1,0,0.7,},
				property = {
					placeName = "place3" ,
					id = 4,
					type = "juji",
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,              --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {800,},
				property = { 
					placeName = "place2" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,              --回血百分比
					id = 26,
				},
			},
		},
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 0,	
				num = 4,
				pos = {200,400,800,1000},
				delay = {1.4,0,0.7,0.3},
				property = {
					placeName = "place2" ,
					id = 4,
					type = "juji",
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,              --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {1000,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,              --回血百分比
					id = 26,
				},
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