local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	--[[{
		enemys = { 
			{
				time = 3,	
				num = 4,
				pos = {-50,50,150,250},
				delay = {0,0.5,0.6,1},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
						{
				time = 4,	
				num = 3,
				pos = {100,200,300},
				delay = {0,1,2},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},		
			{
				time = 5,	
				num = 3,
				pos = {200,400,300},
				delay = {1,2,3},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},		
		},
	},
	{
		enemys = {
			{
				time = 3,
				num = 2,
				delay = {0.3, 0.6},
				pos = {300,150},
				property = {
					placeName = "place4",
					type = "jin",
					id = 2,
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
					placeName = "place6",  
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
					placeName = "place1",
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
					placeName = "place2",
				},
			},									
		},

	},	--]]
	{
		enemys = {  --boss
			{
				time = 3,	
				num = 1,
				pos = {250},
				delay = {0.3},
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
	{id=1,image="anim_enemy_002",demage=2,hp=360,walkRate=400,rollRate=400,fireRate=400,
	weak1=5,weak2=4},

	--近战兵
	{id=2,image="jinzhanb",demage=5,hp=720,walkRate=400,rollRate=100,fireRate=100,
		weak1=2,weak2=2},

	--伞兵
	{id=3,image="sanbing01",demage=2,hp=360,walkRate=400,rollRate=100,
		fireRate=300,weak1=5,weak2=5},

	--导弹
	{id=4,image="daodan",demage=20,hp=100,weak1=3,weak2=5},	

	--铁球
	{id=5,image="tieqiu",demage=30,hp=100,weak1=3,weak2=5},		
}

	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "boss02", --图片名字
		hp = 10000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 400,
		walkRate = 200,
		chongfengDemage = 20,  --冲锋造成伤害
		demageScale = {weak1 = 2, weak2 = 3},	--弱点伤害倍数
		
		skilltrigger = {   			--技能触发(可以同时)
			moveLeftFire = {
				0.95, 0.20,
			},
			moveRightFire = {
				0.65, 0.40,
			},
			chongfeng = {
				0.99, 0.98,0.20
			},
			tieqiu = {
				0.30, 0.60
			},
			weak2 = {
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


function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
end

return waveClass