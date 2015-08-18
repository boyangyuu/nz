local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					placeName = "place6",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0.5},
				pos = {135},
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
				delay ={0, 0.5},
				pos = {130,280},		
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 1.5,
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
				time = 2,
				num = 1,
				delay = {0.3},
				pos = {200},
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
				pos = {200,400},
				property = {
					placeName = "place6", 
					startState = "rollleft",
					id = 1,
				},
			},
					
			{
				time = 1.5,
				num = 1,
				delay = {0},
				pos = {60},
				property = { 
					placeName = "place3",
					id = 2,
					level = 1,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {175},
				property = { 
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},					
			{
				time = 3,
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

--enemy的关卡配置                        mp5  0级 伤害55  青铜头盔恢复2 怪物dps大于等于2 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=6,hp=165,walkCd=2,rollCd=3,fireCd=3,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=165,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1,
	weak1=1},

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