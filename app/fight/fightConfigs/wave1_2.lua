local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{
		enemys = { 
			{
				time = 1,	
				num = 4,
				pos = {200,260,330,440,},
				delay = {0,0.5,0.8,1,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollleft",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0.5},
				pos = {250},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 1,	
				num = 2,
				pos = {250,350},
				delay = {1,1.8},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 3,	
				num = 3,
				pos = {820,750,660},
				delay = {0,0.6,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},

						-- 以上是第一波第一批
			
			{
				time = 5,	
				num = 3,
				pos = {240,370,300},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 3,
				pos = {800,650,700},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.2,0},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},	
			{
				time = 9,	
				num = 2,
				pos = {870,950},
				delay = {0,0.6},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},

									-- 以上是第一波第二批

			{
				time = 5,	
				num = 3,
				pos = {240,370,300},
				delay = {1,1.5,1.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 8,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,
				num = 2,
				delay = {0.2,0},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},	
			{
				time = 9,	
				num = 3,
				pos = {820,910,980},
				delay = {0,0.6,0.8},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
		                                     	-- 以上是第一波第三批31
		},
	},	
	{
		enemys = {                                           
		                                                                -- 第二波

			{
				time = 1,
				num = 3,
				delay = {0, 0.6, 0.8},
				pos = {200,270,340,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1.5,
				num = 3,
				delay = {0, 0.3, 0.7},
				pos = {800,650,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 3,
				num = 3,
				delay = {0.2,0.3, 0.6},
				pos = {470,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 1.2,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},

			                                          -- 以上是第二波第一批10
			{
				time = 6,	
				num = 8,
				pos = {300,360,430,500,560,620,700,850},
				delay = {0,0.7,1.4,2.1,3.5,2.9,2.1,1.5},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place2",
				},
			},	
			{
				time = 9,	
				num = 2,
				pos = {350,700},
				delay = {0.3,0.7},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place3",
				},
			},
			
                                              -- 以上是第二波第二批10
			{
				time = 10,
				num = 3,
				delay = {0, 0.6, 0.8},
				pos = {200,260,330,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 11,
				num = 3,
				delay = {0, 0.3, 0.7},
				pos = {760,820,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 12,
				num = 3,
				delay = {0.2,0.3, 0.6},
				pos = {480,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 13,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place1",
					id = 6,
					startState = "rollright",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
 			                                       -- 以上是第二波第三批 10    

		},

	},

	{	
		waveType = "boss",
		enemys = {                                              --boss
			{
				descId = "boss02",
				time = 3,	
				num = 1,
				pos = {450},
				delay = {4},
				property = { 
					type = "chongBoss",
					placeName = "place8",
					missileId = 8,                 --导弹id        
					qiuId = 5,                   --铁球id
					id = 1,
				},
			},		
		},
	},
}

--enemy的关卡配置                           无镶嵌 MP5伤害65  dps大于等于1 怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=3,hp=190,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=2},

	--近战兵
	{id=2,image="jinzhanb",demage=15,hp=190,walkRate=180,walkCd=2,rollRate=120,rollCd=2,fireRate=180,fireCd=3,
	weak1=2},

	--伞兵
	{id=3,image="sanbing01",demage=0,hp=190,
	weak1=2},	             

    --导弹          --missileType = "daodan",
	{id=4,image="daodan",demage=5,hp=1,
	weak1=1},

	--铁球

	{id=5,image="tieqiu",demage=20,hp=3760,weak1=1},	

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=120,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},
	--手雷
	{id=7,image="shoulei",demage=4,hp=1,
	weak1=2},
	--BOSS导弹          --missileType = "daodan",
	{id=8,image="daodan",demage=5,hp=120,
	weak1=1},


}

	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{

		image = "boss02", --图片名字
		hp = 50000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 100,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 120,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 25,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数
		award = 9000,                   --boss产出金币数量

		
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
				0.80, 0.40, 0.10,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.60, 0.20                      
			},
			demage160 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.99,
			},	
			demage250 = {  
				0.80,
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
	self.goldLimits = {25,55,95}   --黄武激活所需杀人个数  本关共60个小怪
end

return waveClass