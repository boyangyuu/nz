local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				descId = "jinzhanb",
				time = 2,	
				num = 1,
				pos = {550},
				delay = {4},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {220,800},
				delay = {0,0.5},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 6,	
				num = 2,
				pos = {380,600},
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
				delay = {0,0.4},
				pos = {110,220},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},

			{
				time = 10,	
				num = 3,
				pos = {480,700,900},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 11,	
				num = 3,
				pos = {440,600,920},
				delay = {0,0.5,1},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
	                                     	
		},                                                              --21个
	},	
	{   	    
		enemys = {

			{
				time = 1,	
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
				time = 3,
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
				time = 5,
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
				time = 7,	
				num = 4,
				pos = {330,660,880,1000},
				delay = {0,0.3,0.6,0.9},
				property = { 
					placeName = "place5",
					id = 7,
					type = "jin",
				},
			},  
			{
				time = 9,	
				num = 2,
				pos = {440,920},
				delay = {0,0.5},
				property = { 
					placeName = "place10",
					startState = "rollright",
					id = 1,
				},
			}, 
			{
				time = 9,	
				num = 1,
				pos = {110},
				delay = {0.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,
				num = 2,
				delay = {0,0.4},
				pos = {110,330},					
				property = {
					placeName = "place1",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},                                   	

                                       --第二波25个                                  	
		},
	},	
	{
		enemys = {                            --第三波
			{
				time = 1,
				num = 1,
				pos = {800},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 4,	
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
				time = 7,
				num = 2,
				delay = {0.8,1.2},
				pos = {220,660},					
				property = {
					placeName = "place1",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{ 
				time = 9,
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
				time = 11,	
				num = 2,
				pos = {220,800},
				delay = {0,0.5},
				property = { 
					placeName = "place10",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 13,
				num = 2,
				delay = {0.1,0.6},
				pos = {200,400},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},

			},
			{
				time = 14,	
				num = 4,
				pos = {330,500,820,990},
				delay = {0,0.3,0.6,0.9},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{                                                       
				time = 16,
				num = 2,
				delay = {0.2,0.7},
				pos = {0,80},
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{ 
				time = 18,
				num = 2,
				delay = {0.2},
				pos = {100,200},
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
				time = 20,
				num = 2,
				delay = {0.2,0.7},
				pos = {300,500},
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 22,	
				num = 2,
				pos = {400,920},
				delay = {0,0.5},
				property = { 
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 24,
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
				time = 26,
				num = 1,
				pos = {400},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 30,
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
				time = 32,	
				num = 3,
				pos = {300,500,920},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place10",
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 34,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {0,150,300},
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 36,	
				num = 3,
				pos = {300,500,920},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 38,
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
				time = 40,
				num = 3,
				delay = {0,0.4,0.8},
				pos = {260,520,680},
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
		},
	},


}

--enemy的关卡配置                           DPS 3770  dps大于等于4-怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=1880,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=1500,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷
	{id=3,image="shoulei",demage=10,hp=750,
	weak1=2},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=3770,walkRate=120,walkCd=2,fireRate=120,fireCd=5,
	weak1=2},

	--导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1880,
	weak1=1},

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=16,hp=6590,fireRate=180,fireCd=4,speed=60,
	weak1=2},

		                                                           --scale = 2.0,  近战走到屏幕最近放缩比例

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}



local mapId = "map_1_3"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		 --type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		type 	  = "xianShi",
		limitTime = 90,                   --限时模式时长
		-- limitTime = 10, 
		 --type 	  = "taoFan",
		 --limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass