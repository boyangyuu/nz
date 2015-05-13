local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
            {
				time = 2,	
				num = 3,
				pos = {200,300,550,},
				delay = {0,0.5,1,},
				property = { 
					placeName = "place2",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 4,	
				num = 1,
				pos = {420},
				delay = {0.5},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 5,	
				num = 2,
				pos = {970,1100},
				delay = {0.5,1},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {520},
				property = {
					renzhiName = "人质1",      --  一组统一标示
					type = "bangfei",
					placeName = "place10",
					id = 7,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {520},
				property = {
					renzhiName = "人质1",     --  一组统一标示
					type = "bangren",
					placeName = "place10",
					id = 8,
				},
			},
			{
				time = 8,
				num = 2,
				delay = {0.2,1,},
				pos = {190,400,},
				property = { 
					placeName = "place4",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {45},
				property = {
					renzhiName = "人质2",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 7,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {45},
				property = {
					renzhiName = "人质2",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 8,
					exit = "middle",
				},
			},
			{
				time = 11,
				num = 3,
				delay = {0.5,1,2.5},
				pos = {190,330,550},
				property = { 
					placeName = "place11",
					id = 1,
					startState = "rollright",	
				},
			},
			{
				time = 12,
				num = 1,
				delay = {1},
				pos = {430},
				property = { 
					placeName = "place10",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},
			},
			{
				time = 13,	
				num = 3,
				pos = {750,860,1050,},
				delay = {0,0.5,1,},
				property = { 
					placeName = "place4",
					startState = "rollleft",                                          --第一波20个怪
					id = 1,
				},
			},			
		},
	},
	
	{
		enemys = {
			{
				time = 2,	
				num = 2,
				pos = {350,600},
				delay = {0.2,1},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 3,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,350,400,600},					
				property = {
					placeName = "place2",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0.5},
				pos = {45},
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
				pos = {25},
				property = {
					renzhiName = "人质3",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 7,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {25},
				property = {
					renzhiName = "人质3",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 8,
					exit = "middle",
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 6,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {300,400,600,700},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place8",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 8,	
				num = 2,
				pos = {180,200},
				delay = {0.5,1},
				property = { 
					placeName = "place11",
					startState = "rollright",                                    
					id = 1,
				},
			},
			{
				time = 9,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {300,500,550,600,900},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
		},
	},
                                                       --第二波20个怪
	{
		enemys = {
			{
				time = 2,
				num = 1,
				pos = {450},
				delay = {0.4},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place15",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		                                    --持续时间			
				},
			},
			{
				time = 5,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {150,250,350,450},					
				property = {
					placeName = "place2",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},	
			{
				time = 8,
				num = 4,
				delay = {0.7,1.4, 2.1,2.8},
				pos = {200,300,400,500},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place7",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 12,	
				num = 3,
				pos = {250,530,700},
				delay = {0.2,1.4,0.9},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 16,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place5",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 20,
				num = 1,
				delay = {0.5},
				pos = {45},
				property = { 
					placeName = "place6",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 22,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {300,400,500,600,700},					
				property = {
					placeName = "place4",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 24,	
				num = 2,
				pos = {280,400},
				delay = {0.5,1},
				property = { 
					placeName = "place11",
					startState = "rollright",
					id = 1,
				},
			},

			{
				time = 30,
				num = 1,
				delay = {0},
				pos = {600},
				property = {
					renzhiName = "人质4",      --  一组统一标示
					type = "bangfei",
					placeName = "place11",
					id = 7,
				},
			},
			{
				time = 30,
				num = 1,
				delay = {0},
				pos = {600},
				property = {
					renzhiName = "人质4",     --  一组统一标示
					type = "bangren",
					placeName = "place11",
					id = 8,
				},
			},	
		},
	},

}


--enemy的关卡配置                                                    M4A1 8级白银镶嵌   1枪伤害333  dps大于等于3  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=9,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2, weak4=4},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=12,hp=300,
	weak1=1},
	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=5000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=300,
	weak1=1},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=7,image="tufeib",demage=12,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=8,image="hs", hp=3000, weak1=1},


	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=15000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=4.0,
	weak1=2,    award = 60},


	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=12,hp=7000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=4.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},

	--飞镖
	{id=18,image="feibiao",demage=12,hp=500}, 


}


local mapId = "map_1_5"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		-- type 	  = "puTong",

		type 	  = "renZhi",
		saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass