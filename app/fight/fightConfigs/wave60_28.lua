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
				descId = "renzb", --简介鬼眼
				time = 2,	
				num = 1,
				pos = {420},
				delay = {4},
				property = { 
					type = "renzheBoss",
					placeName = "place21",
					missileId = 18, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50)},
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
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1000,
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
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1000,
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
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
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
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					award = "healthBag",                 --医疗包
					value = 1,
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
-----------------------------------------------------------------------------------------------------------

}



--enemy的关卡配置                               黄金镶嵌    10星巴雷特1400伤害   1枪  3220         dps大于等于7
local enemys = {
	


	--鬼眼分身           冲锋伤害  type = "renzhe",
	{id=17,image="renzb",demage=50,hp=30000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},


	--飞镖
	{id=18,image="feibiao",demage=25,hp=1}, 

	-- 金武箱子奖励  type = "awardSan",
	{id=20,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 


}

local bosses = {
	{
		image = "renzb",                       --图片名字                            鬼眼
		award = 50000,                   --boss产出金币数量
		hp = 250000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --
		walkRate = 100,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 120, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 40,                --冲锋造成伤害
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
					                                           
			chongfeng = { 0.95, 0.70, 0.55, 0.45, 0.35, 0.25, 0.15     --冲锋
			},
			zhaohuan =  { 0.90, 0.50, 0.30,                    --召唤分身
			},
			feibiao1 =  { 0.80,                --暴雨梨花针1
			},
			feibiao2 =  { 0.60,                --暴雨梨花针2	
			},
			feibiao3 =  { 0.40,                --暴雨梨花针3
			},
			feibiao4 =  { 0.20,                --暴雨梨花针4
			},

			weak3 = {                               --右腿 技能触发(可以同时)
				0.70,0.40,0.10,                       
			},	
			weak2 = {                               --左腿 技能触发(可以同时)
				0.80,0.60,0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.50,0.30,                       
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
			demage300 = {  
				0.20,
			},			
		},

		feibiao1 = {     --srcPoses= 初始位置       --offsetPoses =偏移                   --暴雨梨花针1
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			},               
		},

		feibiao2 = {
			srcPoses = {
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105), 
						cc.p(-150, 0),  cc.p(-105, 105), cc.p(0, 150), cc.p(105, -105), 
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105),      
			}, 
			offsetPoses = {
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),
			            cc.p(-210, 0), cc.p(-147, 147), cc.p(0, 210), cc.p(147, 147),
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),			
			},               
		},

		feibiao3 = {
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			}, 
		},

		feibiao4 = {
			srcPoses = {
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105), 
						cc.p(-150, 0),  cc.p(-105, 105), cc.p(0, 150), cc.p(105, -105), 
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105),      
			}, 
			offsetPoses = {
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),
			            cc.p(-210, 0), cc.p(-147, 147), cc.p(0, 210), cc.p(147, 147),
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),			
			}, 
		},

		enemys1 = {                                                   --第一波召唤的忍者兵
			{
				time = 0,	
				num = 1,
				pos = {300},
				delay = {0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 0.5,	
				num = 1,
				pos = {450},
				delay = {0.2},
				property = {
					placeName = "place9" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 1,	
				num = 1,
				pos = {650},
				delay = {0.2},
				property = {
					placeName = "place11" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	

		enemys2 = {                                                   --第二波召唤的忍者兵
			{
				time = 1,	
				num = 1,
				pos = {650},
				delay = {0.2},
				property = {
					placeName = "place11" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 1,	
				num = 1,
				pos = {450},
				delay = {0.4},
				property = {
					placeName = "place9" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 1,	
				num = 1,
				pos = {300},
				delay = {0.6},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
		},	

		enemys3 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {180},
				delay = {0.2},
				property = {
					placeName = "place5" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {450},
				delay = {0.4},
				property = {
					placeName = "place9" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {300},
				delay = {0.6},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {650},
				delay = {0.8},
				property = {
					placeName = "place11" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	
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