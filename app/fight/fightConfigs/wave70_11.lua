local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "hs",
				time = 2,
				num = 1,
				delay = {4},
				pos = {330},
				property = { 
					placeName = "place10",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {4},
				pos = {330},
				property = { 
					placeName = "place10",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {440,660},
				delay = {0,0.5},
				property = { 
					placeName = "place10",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0,0.5},
				pos = {300,500},
				property = { 
					placeName = "place5",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {100},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0.5},
				pos = {100},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 14,
				num = 1,
				pos = {40},
				delay = {0,},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
	                                     	
		},                                                              --21个
	},	
	{   	    
		enemys = {

			{ 
				time = 2,
				num = 2,
				delay = {0.7,1.2},
				pos = {100,300},
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
				time = 4,
				num = 4,
				delay = {0,0.2,0.4,0.6},
				pos = {300,480,680,860},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 6,
				num = 1,
				delay = {4},
				pos = {0.5},
				property = { 
					placeName = "place7",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = { 
					placeName = "place7",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 8,
				num = 2,
				delay = {0,0.4},
				pos = {330,780},					
				property = {
					placeName = "place6",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 10,
				num = 2,
				pos = {400,800},
				delay = {0,0.4},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",
				},
			}, 
			{
				time = 11,
				num = 1,
				pos = {20},
				delay = {0,},
				property = { 
					placeName = "place3",
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 13,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {250,400,550,700,850},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},                                      	

                                       --第二波25个                                  	
		},
	},	
	{
		enemys = {                            --第三波
			{
				time = 3,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					award = "goldWeapon",         --黄金武器
					placeName = "place1",
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0.8,1.2},
				pos = {220,550},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 3,
				num = 1,
				pos = {300},                               
				delay = {0},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place5",
					startState = "enterleft", 
					lastTime = 5,                       -- 人质离开时间
					                    			     -- 人质
				},
			},
			{
				time = 4,
				num = 2,
				pos = {400,800},
				delay = {0,0.4},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 7,
				num = 4,
				delay = {0,0.2,0.4,0.6},
				pos = {300,480,680,860},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{ 
				time = 9,
				num = 3,
				delay = {0,0.5,0.7},
				pos = {300,500,800},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",													
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0.1},
				pos = {20},					
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},

			},
			{
				time = 12,
				num = 2,
				pos = {200,400},
				delay = {0,0.4},
				property = { 
					placeName = "place8",
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 14,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {250,400,550,700,850},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			}, 
			{
				time = 15,
				num = 1,
				delay = {0.5},
				pos = {300},
				property = { 
					placeName = "place6",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0.5},
				pos = {300},
				property = { 
					placeName = "place6",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 17,
				num = 2,
				delay = {0,0.3},
				pos = {220,550},
				property = { 
					placeName = "place2" ,
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{                                                       
				time = 19,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {330,820,960},
				property = {
					placeName = "place6",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
		},
	},


}

--enemy的关卡配置                           mp5 55  dps大于等于4 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=1560,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=1250,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷
	{id=3,image="shoulei",demage=10,hp=625,
	weak1=2},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=3130,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

	--导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1040,
	weak1=1},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=60,hp=1090,fireRate=30,speed=70,
	weak1=2},

	-- 盾兵
	{id=8,image="dunbing",demage=10,hp=15600,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=2},		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例
	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=14,image="tufeib",demage=4,hp=2349,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=15,image="hs", hp=6260, weak1=1},

	--人质         type = "renzhi",                                           
	{id=10,image="hs",demage=0,hp=6260,walkCd = 1.0,rollCd=2,speakCd = 5.0,weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}



local mapId = "map_1_3"
local limit = 10  				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		-- type 	  = "puTong",

		 type 	  = "renZhi",
		 saveNums  = 3,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 70,                   --限时模式时长

		-- type 	  = "taoFan",
		-- limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass