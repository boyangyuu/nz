local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {790,420},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0,0.5,1},
				pos = {640,900,320},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 7,
				num = 4,
				delay = {0.4,0,0.8,1.3},
				pos = {200,400,600,800},
				property = { 
					placeName = "place13" ,
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",           --导
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {230,330,510},
				delay = {0.5,0,1},
				property = {
					placeName = "place2" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {270,570},
				delay = {0.5,0},
				property = {
					placeName = "place2" ,         --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {1000,800,600},
				delay = {0,0.5,1},
				property = {
					placeName = "place3" ,         --普
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 3,
				delay = {0.9,0.5,0},
				pos = {970,870,570},
				property = {
					placeName = "place3" ,         --雷
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 5,
				delay = {0,0.7,1.4,2.1,2.8,},
				pos = {220,300,500,700,900,},
				property = { 
					placeName = "place2" ,
					type = "bao",
					startState = "san",
					id = 4,
				},
			},
			{
				time = 13,
				num = 5,
				delay = {3.5,0,0.7,1.4,2.1},
				pos = {300,450,600,750,940},
				property = { 
					placeName = "place1" ,
					type = "common",
					startState = "san",
					id = 1,
				},
			},
		},
	},
	{
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {790,420},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0,0.5,1},
				pos = {640,900,320},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 7,
				num = 4,
				delay = {0.4,0,0.8,1.3},
				pos = {200,400,600,800},
				property = { 
					placeName = "place13" ,
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",           --导
				},
			},
			{
				time = 8,
				num = 1,
				pos = {450},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place11",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,                                    --持续时间			
				},
			},	
			{
				time = 9,	
				num = 3,
				pos = {230,330,510},
				delay = {0.5,0,1},
				property = {
					placeName = "place2" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {270,570},
				delay = {0.5,0},
				property = {
					placeName = "place2" ,         --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 10,
				delay = {0,0.7,1.4,2.1,2.8,3.5,0,0.7,1.4,2.1},
				pos = {220,300,380,460,540,620,700,780,860,940},
				property = { 
					placeName = "place1" ,
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 3,
				pos = {1000,800,600},
				delay = {0,0.5,1},
				property = {
					placeName = "place3" ,         --普
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0.9,0.5,0},
				pos = {970,870,570},
				property = {
					placeName = "place3" ,         --雷
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},

		},
	},
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                              --boss
			{
				descId = "boss02_1",
				time = 3,	
				num = 1,
				pos = {450},
				delay = {4},
				property = { 
					type = "chongBoss",
					placeName = "place8",
					missileId = 19,                 --导弹id        
					qiuId = 13,                   --铁球id
					id = 1,
				},
			},		
		},
	},

}




--enemy的关卡配置                                                    白银镶嵌 MP5伤害90  dps大于等于3,远程3近战3 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=12,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4, weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4, weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=12,hp=1, weak1=1},

	--自爆兵        --type = "bao",
	{id=4,image="zibaob",demage=15,hp=571,fireRate=30,speed=130,
	weak1=2},	
	                                                           
	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=749,walkRate=120,walkCd=2,fireRate=240,fireCd=5, weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1, weak1=1},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=15,hp=5616,fireRate=180,fireCd=5,speed=35, weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=16000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--BOSS铁球
	{id=13,image="tieqiu",demage= 50,hp=9000, weak1=1},

	--BOSS导弹          type = "missile",
	{id=19,image="daodan",demage=15,hp=1000, weak1=1},	

	--烟雾导弹           type = "dao_wu",
	{id=21,image="daodan03",demage=10,hp=5600, weak1=1},--打击者金武平均伤害5558
	
}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		award = 25000,         ----boss产出金币数量
		image = "boss02_1",    --蓝boss基础上改的肌肉boss
		hp = 250000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 25,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数               

		
		skilltrigger = {   			          --技能触发(可以同时)

			daoDan1 = {                                            --烟雾导弹
				0.95, 0.70, 0.50, 0.30, 0.15,
			},
			moveLeftFire = {
				0.90, 0.55,
			},
			moveRightFire = {
				0.75, 0.35,
			},
			chongfeng = {
			    0.85, 0.65, 0.45, 0.25, 0.10,
			},
			tieqiu = {
				0.80, 0.60, 0.40, 0.20, 0.05,
			},	
			


			-- daoDan2 = {                                            --暴雨梨花弹
			-- 	0.70, 0.30,
			-- },


			weak2 = {                               --手 技能触发(可以同时)
				0.80, 0.40,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.60, 0.20,                      
			},
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.70,
			},	
			demage400 = {  
				0.50,
			},						
		},

		daoDan1 = {
		    id = 21,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 0.06,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            cc.p(-300, -300), cc.p(-300, 300), cc.p(300, 300), cc.p(300, -300), 
           },
           -- 	srcPoses =    {--起始点
           --  cc.p(-300, -300), cc.p(-300, 300), cc.p(300, 300), cc.p(300, -300), 
           -- }, 

		},
		-- daoDan2 = {
		-- 	id = 19,                                 --boss导弹
		-- 	type = "missile",
		-- 	timeOffset = 0.08,                       --导弹间隔时间
		-- 	offsetPoses = {
  --           	cc.p(0, 300), cc.p(-300, 0), cc.p(0, -300), cc.p(300, 0), 
		-- 		cc.p(300, -300), cc.p(-300, -300), cc.p(-300, 300), cc.p(300, 300),
		-- 		cc.p(-300, 0), cc.p(0, 300), cc.p(300, 0), cc.p(0, -300),
  --          }               
		-- },


		-- daoDan1 = {
		--     id = 21,                                  --烟雾
		-- 	type = "dao_wu",                  
		-- 	offsetPoses = {
  --               cc.p(-300, 0), cc.p(300, 0), 
  --          }               
		-- },
		-- daoDan2 = {
		-- 	id = 19,                                 --boss导弹
		-- 	type = "missile",
		-- 	offsetPoses = {
  --               cc.p(0, 0), cc.p(0, -500), 
  --          }               
		-- },
		-- daoDan3 = {
		-- 	id = 22,                                 --大黑导弹
		-- 	type = "missile",                        
		-- 	offsetPoses = {
  --               cc.p(-300, -300), cc.p(300, -300), 
  --          }               
		-- },




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

local mapId = "map_1_2"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
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
