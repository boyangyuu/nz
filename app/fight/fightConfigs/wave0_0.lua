local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{		
		enemys = {                                          --1波1个
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {15},
				property = { 
					placeName = "place15",
					startState = "",
					id = 1,
				},
			},					
		},
	},
	{
		enemys = {                                          --2波2个
			{
				time = 1,
				num = 2,
				delay ={0, 0.2},
				pos = {10,120},		
				property = { 
					placeName = "place14",
					startState = "",
					id = 1,
				},
			},					
		},
	},
	--[引导] 3波 3个敌人,扔雷	
	{
		enemys = {                                          
			{
				time = 1,
				num = 2,
				delay ={0, 0.2},
				pos = {10,120},		
				property = { 
					placeName = "place14",
					startState = "",
					id = 1,
				},
			},	
			{
				time = 1,
				num = 1,
				delay = {0.1},
				pos = {70},
				property = { 
					placeName = "place14",
					id = 6,
					startState = "",
					type = "dao",
					missileId = 7,
					missileType = "lei",
				},
			},						
		},
	},	
	--[引导] 4波 换枪
	{
		enemys = {                                           --4波换枪 mp5
			{
				time = 1,	
				num = 4,
				pos = {200,260,330,440},
				delay = {0,0.5,1,1.5},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 1.5,
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
				time = 2.5,	
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
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},		                                     	
		},
	},	
	
	--[引导] 5波 换加特林,长按文字
	{
		--体验枪
		gunData = 
			{ 
			    id = 8,    --枪id
			    delay = 10, --10s之后出现
			    time = 20,	--持续20s
		    },		    
		enemys = {

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
				time = 1,
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
				time = 1.5,
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
				time = 2,	
				num = 4,
				pos = {200,260,330,440,},
				delay = {0,0.5,0.8,1.3,},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 2.5,	
				num = 3,
				pos = {820,750,660},
				delay = {0,0.6,1.2},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 3,	
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
				time = 3.5,	
				num = 3,
				pos = {800,650,700},
				delay = {0,0.6,1.1},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0.2,0.8},
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
				time = 4.5,	
				num = 2,
				pos = {870,950},
				delay = {0,0.6},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {240,370,300},
				delay = {0,0.6,1.3},
				property = { 
					placeName = "place1",
					id = 2,
					type = "jin",
				},
			},		
			{
				time = 5.5,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place2",
					id = 2,
					type = "jin",
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0.2,0.9},
				pos = {250,700},
				property = { 
					placeName = "place1",
					id = 2,
					type = "jin",
				},
			},	
			{
				time = 6.5,	
				num = 3,
				pos = {820,910,980},
				delay = {0,0.6,1.2},
				property = {
					placeName = "place2",
					id = 2,
					type = "jin",
				},
			},
		                                     	
		},
	},	
	--[引导] 第6波空军+飞机 点击黄武
	{
		enemys = {                                           -- 第6波 给黄武 空军+飞机
			{
				time = 1,
				num = 3,
				delay = {0, 0.6, 1.2},
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
				delay = {0, 0.7, 1.4},
				pos = {800,650,900},	
				property = { 
					placeName = "place1", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 2,	
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
			{
				time = 2.5,
				num = 1,
				pos = {450},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 9,
					placeName = "place11",
					missileId = 4,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},		
			{
				time = 3,
				num = 3,
				delay = {0.2,0.8, 1.3},
				pos = {470,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},
			{
				time = 3.5,	
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
				time = 4,
				num = 1,
				pos = {450},
				delay = {0.5},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 9,
					placeName = "place11",
					missileId = 4,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},		
			{
				time = 4.5,	
				num = 2,
				pos = {350,700},
				delay = {0.3,0.9},
				property = { 
					type = "san",
					id = 3,
					enemyId = 1,
					placeName = "place3",
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0, 0.6, 1.3},
				pos = {200,260,330,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 5.5,
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
				time = 6,
				num = 3,
				delay = {0.2,0.6, 0.9},
				pos = {480,550,700},					
				property = {
					placeName = "place2",  
					type = "san",
					id = 3,
					enemyId = 1,
				},
			},	
			{
				time = 6.5,	
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
		},
	},

	--[引导] boss 出现之后开盾; 20%永久机甲
	{
		waveType = "boss",                                      --强敌出现
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
	{id=1,image="anim_enemy_002",demage=1,hp=105,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=3},

	--近战兵
	{id=2,image="jinzhanb",demage=3,hp=140,fireRate=180,fireCd=3,speed=40,scale = 1.4,
	weak1=3},                                                           --scale = 3.0,  近战走到屏幕最近放缩比例

	--伞兵
	{id=3,image="sanbing01",demage=0,hp=105,
	weak1=2},	             

    --导弹          --missileType = "daodan",
	{id=4,image="daodan",demage=1,hp=1,
	weak1=1},

	--铁球
	{id=5,image="tieqiu",demage=20,hp=3760,weak1=1},	

	--手雷兵
	{id=6,image="shouleib",demage=0,hp=105,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},
	--手雷
	{id=7,image="shoulei",demage=1,hp=1,
	weak1=2},
	--BOSS导弹          --missileType = "daodan",
	{id=8,image="daodan",demage=5,hp=120,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=9,image="feiji",demage=0,hp=3200, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=10,image="yyc",demage=0,hp=1600,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=240, fireCd=5.0,
	weak1=2,    award = 60},
}

	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{

		image = "boss02", --图片名字
		hp = 50000,
		demage = 3, 			--这个是没用的 需要告诉俊松
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 120,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 25,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数
		award = 1100,                   --boss产出金币数量

		
		skilltrigger = {   			          --技能触发(可以同时)
			moveLeftFire = {
				0.90, 0.50, 0.10,
			},
			moveRightFire = {
				0.70,  0.30, 
			},
			chongfeng = {
			    0.95, 0.85, 0.65, 0.45, 0.35, 0.25, 0.15, 0.05,
			},
			tieqiu = {
				0.999, 0.80, 0.60, 0.40, 0.20,
			},	
			weak2 = {                               --手 技能触发(可以同时)
				0.80, 0.40,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.60, 0.20,                      
			},
			demage100 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.99,
			},	
			demage150 = {  
				0.80,
			},	
			demage200 = {  
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
	self.goldLimits = {225,355,495}   --黄武激活所需杀人个数  本关共60个小怪
end

return waveClass