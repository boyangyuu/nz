local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 3,	
				num = 1,
				pos = {300},
				delay = {0.3},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			{
			
				time = 6,	
				num = 1,
				pos = {500},
				delay = {0.1},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			
			{
				time = 9,
				num = 6,
				delay = {0,1.4,0.7,0.8,1.6,2.4},
				pos = {450,470,500,960,1000,1080},
				property = {
					type = "jin",
					placeName = "place3",  
					id = 7,
				},
			},
			{
				time = 15,	
				num = 1,
				pos = {340},
				delay = {0.9},
				property = {
					placeName = "place2" ,
					id = 8,
					type = "jin",                                         --盾兵
				},
			},
			{
				time = 22,		
				num = 4,
				pos = {450,350,400,500},
				delay = {0,0.9,1.8,2.5,},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 26,		
				num = 2,
				pos = {100,200},
				delay = {1.8,2.3},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 28,		
				num = 4,
				pos = {950,1050,1000,1250,},
				delay = {0,0.7,1.8,2.4,},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,	
				},
			},
			{
				time = 29,		
				num = 2,
				pos = {500,530},
				delay = {0.8,1.6},
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
				time = 34,		
				num = 3,
				pos = {450,350,500},
				delay = {0,0.9,2.5,},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 36,		
				num = 2,
				pos = {450,550},
				delay = {1.8,2.3},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 34,		
				num = 3,
				pos = {950,1050,1250,},
				delay = {0,0.7,2.4,},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,	
				},
			},
			{
				time = 36,		
				num = 1,
				pos = {450},
				delay = {0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	                                        --第30个怪
				},
			},
			
		},
	},
	{
		enemys = {
		   	{
				time = 2,
				num = 1,
				pos = {700},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间			
				},
			},
			{
				time = 6,
				num = 5,
				delay = {0.7,1.4, 2.1,2.8,3.1},
				pos = {350,400,600,750,800},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},	
			{
				time = 10,
				num = 5,
				delay = {0.7,1.4, 2.1,2.8,3.2},
				pos = {700,750,800,900,1000},					
				property = {
					placeName = "place4",  
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
			{
				time = 13,		
				num = 2,
				pos = {100,200},
				delay = {1.8,2.3},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},	
			{
				time = 16,		
				num = 2,
				pos = {500,530},
				delay = {0.8,1.6},
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
				time = 19,
				num = 6,
				delay = {0,1.4,0.7,0.8,1.6,2.4},
				pos = {450,470,500,960,1000,1080},
				property = {
					type = "jin",
					placeName = "place3",                                
					id = 7,
				},
			},
			{
				time = 23,		
				num = 5,
				pos = {50,130,210,300,350},
				delay = {0.8,1.6,2.3,3.0,3.4},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 1,                                        
				},
			},
			{
				time = 30,		
				num = 4,
				pos = {600,530,400,350},
				delay = {0.8,1.6,2.3,3.0},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,                                        
				},
			},                                                                        --30个怪
		},
	},


	{
		enemys = { 

			{
				time = 3,
				num = 5,
				delay = {0.1,0.5,0.8,1.2,1.5},
				pos = {330,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 6,	
				num = 5,
				pos = {325,420,510,770,900},
				delay = {0.4,0.9,1.5,1.9,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 9,
				num = 5,
				delay = {2.0,2.5,3,2.5,2.0},
				pos = {380,680,960,720,888},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾 15
					id = 8,
				},
			},

			
			{
				time = 15,
				num = 10,
				delay = {0.5,0.9,1.3,1.8,2.1,2.60,2.4,3.0,3.3,3.6},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},

			{
				time = 21,
				num = 1,
				delay = {1.6},
				pos = {670},
				property = { 
					placeName = "place11" ,
					type = "bao",                  --近战boss 15                                
					id = 16,
				},
			},
			{
				time = 26,
				num = 4,
				delay = {0.8,1.5,2.6,3},
				pos = {50,120,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",      --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 31,
				num = 2,
				delay = {0.8,1.5},
				pos = {50,120},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollright",	
				},                                                          
			},	
			{
				time = 33,
				num = 3,
				delay = {0.8,1.2,1.6},
				pos = {490,560,590},
				property = { 
					placeName = "place2" ,
					id = 1,
					startState = "rollleft",	
				},                                                          --30
			},	
			
		},
	},	
	{
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
					wangId    = 19,
					missileId = 6, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50) , cc.p(150, 150)},
					id = 1,
				},
			},

		},
	},	
}


--enemy的关卡配置                                                    白银镶嵌 mp5  100  dps大于等于5  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=20,hp=702,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=468,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=375,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=702,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=936,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=375,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=1170,fireRate=180,fireCd=4,speed=80,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=2340,fireRate=180,fireCd=5,speed=60,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=468,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=50000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=50000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=15,hp=20000,fireRate=120,fireCd=3,speed=40,scale = 2.5 ,
	weak1=3},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="renzb",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=40000},                             
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
		fireRate = 60,                  --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				    --
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)
			wudi = { 0.91, 0.71, 0.51 , 0.31, 0.10               --召唤
			}, 

			zhaohuan = { 0.90,0.70,0.50, 0.30                     --召唤小兵
			},   

			wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15                    --网
			},

			-- yanwu = { 0.90,0.70,0.50,0.30,0.10                    --烟雾
			-- },  



			weak3 = { 0.85,0.65,0.45, 0.25,                                --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.40, 0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.70,0.50,0.30,0.10                              --头 技能触发(可以同时)	                        
			},
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.85,
			},	
			demage250 = {  
				0.60,
			},	
			demage400 = {  
				0.50,
			},	
						
		},
		enemys1 = {                                                   --第一波召唤自爆兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {350,600,1000},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {320,600,750,1000},
				property = { 
					placeName = "place5" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {280,410,580,750,940},
				property = { 
					placeName = "place4" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			

		},	

		enemys2 = {                                                   --第二波召唤盾兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {390,540,888},
				property = { 
					placeName = "place6" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {333,666,777,999},
				property = { 
					placeName = "place5" ,
					type = "jin",       --近
					id = 7,
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {288,338,558,668,998},
				property = { 
					placeName = "place4" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			

	    },	

		enemys3 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,
				num = 1,
				pos = {400},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间			
				},
			},
			{
				time = 4,
				num = 2,
				pos = {400,880},
				delay = {0.3,0.9},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间			
				},
			},
			{
				time = 3,
				num = 3,
				pos = {200,550,920},
				delay = {0.5,1.2,1.8},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		--持续时间
					--demageScale = 1.5                    --伤害翻1.5倍		

				},
			},
			
		},	

		enemys4 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,
				num = 1,
				pos = {400},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间
					--demageScale = 1.5                    --伤害翻1.5倍			
				},
			},
			{
				time = 4,
				num = 2,
				pos = {400,880},
				delay = {0.3,0.9},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		                                    --持续时间
					--demageScale = 1.5                    --伤害翻1.5倍			
				},
			},
			{
				time = 3,
				num = 3,
				pos = {200,550,920},
				delay = {0.5,1.2,1.8},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 120.0,		--持续时间
					--demageScale = 1.5                    --伤害翻1.5倍		

				},
			},
			
		},													
	},


}

local mapId = "map_1_6"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.goldLimits = {25,55,90,130}   --黄武激活所需杀人个数
	
end
return waveClass