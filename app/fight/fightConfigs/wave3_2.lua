local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
--[[
	{
		enemys = { 

			{
				time = 3,
				num = 5,
				delay = {0.1,0.3,0.5,0.3,0.1},
				pos = {230,330,500,590,690},
				property = { 
					placeName = "place1" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 4,	
				num = 5,
				pos = {250,330,510,600,700},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place1" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 6,
				num = 5,
				delay = {2.0,2.5,3,2.5,2.0},
				pos = {200,350,680,490,250},
				property = { 
					placeName = "place1" ,
					type = "jin",                  --盾 15
					id = 8,
				},
			},

			
			{
				time = 20,
				num = 5,
				delay = {0.1,1.0,2.5,1.6,1.9,},
				pos = {290,350,460,600,456,},
				property = { 
					placeName = "place1" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 24,
				num = 5,
				delay = {1.6,1.9,2.1,0.3,0.8},
				pos = {290,350,460,600,570},
				property = { 
					placeName = "place1" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 27,	
				num = 5,
				pos = {250,330,510,600,700},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place1" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 29,	
				num = 5,
				pos = {650,530,310,400,200},
				delay = {1.5,0.9,0.4,1.3,1.8},
				property = {
					placeName = "place1" ,         --近
					id = 7,
					type = "jin",
				},
			},

			{
				time = 31,
				num = 1,
				delay = {0.6},
				pos = {470},
				property = { 
					placeName = "place12" ,
					type = "jin",                  --近boss                                 
					id = 16,
				},
			},
			
			
		},
	},

	{
		enemys = {
			{
				time = 3,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {350,560,700},
				property = { 
					placeName = "place1" ,
					type = "bao",                  --爆
					id = 9,	
				},
			},
			{
				time = 3.5,	
				num = 5,
				pos = {325,420,220,550,700},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place1" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 3.5,
				num = 3,
				delay = {2.0,2.5,3},
				pos = {400,300,670},
				property = { 
					placeName = "place1" ,
					type = "jin",                  --盾
					id = 8,
				},
			},

			{
			    
				time = 7,
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
					lastTime = 30.0,		                                    --持续时间			
				},
			},	
			{
				time = 15,
				num = 3,
				delay = {0.1,0.2,0.3},
				pos = {250,460,600},
				property = { 
					placeName = "place1" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 15,	
				num = 5,
				pos = {250,350,310,470,600},
				delay = {0.4,0.9,0.5,0.8,1.5},
				property = {
					placeName = "place1" ,
					id = 7,
					type = "jin",
				},
			},
			{
				time = 15,
				num = 3,
				delay = {2.8,2.5,3},
				pos = {300,460,560},
				property = { 
					placeName = "place1" ,
					type = "jin",       --盾
					id = 8,
				},
			},
			{
			    
				time = 20,
				num = 1,
				pos = {550},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 23.0,		                                    --持续时间			
				},
			},	
			{    
				time = 22,
				num = 1,
				pos = {850},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 20.0,		                                    --持续时间			
				},
			},	
			{
				time = 21,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place1",  
					type = "san",
					id = 4,
					enemyId = 1,
				},                                                                            --60
			},	
		},
	},
]]
	{
		enemys = {  
			--   蓝boss 白银 （2条）   
			--  		黄金 （3条）      血量（100）
			{
				time = 3,	
				num = 1,
				pos = {450},
				delay = {4},
				property = { 
					type = "chongBoss",
					placeName = "place8",
					enemyId = 6,                 --导弹id        
					qiuId = 19,                   --铁球id
					id = 2,
				},
			},	

			-- 忍者 白银 （3条）      血量（ -100 - 100）
			--      黄金 （3条）      血量（100）
			{
				time = 2,	
				num = 1,
				pos = {368},
				delay = {4},
				property = { 
					type = "renzheBoss",
					placeName = "place13",
					missileId = 18, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50)},
					id = 1,
				},
			},
		},
	},

}



--enemy的关卡配置                                                    青铜镶嵌 MP5伤害80  dps大于等于3 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=12,hp=405,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=270,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=12,hp=135,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=405,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=540,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=375,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=12,hp=675,fireRate=180,fireCd=4,speed=40,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=15,hp=1350,fireRate=180,fireCd=5,speed=35,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=15,hp=270,fireRate=30,speed=100,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=10000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=10000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=9,hp=10000,fireRate=120,fireCd=3,speed=40,scale = 2.5 ,
	weak1=3},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="renzb",demage=35,hp=25000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3},	

	--飞镖
	{id=18,image="feibiao",demage=10,hp=7000},                             

	--铁球
	{id=19,image="tieqiu",demage=20,hp=3760,weak1=1},

}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "renzb",                       --图片名字
		hp = 100000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 40,                --冲锋造成伤害
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)

			feibiao1 = { 0.80, 0.60, 0.30              --暴雨梨花针1
			},
			-- feibiao2 = {                --暴雨梨花针2
			-- 	0.89,0.88,0.86,
			-- },							
			zhaohuan = { 0.90,0.70, 0.40                    --召唤分身
			},                                           
			chongfeng = { 0.95, 0.85, 0.75,0.65, 0.55, 0.45, 0.25, 0.15     --冲锋
			},


			weak3 = {                               --右腿 技能触发(可以同时)
				0.85,0.65,0.45, 0.25,                        
			},	
			weak2 = {                               --左腿 技能触发(可以同时)
				0.80,0.60,0.40, 0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.70,0.50,0.30,0.10                        
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

		feibiao1 = {
			offsetPoses = {
               cc.p(0, 200), cc.p(-200, 0), cc.p(0, -200), cc.p(200, 0), 
               cc.p(300, -300), cc.p(-300, -300), cc.p(-300, 300), cc.p(300, 300),
               cc.p(-400, 0), cc.p(0, 400), cc.p(400, 0), cc.p(0, -400),}               
		},

		enemys1 = {                                                   --第一波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {800},
				delay = {0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	


		enemys2 = {                                                   --第二波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0.2},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {700},
				delay = {0.4},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {1000},
				delay = {0.6},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			
		},	

		enemys3 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {900},
				delay = {0.2},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0.4},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {600},
				delay = {0.6},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {750},
				delay = {0.8},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},

		},	
	},
	{

		image = "boss02", --图片名字
		hp = 100000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 100,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 120,                    --移动频率
		walkCd = 2,                         --移动cd
		chongfengDemage = 25,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数

		
		skilltrigger = {   			          --技能触发(可以同时)
			moveLeftFire = {
				0.90,  0.50, 0.10,
			},
			moveRightFire = {
				0.70,  0.30, 
			},
			chongfeng = {
			     0.95, 0.93, 0.85, 0.75, 0.65, 0.45, 0.35, 0.25, 0.15, 0.05,
			},
			tieqiu = {
				0.999, 0.80, 0.60, 0.40, 0.20, 0.10,
			},	
			weak2 = {                               --手 技能触发(可以同时)
				0.80,0.60,0.40, 0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.70,0.50,0.30,0.10                        
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
	self.goldLimits = {25,55,90,130}   --黄武激活所需杀人个数
end

return waveClass
