local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {                                         
			{
				time = 1,	
				num = 4,
				pos = {200,260,330,440,},
				delay = {0,0.5,0.8,1,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0.5},
				pos = {250},
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
				time = 10,	
				num = 2,
				pos = {250,350},
				delay = {1,1.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 2,
				pos = {820,660},
				delay = {0,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},		                                     	
		},                                                              --10个
	},	
	{
		enemys = {                                           
			{
				time = 1,	
				num = 4,
				pos = {200,280,430,540,},
				delay = {0,0.5,0.8,1,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.5},
				pos = {250},
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
				time = 4,	
				num = 2,
				pos = {250,350},
				delay = {1,1.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 5,	
				num = 3,
				pos = {820,750,660},
				delay = {0,0.6,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 6,	
				num = 3,
				pos = {240,370,300},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 3,
				pos = {800,650,700},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0.2,0},
				pos = {250,900},
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
				time = 12,	
				num = 2,
				pos = {870,950},
				delay = {0,0.6},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 14,	
				num = 3,
				pos = {240,370,300},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place1",
					id = 2,
					type = "jin",
				},
			},		
			{
				time = 16,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place2",
					id = 2,
					type = "jin",
				},
			},
			{
				time = 18,
				num = 2,
				delay = {0.2,0},
				pos = {250,700},
				property = { 
					placeName = "place1",
					id = 2,
					type = "jin",
				},
			},	
			{
				time = 20,	
				num = 3,
				pos = {820,910,980},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place2",
					id = 2,
					type = "jin",                                   --第二波31个
				},
			},
		                                     	
		},
	},	
	{
		enemys = {                                           --第三波
			{
				time = 1,
				num = 3,
				delay = {0, 0.6, 0.8},
				pos = {200,270,340,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 2,
				num = 3,
				delay = {0, 0.3, 0.7},
				pos = {800,650,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 2,	
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
				time = 3,
				num = 1,
				pos = {450},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 9,
					placeName = "place11",
					missileId = 4,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},		
			{
				time = 4,
				num = 3,
				delay = {0.2,0.3, 0.6},
				pos = {470,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 6,	
				num = 8,
				pos = {300,360,430,500,560,620,700,850},
				delay = {0,0.7,1.4,2.1,3.5,2.9,2.1,1.5},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place2",
				},
			},
			{
				time = 9,	
				num = 2,
				pos = {350,700},
				delay = {0.3,0.7},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place3",
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0, 0.6, 0.8},
				pos = {200,260,330,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,
				num = 1,
				pos = {350},
				delay = {0.1},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 10,
					placeName = "place12",
					missileId = 4,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},	
			{
				time = 11,
				num = 3,
				delay = {0, 0.3, 0.7},
				pos = {760,820,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 12,
				num = 3,
				delay = {0.2,0.3, 0.6},
				pos = {480,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 13,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",                   --第三波32个
				},
			},
		},
	},


}

--enemy的关卡配置                           无镶嵌 MP5伤害65  dps大于等于1 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=1,hp=105,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=3},

	--近战兵
	{id=2,image="jinzhanb",demage=3,hp=140,fireRate=180,fireCd=3,speed=40,scale = 1.4,
	weak1=3},                                                           --scale = 3.0,  近战走到屏幕最近放缩比例

	--伞兵
	{id=3,image="sanbing01",demage=0,hp=105,
	weak1=2},	             

    --导弹          --missileType = "daodan",
	{id=4,image="daodan",demage=2,hp=1,
	weak1=1},

	--铁球

	{id=5,image="tieqiu",demage=20,hp=3760,weak1=1},	

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=105,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},
	--手雷
	{id=7,image="shoulei",demage=1,hp=1,
	weak1=2},
	--BOSS导弹          --missileType = "daodan",
	{id=8,image="daodan",demage=5,hp=120,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=9,image="feiji",demage=0,hp=1600, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=10,image="yyc",demage=0,hp=1600,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=240, fireCd=5.0,
	weak1=2,    award = 60},

}



local mapId = "map_1_2"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.goldLimits = {25,95,160}   --黄武激活所需杀人个数  本关共60个小怪
end

return waveClass