
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
				time = 0, 
				num = 1,
				delay = {0},
				pos = {450},
				property = { 
					placeName = "place9",
					type = "bao_tong",
					id = 1,
				},
			},
			{
				time = 0, 
				num = 1,
				delay = {0},
				pos = {500},
				property = { 
					placeName = "place3",
					type = "bao_tong",
					id = 1,
				},
			},--------------------------------- 汽油桶配置 ----------------------
			{ 
				time = 0,
				num = 2,
				delay = {0,0.7,},
				pos = {350,500,},
				property = { 
					type = "taofan_qiu",
					placeName = "place9",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place11",
					id = 4,
					startState = "enterright", --从屏幕右侧进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = 500,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
						{
							pos = -300,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
						{
							pos = -250,  --第一次藏身处 移动 600
							time = 0,   --隐藏时间 3s
						},
					},
					exit = "middle" ,  --消失
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 275,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},	
						{
							pos = 400,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s
						},										
					},									
				},
			},
			{
				time = 13,
				num = 1,
				pos = {500},
				delay = {4},                            -- 吉普车
				property = {
					placeName = "place21",
					type = "jipu" ,
					id = 12,
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(0,0),},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					flyTime = 5.0,                           --导弹飞到脸前的时间
					startState = "enterright",          --从右面进来
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place3",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 200,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
						{
							pos = 350,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
					},
				},
			},
			{ 
				time = 15,
				num = 1,
				delay = {0,},
				pos = {15,},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},

		},
	},
	{
		enemys = { 
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {100},
				property = { 
					placeName = "place5",
					type = "bao_tong",
					id = 1,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {550},
				property = { 
					placeName = "place9",
					type = "bao_tong",
					id = 1,
				},
			},--------------------------------- 汽油桶配置 ----------------------
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 160,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s	
						},	
						{
							pos = 500,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s
						},										
					},									
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place3",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 300,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
						{
							pos = 300,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
					},
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place11",
					id = 4,
					startState = "enterright", --从屏幕右侧进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = 650,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},
						{
							pos = -300,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s
						},
						{
							pos = -350,  --第一次藏身处 移动 600
							time = 0,   --隐藏时间 3s
						},
					},
					exit = "middle" ,  --消失
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place11",
				},
			},
			{
				time = 13,
				num = 1,
				pos = {500},
				delay = {4},                            -- 吉普车
				property = {
					placeName = "place21",
					type = "jipu" ,
					id = 12,
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(0,0),},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					flyTime = 5.0,                           --导弹飞到脸前的时间
					startState = "enterright",          --从右面进来
					lastTime = 60.0,		--持续时间			
				},
			},
			{ 
				time = 15,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {200,400,600},
				property = { 
					type = "taofan_qiu",
					placeName = "place11",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},

		},
	},		
	{
		enemys = {
			{
				time = 0,
				num = 2,
				delay = {0,0},
				pos = {450, 650 },
				property = { 
					placeName = "place9",
					type = "bao_tong",
					id = 1,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {770},
				property = { 
					placeName = "place3",
					type = "bao_tong",
					id = 1,
				},
			},--------------------------------- 汽油桶配置 ----------------------	
		    {
				time = 0,
				num = 1,
				pos = {700},
				delay = {0},                         -- 飞机          
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place17",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},
			{ 
				time = 5,
				num = 2,
				delay = {0,0.7,},
				pos = {350,500,},
				property = { 
					type = "taofan_qiu",
					placeName = "place9",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},
			{ 
				time = 8,
				num = 2,
				delay = {0,0.7,},
				pos = {200,500,},
				property = { 
					type = "taofan_qiu",
					placeName = "place3",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},
			{ 
				time = 10,
				num = 2,
				delay = {0,0.7,},
				pos = {260,500,},
				property = { 
					type = "taofan_qiu",
					placeName = "place11",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},
			{
				time = 13,
				num = 1,
				pos = {500},
				delay = {4},                            -- 吉普车
				property = {
					placeName = "place21",
					type = "jipu" ,
					id = 12,
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(0,0),},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					flyTime = 5.0,                           --导弹飞到脸前的时间
					startState = "enterright",          --从右面进来
					lastTime = 60.0,		--持续时间			
				},
			},
			{ 
				time = 15,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {10,280,640,},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {550},
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
		},
	},

}



--enemy的关卡配置                                  黄金镶嵌    狙击枪9星590伤害   1枪  1350        dps大于等于4
local enemys = {

	--汽油桶         --type = "bao_tong",
	{id=1,image="qyt_01",demage=2000,hp=1,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=16,hp=1350,
	weak1=3, weak4=4},


	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=6750, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=6750,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=6, fireCd=8.0,
	weak1=2,    award = 60},

	--导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=16,hp=1,
	weak1=1},

	--箱子奖励  type = "awardSan",
	{id=20,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=16,hp=1, weak1=1},


}





local mapId = "map_1_4"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		type 	  = "taoFan",
		limitNums = 5,                      --逃跑逃犯数量
	}
end
return waveClass