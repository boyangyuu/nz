local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {

	{
		enemys = { 
			{
				descId = "jujib", --简介
				time = 2,
				num = 1,
				delay = {4},
				pos = {50},
				property = {
					placeName = "place10",  
					type = "juji",
					startState = "rollright",
					id = 4,
				},
			},
			{
				time = 7,
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
				time = 10,
				num = 1,
				delay = {0.5},
				pos = {360},
				property = {
					placeName = "place5",  
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 13,
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
				delay = {0},
				pos = {500},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 1,
				},
			},
			{
				
				time = 17,
				num = 1,
				delay = {0.3,},
				pos = {280},
				property = {
					placeName = "place16",
					type = "juji",
					startState = "rollright",
					id = 4,
				},
			},
			{
				time = 21,
				num = 1,
				delay = {0.6,},
				pos = {300,},
				property = {
					placeName = "place9",  
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 23,
				num = 1,
				delay = {0},
				pos = {20},
				property = {
					placeName = "place15",  
					type = "juji",
					startState = "rollright",
					id = 4,
				},
			},
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
					startState = "rollright",
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
					startState = "",
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
				pos = {20},
				property = {
					placeName = "place15",  
					type = "juji",
					startState = "rollright",
					id = 4,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {666},
				property = {
					renzhiName = "人质2",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 7,
				},
			},
			{
				time = 15,
				num = 1,
				delay = {0},
				pos = {666},
				property = {
					renzhiName = "人质2",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 8,
				},
			},
			{
				time = 18,
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
				time = 21,
				num = 1,
				delay = {0.4},
				pos = {195},
				property = {
					placeName = "place14",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
					startState = "",
				},
			}, 
			{
				time = 24,
				num = 1,
				delay = {0.4},
				pos = {80},
				property = {
					placeName = "place12",
					id = 1,
				},
			}, 
			{
				time = 27,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					placeName = "place9",  
					type = "juji",
					startState = "rollright",
					id = 4,
				},
			},
		},
	},	
	{
		enemys = {
		    {
				time = 1,
				num = 1,
				pos = {700},
				delay = {0},                         -- 飞机          
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
				time = 8,	                                               --金武奖励箱子
				num = 1,
				pos = {680},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 20,
					award = "goldWeapon",     --黄金武器
					--award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 1,
					placeName = "place9",
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {570},
				property = {
					renzhiName = "人质3",      --  一组统一标示
					type = "bangfei",
					placeName = "place3",
					id = 7,
				},
			},
			{
				time = 5,
				num = 1,
				delay = {0},
				pos = {570},
				property = {
					renzhiName = "人质3",     --  一组统一标示
					type = "bangren",
					placeName = "place3",
					id = 8,
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
				num = 3,
				delay = {0, 1.4, 2.8},
				pos = {380,570,700},					
				property = {
					placeName = "place9",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},	
		},
	},

}



--enemy的关卡配置                                   无镶嵌 狙击枪6星470伤害   1枪  470         dps大于等于2
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=2,hp=470,walkRate=120,walkCd=2,rollRate=180,rollCd=4,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=470,walkRate=120,walkCd=2,rollRate=180,rollCd=4,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=2,hp=1,
	weak1=1},

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=6,hp=1400, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=2,hp=1,
	weak1=1},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=7,image="tufeib",demage=2,hp=470,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=8,image="hs", hp=310, weak1=1},	

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=2000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=2.0,    award = 60},

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