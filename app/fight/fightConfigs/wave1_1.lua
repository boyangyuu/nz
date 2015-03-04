local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 2,
				delay = {0,0.8},
				pos = {330,400},
				property = { 
					placeName = "place6",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0,0.8},
				pos = {50,135},
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
				num = 3,
				delay ={0, 0.5, 1.2},
				pos = {130,220,280},		
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 2,
				num = 1,
				delay = {0.1},
				pos = {80},
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
				time = 3,
				num = 2,
				delay = {0.3,1},
				pos = {130,200},
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
				delay = {0, 0.6},
				pos = {390,450},
				property = {
					placeName = "place6", 
					startState = "rollleft",
					id = 1,
				},
			},
					
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {60},
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
				time = 3,
				num = 1,
				delay = {0.5},
				pos = {230},
				property = { 
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0.5},
				pos = {40},
				property = { 
					placeName = "place8", 
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0.5},
				pos = {230},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0.5},
				pos = {50},
				property = { 
					placeName = "place3",
					id = 1,
					startState = "rollright",
				},
			},						
			{
				time = 7,
				num = 2,
				delay = {0, 0.3},
				pos = {180,270},
				property = { 
					placeName = "place5", 
					startState = "rollright",
					id = 1,
				},
			},	

		},
	},				
}

--enemy的关卡配置
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=1,hp=160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=3,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=120,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=2,hp=1,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=160,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=160,walkRate=180,walkCd=2,fireRate=180,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=3,hp=1,
	weak1=1},	
}


local mapId = "map_1_7"

local isNotMoveMap = true  		--此关不能移动 

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.isNotMoveMap = isNotMoveMap
	self.goldLimits = {300}   --黄武激活所需杀人个数
end

return waveClass