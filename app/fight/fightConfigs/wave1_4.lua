local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
-------------- 汽油桶配置 ----------------------
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {250},
				property = { 
					placeName = "place2",
					type = "bao_tong",
					id = 4,
				},
			},
----------------------------------------------	
			{
				descId = "zibaob", --简介
				time = 2,	
				num = 1,
				pos = {380},
				delay = {4},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			{
			
				time = 6,	
				num = 4,
				pos = {100,250,500,600},
				delay = {4,4.6,2.5,3},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			{
				time = 9,		
				num = 2,
				pos = {500,700},
				delay = {0,1.1},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 12,		
				num = 2,
				pos = {400,550},
				delay = {0.8,0},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 13,		
				num = 1,
				pos = {1160},
				delay = {0.7},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,	
				},
			},
			{
				time = 14,		
				num = 1,
				pos = {530},
				delay = {0},
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
				time = 15,		
				num = 2,
				pos = {420,560},
				delay = {0,0.9},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
		},                                                         
	},
	{
		enemys = { 
			{
				time = 2,
				num = 3,
				delay = {0,0.5,1},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾 15
					id = 8,
				},
			},
			{
				time = 5,
				num = 5,
				delay = {4.1,2.5,3.8,2.2,3.5},
				pos = {500,650,760,860,950},
				property = { 
					placeName = "place3" ,
					type = "bao",                   --爆
					id = 9,
					startState = "san",	
				},
			},
			{
				time = 6,	
				num = 3,
				pos = {480,760,970},
				delay = {0,0.5,1.2},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 7,	                                               --金武奖励箱子
				num = 1,
				pos = {930},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					award = "goldWeapon",
					placeName = "place3",
				},
			},
			{
				time = 16,
				num = 4,
				delay = {0,0.9,1.6,0.4},
				pos = {350,600,1050,870},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 18,
				num = 1,
				delay = {1.6},
				pos = {670},
				property = { 
					placeName = "place11" ,
					type = "bao",                  --自爆boss                                 
					id = 18,
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place2" ,
					startState = "rollright",
					id = 1,
				},                                                          
			},	
			{
				time = 19,
				num = 1,
				delay = {0.2,},
				pos = {900,},
				property = { 
					placeName = "place3" ,
					id = 1,
					startState = "rollleft",
				},                                                          
			},	
			{
				time = 20,		
				num = 1,
				pos = {360,},
				delay = {0.3,},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	                                        
				},
			},
			{
				time = 21,
				num = 2,
				delay = {0.1,0.6,},
				pos = {870,1090},
				property = { 
					placeName = "place3" ,
					id = 1,
					startState = "rollleft",	
				},                                                        
			},
			{
				time = 22,		
				num = 1,
				pos = {460,},
				delay = {0.3,},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	                                        
				},
			},
			{
				time = 23,
				num = 1,
				delay = {0},
				pos = {350,},
				property = { 
					placeName = "place2" ,
					startState = "rollright",                   --29
					id = 1,
				},                                                          
			},	
		},
	},	

	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                                                --boss
			{
				descId = "boss01",  --简介
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place1",
					missileId = 19,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss         
				},
			},
		},
	},	
}




--enemy的关卡配置                                           小兵难度   青铜镶嵌  武器MP5 65  难度 80 伤害dps大于等于1.5
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=3,hp= 378,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=378,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=4,hp=1,
	weak1=1},

	--汽油桶         --type = "bao_tong",
	{id=4,image="qyt_01",demage=3500,hp=1,
	weak1=1},

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=4.5,hp=545,fireRate=120,fireCd=3,speed=50,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=6,hp=3270,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=8,hp=504,fireRate=30,speed=70,
	weak1=2},	

	--boss召唤第一波自爆兵        --type = "bao",
	{id=16,image="zibaob",demage=12,hp=504,fireRate=30,speed=70, weak1=2},

	--boss召唤第二波自爆兵        --type = "bao",	
	{id=17,image="zibaob",demage=17,hp=756,fireRate=30,speed=70, weak1=2},

	--自爆兵BOSS        --type = "bao",自爆boss
	{id=18,image="zibaob",demage=20,hp=2200,fireRate=30,speed=70,scale = 3.0, weak1=2},	
	                                                --scale = 3.0,  近战走到屏幕最近放缩比例	 
	--boss导弹          type = "missile",
	{id=19,image="daodan",demage=10,hp=10,
	weak1=1},

	-- 金武箱子奖励     type = "awardSan",
	{id=20,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

}

--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "boss01", --图片名字
		award = 5000,                   --boss产出金币数量
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
				0.70,--0.65,
			},	
			demage400 = {  
				0.30,
			},							
		},

		daoDan1 = {
		
		    id = 19,                                 --boss导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(-300, 0), cc.p(300, 0), 
           }               
		},
		daoDan2 = {
			id = 19,                                 --boss导弹
			type = "missile",
			offsetPoses = {
                cc.p(0, 0), cc.p(0, -500), 
           }               
		},
		daoDan3 = {
			id = 19,                                 --boss导弹
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
					id = 16,
					type = "bao",
				},
			},
			{
				time = 0,	                                               --金武奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					placeName = "place4",
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
				},
			},
		},

		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 0,	
				num = 3,
				pos = {360,760,1050},
				delay = {0,0.7,1.4},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "bao",
				},
			},
		},


		
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 0,	
				num = 3,
				pos = {420,730,920},
				delay = {0,0.7,1.4},
				property = {
					placeName = "place3" ,
					id = 17,
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