local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 3,
				delay = {0,0.5,1},
				pos = {500,490,530},
				property = { 
					placeName = "place12",
					startState = "rollleft",
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
				delay ={0, 0.5,0.9},
				pos = {30,90,180},		
				property = { 
					placeName = "place13",
					startState = "rollright",
					id = 1,
				},
			},	
			{
				time = 1,
				num = 1,
				delay = {0.1},
				pos = {45},
				property = { 
					placeName = "place8",
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
		enemys = {
			{
				time = 2,
				num = 2,
				delay = {0, 0.3},
				pos = {450,400},
				property = {
					placeName = "place11", 
					startState = "rollleft",
					id = 1,
				},
			},
					
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {60},
				property = { 
					placeName = "place8", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1,
				num = 2,
				delay = {0,0.5},
				pos = {20,30},
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.5},
				pos = {150},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},						
			{
				time = 4,
				num = 2,
				delay = {0, 0.3},
				pos = {450,400},
				property = { 
					placeName = "place12", 
					startState = "rollleft",
					id = 1,
				},
			},	

		},
	},				
}

--enemy的关卡配置
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=2,hp=160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=120,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=3,hp=1,
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


local mapId = "map_1_1"

--local isNotMoveMap = true  		--此关不能移动 

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