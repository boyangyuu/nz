local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				pos = {450},
				delay = {0},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		                                    --持续时间		
				},
			},
			{
				time = 4,	
				num = 3,
				pos = {400,700,1000},                                 -- 空投盾兵
				delay = {0,1,0.5},
				property = {
					placeName = "place3",
					type = "jin",
					startState = "san",
					id = 9,
				},
			},
			{
				time = 6,
				num = 1,
				pos = {300,},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place1",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0,0.5,1},
				pos = {250,500,1100},
				property = { 
					placeName = "place11" ,
					id = 4,
					type = "juji",                    --狙击             
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0,},
				pos = {430,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
		
		},
	},	
	{
		enemys = { 
			{
				time = 2,	
				num = 3,
				pos = {400,700,1000},                                 -- 空投盾兵
				delay = {0,1,0.5},
				property = {
					placeName = "place3",
					type = "jin",
					startState = "san",
					id = 9,
				},
			},
			{
				time = 2,
				num = 1,
				pos = {450,},
				delay = {0,},                          -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0,1},
				pos = {270,1060},
				property = { 
					placeName = "place11" ,
					id = 4,
					type = "juji",                 --狙击             
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 14,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
			{
				time = 18,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},

			{
				time = 22,
				num = 20,
				delay = {0.5,1.2,0,0.4,0.9,1.1,1.2,1.3,1.4,1.5,2.4,2.3,2.2,2.1,2.5,3.9,3.5,3.0,3.5,3.0},
				pos = {180,300,550,750,930,850,250,550,200,400,180,300,550,750,930,850,250,550,200,400},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 20,	
				},
			},
		},
	},	
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                                               
			{
				descId = "boss01_2", --简介               -- 紫炮boss
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place1",
					missileId = 21,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss     
				},
			},
		},
	},

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于5  怪物数据
local enemys = {

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=30,hp=25000, rollRate=180,rollCd=3,fireRate= 60, fireCd = 6,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=5000,
	weak1=1},

	--自爆兵        --type = "bao",
	{id=8,image="zibaob",demage=25,hp=10000,fireRate=30,speed=130,scale = 1.8,
	weak1=2},

	--盾兵         --type = "jin",
	{id=9,image="dunbing",demage=25,hp=60000,fireRate=180,fireCd=6,speed=35, scale = 1.9,--scale = 3.0,  近战走到屏幕最近放缩比例
	weak1=2, weak4=3,},

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=20,hp=25000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=70000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=70000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=5000, weak1=1}, 

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=5000, speed=80,
	weak1=1},

	--BOSS导弹          type = "missile",
	{id=21,image="daodan",demage=25,hp=6000, weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=25,hp=6000, weak1=1},           --打击者金武平均伤害5558

	--大黑导弹           type = "missile",
	{id=23,image="daodan02",demage=200,hp=10000, weak1=1},



}

	--boss的关卡配置
local bosses = {
	--出场的boss
	{
		image = "boss01_2", --图片名字                         紫炮
		award = 50000,                   --boss产出金币数量
		hp = 300000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,
		fireCd = 2,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)

			saoShe = { 0.80, 0.60, 0.40, 0.20, },                --调用普通攻击的伤害  扫射               
			wudi = {0.90, 0.70, 0.50, 0.30,},                    --无敌                                        
			zhaohuan = {0.91,},                         --召唤boss 
			moveLeftFire = { 0.90, 0.50, },
			moveRightFire = { 0.70, 0.30, },			

			daoDan1 = {                                            --两发导弹
				0.99, 0.85, 0.75, 0.65, 0.55, 0.45, 0.35, 0.25, 0.15,
			},

			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80, 0.20,
			},
			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.60,
			},	
			demage300 = {  
				0.30,
			},							
		},

		daoDan1 = {
		    id = 23,                                 --大黑导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(0, 0),
           }               
		},



		enemys1 = {                                                     
			{
				time = 0,	
				num = 1,
				pos = {350},
				delay = {0},
				property = {
					type = "boss",                               --召唤的盾牌boss
					placeName = "place4",
					missileId = 21,            --BOSS导弹ID
					id = 2,            --boss里面id为1  ,以后有可能有很多boss         
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {900},
				delay = {0},
				property = {
					type = "boss",                               --召唤的红枪boss
					placeName = "place5",
					missileId = 21,            --BOSS导弹ID
					id = 3,            --boss里面id为1  ,以后有可能有很多boss         
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
	{
		image = "boss01", --图片名字                         盾牌boss
		award = 10000,                   --boss产出金币数量
		hp = 150000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,                  --0就不普通攻击了
		fireCd = 2,  		
		walkRate = 60,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 15, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)
                       
			saoShe = { 0.90, 0.60, 0.30 },                --调用普通攻击的伤害  扫射 			

			daoDan1 = {                                            --烟雾导弹
				0.99, 0.80, 0.60, 0.40, 0.20,
			},

			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80, 0.20,
			},
			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.60,
			},	
			demage300 = {  
				0.30,
			},							
		},

		daoDan1 = {
		
		    id = 22,                                 --烟雾导弹
			type = "dao_wu",                  
			offsetPoses = {
                cc.p(-150, 0), cc.p(150, 0), 
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
--------------------------------------------------------------------------------------------------第1个出场的boss 盾牌	id = 2
	{
		image = "boss01_1", --图片名字                         红枪boss
		award = 10000,                   --boss产出金币数量
		hp = 150000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,                  --0就不普通攻击了
		fireCd = 2,  		
		walkRate = 60,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 15, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)
                       
			saoShe = { 0.90, 0.60, 0.30 },                --调用普通攻击的伤害  扫射 			

			daoDan1 = {                                            --boss导弹
				0.99, 0.80, 0.60, 0.40, 0.20,
			},

			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80, 0.20,
			},
			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.60,
			},	
			demage300 = {  
				0.30,
			},							
		},

		daoDan1 = {
		
		    id = 22,                                 --烟雾导弹
			type = "dao_wu",                   
			offsetPoses = {
                cc.p(0, 150), cc.p(0, -150),
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
--------------------------------------------------------------------------------------------------第2个出场的boss 红枪  id = 3
}
local limit = 10   				--此关敌人上限

local mapId = "map_1_6"

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

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass