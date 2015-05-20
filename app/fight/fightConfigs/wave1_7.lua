local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
			adviseData = {
			type = "jtl",
			cost  = 120,    --钻石
			gunId = 8,      --武器id8  加特林
		},
------------------------------------------------------------------推荐武器
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0.2,1.3},
				pos = {350,650},
				property = { 
					placeName = "place1" ,
					type = "jin",                  --盾 
					id = 8,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.8},
				pos = {900},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 6,	
				num = 3,
				pos = {250,510,700},
				delay = {0.2,0.8,1.5},
				property = {
					placeName = "place1" ,         --近
					id = 7,
					type = "jin",
				},
			},

			{
				time = 7,
				num = 5,
				delay = {0.1,0.6,1,2.3,1.7},
				pos = {230,330,500,590,690},
				property = { 
					placeName = "place1" ,
					type = "bao",                  --爆
					id = 9,	
					startState = "san",
				},
			},
			{
				time = 9,
				num = 3,
				delay = {0.2,0.7,1.3},
				pos = {500,300,700},
				property = { 
					placeName = "place1" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 11,
				num = 4,
				delay = {0,2,0.8,1.6},
				pos = {220,480,600,700},
				property = { 
					placeName = "place1" ,
					type = "bao",                 --爆
					id = 9,	
					startState = "san",
				},
			},
			{
				time = 13,
				num = 5,
				delay = {0.6,1.5,1.1,0.3,0.8},
				pos = {290,350,460,600,680},
				property = { 
					placeName = "place1" ,
					type = "bao",                    --爆20个
					id = 9,	
				},
			},
			{
				time = 14,	                                               --金武奖励箱子
				num = 1,
				pos = {250},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 19,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
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
				delay = {0.2,0.7,1.3},
				pos = {500,300,700},
				property = { 
					placeName = "place1" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 6,	
				num = 3,
				delay = {0.1,1.5,0.8},
				pos = {325,420,550},
				property = {
					placeName = "place1" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0.1,0.5,1},
				pos = {350,560,700},
				property = { 
					placeName = "place1" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 10,	
				num = 3,
				delay = {0,0.9,1.5},
				pos = {350,410,700},
				property = {
					placeName = "place1" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0.1,0.9,0.7},
				pos = {250,460,600},
				property = { 
					placeName = "place1" ,
					type = "bao",      --爆
					id = 9,	
					startState = "san",
				},
			},
			{
				time = 14,	                                               --金武奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 19,
					award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place2",
				},
			},
			{
				time = 16,
				num = 3,
				delay = {0.1,0.6,1.3},
				pos = {350,650,900},
				property = { 
					placeName = "place2" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			{
				time = 18,
				num = 5,
				delay = {0.7,1.4,3.5, 2.1,2.8},
				pos = {1050,760,630,500,320,},					
				property = {
					placeName = "place1",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 20,
				num = 5,
				delay = {0.7,1.4,3.5, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place1",  
					type = "bao",      --爆
					id = 9,	
					startState = "san",
				},
			},
			
		},
	},
	{
	    waveType = "boss",                                      --强敌出现
		enemys = { 
			{
				descId = "renzb", --简介
				time = 2,	
				num = 1,
				pos = {368},
				delay = {4},
				property = { 
					type = "renzheBoss",
					placeName = "place13",
					missileId = 18, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50)},
					id = 1,
				},
			},
		},
	},
}


--enemy的关卡配置                                                    青铜镶嵌 MP5伤害80  dps大于等于2 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=8,hp=403,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4, weak1=2},

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=8,hp=907,fireRate=180,fireCd=4,speed=40, weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=10,hp=4536,fireRate=180,fireCd=5,speed=40, weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=15,hp=403,fireRate=30,speed=100, weak1=2},	 --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="renzb",demage=30,hp=10000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=3.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage= 5 ,hp= 500 },

	-- 金武箱子奖励  type = "awardSan",
	{id=19,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		award = 20000,
		image = "renzb",                       --图片名字
		hp = 100000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --扔飞镖,按飞镖伤害
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 35,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
			feibiao1 = { 0.95,                --暴雨梨花针1
			},
			feibiao2 = { 0.75,                --暴雨梨花针2	
			},
			feibiao3 = { 0.50,                --暴雨梨花针3
			},						
			zhaohuan = { 0.90, 0.60, 0.30                    --召唤分身
			},                                           
			chongfeng = { 0.99, 0.80, 0.65, 0.55, 0.45, 0.35, 0.15     --冲锋
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
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.95,
			},	
			demage300 = {  
				0.70,
			},	
			demage300 = {  
				0.40,
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

		enemys1 = {                                                   --第一波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0},
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
				pos = {800},
				delay = {0.5},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			
		},	


		enemys2 = {                                                   --第二波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {700},
				delay = {0.5},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {1000},
				delay = {1},
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
				pos = {900},
				delay = {0},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0.5},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {600},
				delay = {1},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 0,	                                               --金武奖励箱子
				num = 1,
				pos = {730},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 19,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place3",
				},
			},
			
		},
	},

}

local mapId = "map_1_2"
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