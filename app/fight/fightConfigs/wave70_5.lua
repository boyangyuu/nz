local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {

			{
				time = 2,	
				num = 2,
				pos = {230,400},
				delay = {0,0.5},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},
			--{
			--	time = 5,
			--	num = 1,
			--	delay = {0.2},
			--	pos = {250},
			--	property = { 
			--		placeName = "place1",
			--		id = 6,
			--		startState = "rollright",
			--		type = "dao",
			--		missileId = 7,
			--		missileType = "lei",
			--	},
			--},
			{
				time = 4,
				num = 2,
				delay = {0,0.5},
				pos = {320,480},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 6,	
				num = 2,
				pos = {900,670},
				delay = {0,0.8},
				property = { 
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,
				num = 3,
				pos = {580,690,800},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place2",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			-- {
			-- 	time = 10,	
			-- 	num = 2,
			-- 	pos = {270,370},
			-- 	delay = {0.2,1},
			-- 	property = { 
			-- 		placeName = "place3",
			-- 		startState = "rollright",
			-- 		id = 1,
			-- 	},
			-- },
	                                     	
		},                                                              --21个
	},	
	{   	    
		enemys = {
			{
				time = 1,	
				num = 1,
				pos = {500},
				delay = {0},
				property = { 
					placeName = "place2",
					type = "jin", 
					id = 11,
				},
			},
			{
				time = 3,	
				num = 3,
				pos = {260,350,500},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft", 
					id = 1,
				},
			},
			{
				time = 5,
				num = 3,
				pos = {220,330,440},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place4",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},                                          
			{
				time = 6,	
				num = 2,
				pos = {520,680},
				delay = {0,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {220,440,660},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {480,600,720},
				delay = {0.5,1.0,1.2},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				num = 1,
				time = 10,--奖励箱子
				pos = {250},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place3",
				},
			},	

                                       --第二波25个                                  	
		},
	},	
	{
		enemys = {                            --第三波

			{
				time = 1,
				num = 2,
				delay = {0,0.5},
				pos = {300,600},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 11,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0.1,0.4,0.7},
				pos = {270,400,700},					
				property = {
					placeName = "place2",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0.1,0.6},
				pos = {300,600},					
				property = {
					placeName = "place3",  
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 7,
				num = 3,
				delay = {0.2,0.7,1.5},
				pos = {220,360,550},
				property = {
					placeName = "place1",
					startState = "rollleft",
					id = 6,
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{                                                       
				time = 9,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {420,600,760},
				property = {
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 11,
				num = 2,
				delay = {0.2,1},
				pos = {230,450},
				property = {
					placeName = "place2",
					type = "jin", 
					id = 11,
				},
			},
			{                                                       
				time = 12,
				num = 3,
				delay = {0.2,0.6,1.2},
				pos = {420,580,740},
				property = {
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 14,
				num = 3,
				delay = {0.2,0.6,1.0},
				pos = {220,360,480},
				property = {
					placeName = "place2",
					startState = "rollleft",
					id = 6,
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{                                                       
				time = 15,
				num = 2,
				delay = {0,0.6},
				pos = {420,680},
				property = {
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 16,
				num = 3,
				delay = {0.6,1.2,1.6},
				pos = {360,480,600},
				property = {
					placeName = "place1",
					startState = "rollleft",
					id = 6,
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{                                                       
				time = 17,
				num = 2,
				delay = {0.6,1.0},
				pos = {280,420},
				property = {
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},
		},
	},


}

--enemy的关卡配置                           mp5 55  dps大于等于2 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=550,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=440,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=3},

	--手雷
	{id=7,image="shoulei",demage=8,hp=1,
	weak1=2},

	-- 盾兵
	{id=11,image="dunbing",demage=4,hp=5500,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=3},		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}



local mapId = "map_1_2"
local limit = 15   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		type 	  = "xianShi",
		limitTime = 70,                   --限时模式时长
		-- limitTime = 10, 
		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass