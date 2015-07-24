local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 2,
				num = 1,
				pos = {450},
				delay = {0.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间		
				},
			},
			{
				time = 6,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {220,660,430,790,930,550,720,300,860,500},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 10,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {510,790,230,610,900,310,850,430,700,800},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 14,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {220,660,430,790,930,550,720,300,860,500},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},


			{
				time = 22,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 24,
				num = 2,
				delay = {0,0.5},
				pos = {260,550},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 26,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {510,790,230,610,900,310,850,430,700,800},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 29,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {220,660,430,790,930,550,720,300,860,500},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 31,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 33,
				num = 2,
				delay = {0,0.5},
				pos = {400,850},					
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 41,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {510,790,230,610,900,310,850,430,700,800},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
                                                              -- 紫炮boss
			{
				time = 44,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {220,660,430,790,930,550,720,300,860,500},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 46,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 49,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {510,790,230,610,900,310,850,430,700,800},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 50,
				num = 2,
				delay = {0,0.5},
				pos = {300,500},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 58,
				num = 1,
				pos = {450},
				delay = {0.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间		
				},
			},
			{
				time = 60,
				num = 2,
				delay = {0,0.5},
				pos = {400,500},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 62,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 65,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {220,660,430,790,930,550,720,300,860,500},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 67,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 70,
				num = 2,
				delay = {0,0.5},
				pos = {600,800},					
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 74,
				num = 1,
				pos = {500},
				delay = {0.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		                                    --持续时间		
				},
			},
			{
				time = 76,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {510,790,230,610,900,310,850,430,700,800},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 78,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {220,660,430,790,930,550,720,300,860,500},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
			{
				time = 80,
				num = 10,
				delay = {0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8},
				pos = {510,790,230,610,900,310,850,430,700,800},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},
		},
	},
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于4  怪物数据
local enemys = {

	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=16,hp=7440,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=14890,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=7445,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=26060,fireRate=180,fireCd=4,speed=60,
	weak1=2},

	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0, speakRate =240,speakCd = 5.0,
	weak1=1},

	--小蜘蛛   --type = "bao",
	{id=9,image="xiaozz",demage=25,hp=5950, speed=70,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=100420, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=14,image="tufeib",demage=8,hp=11160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=15,image="hs", hp=14890, weak1=1},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=30,hp=44670,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3, award = 10},	 

	--黄衣人质商人      type = "shangren",
	{id=21,image="shangr_1",hp=14890, weak1=1},	--黄衣人质商人	

}


local mapId = "map_1_6"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		--type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		 type 	  = "xianShi",
		 limitTime = 80,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end
return waveClass