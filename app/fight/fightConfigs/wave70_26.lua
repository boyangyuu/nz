local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {

			{
				time = 2,	
				num = 2,
				pos = {230,500},
				delay = {0,0.5},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
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
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
			 	time = 6,	
			 	num = 2,
			 	pos = {390,540},
			 	delay = {0.2,1},
			 	property = { 
			 		placeName = "place3",
					type = "yiliao",
					startState = "enterright",
					skillCd = 4.0,
					skillValue = 30,
					id = 20,
			 	},
			},
			{
				time = 10,	
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
				time = 12,
				num = 3,
				pos = {580,690,800},
				delay = {0,0.4,0.7},
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
				time = 2,	
				num = 3,
				pos = {300,500,700},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place2",
					type = "jin", 
					id = 8,
				},
			},
			{
			 	time = 3,	
			 	num = 2,
			 	pos = {270,370},
			 	delay = {0.2,1},
			 	property = { 
			 		placeName = "place3",
					type = "yiliao",
					startState = "enterright",
					skillCd = 4.0,
					skillValue = 30,
					id = 20,
			 	},
			},
			{
				time = 5,	
				num = 3,
				pos = {260,350,500},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft", 
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				pos = {300,600},
				delay = {0,0.4},
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
				time = 10,	
				num = 3,
				pos = {220,440,660},
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
				time = 12,	
				num = 3,
				pos = {480,600,720},
				delay = {0.5,1.0,1.2},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},


                                       --第二波25个                                  	
		},
	},	
	{
		enemys = {                            --第三波
			{
			 	time = 3,	
			 	num = 2,
			 	pos = {370,670},
			 	delay = {0.2,1},
			 	property = { 
			 		placeName = "place4",
					type = "yiliao",
					startState = "enterright",
					skillCd = 4.0,
					skillValue = 30,
					id = 20,
			 	},
			},
			{
				time = 5,
				num = 4,
				delay = {0,0.4,0.8,1.2},
				pos = {200,400,600,800},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 8,
				},
			},
			{
				time = 10,
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
				time = 12,
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
				time = 14,
				num = 2,
				delay = {0,0.4},
				pos = {420,760},
				property = {
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{
			 	time = 16,	
			 	num = 1,
			 	pos = {550},
			 	delay = {0.2},
			 	property = { 
			 		placeName = "place2",
					type = "yiliao",
					startState = "enterright",
					skillCd = 4.0,
					skillValue = 30,
					id = 20,
			 	},
			},
			{                                                       
				time = 18,
				num = 3,
				delay = {0.2,0.6,1.2},
				pos = {420,580,740},
				property = {
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{                                                       
				time = 20,
				num = 2,
				delay = {0.2,0.6},
				pos = {300,480},
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
				time = 22,
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
				time = 24,
				num = 2,
				delay = {0,0.4},
				pos = {360,720},
				property = {
					placeName = "place2", 
					type = "jin", 
					id = 8,
				},
			},
			{
			 	time = 26,	
			 	num = 2,
			 	pos = {350,750},
			 	delay = {0.2},
			 	property = { 
			 		placeName = "place3",
					type = "yiliao",
					startState = "enterright",
					skillCd = 4.0,
					skillValue = 30,
					id = 20,
			 	},
			},
			{                                                       
				time = 28,
				num = 2,
				delay = {0.6,1.0},
				pos = {280,420},
				property = {
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},
		},
	},


}

--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于4  怪物数据
local enemys = {

	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=16,hp=9056,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=7245,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=3620,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=4,hp=27160,
	weak1=3, weak4=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=9056,
	weak1=1},	

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=90560,fireRate=180,fireCd=5,speed=30,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=126780, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--吉普       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=108670,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--吉普车烟雾导弹          missileType = "dao_wu",
  	{id=13,image="daodan03",demage=25,hp=13580, weak1=1},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=30,hp=54330,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2, award = 10},	 

	--医疗兵      type = "yiliao",
	{id=20,image="yiliaob",demage=16,hp=36220,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--狙击兵      --type = "juji",
	{id=21,image="jujib",demage=18,hp=27160, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2}, 

	--飞镖
	{id=18,image="feibiao",demage=15,hp=9056},  

}


local mapId = "map_1_2"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 5,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 80,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 4,                      --逃跑逃犯数量
	}
end
return waveClass