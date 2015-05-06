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
					missileId = 13,
					missileType = "dao_wu",
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
				time = 12,	
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
				time = 13,
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
				time = 14,
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
				time = 16,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.1,0.6,1.5,1.8,0.8},
				property = {
					placeName = "place4" ,        
					startState = "rollright",
					id = 1,
					startState = "san",
				},
			},
			{
				time = 18,
				num = 3,
				delay = {0,1.0,1.5},
				pos = {250,410,510},
				property = { 
					placeName = "place2" ,
					type = "dao",                              --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
			{
				time = 20,
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
				time = 22,
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
				time = 24,
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
					startState = "san",
				},
			},
			{
				time = 12,
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
				num = 1,
				pos = {400},
				delay = {0},                            -- 吉普车
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
				time = 16,
				num = 5,
				delay = {0,0.7,1.4,1.8,0.5},
				pos = {1000,900,800,700,600},					
				property = {
					placeName = "place4" ,
					id = 1,
					startState = "san",
				},
			},
			{
				time = 18,
				num = 3,
				delay = {0.2,1.0,1.8},
				pos = {200,380,560},
				property = { 
					placeName = "place2" , 
					type = "jin",                              --盾
					id = 8,
				},
			},
			{
				time = 22,	
				num = 5,
				pos = {25,120,310,470,600},
				delay = {0.2,0.9,1.8,2.5,3.3},                  --近
				property = {
					placeName = "place2" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 26,
				num = 3,
				delay = {0.1,0.9,1.7},
				pos = {250,460,600},
				property = { 
					placeName = "place2" ,
					type = "bao",                                --爆
					id = 9,
					startState = "san",
				},
			},
			{
				time = 28,
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
				time = 30,
				num = 5,
				delay = {0,0.7,1.4,1.8,0.5},
				pos = {1000,900,800,700,600},					
				property = {
					placeName = "place4" ,
					id = 1,
					startState = "rollleft",
					startState = "san",
				},
			},	
		},
	},
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                              --冲锋铁球召唤医疗 CF boss
			{
				descId = "boss02_1",
				time = 3,	
				num = 1,
				pos = {450},
				delay = {4},
				property = { 
					type = "chongBoss",
					placeName = "place1",
					missileId = 19,                 --导弹id
					qiuId = 18,                   --铁球id
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
	weak1=2, weak4=3},

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
	{id=8,image="dunbing",demage=25,hp=45000,fireRate=180,fireCd=5,speed=40,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=5000,fireRate=30,speed=120,
	weak1=2, weak4=3 },	

	--越野车       type = "jipu",
	{id=12,image="yyc",demage=0,hp=60000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--吉普车烟雾导弹          type = "dao_wu",
	{id=13,image="daodan03",demage=10,hp=3500, weak1=1}, 

	--BOSS铁球
	{id=18,image="tieqiu",demage= 50,hp=9000, weak1=1},

	--BOSS导弹            type = "missile",
	{id=19,image="daodan",demage=15,hp=1000, weak1=1},
 
	--烟雾导弹            type = "dao_wu",
	{id=21,image="daodan03",demage=10,hp=5000, weak1=1},   --打击者金武平均伤害5558

	--医疗兵              type = "yiliao",
	{id=25,image="yiliaob",demage=12,hp=5000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=12,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		award = 25000,         ----boss产出金币数量
		image = "boss02_1",    --蓝boss基础上改的肌肉boss
		hp = 150000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 25,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数               

		
		skilltrigger = {   			          --技能触发(可以同时)

			-- daoDan1 = {                                            --烟雾导弹
			-- 	0.95, 0.70, 0.50, 0.30, 0.15,
			-- },
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
			zhaohuan = { 0.95, 0.70, 0.50, 0.30,                      --召唤小兵
			},	
			



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
				0.60,
			},	
			demage400 = {
				0.30,
			},						
		},

		-- daoDan1 = {
		--     id = 21,                                  --烟雾
		-- 	type = "dao_wu",  
		-- 	timeOffset = 0.06,                        --导弹间隔时间                 
		-- 	offsetPoses = {                  --目标点
  --           cc.p(-300, -300), cc.p(-300, 300), cc.p(300, 300), cc.p(300, -300), 
  --          },
		-- },

		enemys1 = {                                                   --第1波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {800,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
		},
		enemys2 = {                                                   --第2波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {260,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {860,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
		},
		enemys3 = {                                                   --第3波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {470,},
				property = { 
					placeName = "place6" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
		},
		enemys4 = {                                                   --第4波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {370,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {950,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
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
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
	
end
return waveClass