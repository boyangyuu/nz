local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "zibaob",
				time = 2,
				num = 3,
				delay = {4.3,4.6,4.9,},
				pos = {220,460,700},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{ 
				time = 8,
				num = 2,
				delay = {0,0.4,},
				pos = {220,800},
				property = { 
					placeName = "place4",
					id = 1,
					startState = "rollleft",  												
				},
			},
			{ 
				time = 10,
				num = 3,
				delay = {0,0.5,0.7},
				pos = {380,500,700},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",													
				},
			},
	        { 
				time = 12,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {400,550,770},
				property = { 
					placeName = "place5",
					id = 1,
					startState = "san",  --从伞进入												
				},
			}, 
			{ 
				time = 14,
				num = 2,
				delay = {0,0.5},
				pos = {500,650},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",													
				},
			},
			{
				time = 16,
				num = 4,
				delay = {0,0.3,0.6,0.9},
				pos = {260,460,670,830},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{ 
				time = 18,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {270,470,660},
				property = { 
					placeName = "place3",
					id = 1,
					startState = "rollleft",  												
				},
			},
			{ 
				time = 20,
				num = 2,
				delay = {0,0.5},
				pos = {350,770},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",													
				},
			},
			{
				time = 22,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {260,420,580,740,900},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},                           	
		},                                                              --21个
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

	{
		enemys = {                            --第三波
			{
				time = 1,--奖励箱子
				num = 2,
				pos = {220,660},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 1,--奖励箱子
				num = 3,
				pos = {380,550,780},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 2,--奖励箱子
				num = 2,
				pos = {600,800},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 2,--奖励箱子
				num = 3,
				pos = {220,500,700},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place5",
				},
			},
			{
				time = 3,--奖励箱子
				num = 2,
				pos = {330,600},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "shouLei",                      --手雷
					value = 1,
					placeName = "place1",
				},
			},
			{
				time = 3,--奖励箱子
				num = 3,
				pos = {440,550,750},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 4,--奖励箱子
				num = 2,
				pos = {660,820},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 4,--奖励箱子
				num =3,
				pos = {330,480,720},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 5,--奖励箱子
				num = 2,
				pos = {400,500},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 5,--奖励箱子
				num = 3,
				pos = {300,580,760},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 6,--奖励箱子
				num = 2,
				pos = {200,360},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 6,--奖励箱子
				num = 3,
				pos = {270,540,670},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 7,--奖励箱子
				num = 2,
				pos = {320,800},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "healthBag",                        --医药包
					value = 1,
					placeName = "place1",
				},
			},
			{
				time = 8,--奖励箱子
				num = 3,
				pos = {440,570,720},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 9,--奖励箱子
				num = 2,
				pos = {200,370,660},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 9,--奖励箱子
				num = 3,
				pos = {470,590,780},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 10,--奖励箱子
				num = 2,
				pos = {250,410},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 10,--奖励箱子
				num = 3,
				pos = {340,490,640},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 11,--奖励箱子
				num = 2,
				pos = {530,760},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 20,
					placeName = "place1",
				},
			},
						{
				time = 11,--奖励箱子
				num = 3,
				pos = {220,500,700},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place5",
				},
			},
			{
				time = 12,--奖励箱子
				num = 2,
				pos = {330,600},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                      --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 12,--奖励箱子
				num = 3,
				pos = {440,550,750},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
						{
				time = 13,--奖励箱子
				num = 2,
				pos = {200,360},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 13,--奖励箱子
				num = 3,
				pos = {270,540,670},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 14,--奖励箱子
				num = 2,
				pos = {320,800},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 14,--奖励箱子
				num = 3,
				pos = {440,570,720},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 15,--奖励箱子
				num = 2,
				pos = {220,660},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 15,--奖励箱子
				num = 3,
				pos = {380,550,780},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 16,--奖励箱子
				num = 2,
				pos = {600,800},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 16,--奖励箱子
				num = 3,
				pos = {220,500,700},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place5",
				},
			},
						{
				time = 17,--奖励箱子
				num = 2,
				pos = {200,370,660},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 17,--奖励箱子
				num = 3,
				pos = {470,590,780},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place1",
				},
			},
			{
				time = 18,--奖励箱子
				num = 2,
				pos = {250,410},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 18,--奖励箱子
				num = 3,
				pos = {340,490,640},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 19,--奖励箱子
				num = 2,
				pos = {530,760},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 20,
					placeName = "place1",
				},
			},
			{
				time = 19,--奖励箱子
				num = 3,
				pos = {220,500,700},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 21,
					award = "coin",                        --金币
					value = 50,
					placeName = "place5",
				},
			},																											
		},
	},	
}

--enemy的关卡配置                           mp5 55  dps大于等于4 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=1100,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=820,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷
	{id=3,image="shoulei",demage=10,hp=410,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=24,hp=770,fireRate=30,speed=70,
	weak1=3},

	-- 盾兵
	{id=8,image="dunbing",demage=10,hp=11000,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=3},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="renzb",demage=30,hp=9900,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=3.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

		--飞镖
	{id=18,image="feibiao",demage= 15 ,hp= 410 },		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=160, weak1=1},	--金武箱子奖励
}


	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		award = 3000,
		image = "renzb",                       --图片名字
		hp = 80000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --扔飞镖,按飞镖伤害
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 50,                --冲锋造成伤害
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
					id = 21,
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
	self.limit  = limit
	self.fightMode =  {
		 type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		--type 	  = "xianShi",
		--limitTime = 70,                   --限时模式时长
		-- limitTime = 10, 
		 --type 	  = "taoFan",
		 --limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass