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
				pos = {200},                               
				delay = {0},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place6",
					startState = "enterleft", 
					lastTime = 5,                       -- 人质离开时间
					                    			     -- 人质
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
				pos = {150},
				property = {
					renzhiName = "人质4",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 5,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {150},
				property = {
					renzhiName = "人质4",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 6,
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

--enemy的关卡配置                         无镶嵌 mp5伤害55  dps大于等于1 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=1,hp=220,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=3,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=2,hp=1,
	weak1=1},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=5,image="tufeib",demage=4,hp=160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=6,image="hs", hp=1000, weak1=1},

	--女人质         type = "renzhi",                                             speakRate =120,speakCd = 2.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=1000,walkRate=120,walkCd = 1.0,rollRate=120,rollCd=2.0, speakRate =60,speakCd = 2.0,
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
		-- type 	  = "puTong",

		 type 	  = "renZhi",
		 saveNums  = 2,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
	
end

return waveClass