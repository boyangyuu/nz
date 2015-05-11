local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {                                                                -- 红枪boss
			{
				descId = "boss01_1", --简介
				time = 2,	
				num = 1,
				pos = {400},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place21",
					missileId = 20,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss         
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



--enemy的关卡配置                               黄金镶嵌    狙击枪7星510伤害   1枪  1150         dps大于等于3
local enemys = {
	

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=18,hp=3000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2},                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=3000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1,
	weak1=1},	

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=12,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2}, 

	-- 金武箱子奖励  type = "awardSan",
	{id=20,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 

	--boss大黑导弹           type = "missile",
	{id=21,image="daodan02",demage=100,hp=1, weak1=1},

}

local bosses = {
	{
		image = "boss01_1", --图片名字
		award = 10000,                   --boss产出金币数量
		hp = 35000,
		demage = 4,
		fireRate = 180,
		fireCd = 4,  		
		walkRate = 60,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射10下
		weak1 = 2,					--手  弱点伤害倍数
		weak2 = 2,					--腹  弱点伤害倍数
		weak3 = 2,					--头  弱点伤害倍数
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

			daoDan1 = { 0.99, 0.80, 0.60, 0.40, 0.20,     --两发导弹
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
		    id = 21,                                 --boss导弹
			type = "missile", 
			timeOffset = 0.1,                        --导弹间隔时间 
            flyTime = 10.0,                           --导弹飞到脸前的时间 
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
				pos = {100},
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
					skillValue = 0.05,              --回血百分比
					id = 10,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0.5,},
				pos = {660,},
				property = {
					placeName = "place11",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
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
					skillValue = 0.05,              --回血百分比
					id = 10,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0.5,},
				pos = {660,},
				property = {
					placeName = "place11",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
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
					skillValue = 0.05,              --回血百分比
					id = 10,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0.5,},
				pos = {660,},
				property = {
					placeName = "place11",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
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
--------------------------------------------------------------------------------------------------boss 红枪  id = 1




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