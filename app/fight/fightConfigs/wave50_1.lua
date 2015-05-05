local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {                                                                --盾牌boss
			{
				descId = "boss01",  --简介
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
-----------------------------------------------------------------------------------------------------------第1个boss
	{
		enemys = {                                                                -- 红枪boss
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
-----------------------------------------------------------------------------------------------------------第2个boss
	{
		enemys = {                                                                -- 紫炮boss
			{
				descId = "boss01_2", --简介
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
-----------------------------------------------------------------------------------------------------------第3个boss
			
	{	
		enemys = {                                                 -- 多足蜘蛛boss
			{
				descId = "dzboss", --简介
				time = 3,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "duozuBoss",
					placeName = "place1",
					wangId    = 27,
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

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=30,hp=5000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=3},

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

	--BOSS导弹          --missileType = "daodan",
	{id=20,image="daodan",demage=35,hp=3000,
	weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=10,hp=5000, weak1=1},--打击者金武平均伤害5558

	--大黑导弹          --missileType = "daodan",
	{id=23,image="daodan02",demage=50,hp=3000, weak1=1},

	--BOSS铁球
	{id=24,image="tieqiu",demage= 50,hp=9000, weak1=1},

	--boss扔的汽车
	{id=25,image="qiche",demage=20,hp=4000,weak1=1},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=12,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--蜘蛛网
	{id=27,image="zzw",demage=15,hp=20000},

	--小蜘蛛   --type = "bao",
	{id=28,image="xiaozz",demage=15,hp=5000, speed=120,
	weak1=1},

	

}

	--boss的关卡配置
local bosses = {
	{
		image = "boss01", --图片名字
		-- hp = 60000,
		award = 10000,                   --boss产出金币数量
		hp = 30000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,
		fireCd = 2,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间
		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 15, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)
                       
			-- wudi = {0.91,0.71,0.51,0.31                    --无敌
			-- },                                        

			saoShe = { 0.90, 0.63, 0.35 },                --调用普通攻击的伤害  扫射 

			zhaohuan = {0.95, 0.70, 0.40 },                         --召唤小怪 

			moveLeftFire = { 0.85 , 0.30 },
			moveRightFire = { 0.60, },
			

			daoDan1 = {                                            --两发导弹
				0.99, 0.45, 0.10
			},

			daoDan2 = {                                            --两发导弹
				0.80, 0.50, 0.20
			},

			daoDan3 = {                                            --两发导弹
				0.75, 0.25, 0.15
			},

			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80,0.20,
			},

			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.65,
			},	
			demage400 = {  
				0.30,
			},							
		},

		daoDan1 = {
		
		    id = 20,                                 --boss导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(-300, 0), cc.p(300, 0), 
           }               
		},
		daoDan2 = {
			id = 20,                                 --boss导弹
			type = "missile",
			offsetPoses = {
                cc.p(0, 0), cc.p(0, -500), 
           }               
		},
		daoDan3 = {
			id = 20,                                 --boss导弹
			type = "missile",                        
			offsetPoses = {
                cc.p(-300, -300), cc.p(300, -300), 
           }               
		},


		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 0,	
				num = 3,
				pos = {360,660,960},
				delay = {0.7,0,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
		},
		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 0,	
				num = 4,
				pos = {360,560,860,1050},
				delay = {1,0,0.7,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
		},
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 0,	
				num = 5,
				pos = {420,620,830,920,1100},
				delay = {1.4,0,0.7,1.4,0.3},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
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
-----------------------------------------------------------------------------------------------------------第1个出场的boss	
	{
		image = "boss01_1", --图片名字
		award = 10000,                   --boss产出金币数量
		hp = 30000,
		--hp = 60000,
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


                                    
			wudi = {0.91,0.71,0.51,0.31,0.11                         --无敌
			},                                        

			saoShe = { 0.85, 0.70, 0.50, 0.30 , 0.10   --调用普通攻击的伤害  扫射
			}, 

			zhaohuan = {0.95, 0.65, 0.35},                           --召唤 

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
-----------------------------------------------------------------------------------------------------------第2个出场的boss
	{
		image = "boss01_2", --图片名字
		-- hp = 150000,
		award = 10000,                   --boss产出金币数量
		hp = 60000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,
		fireCd = 2,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间
		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 15, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)
                       
			-- wudi = {0.91,0.71,0.51,0.31                    --无敌
			-- },                                        

			saoShe = { 0.90, 0.63, 0.35 },                --调用普通攻击的伤害  扫射 

			zhaohuan = {0.95, 0.70, 0.40 },                         --召唤小怪 

			moveLeftFire = { 0.85 , 0.30 },
			moveRightFire = { 0.60, },
			

			daoDan1 = {                                            --两发导弹
				0.99, 0.45, 0.10
			},

			daoDan2 = {                                            --两发导弹
				0.80, 0.50, 0.20
			},

			daoDan3 = {                                            --两发导弹
				0.75, 0.25, 0.15
			},

			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80,0.20,
			},

			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.65,
			},	
			demage400 = {  
				0.30,
			},							
		},

		daoDan1 = {
		
		    id = 20,                                 --boss导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(-300, 0), cc.p(300, 0), 
           }               
		},
		daoDan2 = {
			id = 20,                                 --boss导弹
			type = "missile",
			offsetPoses = {
                cc.p(0, 0), cc.p(0, -500), 
           }               
		},
		daoDan3 = {
			id = 20,                                 --boss导弹
			type = "missile",                        
			offsetPoses = {
                cc.p(-300, -300), cc.p(300, -300), 
           }               
		},


		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 0,	
				num = 3,
				pos = {360,660,960},
				delay = {0.7,0,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
		},
		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 0,	
				num = 4,
				pos = {360,560,860,1050},
				delay = {1,0,0.7,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
		},
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 0,	
				num = 5,
				pos = {420,620,830,920,1100},
				delay = {1.4,0,0.7,1.4,0.3},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
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
-----------------------------------------------------------------------------------------------------------第1个出场的boss	
	{
		image = "dzboss_1", --图片名字
		award = 50000,                   --boss产出金币数量
		hp = 250,
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
					id = 28,	
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
					id = 28,
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
					id = 28,
					demageScale = 3  ,                  --伤害翻2倍	
				},
			},
		},													
	},
-----------------------------------------------------------------------------------------------------------第3个出场的boss
}

local mapId = "map_1_6"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "bossContest",
	}

	self.randomWaveOrders = {
		{1, 2, 3, 4},
		{1, 2, 3, 4},
		{1, 2, 3, 4},
		{1, 2, 3, 4},
	}
	self:randomWaves()
end

return waveClass