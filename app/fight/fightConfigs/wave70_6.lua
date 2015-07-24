local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{ 
				descId = "qiufan",				
				time = 2,
				num = 1,
				delay = {4},
				pos = {990},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "enterright",  --从右进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = -300,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},	
						{
							pos = -600,  --第2次藏身处 移动 - 600
							time = 3,	 --隐藏时间 4s													
						},											
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {230,700},
				delay = {0,0.5},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0,0.5},
				pos = {330,500},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 12,	
				num = 2,
				pos = {420,800},
				delay = {0,0.8},
				property = { 
					placeName = "place6",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 13,
				num = 3,
				pos = {280,690,880},
				delay = {0,0.4,0.7},
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
				time = 13,
				num = 1,
				delay = {0},
				pos = {200},
				property = { 
					type = "taofan_qiu",
					placeName = "place6",
					id = 4,
					startState = "enterleft",  --从右进入
					data = {
						direct = "right", --向左逃跑
						{
							pos = 300,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},											
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},	                                     	
		},                                                              --21个
	},	
	{   	    
		enemys = {
			{
				time = 2,	
				num = 1,
				pos = {550},
				delay = {0,},
				property = { 
					placeName = "place2",
					type = "jin", 
					id = 8,
				},
			},
			{
				time = 5,	
				num = 2,
				pos = {260,600},
				delay = {0,0.6},
				property = { 
					placeName = "place4",
					startState = "rollleft", 
					id = 1,
				},
			},
			{ 				
				time = 7,
				num = 1,
				delay = {4},
				pos = {990},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "enterright",  --从右进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = -300,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{ 				
				time = 7,
				num = 1,
				delay = {0},
				pos = {100},
				property = { 
					type = "taofan_qiu",
					placeName = "place6",
					id = 4,
					startState = "enterleft",  --从左进入
					data = {
						direct = "right", --向右逃跑										
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{
				time = 9,
				num = 3,
				pos = {440,750,920},
				delay = {0,0.4,0.7},
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
				time = 13,	
				num = 2,
				pos = {520,780},
				delay = {0,0.8},
				property = { 
					placeName = "place6",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 15,	
				num = 2,
				pos = {220,660},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{ 				
				time = 16,
				num = 1,
				delay = {4},
				pos = {990},
				property = { 
					type = "taofan_qiu",
					placeName = "place7",
					id = 4,
					startState = "enterright",  --从右进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = -300,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{
				time = 18,	
				num = 3,
				pos = {480,600,720},
				delay = {0.5,1.0,1.2},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
			{
				num = 1,
				time = 20,--奖励箱子
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
				time = 2,
				num = 2,
				delay = {0,0.4},
				pos = {400,650},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 8,
				},
			},
			{
				time = 6,
				num = 3,
				delay = {0.1,0.4,0.7},
				pos = {260,400,900},					
				property = {
					placeName = "place3",  
					startState = "rollright",
					id = 1,
				},
			},
			{ 				
				time = 8,
				num = 2,
				delay = {0,6},
				pos = {150,200},
				property = { 
					type = "taofan_qiu",
					placeName = "place6",
					id = 4,
					startState = "enterleft",  --从右进入
					data = {
						direct = "right", --向左逃跑
						{
							pos = 600,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{                                                       
				time = 10,
				num = 2,
				delay = {0.2,0.7},
				pos = {330,600},
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
				time = 11,
				num = 2,
				delay = {0,0.4},
				pos = {550,860},
				property = {
					placeName = "place6",
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
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{ 				
				time = 16,
				num = 1,
				delay = {4},
				pos = {990},
				property = { 
					type = "taofan_qiu",
					placeName = "place5",
					id = 4,
					startState = "enterright",  --从右进入
					data = {
						direct = "left", --向左逃跑												
					},		
					exit = "", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{                                                       
				time = 17,
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
				time = 18,
				num = 2,
				delay = {0,0.6},
				pos = {320,800},
				property = {
					placeName = "place4",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{                                                       
				time = 19,
				num = 2,
				delay = {0.6,1.0},
				pos = {200,550},
				property = {
					placeName = "place6",
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
	{id=1,image="anim_enemy_002",demage=8,hp=750,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=600,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=4,hp=1100,
	weak1=4, weak4=4},

	--手雷
	{id=3,image="shoulei",demage=10,hp=210,
	weak1=1},

	-- 盾兵
	{id=8,image="dunbing",demage=10,hp=5500,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=3},		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例

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

		-- type 	  = "xianShi",
		-- limitTime = 60,
		                   --限时模式时长
		 type 	  = "taoFan",
		 limitNums = 3,                      --逃跑逃犯数量
	}

end

return waveClass