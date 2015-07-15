local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {

			{
				time = 2,	
				num = 2,
				pos = {330,770},
				delay = {0,0.5},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{ 
				time = 3,
				num = 1,
				delay = {0},
				pos = {200},
				property = { 
					type = "taofan_qiu",
					placeName = "place4",
					id = 4,
					startState = "enterleft",  --从左进入
					data = {
						direct = "right", --向左逃跑
						{
							pos = 200,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},											
					},		
			exit = "", --在屏幕中消失 不填表示屏幕外消失			
		},
	},
			{
				time = 4,
				num = 2,
				delay = {0,0.5},
				pos = {320,480},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
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
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
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
				num = 2,
				delay = {0,0.3},
				pos = {300,460},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 400,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{
				time = 2,	
				num = 3,
				pos = {260,500,780},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft", 
					id = 1,
				},
			},
			{ 
				time = 3,
				num = 2,
				delay = {0.6,0.9},
				pos = {620,780},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = -200,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},											
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{
				time = 5,	
				num = 2,
				pos = {350,700},
				delay = {0,0.2},
				property = { 
					placeName = "place2",
					type = "jin", 
					id = 8,
				},
			},
			{
				time = 7,
				num = 2,
				pos = {330,600},
				delay = {0,0.4,0.7},
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
				time = 9,	
				num = 2,
				pos = {520,780},
				delay = {0,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 2,
				pos = {440,820},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				num = 1,
				time = 11,--奖励箱子
				pos = {660},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 20,
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
				delay = {0,0.3},
				pos = {260,460},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 400,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{ 
				time = 1,
				num = 3,
				delay = {0.5,0.8,1.2},
				pos = {360,560,760},
				property = { 
					placeName = "place3",
					startState = "san",  --从伞进入											
					id = 1,					
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0.5,1.0},
				pos = {300,600},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 8,
				},
			},
			{ 
				time = 7,
				num = 1,
				delay = {0},
				pos = {900},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "enterright",  --从伞进入
					data = {
						direct = "left", --向右逃跑
						{
							pos = -200,  --第一次藏身处 移动 -200
							time = 2,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{ 
				time = 9,
				num = 1,
				delay = {1},
				pos = {200},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "enterleft",  --从伞进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 600,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{
				time = 11,
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
				time = 13,
				num = 3,
				delay = {0.2,0.7,1.5},
				pos = {220,360,550},
				property = {
					placeName = "place1",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{                                                       
				time = 15,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {420,600,760},
				property = {
					placeName = "place4",
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
	{id=1,image="anim_enemy_002",demage=8,hp=820,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=660,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=3},

	--手雷
	{id=3,image="shoulei",demage=16,hp=1,
	weak1=2},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=8,hp=1100,
	weak1=4, weak4=4},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=60,hp=550,fireRate=30,speed=120,
	weak1=3},

	-- 盾兵
	{id=8,image="dunbing",demage=4,hp=5500,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
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

		--type 	  = "xianShi",
		--limitTime = 70,                   --限时模式时长
		-- limitTime = 10, 
		 type 	  = "taoFan",
		 limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass