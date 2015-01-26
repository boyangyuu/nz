local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				descId = "zibaob", --简介
				time = 3,	
				num = 1,
				pos = {200},
				delay = {4},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			
			{
				time = 10,
				num = 6,
				delay = {0,1.4,0.7,0.8,1.6,2.4},
				pos = {250,350,550,900,1000,1080},
				property = {
					type = "jin",
					placeName = "place3",  
					id = 7,
				},
			},
			{
				time = 11,	
				num = 1,
				pos = {300},
				delay = {0.9},
				property = {
					placeName = "place2" ,
					id = 8,
					type = "jin",
				},
			},
			
		
		},
	},
	{
		enemys = {
			



		},
	},	
	{
		enemys = {
			



		},
	},	
	{
		enemys = {  --boss
			{
				descId = "boss02",  --简介
				time = 3,	
				num = 1,
				pos = {250},
				delay = {0.3},
				property = { 
					type = "boss",
					placeName = "place1",
					enemyId = 6, 
					id = 1,


				},
			},
		},
	},	
}




--enemy的关卡配置
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=4,hp=260,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=60,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=195,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=60,fireCd=5,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=5,hp=1,
	weak1=3},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=260,
	weak1=3},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=260,walkRate=180,walkCd=1,fireRate=30,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=1,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=5,hp=325,fireRate=30,fireCd=4,speed=40,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=5,hp=650,fireRate=30,fireCd=4,speed=20,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=20,hp=650,fireRate=30,speed=20,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=8888, walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=30, fireCd=4.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=6000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=30, fireCd=4.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30

}

--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "boss01", --图片名字
		hp = 150000,
		demage = 3,
		fireRate = 400,fireCd=4.0,
		walkRate = 200,walkCd = 2.0,
		saoFireOffset = 0.4, 		--扫射时间间隔
		saoFireTimes = 10, 			--扫射次数
		weak1 = 2,					--弱点伤害倍数
		weak2 = 2,					--弱点伤害倍数
		weak3 = 3,					--弱点伤害倍数
		skilltrigger = {   			--技能触发(可以同时)
			moveLeftFire = {
				0.65, 0.35,
			},
			moveRightFire = {
				0.55, 0.25,
			},
			daoDan = {
				0.80, 0.61, 0.40, 0.20,
			},
			saoShe = {
				0.95,0.70, 0.45,
			},
			weak2 = {
				0.60,
			},	
			weak3 = {
				0.30,
			},	
			demage150 = {  --伤害乘以1.20  备注不要超过三位数 比如demage1200是不行的
				0.59,
			},	
			demage400 = {  
				0.10,
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
end
return waveClass