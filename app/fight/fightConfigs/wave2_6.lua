local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				descId = "yyc", --简介
				time = 3,
				num = 1,
				pos = {555},
				delay = {4},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0,1.1,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
			{
				time = 11,	
				num = 5,
				pos = {420,510,700,900,1050},
				delay = {0.5,2,0,0.5,1.5},
				property = {
					placeName = "place4" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0.1,0.5,1.2},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},			
			{
				time = 13,
				num = 3,
				delay = {0.1,0.6,1},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 26,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.1,0.6,1.5,1.8,0.8},
				property = {
					placeName = "place4" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 23,
				num = 3,
				delay = {0,1.0,1.5},
				pos = {250,410,510},
				property = { 
					placeName = "place2" ,
					type = "dao",      --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 24,
				num = 3,
				delay = {0,0.5,1},
				pos = {300,370,440},
				property = { 
					placeName = "place3" ,
					id = 1,
					startState = "rollright",	
				},                                                          
			},	
			{
				time = 25,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {700,900,1100},
				property = { 
					placeName = "place3" ,
					id = 1,
					startState = "rollleft",	
				},
			},
			{
				time = 26,
				num = 2,
				delay = {0,0.6},
				pos = {380,560},
				property = { 
					placeName = "place4" ,
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
				delay = {0.5,0,1.2},
				pos = {300,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
		    
			{
				time = 6,	
				num = 5,
				pos = {420,560,700,880,990},
				delay = {1.4,0.6,0,1,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0.5,0,1.3},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 13,
				num = 5,
				delay = {0.7,1.4,1.8, 0.1,0.8},
				pos = {350,450,550,650,750},					
				property = {
					placeName = "place3" ,
					id = 1,
					startState = "rollright",
				},
			},	
			{
				time = 14,
				num = 5,
				delay = {0,0.7,1.4,1.8,0.5},
				pos = {1000,900,800,700,600},					
				property = {
					placeName = "place4" ,
					id = 1,
					startState = "rollleft",
				},
			},
			{
				time = 16,
				num = 3,
				delay = {0.2,1.0,1.8},
				pos = {200,380,560},
				property = { 
					placeName = "place2" ,
					type = "jin",                      --盾
					id = 8,
				},
			},
			{
				time = 20,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.2,0.9,1.8,2.5,3.3},              --近
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 24,
				num = 3,
				delay = {0.1,0.9,1.7},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",                                --爆
					id = 9,	
				},
			},
			{
				time = 25,
				num = 5,
				delay = {0.7,1.4,1.8, 0.1,0.8},
				pos = {350,450,550,650,750},					
				property = {
					placeName = "place3" ,
					id = 1,
					startState = "rollright",
				},
			},	
			{
				time = 26,
				num = 5,
				delay = {0,0.7,1.4,1.8,0.5},
				pos = {1000,900,800,700,600},					
				property = {
					placeName = "place4" ,
					id = 1,
					startState = "rollleft",
				},
			},	
		},
	},
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                                 --boss
			{
				descId = "dzboss", --简介
				time = 3,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "duozuBoss",
					placeName = "place1",
					wangId    = 19,        --网
					missileId = 23,        --boss导弹
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50) , cc.p(150, 150)},
					id = 1,
				},
			},
		},
	},	

}


--enemy的关卡配置                                                    黄金镶嵌  dps大于等于5  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=20,hp=6000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=6000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=300,
	weak1=1},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=7000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=500,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=18000,fireRate=180,fireCd=4,speed=60,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=60000,fireRate=180,fireCd=5,speed=40,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=7000,fireRate=30,speed=120,
	weak1=2},	

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=70000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=10000},       

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=5000, speed=120,weak1=1}, 

	--烟雾导弹          type = "dao_wu",
	{id=21,image="daodan03",demage=10,hp=6000, weak1=1},   

	--BOSS导弹          type = "missile",
	{id=23,image="daodan",demage=10,hp=1000, weak1=1},

}




--fire1 dao1 dao2 发闪光弹
--fire2 dao3 dao4 dao5 --多发导弹
--fire3 dao6  --发蜘蛛网


	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "dzboss", --图片名字
		hp = 250000,
		award = 30000,
		fireRate = 180,                  --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			 --技能触发(可以同时)

			
			daoDan1 =  { 0.96, 0.85, 0.70, 0.55, 0.40, 0.25,                --烟雾弹
			},
			zhaohuan = { 0.92, 0.80, 0.65, 0.50, 0.35,                      --召唤小兵
			}, 
			wudi =     { 0.90, 0.75, 0.60, 0.45, 0.30, 0.10,                --无敌
			},  

			-- wang = { 0.99,0.91,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15 ,0.05                    --网
			-- },


			weak3 = { 0.70, 0.40, 0.10,                                --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80, 0.60, 0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90, 0.50, 0.30,                                --头 技能触发(可以同时)	                        
			},
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage250 = {  
				0.70,
			},	
			demage300 = {  
				0.50,
			},
			demage400 = {  
				0.40,
			},			
		},

		daoDan1 = {
		    id = 21,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 0.1,                        --导弹间隔时间
			srcPoses =    {                --起始点
            cc.p(-150, -100), cc.p(0, -100), cc.p(150, -100), 
           },                   
			offsetPoses = {               --偏移点
            cc.p(-200, -200), cc.p(0, -200), cc.p(200, -200), 
           },               
		},

		enemys1 = {                                                   --第一波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
		},	

		enemys2 = {                                                   --第二波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 1.5                    --伤害翻1.5倍	
				},
			},
	    },	

		enemys3 = {                                                   --第三波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 2                    --伤害翻2倍	
				},
			},
		},	

		enemys4 = {                                                   --第四波召唤的蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 2	                     --伤害翻2倍
				},
			},
		},	

		enemys5 = {                                                   --第四波召唤的蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
					demageScale = 3	                     --伤害翻3倍
				},
			},
		},	


	},
}

local mapId = "map_1_6"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
	
end
return waveClass