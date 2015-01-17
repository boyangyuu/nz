local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 1,	
				num = 3,
				pos = {50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					placeName = "place5",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0.5,10,15},
				pos = {0,50,100},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {100,200,300},
				delay = {0,1,2},
				property = { 
					placeName = "place8",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0.5,10,15},
				pos = {0,50,100},
				property = { 
					placeName = "place5",
					id = 6,
					startState = "",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},		
			{
				time = 11,	
				num = 3,
				pos = {200,400,300},
				delay = {1,2,3},
				property = {
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0.5,10,15},
				pos = {0,50,100},
				property = { 
					placeName = "place3",
					id = 6,
					startState = "",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},	
			{
				time = 15,	
				num = 3,
				pos = {200,400,300},
				delay = {1,2,3},
				property = {
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 18,
				num = 3,
				delay = {0.5,10,15},
				pos = {0,50,100},
				property = { 
					placeName = "place8",
					id = 6,
					startState = "",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},
			{
				time = 21,	
				num = 3,
				pos = {50,250,200},
				delay = {1,2,3},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 24,
				num = 3,
				delay = {0.5,10,15},
				pos = {0,50,100},
				property = { 
					placeName = "place5",
					id = 6,
					startState = "",
					type = "dao",
					missileId = 7,
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
				delay = {0.3, 0.6,1},
				pos = {300,150,0},
				property = {
					placeName = "place8",
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0.3, 0.6},
				pos = {250,400},	
				property = { 
					placeName = "place5", 
					startState = "rollleft",
					id = 1,
				},
			},	
			{
				time = 5,
				num = 2,
				delay = {0.3, 0.6},
				pos = {200,100},					
				property = {
					placeName = "place3",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 8,	
				num = 2,
				pos = {100, 300},
				delay = {1, 2},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place8",
				},
			},
			{
				time = 9,	
				num = 2,
				pos = {100, 250},
				delay = {0.5, 1.5},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place3",
				},
			},	
			{
				time = 10,	
				num = 4,
				pos = {0,50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					placeName = "place3",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 4,
				pos = {0,50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					placeName = "place3",
					id = 1,
				},
			},
			{
				time = 15,
				num = 2,
				delay = {0.3, 0.6},
				pos = {200,100},					
				property = {
					placeName = "place5",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 12,	
				num = 4,
				pos = {0,50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					placeName = "place3",
					id = 1,
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0.3, 0.6},
				pos = {200,100},					
				property = {
					placeName = "place8",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0.3, 0.6},
				pos = {250,400,0},	
				property = { 
					placeName = "place8", 
					startState = "rollleft",
					id = 1,
				},
			},
		},


	},
	{	
		waveType = "boss",
		enemys = {  --boss
			{
				descId = "boss02",
				time = 3,	
				num = 1,
				pos = {250},
				delay = {4.0},
				property = { 
					type = "chongBoss",
					placeName = "place7",
					enemyId = 4, 
					qiuId = 5,
					id = 1,
				},
			},		
		},
	},
}

--enemy的关卡配置
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=2,hp=340,walkRate=200,rollRate=300,fireRate=100,fireCd=5,weak1=4,weak2=4},

	--近战兵
	{id=2,image="jinzhanb",demage=4,hp=1080,walkRate=400,rollRate=100,fireRate=100,
		weak1=2,weak2=2},

	--伞兵
	{id=3,image="sanbing01",demage=2,hp=340,walkRate=400,rollRate=100,
		fireRate=300,weak1=4,weak2=5},


	{id=4,image="daodan",demage=10,hp=100,weak1=3,weak2=5},	

	--铁球
	{id=5,image="tieqiu",demage=20,hp=100,weak1=3,weak2=5},	
	--手雷兵
	{id=6,image="shouleib",demage=2,hp=340,walkRate=200,rollRate=200,fireRate=100,fireCd=5,weak1=3,weak2=5},	
	--手雷
	{id=7,image="shoulei",demage=5,hp=1,weak1=3,weak2=5},	
}

	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{

		image = "boss02", --图片名字
		hp = 80000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 400,
		fireCd = 6,
		walkRate = 200,
		walkCd = 1,
		chongfengDemage = 20,  --冲锋造成伤害
		demageScale = {weak1 = 3, weak2 = 2},	--弱点伤害倍数
		
		skilltrigger = {   			--技能触发(可以同时)
			moveLeftFire = {
				0.70,0.33,
			},
			moveRightFire = {
				0.50,0.13,
			},
			chongfeng = {
				0.85, 0.65,0.45,0.35,15,
			},
			tieqiu = {
				0.99, 0.69,0.39,
			},
			weak2 = {
				0.40,
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
local limit = 9   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
end

return waveClass