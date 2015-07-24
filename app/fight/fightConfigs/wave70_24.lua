local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				pos = {600},
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
				time = 4,
				num = 1,
				delay = {0},
				pos = {730},
				property = { 
					placeName = "place6",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0},
				pos = {730},
				property = { 
					placeName = "place6",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 6,	
				num = 2,
				pos = {300,800},
				delay = {0.5,0.8},
				property = { 
					placeName = "place3",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0,0.5},
				pos = {700,900},					
				property = {
					placeName = "place4",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 8,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {300,420,600,750,890},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0.1},
				pos = {800},                                 
				property = {                               --黄衣人质
					placeName = "place3",
					startState = "enterright",
					type = "shangren",	
					id = 21,
					data = {
						{
							pos = 600,
							time = 3,
							direct = "left",							
						},						
					},
				},
			},
			{
				time = 12,	
				num = 1,
				pos = {500},
				delay = {0.5},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 14,	
				num = 1,
				pos = {800},
				delay = {0.5},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0},
				pos = {390},
				property = { 
					placeName = "place4",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0},
				pos = {390},
				property = { 
					placeName = "place4",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 20,
				num = 5,
				delay = {0.5,1.2,0,0.4,0.9},
				pos = {300,420,600,750,890},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
		},
	},
	{
		enemys = {
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {320},
				property = { 
					placeName = "place5",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {320},
				property = { 
					placeName = "place5",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 3,	
				num = 2,
				pos = {400,800},
				delay = {0,0.5},
				property = {
					placeName = "place5" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.5,1.2,0,0.4},
				pos = {420,600,750,890},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 7,	
				num = 2,
				pos = {280,600},
				delay = {0,0.5},
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
		enemys = {			
			{
				time = 1,
				num = 4,
				delay = {0.5,1.2,0,0.4},
				pos = {300,550,750,930},
				property = { 
					placeName = "place4" ,
					type = "jin",      --jin
					id = 7,	
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0.1},
				pos = {300},                                 
				property = {                               --黄衣人质
					placeName = "place5",
					startState = "enterleft",
					type = "shangren",	
					id = 21,
					data = {
						{
							pos = 700,
							time = 3,
							direct = "right",							
						},						
					},
				},
			},
			{
				time = 6,
				num = 2,
				delay = {0,0.5},
				pos = {300,750},					
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 9,
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
				time = 12,
				num = 1,
				delay = {0},
				pos = {730},
				property = { 
					placeName = "place6",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {730},
				property = { 
					placeName = "place6",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 14,
				num = 2,
				delay = {0,0.5},
				pos = {400,670},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 16,	
				num = 2,
				pos = {300,600},
				delay = {0,0.5},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 18,	
				num = 2,
				pos = {500,850},
				delay = {0,0.5},
				property = {
					placeName = "place5" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 21,
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
				time = 26,
				num = 2,
				delay = {0},
				pos = {600},
				property = { 
					placeName = "place3",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 26,
				num = 1,
				delay = {0},
				pos = {600},
				property = { 
					placeName = "place3",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},
		},
	},
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级180  dps大于等于4  怪物数据
local enemys = {

	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=16,hp=8650,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=17300,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=8650,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=30280,fireRate=180,fireCd=4,speed=60,
	weak1=2},

	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=17300,walkRate=120,walkCd = 1.0, speakRate =240,speakCd = 5.0,
	weak1=1},

	--小蜘蛛   --type = "bao",
	{id=9,image="xiaozz",demage=25,hp=6920, speed=70,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=121150, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=14,image="tufeib",demage=8,hp=12980,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=2},

	--被绑架人        --type = "bangren",
	{id=15,image="hs", hp=17300, weak1=1},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=30,hp=51920,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=2, award = 10},	 

	--飞镖
	{id=18,image="feibiao",demage=15,hp=8650},  

	--黄衣人质商人      type = "shangren",
	{id=21,image="shangr_1",hp=17300, weak1=1},	--黄衣人质商人	

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

		 type 	  = "renZhi",
		 saveNums  = 5,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 80,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end
return waveClass