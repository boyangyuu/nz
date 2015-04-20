local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	-- {
	-- 	enemys = {
	-- 		{
	-- 			time = 2,
	-- 			num = 3,
	-- 			delay = {1.0,0,0.5},
	-- 			pos = {400,680,960},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				type = "jin",                   --盾
	-- 				id = 8,	 
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 4,	
	-- 			num = 5,
	-- 			pos = {120,210,300,400,550},
	-- 			delay = {0.5,2,0,0.5,1.5},
	-- 			property = {
	-- 				placeName = "place2" ,           --普
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 5,
	-- 			num = 3,
	-- 			delay = {0.1,0.5,1.2},
	-- 			pos = {450,660,900},
	-- 			property = { 
	-- 				placeName = "place3" ,
	-- 				startState = "rollleft",
	-- 				id = 2,
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",              --雷
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 6,	
	-- 			num = 10,
	-- 			pos = {400,550,700,850,1000,250,900,750,600,350},              --自爆
	-- 			delay = {0,0.5,1.5,1,2,2.5,3,3.5,4,4.5},
	-- 			property = {
	-- 				placeName = "place3" ,
	-- 				id = 9,
	-- 				type = "bao",
	-- 				startState = "san",
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 7,
	-- 			num = 3,
	-- 			delay = {0.1,0.6,1},
	-- 			pos = {250,460,800},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				id = 5,
	-- 				type = "dao",
	-- 				missileId = 6,
	-- 				missileType = "daodan",          --导弹
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 8,	
	-- 			num = 5,
	-- 			pos = {250,320,410,470,600},
	-- 			delay = {0.1,0.6,1.5,1.8,0.8},
	-- 			property = {
	-- 				placeName = "place3" ,            --普
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 9,
	-- 			num = 3,
	-- 			delay = {0,1.1,0.5},
	-- 			pos = {400,680,960},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				type = "jin",                        --盾
	-- 				id = 8,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 10,
	-- 			num = 3,
	-- 			delay = {0,0.5,1},
	-- 			pos = {300,370,440},
	-- 			property = { 
	-- 				placeName = "place3" ,
	-- 				startState = "rollright",           --雷
	-- 				id = 2,
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",	
	-- 			},                                                          
	-- 		},	
	-- 		{
	-- 			time = 12,
	-- 			num = 3,
	-- 			delay = {0,0.7,1.4},
	-- 			pos = {700,900,1100},
	-- 			property = { 
	-- 				placeName = "place4" ,             --导弹
	-- 				id = 5,
	-- 				type = "dao",
	-- 				missileId = 6,
	-- 				missileType = "daodan",	
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 13,	
	-- 			num = 4,
	-- 			pos = {100,250,500,600},              --自爆
	-- 			delay = {0,0.5,1.5,1},
	-- 			property = {
	-- 				placeName = "place3" ,
	-- 				id = 9,
	-- 				type = "bao",
	-- 				startState = "san",
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 15,
	-- 			num = 2,
	-- 			pos = {350,550},
	-- 			delay = {0,2.5},                          -- 吉普车
	-- 			property = {
	-- 				type = "jipu" ,
	-- 				id = 12,
	-- 				placeName = "place1",
	-- 				missileId = 6,
	-- 				missileType = "daodan",
	-- 				missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
	-- 				startState = "enterleft",
	-- 				lastTime = 60.0,		--持续时间			
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                                                -- 1-6 boss
			{
				descId = "boss01_1", --简介
				time = 3,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place1",
					missileId = 20,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss         
				},
			},
		},
	},
	-- {
	-- 	enemys = {
	-- 		{
	-- 			time = 2,
	-- 			num = 3,
	-- 			delay = {1.0,0,0.5},
	-- 			pos = {400,680,960},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				type = "jin",                  --盾
	-- 				id = 8,
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 4,	
	-- 			num = 5,
	-- 			pos = {120,210,300,400,550},
	-- 			delay = {0.5,2,0,0.5,1.5},
	-- 			property = {
	-- 				placeName = "place2" ,         --普
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 6,
	-- 			num = 2,
	-- 			delay = {0.1,1.2},
	-- 			pos = {450,900},
	-- 			property = { 
	-- 				placeName = "place3" ,
	-- 				id = 17,
	-- 				type = "renzhe",
	-- 				missileId = 18,               --忍者
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 10,	
	-- 			num = 5,
	-- 			pos = {250,320,410,470,600},
	-- 			delay = {0.1,0.6,1.5,1.8,0.8},
	-- 			property = {
	-- 				placeName = "place3" ,         --普
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 13,
	-- 			num = 3,
	-- 			delay = {0,1.1,0.5},
	-- 			pos = {400,680,960},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				type = "jin",                  --盾
	-- 				id = 8,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 15,
	-- 			num = 3,
	-- 			delay = {0,1.0,1.5},
	-- 			pos = {350,610,910},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				type = "dao",               --导
	-- 				id = 5,
	-- 				missileId = 6,
	-- 				missileType = "daodan",
	-- 			},                                                          
	-- 		},
	-- 		{
	-- 			time = 16,
	-- 			num = 3,
	-- 			delay = {0,0.5,1},
	-- 			pos = {300,370,440},
	-- 			property = { 
	-- 				placeName = "place3" ,
	-- 				id = 1,
	-- 				startState = "rollright",	
	-- 			},                                                          
	-- 		},	
	-- 		{
	-- 			time = 17,
	-- 			num = 3,
	-- 			delay = {0,0.7,1.4},
	-- 			pos = {700,900,1100},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				id = 1,
	-- 				startState = "rollleft",	
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 18,
	-- 			num = 2,
	-- 			delay = {0,0.6},
	-- 			pos = {380,560},
	-- 			property = { 
	-- 				placeName = "place4" ,
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},
	-- 	},
	-- },

	{	
		waveType = "boss",                                      --强敌出现
		enemys = {                                                 -- 多足蜘蛛boss
			{
				descId = "dzboss_1", --简介
				time = 3,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "duozuBoss",
					placeName = "place1",
					wangId    = 19,
					missileId = 20, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50) , cc.p(150, 150)},
					id = 2,
				},
			},
		},
	},	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=21,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=28,hp=2000,
	weak1=1},
                                                           
	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=3000,
	weak1=1},	

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=50000,fireRate=180,fireCd=5,speed=40, scale = 1.8 ,
	weak1=2, weak4=4},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=5000,fireRate=30,speed=130,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=70000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=5000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=15,hp=20000},  

	--BOSS导弹          --missileType = "daodan",
	{id=20,image="daodan",demage=35,hp=3000,
	weak1=1},

	--小蜘蛛   --type = "bao",
	{id=21,image="xiaozz",demage=15,hp=5000, speed=120,
	weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=10,hp=5000, weak1=1},--打击者金武平均伤害5558

}

	--boss的关卡配置
local bosses = {
	--第1个出场的boss
	
	{
		image = "boss01_1", --图片名字
		award = 50000,                   --boss产出金币数量
		hp = 160000,
		demage = 4,
		fireRate = 60,
		fireCd = 3,  		
		walkRate = 120,
		walkCd = 2,         --移动cd	
		wudiTime = 6 , 	
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射10下
		weak1 = 1.1,					--手  弱点伤害倍数
		weak2 = 1.1,					--腹  弱点伤害倍数
		weak3 = 1.1,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)


                                    
			wudi = {0.91,0.71,0.51,0.31,0.11            --无敌
			},                                        

			saoShe = { 0.85, 0.70, 0.50, 0.30 , 0.10   --调用普通攻击的伤害  扫射
			}, 

			--zhaohuan = {0.95,0.65,0.35},                                        --召唤 

			moveLeftFire = {
				0.90, 0.60, 0.30, 
			},
			-- moveRightFire = {
			-- 	0.75, 0.35,
			-- },

			daoDan1 = {                                            --两发导弹
				0.99, 0.75, 0.45, 
			},

			daoDan2 = {                                            --两发导弹
				0.80, 0.55, 0.34,
			},

			daoDan3 = {                                            --两发导弹
				0.64, 0.22, 0.15
			},

			weak1 = {
				0.70,0.50,0.10
			},	
			weak2 = {
				0.80,0.60,0.30
			},	
			weak3 = {
				0.90,0.40,0.20
			},

			

			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.70,
			},	
			demage400 = {  
				0.40,
			},							
		},
		
		daoDan1 = {
		    id = 20,                                 --boss导弹
			type = "missile", 
			timeOffset = 0.1,                        --导弹间隔时间 
            flyTime = 5.0,                           --导弹飞到脸前的时间 
            srcPoses = {
						cc.p(-225, -165), cc.p(-300, -200), cc.p(-225, -265), cc.p(-150,-300), cc.p(-75, -265),cc.p(0, -200), 
						cc.p(75, -165), cc.p(150, -100), cc.p(225, -165),cc.p(300, -200), cc.p(225, -265),         
			}, 
			offsetPoses = { 
						cc.p(-225, -165), cc.p(-300, -200), cc.p(-225, -265), cc.p(-150,-300), cc.p(-75, -265),cc.p(0, -200), 
						cc.p(75, -165), cc.p(150, -100), cc.p(225, -165),cc.p(300, -200), cc.p(225, -265),  
			},
		},
		daoDan2 = {
		    id = 20,                                 --boss导弹
			type = "missile", 
			timeOffset = 0.1,                        --导弹间隔时间 
            flyTime = 5.0,                           --导弹飞到脸前的时间 
            srcPoses = {
						cc.p(-300, -200), cc.p(-225, -265), cc.p(-150,-300), cc.p(-75, -265),cc.p(0, -200), 
						cc.p(75, -165), cc.p(150, -100), cc.p(225, -165),cc.p(300, -200),
						 --cc.p(-0, -250), cc.p(-0, -250), cc.p(-0, -250),           
			}, 
			offsetPoses = { 
						cc.p(-300, -200), cc.p(-225, -265), cc.p(-150,-300), cc.p(-75, -265),cc.p(0, -200), 
						cc.p(75, -165), cc.p(150, -100), cc.p(225, -165),cc.p(300, -200),
						 --cc.p(-0, -250), cc.p(-0, -250), cc.p(-0, -250),  
			},
		},
		daoDan3 = {
		    id = 20,                                 --boss导弹
			type = "missile", 
			timeOffset = 0.1,                        --导弹间隔时间 
            flyTime = 5.0,                           --导弹飞到脸前的时间 
            srcPoses = {
						cc.p(-300, -200), cc.p(-225, -265), cc.p(-150,-300), cc.p(-75, -265),cc.p(0, -200), 
						cc.p(75, -165), cc.p(150, -100), cc.p(225, -165),cc.p(300, -200),
						 --cc.p(-0, -250), cc.p(-0, -250), cc.p(-0, -250),           
			}, 
			offsetPoses = { 
						cc.p(-300, -200), cc.p(-225, -265), cc.p(-150,-300), cc.p(-75, -265),cc.p(0, -200), 
						cc.p(75, -165), cc.p(150, -100), cc.p(225, -165),cc.p(300, -200),
						 --cc.p(-0, -250), cc.p(-0, -250), cc.p(-0, -250),  
			},
		},

		getMoveLeftAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
			local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
			local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
			local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,

		getMoveRightAction = function ()
			local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
			local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
			local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
			local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
			local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
			return cc.Sequence:create(move1, move2, move3, move4, move5)
		end,
	},

-------第2个出场的boss
	{
		image = "dzboss_1", --图片名字
		award = 50000,                   --boss产出金币数量
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
			wudi = { 0.91, 0.71, 0.51 , 0.31, 0.10
			}, 

			zhaohuan = { 0.90, 0.70, 0.40,                    --召唤小兵
			},   

			wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15                    --网
			},

			daoDan1 = {                                            --两发导弹
				0.95, 0.75, 0.45, 
			},

			daoDan2 = {                                            --两发导弹
				0.80, 0.55, 0.34,
			},

			daoDan3 = {                                            --两发导弹
				0.64, 0.22, 0.15,
			},



			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.85,
			},
			demage250 = {
				0.60,
			},
			demage350 = {
				0.50,
			},			
		},


		daoDan1 = {
		    id = 22,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 0.06,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            	cc.p(-300, 300), cc.p(300, 300), cc.p(0, -300),
        	},
        },

		daoDan2 = {
		    id = 22,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 0.06,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            	cc.p(-300, 300), cc.p(300, 300), cc.p(0, -300),
        	},
        },

		daoDan3 = {
		    id = 22,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 0.06,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            	cc.p(-300, 300), cc.p(300, 300), cc.p(0, -300),
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
					id = 21,	
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
					id = 21,
					demageScale = 2 ,                   --伤害翻1.5倍	
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
					id = 21,
					demageScale = 3  ,                  --伤害翻2倍	
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
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end


return waveClass