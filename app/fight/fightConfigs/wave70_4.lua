local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
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
			{
				time = 4,
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
				time = 6,
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
				descId = "dunbing",
				time = 2,	
				num = 1,
				pos = {140},
				delay = {4},
				property = { 
					placeName = "place1",
					type = "jin", 
					id = 8,
				},
			},
			{
				time = 8,
				num = 2,
				delay = {0,0.2},
				pos = {100,175},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0,0.5},
				pos = {100,175},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},					
			{
				time = 12,
				num = 2,
				delay ={0,0.5},
				pos = {20,120},		
				property = { 
					placeName = "place8",
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 14,
				num = 2,
				delay = {0,0.2},
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
		},						
	},	
		{
					--体验枪
		--gunData = 
		--	{ 
		--	    id = 8,    --枪id
		--	    delay = 5, --6s之后出现
		--    },	
		enemys = {	
			{
				time = 2,	
				num = 2,
				pos = {60,200},
				delay = {0.5,0.8},
				property = { 
					placeName = "place1",
					type = "jin", 
					id = 8,
				},
			},
						{
				time = 8,
				num = 2,
				delay = {0,0.2},
				pos = {100,175},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0,0.5},
				pos = {175,390},
				property = { 
					placeName = "place6",
					startState = "rollleft",
					id = 1,
				},
			},						
			{
				time = 12,
				num = 2,
				delay = {0,0.2},
				pos = {40,140},
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
				time = 14,
				num = 2,
				delay ={0,0.5},
				pos = {100,700},		
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {40},
				property = { 
					placeName = "place8",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},
}

--enemy的关卡配置                         无镶嵌 mp5伤害55  dps大于等于1 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=4,hp=600,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=480,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=4,hp=160,
	weak1=1},

	-- 盾兵
	{id=8,image="dunbing",demage=10,hp=6600,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=3,award=1500},

	-- 金武箱子奖励  type = "awardSan",
	{id=31,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}



local mapId = "map_1_7"
local limit = 10

local isNotMoveMap = true  		--此关不能移动 

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = 10
	-- self.isNotMoveMap = isNotMoveMap

	self.fightMode =  {
		 type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan",
		-- limitNums = 14,                      --逃跑逃犯数量
	}
	
end

return waveClass