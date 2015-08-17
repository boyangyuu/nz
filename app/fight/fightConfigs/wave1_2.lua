local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "dunbing",  --简介
				time = 3,
				num = 1,
				delay = {4},
				pos = {600},
				property = {
					placeName = "place1", 
					type = "jin", 
					id = 11,
				},
			},

			-- {
			-- 	time = 2,	
			-- 	num = 2,
			-- 	pos = {230,430},
			-- 	delay = {0,0.8},
			-- 	property = { 
			-- 		placeName = "place1",
			-- 		startState = "rollright",
			-- 		id = 1,
			-- 	},
			-- },
			-- {
			-- 	time = 4,	
			-- 	num = 2,
			-- 	pos = {960,670},
			-- 	delay = {0,0.8},
			-- 	property = { 
			-- 		placeName = "place2",
			-- 		startState = "rollleft",
			-- 		id = 1,
			-- 	},
			-- },
			-- {
			-- 	time = 5,
			-- 	num = 1,
			-- 	delay = {0.2},
			-- 	pos = {250},
			-- 	property = { 
			-- 		placeName = "place1",
			-- 		id = 6,
			-- 		startState = "rollright",
			-- 		type = "dao",
			-- 		missileId = 7,
			-- 		missileType = "lei",
			-- 	},
			-- },
			-- {
			-- 	time = 6,
			-- 	num = 2,
			-- 	delay = {0,0.8},
			-- 	pos = {350,450},
			-- 	property = { 
			-- 		placeName = "place2",
			-- 		id = 6,
			-- 		startState = "rollright",
			-- 		type = "dao",
			-- 		missileId = 7,
			-- 		missileType = "lei",
			-- 	},
			-- },
			-- {
			-- 	time = 8,
			-- 	num = 1,
			-- 	delay = {0.5},
			-- 	pos = {880},
			-- 	property = { 
			-- 		placeName = "place3",
			-- 		id = 6,
			-- 		startState = "rollleft",
			-- 		type = "dao",
			-- 		missileId = 7,
			-- 		missileType = "lei",
			-- 	},
			-- },

	                                     	
		},                                                              --21个
	},	
	{   
	    --体验枪
		gunData = 
			{ 
			    id = 3,    --枪id
			    delay = 4, --10s之后出现
		    },		    
		enemys = {
			{
				time = 1,
				num = 3,
				delay = {0.2,0,0.2},
				pos = {400,600,830},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 11,
				},
			},
			{
				time = 4,	
				num = 3,
				pos = {230,430,500},
				delay = {0,0.7,1.4},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {960,800,670},
				delay = {0,0.7,1.4},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0,0.5},
				pos = {700,800},
				property = { 
					placeName = "place2",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},                                          
			{
				time = 7,	
				num = 3,
				pos = {200,430,540,},
				delay = {0,0.5,1},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {250,350},
				delay = {0,0.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {820,750,660},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {240,370,300},
				delay = {0,0.5,1.3},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0.2,0.8},
				pos = {250,350},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 10,	                                         
				num = 3,
				pos = {800,650,700},
				delay = {0,0.6,1.2},
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
				pos = {250,900},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 6,
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {250},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place3",
				},
			},	
			{
				time = 11,	
				num = 2,
				pos = {870,950},
				delay = {0,0.6},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 12,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
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
				time = 12,
				num = 2,
				delay = {0.2,0.7},
				pos = {250,700},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},	                                                   --第二波25个                                  	
		},
	},	
	{
		enemys = {                            --第三波
			{
				time = 1,	                                               --奖励箱子
				num = 1,
				pos = {600},
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
			{
				time = 3,
				num = 3,
				delay = {0.2,0,0.2},
				pos = {400,600,830},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 11,
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0.1,0.7, 1.5},
				pos = {270,400,700},					
				property = {
					placeName = "place1",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 7,
				num = 4,
				delay = {0.1,0.7,1.2,1.8},
				pos = {510,630,820,970},					
				property = {
					placeName = "place2",  
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 9,
				num = 2,
				delay = {0.2,0.9},
				pos = {333,700},
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
				time = 11,
				num = 5,
				delay = {0.1,0.7,1.2,1.7,2.2},
				pos = {230,310,480,600,680},					
				property = {
					placeName = "place2",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 13,
				num = 3,
				delay = {0.1,0.7,1.2},
				pos = {470,550,620},					
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
				num = 3,
				delay = {0, 0.6, 1.3},
				pos = {300,460,530},	
				property = { 
					placeName = "place3", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 17,
				num = 3,
				delay = {0, 0.6, 1.3},
				pos = {760,820,900},	
				property = { 
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 19,
				num = 3,
				delay = {0.2,0.9, 1.4},
				pos = {580,650,800},					
				property = {
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 21,
				num = 2,
				delay = {0.2,0.9},
				pos = {580,750},					
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
				time = 23,	
				num = 1,
				pos = {300},
				delay = {0.5},
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
				time = 25,
				num = 4,
				delay = {0.1,0.7,1.2,1.8},
				pos = {510,630,820,970},					
				property = {
					placeName = "place2",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 27,
				num = 3,
				delay = {0, 0.6, 1.3},
				pos = {300,460,530},	
				property = { 
					placeName = "place3", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 27,
				num = 2,
				delay = {0.2,0.9},
				pos = {580,750},					
				property = {
					placeName = "place2",  
					startState = "rollleft",
					id = 6,
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
		},
	},


}

--enemy的关卡配置                            mp5伤害65  打击者青铜头盔恢复2 怪物dps大于等于2 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=165,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=165,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷
	{id=7,image="shoulei",demage=10,hp=1,
	weak1=2},

	-- 盾兵
	{id=11,image="dunbing",demage=10,hp=1650,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=2},		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
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
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		type 	  = "xianShi",
		limitTime = 80,                   --限时模式时长
		-- limitTime = 10, 
		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass