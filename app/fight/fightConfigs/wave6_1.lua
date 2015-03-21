local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 2,
				num = 3,
				delay = {1.0,0,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                   --盾
					id = 8,
				},
			},
			{
				time = 4,	
				num = 3,
				pos = {210,300,550},
				delay = {0.5,0,1.5},
				property = {
					placeName = "place2" ,           --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0.1,0.5,1.2},
				pos = {450,660,900},
				property = { 
					placeName = "place3" ,
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",              --雷
				},
			},
			{
				time = 5,                      
				num = 2,
				delay = {0,0.6},
				pos = {380,560},
				property = { 
					placeName = "place4" ,
					id = 2,
					startState = "rollright",
					type = "dao",                     --雷
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,	
				num = 4,
				pos = {320,410,470,600},
				delay = {0.1,1.5,1.8,0.8},
				property = {
					placeName = "place3" ,            --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 7,
				num = 3,
				delay = {0,0.5,1},
				pos = {300,370,440},
				property = { 
					placeName = "place3" ,
					startState = "rollright",           --雷
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},                                                          
			},
			{
				time = 8,	
				num = 3,
				pos = {210,300,550},
				delay = {0.5,0,1.5},
				property = {
					placeName = "place2" ,           --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 8,                               --雷
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
			{
				time = 10,
				num = 3,
				delay = {0.1,0.6,1},
				pos = {250,460,800},
				property = { 
					placeName = "place3" ,
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",          --导弹
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {700,900,1100},
				property = { 
					placeName = "place4" ,             --导弹
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",	
				},
			},
			{
				time = 14,
				num = 1,
				pos = {550},
				delay = {0,},                          -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		--持续时间			
				},
			},
		},
	},

	{
		enemys = {	
			{
				time = 2,
				num = 3,
				delay = {1.0,0,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                   --盾
					id = 8,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0.1,1.2},
				pos = {450,900},
				property = { 
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,               --忍者
				},
			},
			{
				time = 5,	
				num = 5,
				pos = {250,320,410,470,600},
				delay = {0.1,0.6,1.5,1.8,0.8},
				property = {
					placeName = "place3" ,         --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 5,	
				num = 5,
				pos = {120,210,300,400,550},
				delay = {0.5,2,0,0.5,1.5},
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
				time = 6,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {700,900,1100},
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
				time = 7,
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
			{
				time = 8,	
				num = 3,
				pos = {210,300,550},
				delay = {0.5,0,1.5},
				property = {
					placeName = "place2" ,           --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 8,
				num = 4,
				delay = {0,0.7,1.4,2},
				pos = {600,700,900,1100},
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
				time = 9,
				num = 3,
				delay = {0,1.0,1.5},
				pos = {350,610,910},
				property = { 
					placeName = "place4" ,
					type = "dao",                  --导
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},	
		},
	},

	{
		enemys = {
			{
				time = 2,
				num = 3,
				delay = {1.0,0,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                   --盾
					id = 8,
				},
			},
			{
				time = 4,	
				num = 3,
				pos = {210,300,550},
				delay = {0.5,0,1.5},
				property = {
					placeName = "place2" ,           --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 5,
				num = 3,
				delay = {0.1,0.5,1.2},
				pos = {450,660,900},
				property = { 
					placeName = "place3" ,
					startState = "rollleft",          --雷
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,	
				num = 4,
				pos = {320,410,470,600},
				delay = {0.1,1.5,1.8,0.8},
				property = {
					placeName = "place3" ,            --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 8,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,2.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",                     --爆小蜘蛛
					id = 21,	
				},
			},
			{
				time = 10,
				num = 3,
				delay = {0.1,0.6,1},
				pos = {250,460,800},
				property = { 
					placeName = "place3" ,
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",          --导弹
				},
			},
			{
				time = 12,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {700,900,1100},
				property = { 
					placeName = "place3" ,             --导弹
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",	
				},
			},
			{
				time = 13,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,0.7,0.5,1.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",                     --爆小蜘蛛
					id = 21,	
				},
			},
			{
				time = 14,
				num = 1,
				pos = {550},
				delay = {0,},                          -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		--持续时间			
				},
			},
		},
	},

	
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=21,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=28,hp=2000,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=10000,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=180,fireCd=4,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=3000,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=30000,fireRate=180,fireCd=4,speed=60,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=70000,fireRate=180,fireCd=5,speed=40, scale = 1.8 ,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=25,hp=5000,fireRate=30,speed=120,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=1,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=100000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=100000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=2,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=2,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=2,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=2,award = 30},	--award = 30  金币数量为30
	
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=90000,fireRate=60,fireCd=2,speed=40,scale = 2.5 ,
	weak1=2},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=50000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=5000}, 
	
	--蜘蛛网
	{id=19,image="zzw",demage=15,hp=20000},  


	--BOSS导弹   --missileType = "daodan",
	{id=20,image="daodan",demage=35,hp=5000,
	weak1=1},  

	--小蜘蛛   --type = "bao",
	{id=21,image="xiaozz",demage=15,hp=5000, speed=120,
	weak1=1},                      
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