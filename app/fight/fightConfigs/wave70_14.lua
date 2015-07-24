local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 1,
				num = 1,
				pos = {300},
				delay = {0},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 30.0,		--持续时间			
				},
			},
			{
				time = 4,	
				num = 2,
				pos = {220,800},
				delay = {0,0.5},
				property = { 
					placeName = "place5",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {0},
				property = { 
					placeName = "place7",
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 20,
					id = 20,
				},
			},
			{
				time = 6,	
				num = 2,
				pos = {380,720},
				delay = {0,0.4},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {300,500,920},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 11,
				num = 2,
				delay = {0,0.3},
				pos = {220,550},
				property = { 
					placeName = "place2" ,
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 14,	
				num = 2,
				pos = {550,900},
				delay = {0,0.4},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 15,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                 --金币
					value = 100,
					placeName = "place1",
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0},
				pos = {130},
				property = { 
					placeName = "place5",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0},
				pos = {130},
				property = { 
					placeName = "place5",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "", --在屏幕中消失 不填表示屏幕外消失
				},
			},
	                                     	
		},                                                              --14个
	},	
	{   	    
		enemys = {

			{
				time = 1,	
				num = 3,
				pos = {300,500,920},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place5",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0,0.3},
				pos = {220,550},
				property = { 
					placeName = "place2" ,
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 4,	
				num = 3,
				pos = {330,660,900},
				delay = {0,0.3,0.6},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 7,
				num = 3,
				pos = {300,600,900},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			}, 
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {880},
				property = { 
					placeName = "place5",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {880},
				property = { 
					placeName = "place5",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "", --在屏幕中消失 不填表示屏幕外消失
				},
			},  
			{
				time = 9,	
				num = 2,
				pos = {440,880},
				delay = {0,0.5},
				property = { 
					placeName = "place10",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0,0.5},
				pos = {440,880},
				property = { 
					placeName = "place5",
					type = "yiliao",
					startState = "enterleft",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			}, 
			{
				time = 12,	
				num = 2,
				pos = {440,660},
				delay = {0.8,1.2},
				property = { 
					placeName = "place6",
					startState = "san",
					id = 1,
				},
			},

			{
				time = 14,
				num = 3,
				pos = {300,700,900},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			}, 
			{
				time = 16,	
				num = 4,
				pos = {330,660,880,1000},
				delay = {0,0.3,0.6,0.9},
				property = { 
					placeName = "place5",
					id = 7,
					type = "jin",
				},
			},

                                  	

                                       --第二波23个                                  	
		},
	},	
	{
		enemys = {                            --第三波
			{
				time = 1,
				num = 1,
				pos = {600},
				delay = {0},                         -- 飞机
				property = {
					type = "feiji",
					id = 11,
					placeName = "place14",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150,-150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 40,		                                    --持续时间		
				},
			},
			{
				time = 4,	
				num = 2,
				pos = {440,660},
				delay = {0.5,0.8},
				property = { 
					placeName = "place2",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 4,
				num = 3,
				pos = {300,800,950},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					placeName = "place10",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					placeName = "place5",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 7,	
				num = 5,
				pos = {330,500,670,820,990},
				delay = {0,0.3,0.6,0.9,1.2},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{ 
				time = 9,
				num = 3,
				delay = {0,0.5,0.7},
				pos = {320,720,900},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",													
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0.1},
				pos = {0},                                 
				property = {                               --黄衣人质
					placeName = "place10",
					startState = "enterleft",
					type = "shangren",	
					id = 21,
					exit = "middle",
					data = {
						{
							pos = 600,
							time = 3,
							direct = "right",							
						},						
					},
				},
			},
			{
				time = 11,	
				num = 2,
				pos = {220,800},
				delay = {0,0.5},
				property = { 
					placeName = "place10",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 14,	
				num = 2,
				pos = {0,80},
				delay = {0,0.6},
				property = { 
					placeName = "place3",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{ 
				time = 16,
				num = 2,
				delay = {0.2},
				pos = {100,200},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 18,	
				num = 3,
				pos = {440,800,700},
				delay = {0.5,0.8},
				property = { 
					placeName = "place5",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 18,
				num = 2,
				pos = {600,900},
				delay = {0,0.4,0.7},
				property = { 
					placeName = "place6",
					id = 2,
					startState = "san",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 20,	
				num = 2,
				pos = {100,300},
				delay = {0,0.5},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 22,
				num = 1,
				pos = {700},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place13",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 26,
				num = 2,
				delay = {0,0.3},
				pos = {220,550},
				property = { 
					placeName = "place2" ,
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 30,	
				num = 5,
				pos = {330,500,670,820,990},
				delay = {0,0.3,0.6,0.9,1.2},
				property = { 
					placeName = "place6",
					id = 7,
					type = "jin",
				},
			},
			{
				time = 32,	
				num = 2,
				pos = {300,500,},
				delay = {0,0.4},
				property = { 
					placeName = "place2",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 36,	
				num = 3,
				pos = {300,800,960},
				delay = {0,0.4,0.8},
				property = { 
					placeName = "place5",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 37,
				num = 1,
				delay = {0},
				pos = {0},
				property = { 
					placeName = "place7",
					type = "bangfei",
					renzhiName = "人质4",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 37,
				num = 1,
				delay = {0},
				pos = {0},
				property = { 
					placeName = "place7",
					type = "bangren",
					renzhiName = "人质4",     --  一组统一标示
					id = 15,
					exit = "", --在屏幕中消失 不填表示屏幕外消失
				},
			},
			{
				time = 37,
				num = 2,
				delay = {0,0.3},
				pos = {220,880},
				property = { 
					placeName = "place5" ,
					id = 2,
					startState = "",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},


}

--enemy的关卡配置                           dps 4350  dps大于等于4-怪物数据
local enemys = {
	--普通兵
	{id=1,image="anim_enemy_002",demage=8,hp=2465,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵
	{id=2,image="shouleib",demage=0,hp=1970,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=5,
	weak1=2},

	--手雷
	{id=3,image="shoulei",demage=10,hp=980,
	weak1=2},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=4930,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=44300, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2,    award = 60},

	--导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=2465,
	weak1=1},

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=16,hp=6160,fireRate=180,fireCd=4,speed=60,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=36900,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},

	--吉普车烟雾导弹          missileType = "dao_wu",
  	{id=13,image="daodan03",demage=16,hp=2465, weak1=1},
		                                                        
	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=14,image="tufeib",demage=4,hp=2465,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=15,image="hs", hp=6160, weak1=1},

	--人质         type = "renzhi",                                           
	{id=10,image="hs",demage=0,hp=6160,walkCd = 1.0,rollCd=2,speakCd = 5.0,weak1=1},

	--黄衣人质商人      type = "shangren",
	{id=21,image="shangr_1",hp=6160, weak1=1},	--黄衣人质商人

	--医疗兵              type = "yiliao",
	{id=20,image="yiliaob",demage=10,hp=6160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

	-- 金武箱子奖励  type = "awardSan",
	{id=31,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励
}


local mapId = "map_1_3"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		 --type 	  = "puTong",

		 type 	  = "renZhi",
		 saveNums  = 4,                 --解救人质数量

		--type 	  = "xianShi",
		--limitTime = 90,                   --限时模式时长
		-- limitTime = 10, 
		 --type 	  = "taoFan",
		 --limitNums = 4,                      --逃跑逃犯数量
	}

end

return waveClass