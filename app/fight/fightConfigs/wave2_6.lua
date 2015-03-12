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
				time = 14,	
				num = 5,
				pos = {420,510,700,900,1050},
				delay = {0.5,2,0,0.5,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 18,
				num = 3,
				delay = {0.1,0.5,1.2},
				pos = {450,660,800},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},			
			{
				time = 22,
				num = 3,
				delay = {0.1,0.6,1},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",                 --爆
					id = 9,	
				},
			},
			{
				time = 26,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.1,0.6,1.5,1.8,0.8},
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
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
					placeName = "place4" ,
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
				time = 14,
				num = 3,
				delay = {0.2,1.0,1.8},
				pos = {200,380,560},
				property = { 
					placeName = "place2" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			{
				time = 18,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.2,0.9,1.8,2.5,3.3},
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 22,
				num = 3,
				delay = {0.1,0.9,1.7},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 23,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 4,
					enemyId = 1,
				},                                                                            --60
			},	
			{
				time = 26,
				num = 4,
				delay = {0,0.7,1.4,1.8},
				pos = {600,500,400,300},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 4,
					enemyId = 1,
				},                                                                            --60
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
					wangId    = 19,
					missileId = 6, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50) , cc.p(150, 150)},
					id = 1,
				},
			},
		},
	},	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=20,hp=6000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=6000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=234,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=6000,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=7000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=468,
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

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=20000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=20000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=1,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=1,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=1,award = 30},	--award = 30  金币数量为30

	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=15,hp=20000,fireRate=120,fireCd=3,speed=40,scale = 2.5 ,
	weak1=2},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=20000},       

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=10,hp=7000, speed=120,
	weak1=2},   	                      
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
			wudi = { 0.91, 0.71, 0.51 , 0.31, 0.16, 0.10 ,0.06               --无敌
			}, 

			zhaohuan = { 0.90, 0.70, 0.50, 0.30                     --召唤小兵
			},   

			wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15                    --网
			},

			-- yanwu = { 0.90,0.70,0.50,0.30,0.10                     --烟雾
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
		enemys1 = {                                                   --第一波召唤蜘蛛兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {350,600,1000},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {300,600,750,1000},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {280,410,580,750,940},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
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
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {333,666,777,999},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {288,338,558,668,998},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
				},
			},
			

	    },	

		enemys3 = {                                                   --第三波召唤的兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {390,540,888},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {333,666,777,999},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {288,338,558,668,998},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
					--demageScale = 1.2                    --伤害翻1.5倍
				},
			},
			
		},	

		enemys4 = {                                                   --第三波召唤的兵
			{
				time = 2,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {390,540,888},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.1,0.2,0.3,0.4},
				pos = {333,666,777,999},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.1,0.2,0.3,0.4,0.1},
				pos = {288,338,558,668,998},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,
					--demageScale = 1.2                    --伤害翻1.5倍
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

	
end
return waveClass