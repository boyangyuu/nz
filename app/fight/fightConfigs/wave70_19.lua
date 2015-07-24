local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				pos = {200},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		--持续时间			
				},
			},
			{
				time = 3,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0.1},
				pos = {0,50},
				property = { 
					placeName = "place7" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0,0.5,0.9},
				pos = {125,250,333},					
				property = {
					placeName = "place1",   
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0},
				pos = {0,50},					
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
				time = 8,
				num = 2,
				delay = {0,0.6},
				pos = {0,420},
				property = { 
					placeName = "place3",
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place5" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 11,
				num = 2,
				delay = {0,1,0.5},
				pos = {200,600},
				property = { 
					placeName = "place4" ,
					startState = "rollleft",					
					id = 1,
				},
			},
			{
				time = 12,
				num = 2,
				delay = {0,0.2},
				pos = {0,300},					
				property = {
					placeName = "place2",   
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 13,	
				num = 2,
				pos = {400,550},
				delay = {0,0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {220},
				property = { 
					placeName = "place10",
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			},

		},
	},	
	{
		enemys = {
			{
				time = 1,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 3,	
				num = 3,
				pos = {250,350,550},
				delay = {0,0.5,1.0},
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
				time = 4,
				num = 2,
				delay = {0,0.5},
				pos = {550,800},
				property = { 
					placeName = "place2",
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0.1,0.5},
				pos = {200,330},
				property = { 
					placeName = "place1" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 6,
				num = 3,
				delay = {0,1,1.5},
				pos = {190,270,350},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 7,	
				num = 2,
				pos = {200,400},
				delay = {0},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 8,
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
				time = 9,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place6" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0,0.5,1},
				pos = {790,900,1050},
				property = { 
					placeName = "place10",
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place5" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 10,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 13,	
				num = 3,
				delay = {0,0.5,1,},
				pos = {100,200,550},
				property = { 
					placeName = "place11",
					startState = "rollright",                                   
					id = 1,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place7" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 16,	
				num = 1,
				pos = {200},
				delay = {0},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 18,
				num = 1,
				delay = {0.1,0.5},
				pos = {0,50},
				property = { 
					placeName = "place5" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 19,
				num = 1,
				delay = {0},
				pos = {300},
				property = { 
					placeName = "place4",
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			},
			{
				time = 20,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 22,
				num = 3,
				delay = {0,0.5,1},
				pos = {0,550,800},
				property = { 
					placeName = "place3",
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 23,
				num = 2,
				delay = {0,0.5},
				pos = {0,500},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
		},
	},
	{
		enemys = { 
			{
				time = 1,
				num = 1,
				pos = {330},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		--持续时间			
				},
			},
			{                                                       
				time = 2,
				num = 4,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {100,230,460,590,720},
				property = {
					placeName = "place3",
					type = "jin", 
					id = 8,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place7" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 5,	
				num = 2,
				pos = {250,350},
				delay = {0.5,1},
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
				time = 6,	
				num = 2,
				pos = {200,400},
				delay = {0},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.1,0.5},
				pos = {220,330},
				property = { 
					placeName = "place1" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {20},					
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
				time = 10,
				num = 1,
				pos = {600},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 30.0,		--持续时间			
				},
			},
			{
				time = 11,
				num = 2,
				delay = {0.1,0.5},
				pos = {0,60},
				property = { 
					placeName = "place7" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 13,	
				num = 2,
				pos = {200,400},
				delay = {0},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 15,
				num = 3,
				delay = {0,0.5,0.9},
				pos = {125,250,333},					
				property = {
					placeName = "place1",   
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 16,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},	
			{
				time = 17,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place5" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 19,
				num = 2,
				delay = {0,0.6},
				pos = {0,420},
				property = { 
					placeName = "place3",
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			},
			{
				time = 20,
				num = 1,
				delay = {0.1,0.5},
				pos = {0,60},
				property = { 
					placeName = "place5" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			}, 
			{
				time = 22,
				num = 1,
				delay = {0},
				pos = {600},					
				property = {
					placeName = "place2",   
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			},
			{
				time = 20,
				num = 2,
				delay = {0,1,0.5},
				pos = {200,600},
				property = { 
					placeName = "place4" ,
					startState = "rollleft",					
					id = 1,
				},
			},
			{
				time = 20,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place7" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 22,
				num = 2,
				delay = {0,0.4},
				pos = {0,300},					
				property = {
					placeName = "place2",   
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 23,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place5" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},
		},
	},	
}
local enemys = {
	--普通兵                                      怪物dps>6
	{id=1,image="anim_enemy_002",demage=12,hp=7040,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=5630,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=12,hp=2815,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=12,hp=21130,
	weak1=2, weak4=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=10,hp=70430,fireRate=180,fireCd=5,speed=30,
	weak1=3},	

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=30,hp=4930,fireRate=30,speed=120,
	weak1=2},

	--吉普       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=105600,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--吉普车烟雾导弹          missileType = "dao_wu",
  	{id=13,image="daodan03",demage=30,hp=7040, weak1=1},


	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=20,hp=42260,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2, award = 10},	

	--飞镖
	{id=18,image="feibiao",demage=12,hp=7040}, 

	--医疗兵      type = "yiliao",
	{id=20,image="yiliaob",demage=12,hp=28170,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--狙击兵      --type = "juji",
	{id=21,image="jujib",demage=30,hp=21130, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2}, 	
}



local limit = 10   				--此关敌人上限

local mapId = "map_1_5"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		--type 	  = "renZhi",
		--saveNums  = 3,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		--type 	  = "taoFan",
		--limitNums = 3,                      --逃跑逃犯数量
	}
end

return waveClass