local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			
			{
				time = 1,
				num = 3,
				delay = {0.1, 0.6, 1.2},
				pos = {400,550,700,},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.6, 1,0.5},
				pos = {350,500,620,700},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{
				time = 7,	
				num = 2,
				pos = {230,430},
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
				pos = {960,830,670},
				delay = {0,0.8,1.3},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 9,
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
				time = 9,
				num = 1,
				delay = {0.5},
				pos = {880},
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
				time = 9,	
				num = 2,
				pos = {250,350},
				delay = {0.3,1.2},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {820,660},
				delay = {0,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 11,	
				num = 3,
				pos = {250,350,470},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},	                                     	
		},                                                              --15个
	},	
	{
	    --体验枪
		gunData = 
			{ 
			    id = 3,    --枪id
			    delay = 4, --10s之后出现
			    time = 20,	--持续20s
		    },		    
		enemys = {
			{
				time = 1,
				num = 3,
				delay = {0.1, 0.6, 1.2},
				pos = {400,550,700,},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.6, 1,0.5},
				pos = {350,500,620,700},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},                                           
			{
				time = 7,	
				num = 4,
				pos = {200,280,430,540,},
				delay = {0,0.5,1,1.5},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0.5},
				pos = {800},
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
				time = 9,
				num = 1,
				delay = {0.5},
				pos = {250},
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
				time = 11,	
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
				time = 12,	
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
				time = 13,	                                         --给体验枪飓风之锤
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
				time = 14,
				num = 2,
				delay = {0.2,1},
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
				time = 15,	
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
				time = 16,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 17,
				num = 2,
				delay = {0.2,1},
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
			{
				time = 12,
				num = 3,
				delay = {0.1,0.9, 1.5},
				pos = {270,400,700},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{
				time = 16,
				num = 4,
				delay = {0.1,0.7,1.2,1.8},
				pos = {210,330,520,670},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{                                                       --黄武触发位置
				time = 20,
				num = 2,
				delay = {0.2,0.9},
				pos = {333,700},
				property = {
					placeName = "place1",
					type = "jin",  
					id = 11,
				},
			},
			{
				time = 23,
				num = 5,
				delay = {0.1,0.7,1.2,1.7,2.2},
				pos = {230,310,480,600,680},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{
				time = 24,
				num = 3,
				delay = {0.1,0.7,1.2},
				pos = {270,350,520,},					
				property = {
					placeName = "place1",  
					type = "jin",
					id = 2,
				},
			},
			{
				time = 25,
				num = 3,
				delay = {0, 0.6, 1.3},
				pos = {200,260,330,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 25.5,
				num = 3,
				delay = {0, 0.6, 1.3},
				pos = {760,820,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 26,
				num = 3,
				delay = {0.2,0.9, 1.4},
				pos = {480,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 26.5,
				num = 2,
				delay = {0.2,0.9},
				pos = {280,450},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 27,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",                   --第三波35个
				},
			},
		},
	},


}

--enemy的关卡配置                           无镶嵌 MP5伤害65  dps大于等于1 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=2,hp=195,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--近战兵
	{id=2,image="jinzhanb",demage=3,hp=585,fireRate=180,fireCd=3,speed=40,scale = 1.6,
	weak1=3},                                                           --scale = 3.0,  近战走到屏幕最近放缩比例

	--伞兵
	{id=3,image="sanbing01",demage=0,hp=195,
	weak1=2},	             

    --导弹          --missileType = "daodan",
	{id=4,image="daodan",demage=3,hp=1,
	weak1=1},

	--铁球

	{id=5,image="tieqiu",demage=20,hp=3760,weak1=1},	

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=105,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},
	--手雷
	{id=7,image="shoulei",demage=3,hp=1,
	weak1=2},
	--BOSS导弹          --missileType = "daodan",
	{id=8,image="daodan",demage=5,hp=120,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=9,image="feiji",demage=0,hp=3200, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=10,image="yyc",demage=0,hp=1600,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=240, fireCd=5.0,
	weak1=2,    award = 60},
	-- 盾兵
	{id=11,image="dunbing",demage=3,hp=3000,fireRate=240,fireCd=5,speed=35,--scale = 2.0,
	weak1=3},		                                                     --scale = 2.0,  近战走到屏幕最近放缩比例

}



local mapId = "map_1_2"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.goldLimits = {300}   --备份数量48,95,160黄武激活所需杀人个数  本关共15+25+35=75个小怪
end

return waveClass