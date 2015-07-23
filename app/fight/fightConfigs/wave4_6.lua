local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 2,
				num = 1,
				pos = {500,},
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
				time = 4,
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
				time = 8,
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
				time = 12,
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
		enemys = { 

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
				num = 1,
				delay = {0,},
				pos = {400,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 3,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 4,
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
				time = 8,
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
				time = 12,
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
		enemys = {                                                                -- 紫炮boss
			{
				descId = "boss01_2", --简介               -- 紫炮boss
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place1",
					missileId = 6,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss     
				},
			},
		},
	},

}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于4  怪物数据
local enemys = {

    --boss导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=5000,
	weak1=1},

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=16,hp=25000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=50000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=5000, weak1=1},

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=25,hp=5000, speed=70,
	weak1=1},

	--绑匪
	{id=29,image="tufeib",demage=30,hp=20000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=60,fireCd=4, weak1=2},

	--被绑架人        --type = "bangren",
	{id=30,image="hs", hp=5000, weak1=1},

}

	--boss的关卡配置
local bosses = {	
	--出场的boss
	{
		image = "boss01_2", --图片名字                         紫炮
		award = 50000,                   --boss产出金币数量
		hp = 200000,
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

			saoShe = { 0.95, 0.65, 0.35,},                --调用普通攻击的伤害  扫射
                       
			wudi = {0.90, 0.70, 0.50, 0.30,},                    --无敌                                        
 
			zhaohuan = {0.92, 0.72, 0.52, 0.32, },                         --召唤小怪 

			moveLeftFire = { 0.80 , 0.40, },
			moveRightFire = { 0.60, 0.20, },
			

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
				0.80,0.20,
			},

			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.65,
			},	
			demage300 = {  
				0.30,
			},							
		},

		daoDan1 = {
		    id = 6,                                 --boss导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(300, 0), cc.p(-300, 0),
           }               
		},



		enemys1 = {                                                     --第一波召唤的人质
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质1",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 29,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质1",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 30,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质2",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 29,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质2",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 30,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质3",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 29,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质3",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 30,
				},
			},
		},
		enemys2 = {                                                     --第一波召唤的人质
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质4",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 29,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质4",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 30,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质5",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 29,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质5",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 30,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质6",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 29,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质6",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 30,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {350},
				property = {
					renzhiName = "人质7",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 29,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {350},
				property = {
					renzhiName = "人质7",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 30,
				},
			},
		},
		enemys3 = {                                                     --第一波召唤的人质
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质8",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 29,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质8",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 30,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质9",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 29,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质9",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 30,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质10",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 29,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质10",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 30,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质11",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 29,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质11",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 30,
				},
			},
		},
		enemys4 = {                                                     --第一波召唤的人质
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质12",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 29,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质12",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 30,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质13",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 29,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质13",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 30,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质14",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 29,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质14",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 30,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质15",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 29,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质15",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 30,
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