local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{	
		enemys = {                                                               
			{
				descId = "dzboss", --简介
				time = 4,	
				num = 1,
				pos = {500},
				delay = {6},
				property = { 
					type = "duozuBoss",                                              -- 多足boss巨炮泰坦
					placeName = "place1",
					--wangId    = 27,    --网ID
					missileId = 20,    --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(150, -150) ,},
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
				pos = {450},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 2.5,	                                               --奖励箱子
				num = 1,
				pos = {1050},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place5",
				},
			},
			{
				time = 3,	                                               --奖励箱子
				num = 1,
				pos = {800},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 10,
					placeName = "place6",
				},
			},
			{
				time = 3.5,	                                               --奖励箱子
				num = 1,
				pos = {300},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
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
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 50,
					placeName = "place5",
				},
			},
			{
				time = 4.5,	                                               --奖励箱子
				num = 1,
				pos = {680},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 50,
					placeName = "place6",
				},
			},
			{
				time = 5,	                                               --奖励箱子
				num = 1,
				pos = {1060},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 50,
					placeName = "place5",
				},
			},
			{
				time = 5.5,	                                               --奖励箱子
				num = 1,
				pos = {750},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 50,
					placeName = "place6",
				},
			},
			{
				time = 6,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 40,
					placeName = "place3",
				},
			},
			{
				time = 6.5,	                                               --奖励箱子
				num = 1,
				pos = {950},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place6",
				},
			},
		},
	},

}


--enemy的关卡配置                                                    青铜镶嵌 m4a1满级  dps大于等于6  怪物数据
local enemys = {


	--BOSS导弹          type = "missile",
	{id=20,image="daodan",demage=20,hp=40, weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=20,hp=60, weak1=1},           --打击者金武平均伤害5558


	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=30,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=120,fireCd=4,
	weak1=2},


	

}

	--boss的关卡配置
local bosses = {

	{
		image = "dzboss", --图片名字                                                             多足boss巨炮泰坦
		award = 200,                   --boss产出金币数量
		hp = 100000,
		fireRate = 180,                  --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)

			-- wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15        --网
			-- },
			wudi = { 0.90, 0.70, 0.30,
			}, 

			zhaohuan = { 0.91, 0.71, 0.31,                  --召唤小兵
			},   

			daoDan1 = {                                                   --烟雾导弹
				0.99, 0.80, 0.60, 0.40,
			},


			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage130 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage160 = {
				0.70,
			},
			demage200 = {
				0.30,
			},			
		},


		daoDan1 = {
		    id = 22,                                  --烟雾导弹
			type = "dao_wu",  
			timeOffset = 3.0,                        --导弹间隔时间                 
			offsetPoses = {                           --目标偏移点
            	cc.p( -250, -200),cc.p( 200, -250), cc.p( 200, 200),
        	},
        },


		enemys1 = {                                                   --第1波召唤蜘蛛兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
		},

		enemys2 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {800,},
				property = { 
					placeName = "place6" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
		},

		enemys3 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
		},
												
	},

}

local mapId = "map_1_6"
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
	self.reliveCosts = {20,}
end
return waveClass