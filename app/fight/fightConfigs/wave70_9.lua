local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {

			{
				time = 1,	
				num = 2,
				pos = {440,660},
				delay = {0,0.5},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0,0.5},
				pos = {380,600},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0,0.4},
				pos = {110,330},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},

			{
				time = 6,	
				num = 2,
				pos = {330,660},
				delay = {0,0.4},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 8,
				num = 2,
				pos = {230,550},
				delay = {0,0.4},
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
				delay = {0.7,1.2},
				pos = {100,300},
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
				time = 3,	
				num = 3,
				pos = {330,660,900},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0,0.4},
				pos = {110,330},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 7,
				num = 3,
				pos = {300,600,900},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			}, 
			{
				time = 8,	
				num = 3,
				pos = {660,880,1000},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place5",
					id = 7,
					type = "jin",
				},
			},                                      	

                                       --第二波25个                                  	
		},
	},	
	{
		enemys = {                            --第三波
			{
				time = 6,	                                               --金武奖励箱子
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
				time = 1,
				num = 2,
				delay = {0.8,1.2},
				pos = {220,660},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 2,	
				num = 5,
				pos = {330,500,670,820,990},
				delay = {0,0.3,0.6,0.9,1.2},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{ 
				time = 4,
				num = 3,
				delay = {0,0.5,0.7},
				pos = {320,720,900},
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
				time = 6,
				num = 2,
				delay = {0.1,0.6},
				pos = {200,400},					
				property = {
					placeName = "place1",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},

			},
			{                                                       
				time = 8,
				num = 2,
				delay = {0.2,0.7},
				pos = {220,360},
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{ 
				time = 9,
				num = 1,
				delay = {0.2},
				pos = {100},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {330,550,850,950,1050},					
				property = {
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 13,
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
				time = 14,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {330,860,1000},
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

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=16,hp=3915,fireRate=180,fireCd=4,speed=60,
	weak1=3},

	-- 盾兵
	{id=8,image="dunbing",demage=10,hp=6600,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
	weak1=2},		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}



local mapId = "map_1_3"
local limit = 15   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		 type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		--type 	  = "xianShi",
		--limitTime = 70,                   --限时模式时长
		-- limitTime = 10, 
		 --type 	  = "taoFan",
		 --limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass