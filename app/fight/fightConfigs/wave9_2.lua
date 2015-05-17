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
		waveType = "boss",                                      --强敌出现
		enemys = { 
			{
				descId = "dzboss_1", --简介                  -- 毒刺boss
				time = 2,	
				num = 1,
				pos = {400},
				delay = {4},
				property = { 
					type = "duozuBoss",
					placeName = "place13",
					wangId    = 27,     --网ID
					missileId = 22,     --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(150, -150)},
					id = 1,
				},
			},	
		},
	},
	{
		waveType = "boss",                                      --强敌出现
		enemys = { 
			{
				descId = "dzboss", --简介                -- 多足蜘蛛boss
				time = 2,	 
				num = 1,
				pos = {400},
				delay = {4},
				property = { 
					type = "duozuBoss",
					placeName = "place13",
					wangId    = 27,    --网ID
					missileId = 22,     --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(150, -150)},
					id = 2,
				},
			},		
		},
	},

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于5  怪物数据
local enemys = {

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=30,hp=80000, rollRate=180,rollCd=3,fireRate= 60, fireCd = 6,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=10000,
	weak1=1},

	--盾兵         --type = "jin",
	{id=9,image="dunbing",demage=25,hp=100000,fireRate=180,fireCd=6,speed=35, scale = 1.9,--scale = 3.0,  近战走到屏幕最近放缩比例
	weak1=2, weak4=3,},

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=20,hp=80000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=200000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=200000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=10000, weak1=1}, 

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=8000, speed=80,
	weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 

	--BOSS导弹          type = "missile",
	{id=22,image="daodan",demage=25,hp=10000, weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=23,image="daodan03",demage=25,hp=10000, weak1=1},           --打击者金武平均伤害5558

	--大黑导弹           type = "missile",
	{id=24,image="daodan02",demage=100,hp=20000, weak1=1},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=15,hp=80000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--蜘蛛网
	{id=27,image="zzw",demage=15,hp=20000},

}

	--boss的关卡配置
local bosses = {
	{
		image = "dzboss_1", --图片名字                                                             --毒刺boss
		award = 50000,                   --boss产出金币数量
		hp = 300000,
		fireRate = 120,                  --普攻频率
		fireCd = 5,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)

			wudi = { 0.90, 0.70, 0.50, 0.30, 0.10,
			}, 

			zhaohuan = { 0.91, 0.71, 0.51, 0.31,                   --召唤小兵
			},   

			daoDan1 = {                                            --2发烟雾导弹
				0.99, 0.80, 0.60, 0.40, 0.20, 0.05,
			},

			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage200 = {
				0.60,
			},
			demage300 = {
				0.40,
			},			
		},

		daoDan1 = {
		    id = 23,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 1.0,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            	cc.p(150, 150), cc.p(170, -190), cc.p(-150, -50),
        	},
        },


		enemys1 = {                                                   --第1波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
		},	
		enemys2 = {                                                   --第2波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 2 ,                   --伤害翻1.5倍	
				},
			},
	    },	
		enemys3 = {                                                   --第3波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 3  ,                  --伤害翻2倍	
				},
			},
		},
		enemys4 = {                                                   --第4波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 3  ,                  --伤害翻2倍	
				},
			},
		},

	},
---------------------------------------------------------------------------------------------------第1个出场的boss 毒刺  id = 1
	{
		image = "dzboss", --图片名字                                                             多足boss巨炮泰坦
		award = 50000,                   --boss产出金币数量
		hp = 300000,
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
			wudi = { 0.90, 0.70, 0.50, 0.30, 0.10,
			}, 

			zhaohuan = { 0.91, 0.71, 0.51, 0.31, 0.11,                  --召唤小兵
			},   

			daoDan1 = {                                            --两发导弹
				0.95, 0.85, 0.75, 0.65, 0.55, 0.45, 0.35, 0.25, 0.15,
			},

			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage300 = {
				0.60,
			},
			demage400 = {
				0.40,
			},			
		},


		daoDan1 = {
		    id = 24,                                  --大黑导弹
			type = "missile",  
			timeOffset = 0.5,                        --导弹间隔时间                 
			offsetPoses = {                           --目标偏移点
            	cc.p(-150, -100), cc.p(150, -100),
        	},
        },


		enemys1 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 23,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place3" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
				delay = {0,},
				property = {
					placeName = "place2" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},	

		enemys2 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 23,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place3" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
				delay = {0,},
				property = {
					placeName = "place2" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys3 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 23,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place3" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
				delay = {0,},
				property = {
					placeName = "place2" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys4 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 23,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place3" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
				delay = {0,},
				property = {
					placeName = "place2" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys5 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place8",
					missileId = 23,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place3" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
				delay = {0,},
				property = {
					placeName = "place2" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},												
	},
---------------------------------------------------------------------------------------------------第9个出场的boss 多足   id = 9

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