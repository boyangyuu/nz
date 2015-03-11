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
				num = 10,
				delay = {0,0.7,1.4,2.1,2.8,3.5,0,0.7,1.4,2.1},
				pos = {220,300,380,460,540,620,700,780,860,940},
				property = { 
					placeName = "place1" ,
					type = "san",
					id = 4,
					enemyId = 1,
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
				time = 8.5,	
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
				time = 8.5,	
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
				num = 10,
				delay = {0,0.7,1.4,2.1,2.8,3.5,0,0.7,1.4,2.1},
				pos = {220,300,380,460,540,620,700,780,860,940},
				property = { 
					placeName = "place1" ,
					type = "san",
					id = 4,
					enemyId = 1,
				},
			},
		},
	},
	{
		waveType = "boss",                                      --强敌出现
		enemys = {                                              --boss
			{
				descId = "boss02_2",
				time = 3,	
				num = 1,
				pos = {450},
				delay = {4},
				property = { 
					type = "chongBoss",
					placeName = "place8",
					missileId = 12,                 --导弹id        
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
	{id=1,image="anim_enemy_002",demage=12,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=12,hp=1,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=562,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=749,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=12,hp=1123,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=15,hp=5616,fireRate=180,fireCd=5,speed=35,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=15,hp=749,fireRate=30,speed=100,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=16000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--BOSS导弹          --missileType = "daodan",
	{id=12,image="daodan",demage=15,hp=302,
	weak1=1},	

	--BOSS铁球
	{id=13,image="tieqiu",demage=25,hp=3760,
	weak1=1},
                          



}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		award = 25000,         ----boss产出金币数量
		image = "boss02_2",    --蓝boss基础上改的黄颜色boss
		hp = 100000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 60,               --普攻频率
		fireCd = 2,                     --普攻cd

		walkRate = 120,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 25,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数               

		
		skilltrigger = {   			          --技能触发(可以同时)
			moveLeftFire = {
				0.90, 0.50, 
			},
			moveRightFire = {
				0.70,  0.30, 
			},
			chongfeng = {
			    0.999,0.97, 0.86,0.83, 0.76,0.73, 0.66, 0.63 ,0.56, 0.53, 0.46, 0.43, 0.36, 0.33, 0.26,0.23, 0.16, 0.13, 0.05,
			},
			tieqiu = {
				0.95, 0.80,  0.60, 0.40, 0.20,
			},	
			weak2 = {                               --手 技能触发(可以同时)
				0.80, 0.40,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.60, 0.20,                      
			},
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.70,
			},	
			demage300 = {  
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
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit

end

return waveClass
