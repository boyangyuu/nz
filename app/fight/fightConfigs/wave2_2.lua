
local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
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
			},------------------------------------------------------------ 汽油桶配置 ----------------------
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
							time = 4,   --隐藏时间 3s	
						},
						{
							pos = 300,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s	
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
							time = 4,   --隐藏时间 3s	
						},
						{
							pos = -300,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s
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
							time = 4,	 --隐藏时间 3s													
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
			},------------------------------------------------------------ 汽油桶配置 ----------------------
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
							time = 4,	 --隐藏时间 3s													
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
							time = 4,   --隐藏时间 3s	
						},
						{
							pos = -300,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s	
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
							time = 4,   --隐藏时间 3s	
						},	
						{
							pos = 400,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s
						},										
					},									
				},
			},
			{
				time = 11,	                                               --金武奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 19,
					award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place5",
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
							time = 4,   --隐藏时间 3s	
						},
						{
							pos = 350,  --第一次藏身处 移动 600
							time = 4,   --隐藏时间 3s	
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
							time = 4,	 --隐藏时间 3s													
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
			},------------------------------------------------------------ 汽油桶配置 ----------------------
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
					lastTime = 5.0,		                                    --持续时间			
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
							time = 4,	 --隐藏时间 3s													
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
							time = 4,	 --隐藏时间 3s													
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
							time = 4,	 --隐藏时间 3s													
						},					
					},
				},
			},

			{ 
				time = 15,
				num = 2,
				delay = {0.7,1.4},
				pos = {280,640,},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 0,  --第一次藏身处 移动 -200 
							time = 4,	 --隐藏时间 3s													
						},					
					},
				},
			},
			
		},
	},

}



--enemy的关卡配置                                   雷明顿3星基础伤害390伤害 青铜难度1枪  550         dps大于等于5
local enemys = {

	--汽油桶         --type = "bao_tong",
	{id=1,image="qyt_01",demage=2000,hp=1,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=5,hp=350,
	weak1=4, weak4=4},


	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=1500, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=60, fireCd=4.0,
	weak1=2.0,    award = 60},

	--导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=5,hp=1,
	weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=19,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励


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
		limitNums = 10,                      --逃跑逃犯数量
	}
end
return waveClass