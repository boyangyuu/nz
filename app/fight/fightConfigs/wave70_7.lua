local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "zpbing",
				time = 1,
				num = 1,
				delay = {4},
				pos = {500},					
				property = {
					placeName = "place5",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 7,	
				num = 2,
				pos = {600,800},
				delay = {0,0.4},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 9,
				num = 2,
				delay = {0,0.5},
				pos = {520,760},
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
				time = 11,
				num = 1,
				delay = {0},
				pos = {660},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 13,	
				num = 2,
				pos = {240,450},
				delay = {0,0.8},
				property = { 
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 15,
				num = 3,
				pos = {330,520,720},
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
	    },                                	                                                             --21个
	},	
	{   	    
		enemys = {
			{
				time = 2,	
				num = 3,
				pos = {260,440,660},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place5",
					startState = "rollleft", 
					id = 1,
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0,0.6},
				pos = {330,820},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 7,
				num = 3,
				pos = {220,380,520},
				delay = {0,0.4,0.7},
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
				time = 9,	
				num = 2,
				pos = {560,780},
				delay = {0.2,0.8},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 2,
				pos = {220,660},
				delay = {0,0.6},
				property = { 
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 13,	
				num = 2,
				pos = {480,800},
				delay = {0.5,1.0},
				property = { 
					placeName = "place6",
					startState = "rollright",
					id = 1,
				},
			},	
        },                                                        
	},										  --第二波25个

	{
		enemys = {                            --第三波

			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {400,750},
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
				pos = {270,400,700},					
				property = {
					placeName = "place4",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,
				num = 2,
				delay = {0.1,0.6},
				pos = {300,600},					
				property = {
					placeName = "place1",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{                                                       
				time = 10,
				num = 2,
				delay = {0.2,0.6},
				pos = {450,800},
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
				time = 12,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {420,600,760},
				property = {
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 14,
				num = 3,
				delay = {0.6},
				pos = {250,500,880},					
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
		},
	},


}

--enemy的关卡配置                           mp5 55  dps大于等于2 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=870,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=690,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷
	{id=3,image="shoulei",demage=8,hp=260,
	weak1=1},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=1740,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=340,
	weak1=1},

	-- 盾兵
	{id=8,image="dunbing",demage=10,hp=6600,fireRate=240,fireCd=5,speed=35,   --scale = 2.0,
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
		 type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		--type 	  = "xianShi",
		--limitTime = 70,                   --限时模式时长
		-- limitTime = 10, 
		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass