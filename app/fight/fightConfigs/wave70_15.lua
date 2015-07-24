local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,	
				num = 2,
				pos = {220,800},
				delay = {0,0.5},
				property = { 
					placeName = "place5",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 3,	
				num = 2,
				pos = {380,720},
				delay = {0,0.4},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {300,500,920},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0,0.3},
				pos = {220,550},
				property = { 
					placeName = "place2" ,
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 9,
				num = 1,
				pos = {300},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		--持续时间			
				},
			},
			{
				time = 13,	
				num = 2,
				pos = {440,660},
				delay = {0.5,0.8},
				property = { 
					placeName = "place2",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 15,
				num = 3,
				pos = {300,800,950},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 17,	
				num = 2,
				pos = {550,900},
				delay = {0,0.4},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 19,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "goldWeapon",                 --黄武
					value = 100,
					placeName = "place1",
				},
			},
	        {
				time = 22,
				num = 1,
				pos = {600},
				delay = {0},                         -- 飞机
				property = {
					type = "feiji",
					id = 11,
					placeName = "place14",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150,-150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 40,		                                    --持续时间		
				},
			},
			{
				time = 24,	
				num = 2,
				pos = {440,660},
				delay = {0.8,1.2},
				property = { 
					placeName = "place6",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 25,
				num = 3,
				pos = {300,700,900},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},                            	
		},                                                              --14个
	},	
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                              --冲锋铁球召唤医疗 CF boss
			{
				descId = "boss02_1",
				time = 2,	
				num = 1,
				pos = {550},
				delay = {4},
				property = { 
					type = "chongBoss",
					placeName = "place13",
					missileId = 29,                 --导弹id
					missileOffsets = {cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) },
					qiuId = 28,                   --铁球id
					id = 1,
				},
			},		
		},
	},
	{
		waveType = "award",
		enemys = {
			{
				time = 2,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {190,270,350,430,510,590,670,750,830,910},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 2,                                                    --2*60 / s   每秒移动60像素(右斜)
					id = 33,
				},
			},
			{
				time = 4,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --左斜
					id = 34,
				},
			},
			{
				time = 10,	                                               --金武奖励箱子
				num = 1,
				pos = {170},
				delay = {0},
				property = { 
					type = "awardSan",
					id =31,
					award = "goldWeapon",
					placeName = "place5",
				},
			},

			{
				time = 12,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 3,                                                    --右斜
					id = 33,
				},
			},
			{
				time = 17,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --横
					id = 34,
				},
			},
			{
				time = 17.5,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 3,                                                    --左斜
					id = 33,
				},
			},
			{
				time = 10,
				num = 10,
				delay = {0, 1.5, 3.0,5.0,9.0,13.5,15,20,25,28},
				pos = {450,750,650,700,800, 1000,800,350,666,888},                                    
				                                                                          -- 黄气球
				property = {
					type = "jinbi",
					placeName = "place10", 
					speed = 5, 
					id = 35,
				},
			},
			{
				time = 3,
				num = 10,
				delay = {0, 3.0, 6.0,7.0,9.0,16.5,20.0,24,28,30},
				pos = {500,900,650,720,690, 400,800,650,430,740},
				property = {
					type = "jinbi",
					placeName = "place5", 
					speed = 4.5, 
					id = 34,
				},
			},
			                                                                                 -- 背景散飞蓝气球
			{
				time = 11,
				num = 10,
				delay = {1, 3.7, 5.4,7,8.7,9.5,14.2,16,21,26},
				pos = {750,450,600,380,800,550,750,350,870,666},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 3.5,
					id = 33,
				},
			},                                                                                -- 背景散飞绿气球
			{
				time = 18,
				num = 5,
				delay = {1, 4, 7,11,15},
				pos = {400, 500, 350, 300, 550},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3.5,
					id = 34,
				},
			},
			{
				time = 19,
				num = 5,
				delay = {1, 4, 7,11,15},
				pos = {40, 50, 55, 280, 300},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 3.5,
					id = 33,
				},
			},
			{
				time = 23.5,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 3,                                                    --左斜
					id = 33,
				},
			},
			{
				time = 29,
				num = 10,
				delay = {0, 0, 0,0,0,0,0,0,0,0},
				pos = {1110,1030,950,870,790,710,630,570,490,410},
				property = {
					type = "jinbi",
					placeName = "place5",  
					speed = 3,                                                    --横
					id = 34,
				},
			},
			{
				time = 30,
				num = 10,
				delay = {0, 0.5, 1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5},
				pos = {410,490,570,630,710,790,870,950,1030,1110},
				property = {
					type = "jinbi",
					placeName = "place6",  
					speed = 3,                                                    --右斜
					id = 33,
				},
			},
			{
				time = 34,
				num = 12,
				delay = {0,0,0,0.7,0.7,0.7,0.7,0.7,1.4,1.4,1.4,2.1},
				pos = {650,750,850,550,650,750,850,950,650,750,850,750},                                    
				                                                                          -- 心形绿气球
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 3, 
					id = 33,
				},
			},
			{
				time = 38,
				num = 6,
				delay = {1,1.5,1.8,2.0,2.5,3},
				pos = {780,660,830,550,666,888},                                    
				                                                                          -- 黄气球
				property = {
					type = "jinbi",
					placeName = "place10", 
					speed = 5, 
					id = 35,
				},
			},
			{
				time = 41,
				num = 12,
				delay = {0,0,0,0.7,0.7,0.7,0.7,0.7,1.4,1.4,1.4,2.1},
				pos = {650,750,850,550,650,750,850,950,650,750,850,750},                                    
				                                                                          -- 心形蓝气球
				property = {
					type = "jinbi",
					placeName = "place6", 
					speed = 3, 
					id = 34,
				},
			},
			{
				time = 44,
				num = 12,
				delay = {0,0,0,0.7,0.7,0.7,0.7,0.7,1.4,1.4,1.4,2.1},
				pos = {650,750,850,550,650,750,850,950,650,750,850,750},                                    
				                                                                          -- 心形金气球
				property = {
					type = "jinbi",
					placeName = "place10", 
					speed = 3, 
					id = 35,
				},
			},
		},
	},


}

--enemy的关卡配置                           dps 4350  dps大于等于4-怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=2755,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=2200,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷
	{id=3,image="shoulei",demage=10,hp=1100,
	weak1=2},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=5500,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=49500, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=2755,
	weak1=1},

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=16,hp=6880,fireRate=180,fireCd=4,speed=60,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=41300,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--吉普车烟雾导弹          missileType = "dao_wu",
  	{id=13,image="daodan03",demage=16,hp=2200, weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=31,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

	--BOSS铁球
	{id=28,image="tieqiu",demage= 50,hp=11000, weak1=1},

	--BOSS导弹            type = "missile",
	{id=29,image="daodan",demage=25,hp=6880, weak1=1},

	--医疗兵              type = "yiliao",
	{id=20,image="yiliaob",demage=10,hp=6880,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=20,hp=11000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

		--金币绿气球   type = "jinbi",
	{id=33,image="qiqiu03",hp=1,weak1=3,award = 20},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=34,image="qiqiu02",hp=1,weak1=3,award = 40},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=35,image="qiqiu01",hp=1,weak1=3,award = 80},	--award = 30  金币数量为30
	
}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		award = 5000,         ----boss产出金币数量
		image = "boss02_1",    --蓝boss基础上改的肌肉boss
		hp = 250000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 30,                --冲锋造成伤害

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
				pos = {100},
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
				pos = {100},
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
				pos = {900},
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
				pos = {0},
				property = { 
					placeName = "place8" ,
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
				pos = {550},
				property = { 
					placeName = "place2" ,
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


local mapId = "map_1_3"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		 --type 	  = "puTong",

		 type 	  = "renZhi",
		 saveNums  = 4,                 --解救人质数量

		--type 	  = "xianShi",
		--limitTime = 90,                   --限时模式时长
		-- limitTime = 10, 
		 --type 	  = "taoFan",
		 --limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass