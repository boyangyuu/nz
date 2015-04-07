local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "hs", --简介
				time = 3,
				num = 1,
				pos = {600},                               
				delay = {4},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place4",
					startState = "enterleft", 
					lastTime = 7,                       -- 人质离开时间
					                    			     -- 人质
				},
			},
            {
				time = 9,	
				num = 3,
				pos = {200,350,450,},
				delay = {0.9,1.9,2.3,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {580,660},
				delay = {0.5,1},
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
				time = 11,
				num = 2,
				delay = {0.2,1},
				pos = {550,800},
				property = { 
					placeName = "place3",
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0.2,1,1.5},
				pos = {150,230,450},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 15,
				num = 3,
				delay = {0.5,1,2.5},
				pos = {130,330,550},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质4",      --  一组统一标示
					type = "bangfei",
					placeName = "place10",
					id = 5,
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质4",     --  一组统一标示
					type = "bangren",
					placeName = "place10",
					id = 6,
				},
			},
			{
				time = 17,
				num = 1,
				delay = {1},
				pos = {230},
				property = { 
					placeName = "place10",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 17,	
				num = 3,
				pos = {200,300,350,},
				delay = {0,0.5,1,},
				property = { 
					placeName = "place2",
					startState = "rollright",                                          --第一波20个怪
					id = 1,
				},
			},
		},
	},

	
	{
		enemys = {

			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质1",      --  一组统一标示
					type = "bangfei",
					placeName = "place11",
					id = 5,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质1",     --  一组统一标示
					type = "bangren",
					placeName = "place11",
					id = 6,
				},
			},	


			{
				time = 3,
				num = 1,
				delay = {0.1},
				pos = {0},                                 --不用改
				property = {
					placeName = "place10",
					startState = "enterleft",
					type = "shangren",	
					id = 16,
					data = {
						{
							pos = 230,                  --第一次蹲下的位置
							time = 3,                   --第一次蹲下的时间
							direct = "right",           --往那面跑
						},
						{
							pos = 530,
							time = 3,
							direct = "right",							
						},					
					},
				},
			},	
			{
				time = 4,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,350,400,600},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	

			{
				time = 7,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 9,	
				num = 2,
				pos = {180,500},
				delay = {0.5,1},
				property = { 
					placeName = "place11",
					startState = "rollright",                                    
					id = 1,
				},
			},
			{
				time = 10,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,400,600,700},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place5",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place8",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 13,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {300,500,550,600,1000},					
				property = {
					placeName = "place4",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
		},
	},
                                                                                       --第二波20个怪
	{
		enemys = {
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {300},
				property = {
					renzhiName = "人质2",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 5,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {300},
				property = {
					renzhiName = "人质2",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 6,
				},
			},

			{
				time = 2.5,
				num = 1,
				delay = {0},
				pos = {0},                                 --不用改
				property = {
					placeName = "place10",
					startState = "enterleft",
					type = "shangren",	
					id = 16,
					data = {
						{
							pos = 630,                  --第一次蹲下的位置
							time = 3,                   --第一次蹲下的时间
							direct = "right",           --往那面跑
						},		
					},
				},
			},	

			{
				time = 3.5,
				num = 1,
				delay = {0.1},
				pos = {0},                                 --不用改
				property = {                               --黄衣人质
					placeName = "place11",
					startState = "enterleft",
					type = "shangren",	
					id = 16,
					data = {
						{
							pos = 1000,
							time = 3,
							direct = "right",							
						},						
					},
				},
			},	
			{
				time = 5,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,350,400,600},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 8,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,400,600,700},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {960},
				property = {
					renzhiName = "人质3",      --  一组统一标示
					type = "bangfei",
					placeName = "place10",
					id = 5,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {960},
				property = {
					renzhiName = "人质3",     --  一组统一标示
					type = "bangren",
					placeName = "place10",
					id = 6,
				},
			},
			{
				time = 11,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {300,500,550,600,1000},					
				property = {
					placeName = "place4",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0.5,1,2.5},
				pos = {130,330,1000},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 13,
				num = 2,
				delay = {0.5,1},
				pos = {450,1130},
				property = { 
					placeName = "place10",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
	    },		
	}
}
--enemy的关卡配置                        mp5伤害65  青铜镶嵌   3枪伤害195  4枪伤害260 dps<1
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=4,hp=327,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=327,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=5,hp=1,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=327,
	weak1=2},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=5,image="tufeib",demage=4,hp=327,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=6,image="hs", hp=1000, weak1=1},	 

	--女人质         type = "renzhi",                                             speakRate =120,speakCd = 2.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=1000,walkRate=120,walkCd = 1.0,rollRate=120,rollCd=2.0, speakRate =60,speakCd = 2.0,
	weak1=1},

	--黄衣人质商人      type = "shangren",
	{id=16,image="shangr_1",hp=1000, weak1=1},	--黄衣人质商人	 

                 


	

}

local mapId = "map_1_5"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		-- type 	  = "puTong",

		type 	  = "renZhi",
		saveNums  = 3,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass