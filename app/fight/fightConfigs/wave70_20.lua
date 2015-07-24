local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
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
				pos = {0,30},					
				property = {
					placeName = "place8",   
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
					placeName = "place9" ,
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
			{
				time = 16,
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
				time = 17,	
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
				time = 19,	
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
				time = 21,
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
				time = 22,
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
				time = 24,
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
				time = 25,
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
				time = 26,
				num = 2,
				delay = {0,0.4},
				pos = {0,300},					
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
				time = 28,
				num = 1,
				delay = {0.1},
				pos = {20},
				property = { 
					placeName = "place8" ,
					id = 21,
					type = "juji",                 --狙击             
				},
			},

		},
	},	
	{	
		waveType = "boss",                                      --强敌出现
		enemys = {                                                
			{
				descId = "dzboss_1", --简介                           -- 毒刺boss
				time = 2,	
				num = 1,
				pos = {550},
				delay = {4},
				property = { 
					type = "duozuBoss",
					placeName = "place13",
					wangId    = 19,     --网ID
					missileId = 22,     --boss导弹
					missileOffsets = {cc.p(-150,150) , cc.p(-150, -150)},
					id = 1,
				},
			},
		},
	},
	{
		enemys = { 
			{
				time = 4,
				num = 8,
				pos = {300,400,500,600,700,800,900,1000},
				delay = {1.4,1.2,1.0,0.8,0.6,0.4,0.2,0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place4",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 4,
				num = 8,
				pos = {300,400,500,600,700,800,900,1000},
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place4",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 14,
				num = 8,
				pos = {300,400,500,600,700,800,900,1000},
				delay = {1.4,1.2,1.0,0.8,0.6,0.4,0.2,0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place4",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 14,
				num = 8,
				pos = {300,400,500,600,700,800,900,1000},
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place4",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 60.0,		--持续时间			
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
	weak1=2},	

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=30,hp=4930,fireRate=30,speed=120,
	weak1=2},

	--吉普       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=42260,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=40,
	weak1=3,    award = 600},

	--吉普车烟雾导弹          missileType = "dao_wu",
  	{id=13,image="daodan03",demage=10,hp=2815, weak1=1},


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

	--蜘蛛网
	{id=19,image="zzw",demage=20,hp=20000},  

	--BOSS导弹          --missileType = "daodan",
	{id=23,image="daodan",demage=30,hp=3000,
	weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=20,hp=7040, weak1=1},--打击者金武平均伤害5558

	--小蜘蛛   --type = "bao",
	{id=28,image="xiaozz",demage=20,hp=5630, speed=70, weak1=1},	
}

	--boss的关卡配置
local bosses = {

	{
		image = "dzboss_1", --图片名字                                                             --毒刺boss
		award = 10000,                   --boss产出金币数量
		hp = 300000,
		fireRate = 120,                  --普攻频率
		fireCd = 5,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)
			-- wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15                    --网
			-- },

			wudi = { 0.90, 0.70, 0.50, 0.30, 0.10,
			}, 

			zhaohuan = { 0.91, 0.71, 0.51, 0.31,                   --召唤小兵
			},   

			daoDan1 = {                                            --3发烟雾导弹
				0.99, 0.80, 0.60, 0.40, 0.20, 0.05,
			},



			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage200 = {
				0.60,
			},
			demage300 = {
				0.40,
			},			
		},

		daoDan1 = {
		    id = 22,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 2.0,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            	cc.p(150, 150), cc.p(170, -190), cc.p(-150, -50),
        	},
        },

		enemys1 = {                                                   --第1波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place4" ,
					type = "bao",      --爆
					id = 28,	
				},
			},
		},	
		enemys2 = {                                                   --第2波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place4" ,
					type = "bao",      --爆
					id = 28,
					demageScale = 2 ,                   --伤害翻1.5倍	
				},
			},
	    },	
		enemys3 = {                                                   --第3波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place4" ,
					type = "bao",      --爆
					id = 28,
					demageScale = 3  ,                  --伤害翻2倍	
				},
			},
		},
		enemys4 = {                                                   --第4波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place4" ,
					type = "bao",      --爆
					id = 28,
					demageScale = 4  ,                  --伤害翻2倍	
				},
			},
		},

	},
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