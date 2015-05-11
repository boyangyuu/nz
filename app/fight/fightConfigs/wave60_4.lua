local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0.3,1.0},
				pos = {300,550},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {360},
				property = {
					placeName = "place5",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place11",  
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 8,	                                               --金武奖励箱子
				num = 1,
				pos = {680},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					--award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place9",
				},
			},
			{
				
				time = 11,
				num = 1,
				delay = {0},
				pos = {50},
				property = {
					placeName = "place10",  
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {370},
				property = {
					renzhiName = "人质1",      --  一组统一标示
					type = "bangfei",
					placeName = "place9",
					id = 7,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {370},
				property = {
					renzhiName = "人质1",     --  一组统一标示
					type = "bangren",
					placeName = "place9",
					id = 8,
				},
			},
			{
				
				time = 17,
				num = 1,
				delay = {0.3,},
				pos = {90,},
				property = {
					placeName = "place16",
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				
				time = 18,
				num = 1,
				delay = {0},
				pos = {280},
				property = {
					placeName = "place16",
					type = "juji",
					startState = "",
					id = 4,
				},
			},
			-- {
			-- 	time = 20,	      --忍者
			-- 	num = 1,
			-- 	pos = {700},
			-- 	delay = {0.5,},
			-- 	property = {
			-- 		placeName = "place11" ,
			-- 		id = 17,
			-- 		type = "renzhe",
			-- 		missileId = 18,
			-- 	},
			-- },
				
		},
	},

	{
		enemys = {

			{
				time = 3,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place11",  
					type = "juji",
					startState = "",
					id = 4,
				},
			}, 
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {50},
				property = {
					placeName = "place10",  
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 9,
				num = 1,
				delay = {0},
				pos = {116},
				property = {
					placeName = "place6",  
					startState = "",
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {100},
				property = {
					placeName = "place2",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {370},
				property = {
					renzhiName = "人质2",      --  一组统一标示
					type = "bangfei",
					placeName = "place9",
					id = 7,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {370},
				property = {
					renzhiName = "人质2",     --  一组统一标示
					type = "bangren",
					placeName = "place9",
					id = 8,
				},
			},
			{
				time = 18,
				num = 1,
				delay = {0},
				pos = {600},
				property = {
					placeName = "place5",  
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 21,
				num = 1,
				delay = {0},
				pos = {95},
				property = {
					placeName = "place3",  
					id = 1,
					startState = "rollright",
				},
			},
			{
				time = 24,
				num = 1,
				delay = {0.4},
				pos = {195},
				property = {
					placeName = "place14",  
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},
			}, 
			{
				time = 27,
				num = 1,
				delay = {0.4},
				pos = {80},
				property = {
					placeName = "place12",  
					type = "juji",
					startState = "",
					id = 4,
				},
			}, 
			{
				time = 30,	      --忍者
				num = 1,
				pos = {400,},
				delay = {0.5,},
				property = {
					placeName = "place11" ,
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
				time = 3,
				num = 1,
				pos = {700},
				delay = {0.5},                         -- 飞机          
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place17",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		                                    --持续时间			
				},
			},
			{
				time = 10,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {100,230,300,450,480},					
				property = {
					placeName = "place11",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},	
			{
				time = 15,
				num = 5,
				delay = {0,0.7,1.4, 2.1,2.8},
				pos = {380,490,570,660,700},					
				property = {
					placeName = "place9",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 28,
				num = 5,
				delay = {2.1,2.8,0.7,1.4,0.9 },
				pos = {720,610,380,490,570},					
				property = {
					placeName = "place9",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			-- {
			-- 	time = 33,	      --忍者
			-- 	num = 1,
			-- 	pos = {300},
			-- 	delay = {0.2},
			-- 	property = {
			-- 		placeName = "place9" ,
			-- 		id = 17,
			-- 		type = "renzhe",
			-- 		missileId = 18,
			-- 	},
			-- },	
			{
				time = 35,	      --忍者
				num = 2,
				pos = {400,700},
				delay = {0.5,1.3},
				property = {
					placeName = "place11" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},			
					
		},
	},

}



--enemy的关卡配置                               青铜镶嵌    狙击枪6星470伤害   1枪  650         dps大于等于2
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=8,hp=650,walkRate=120,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=650,walkRate=120,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1,
	weak1=1},	

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=10,hp=1300, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=3},                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=1300,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=1,
	weak1=1},	
	
	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=7,image="tufeib",demage=8,hp=650,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=8,image="hs", hp=400, weak1=1},	

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=3200, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2.0,    award = 60},

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=10,hp=1950,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=4.0, 
	shanRate = 100, shanCd = 4, chongRate = 180, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=10,hp=1}, 

	-- 金武箱子奖励  type = "awardSan",
	{id=20,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 
                            
}





local mapId = "map_1_4"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 40,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end
return waveClass