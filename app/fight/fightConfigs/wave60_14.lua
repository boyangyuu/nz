local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		adviseData = {
			type = "blt",   --goldJijia
			cost  = 450,    --钻石话费
			gunId = 10,      --武器id10  寒冰巴雷特
		},
------------------------------------------------------------------推荐武器
		enemys = {                                                             
			{
				descId = "boss01_2",--简介   -- 紫炮boss
				time = 2,	
				num = 1,
				pos = {450},
				delay = {4},
				property = { 
					type = "boss",                         
					placeName = "place21",
					missileId = 6,                 --导弹id
					id = 1,
				},
			},
		},
	},
	{
		enemys = {
			{
				time = 2,	                                               --奖励箱子
				num = 1,
				pos = {650},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place9",
				},
			},
			{
				time = 3,	                                               --奖励箱子
				num = 1,
				pos = {450},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place3",
				},
			},
			{
				time = 4,	                                               --奖励箱子
				num = 1,
				pos = {40},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place18",
				},
			},
			{
				time = 5,	                                               --奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place3",
				},
			},
			{
				time = 6,	                                               --奖励箱子
				num = 1,
				pos = {520},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place11",
				},
			},
			{
				time = 7,	                                               --奖励箱子
				num = 1,
				pos = {80},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place12",
				},
			},
			{
				time = 8,	                                               --奖励箱子
				num = 1,
				pos = {40},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place19",
				},
			},
			{
				time = 9,	                                               --奖励箱子
				num = 1,
				pos = {650},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place5",
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {300},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place3",
				},
			},
			{
				time = 11,	                                               --奖励箱子
				num = 1,
				pos = {300},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place9",
				},
			},
		},
	},
-----------------------------------------------------------------------------------------------------------红枪boss  id = 1

}



--enemy的关卡配置                               黄金镶嵌    满级狙击枪10星630伤害   1枪  1500         dps大于等于7
local enemys = {
	

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=42,hp=6000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2},                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=6000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=1,
	weak1=1},	

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=35,hp=6000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=6000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=6, fireCd=8.0,
	weak1=2,    award = 60},

	-- 金武箱子奖励  type = "awardSan",
	{id=20,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=30,hp=1, weak1=1},

	--大黑导弹           type = "missile",
	{id=23,image="daodan02",demage=200,hp=1, weak1=1},



}

local bosses = {
	{
		image = "boss01_2", --图片名字   -- 紫炮boss
		award = 10000,                   --boss产出金币数量
		hp = 70000,
		demage = 5,
		fireRate = 120,                  --0就不普通攻击了
		fireCd = 3,  		
		walkRate = 60,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	
		weak1 = 1.1,					--手  弱点伤害倍数
		weak2 = 1.1,					--腹  弱点伤害倍数
		weak3 = 1.1,					--头  弱点伤害倍数
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 8, 			--一次扫射10下
		skilltrigger = {   			   --技能触发(可以同时)

			-- moveLeftFire = {
			-- 	0.90, 0.60, 0.30, 
			-- },
			-- moveRightFire = {
			-- 	0.75, 0.35,
			-- }, 

			wudi = { 0.90, 0.60, 0.30,                        --无敌
			},                                        

			zhaohuan = { 0.92, 0.91, 0.62, 0.61, 0.32, 0.31,                --召唤 
			},                    

			saoShe = { 0.85, 0.65, 0.45, 0.25 , 0.05,   --调用普通攻击的伤害  扫射
			}, 

			daoDan1 = { 0.99, 0.80, 0.60, 0.40, 0.20,     --大黑导弹
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


			

			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.60,
			},	
			demage300 = {  
				0.30,
			},							
		},
		
		daoDan1 = {
		    id = 23,                                 --boss大黑导弹
			type = "missile", 
			timeOffset = 0.06,                        --导弹间隔时间
            flyTime = 5.0,                           --导弹飞到脸前的时间 
            srcPoses = {
						cc.p(0, 0),
			}, 
			offsetPoses = { 
						cc.p(0, 0),
			},
		},

		enemys1 = {                                                   --第1波召唤兵
			{
				time = 0,	                                               --奖励箱子
				num = 1,
				pos = {650},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place9",
				},
			},
		},
		enemys2 = {                                                   --第2波召唤兵
			{
				time = 0,
				num = 1,
				delay = {0.5},
				pos = {200},
				property = {
					placeName = "place16",  
					startState = "",
					type = "juji",
					id = 4,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,              --回血百分比
					id = 10,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {500},
				delay = {0},                            -- 吉普车
				property = {
					placeName = "place21",
					type = "jipu" ,
					id = 12,
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(0,0),},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					flyTime = 4.0,                           --导弹飞到脸前的时间
					startState = "enterright",          --从右面进来
					lastTime = 60.0,		--持续时间			
				},
			},
		},
		enemys3 = {                                                   --第3波召唤兵
			{
				time = 0,	                                               --奖励箱子
				num = 1,
				pos = {450},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place3",
				},
			},
		},
		enemys4 = {                                                   --第4波召唤兵
			{
				time = 0,
				num = 1,
				delay = {0.5},
				pos = {300},
				property = {
					placeName = "place16",  
					startState = "",
					type = "juji",
					id = 4,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,              --回血百分比
					id = 10,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {500},
				delay = {0},                            -- 吉普车
				property = {
					placeName = "place21",
					type = "jipu" ,
					id = 12,
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(0,0),},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					flyTime = 4.0,                           --导弹飞到脸前的时间
					startState = "enterright",          --从右面进来
					lastTime = 60.0,		--持续时间			
				},
			},
		},
		enemys5 = {                                                   --第5波召唤兵
			{
				time = 0,	                                               --奖励箱子
				num = 1,
				pos = {40},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place18",
				},
			},
		},
		enemys6 = {                                                   --第6波召唤兵
			{
				time = 0,
				num = 1,
				delay = {0.5},
				pos = {80},
				property = {
					placeName = "place16",  
					startState = "",
					type = "juji",
					id = 4,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 1,              --回血百分比
					id = 10,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {500},
				delay = {0},                            -- 吉普车
				property = {
					placeName = "place21",
					type = "jipu" ,
					id = 12,
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(0,0),},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					flyTime = 4.0,                           --导弹飞到脸前的时间
					startState = "enterright",          --从右面进来
					lastTime = 60.0,		--持续时间			
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
--------------------------------------------------------------------------------------------紫炮boss  id = 1




local mapId = "map_1_4"

local limit = 10   				--此关敌人上限

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
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end
return waveClass