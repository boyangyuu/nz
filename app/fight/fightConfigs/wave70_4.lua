local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{ 
				time = 1,
				num = 1,
				delay = {0,},
				pos = {600},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "",  --从右进入                          伞落下的逃犯
					data = {
						direct = "left", --向左逃跑
						{
							pos = -200,  --第一次藏身处 移动 -400 
							time = 2,	 --隐藏时间 2s													
						},					
					},
				},
			},
			{
				time = 1.5,
				num = 2,
				delay = {0,0.2},
				pos = {100,175},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {100,175},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},					
		},
	},
	{
		enemys = {
			{
				time = 1,
				num = 2,
				delay ={0,0.5},
				pos = {130,280},		
				property = { 
					placeName = "place8",
					startState = "rollleft",
					id = 1,
				},
			},	
			{ 
				time = 1.5,
				num = 1,
				delay = {0,},
				pos = {0},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "",  --从左进入                          伞落下的逃犯
					data = {
						direct = "right", --向右逃跑
						{
							pos = 400,  --第一次藏身处 移动 -200 
							time = 2,	 --隐藏时间 3s													
						},					
					},
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0.3,0.5},
				pos = {200,300},
				property = { 
					placeName = "place6", 
					startState = "rollright",
					id = 1,
				},
			},						
		},
	},	
	{
		enemys = {
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {200},
				property = {
					type = "taofan_qiu", 
					placeName = "place3",
					id = 4,
					startState = "", --从屏幕左侧进入
					data = {
						direct = "left", --向右逃跑
						{
							pos = -100,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s	
						},										
					},									
				},
			},
			{
				time = 1.5,
				num = 2,
				delay = {0, 0.3},
				pos = {200,400},
				property = {
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},
					
			{
				time = 2,
				num = 2,
				delay = {0,0.3},
				pos = {60,120},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {100},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 100,  --第一次藏身处 移动 600
							time = 3,   --隐藏时间 3s	
						},	
						{
							pos = 600,  --第一次藏身处 移动 600
							time = 3,   --隐藏时间 3s
						},										
					},									
				},
			},

			-- {
			-- 	time = 2.5,
			-- 	num = 1,
			-- 	delay = {0.5},
			-- 	pos = {40},
			-- 	property = { 
			-- 		placeName = "place8", 
			-- 		id = 2,
			-- 		startState = "",
			-- 		type = "dao",
			-- 		missileId = 3,
			-- 		missileType = "lei",
			-- 	},
			-- },						
			{
				time = 2.5,
				num = 2,
				delay = {0, 0.3},
				pos = {170,430},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},
		},
	},				
}

--enemy的关卡配置                         无镶嵌 mp5伤害55  dps大于等于1 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=4,hp=330,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=270,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=4,hp=1,
	weak1=1},
	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=4,hp=550,
	weak1=4, weak4=4},
}


local mapId = "map_1_7"

local isNotMoveMap = true  		--此关不能移动 

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = 10
	-- self.isNotMoveMap = isNotMoveMap

	self.fightMode =  {
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		 type 	  = "taoFan",
		 limitNums = 3,                      --逃跑逃犯数量
	}
	
end

return waveClass