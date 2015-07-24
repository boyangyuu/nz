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
				time = 1,
				num = 1,
				pos = {600},
				delay = {0.4},                         -- 飞机
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
				time = 3,
				num = 2,
				delay = {0,0.5},
				pos = {700,900},					
				property = {
					placeName = "place4",   
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 5,
				num = 2,
				delay = {0,0.5},
				pos = {500,800},					
				property = {
					placeName = "place3",   
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 7,
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
				time = 8,
				num = 2,
				delay = {0,0.5},
				pos = {360,600},					
				property = {
					placeName = "place2",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 9,
				num = 2,
				delay = {0,0.5},
				pos = {560,750},					
				property = {
					placeName = "place3",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},
			{
				time = 10,
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
		waveType = "boss",                                      --强敌出现
		enemys = {                                                                -- 紫炮boss
			{
				descId = "boss01_2", --简介               -- 紫炮boss
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",
					placeName = "place1",
					missileId = 22,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多boss     
				},
			},
		},
	},
	{
		enemys = {			
			{
				time = 5,
				num = 5,
				pos = {300,420,540,660,780,800},
				delay = {0,0.4,0.6,0.8,1.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		                                    --持续时间		
				},
			},
			{
				time = 5,
				num = 5,
				pos = {250,370,490,610,730,850},
				delay = {0,0.4,0.6,0.8,1.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 50.0,		                                    --持续时间		
				},
			},
			{
				time = 11,--奖励箱子
				num = 2,
				pos = {200,370,660},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 11,--奖励箱子
				num = 3,
				pos = {470,590,780},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 12,--奖励箱子
				num = 2,
				pos = {250,410},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 31,
					award = "shouLei",                        --手雷
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 12,--奖励箱子
				num = 3,
				pos = {340,490,640},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 13,--奖励箱子
				num = 2,
				pos = {530,760},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 20,
					placeName = "place4",
				},
			},
			{
				time = 13,--奖励箱子
				num = 3,
				pos = {220,500,700},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 15,
				num = 5,
				pos = {300,420,540,660,780,800},
				delay = {0,0.4,0.6,0.8,1.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place9",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		                                    --持续时间		
				},
			},
			{
				time = 15,
				num = 5,
				pos = {250,370,490,610,730,850},
				delay = {0,0.4,0.6,0.8,1.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterright",
					lastTime = 50.0,		                                    --持续时间		
				},
			},
			{
				time = 21,--奖励箱子
				num = 2,
				pos = {200,370,660},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place4",
				},
			},
			{
				time = 21,--奖励箱子
				num = 3,
				pos = {470,590,780},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 22,--奖励箱子
				num = 2,
				pos = {250,410},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 31,
					award = "healthBag",                    --医药包
					value = 50,
					placeName = "place2",
				},
			},
			{
				time = 22,--奖励箱子
				num = 3,
				pos = {340,490,640},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place3",
				},
			},
			{
				time = 23,--奖励箱子
				num = 2,
				pos = {530,760},
				delay = {0,0.2},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 20,
					placeName = "place4",
				},
			},
			{
				time = 23,--奖励箱子
				num = 3,
				pos = {220,500,700},
				delay = {0.4,0.6,0.8},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                        --金币
					value = 50,
					placeName = "place2",
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
	{id=6,image="daodan",demage=1,hp=8650,
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
	{id=11,image="feiji",demage=0,hp=60575, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=40.0,
	weak1=3,    award = 200},

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

	  --boss导弹          --missileType = "daodan",
	{id=22,image="daodan",demage=40,hp=8650,
	weak1=1},	

	-- 金武箱子奖励  type = "awardSan",
	{id=31,image="dl_xz",hp=6920, weak1=1},	--金武箱子奖励

}

	--boss的关卡配置
local bosses = {	
	--出场的boss
	{
		image = "boss01_2", --图片名字                         紫炮
		award = 50000,                   --boss产出金币数量
		hp = 350000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,
		fireCd = 2,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间
		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)

			saoShe = { 0.95, 0.65, 0.35,},                --调用普通攻击的伤害  扫射
                       
			wudi = {0.90, 0.70, 0.50, 0.30,},                    --无敌                                        
 
			zhaohuan = {0.92, 0.72, 0.52, 0.32, },                         --召唤小怪 

			moveLeftFire = { 0.80 , 0.40, },
			moveRightFire = { 0.60, 0.20, },
			

			daoDan1 = {                                            --两发导弹
				0.99, 0.85, 0.75, 0.65, 0.55, 0.45, 0.35, 0.25, 0.15,
			},


			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80,0.20,
			},

			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.65,
			},	
			demage300 = {  
				0.30,
			},							
		},

		daoDan1 = {
		    id = 6,                                 --boss导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(300, 0), cc.p(-300, 0),
           }               
		},



		enemys1 = {                                                     --第一波召唤的人质
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质1",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 14,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质1",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 15,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质2",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 14,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质2",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 15,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质3",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 14,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质3",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 15,
				},
			},
		},
		enemys2 = {                                                     --第一波召唤的人质
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质4",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 14,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质4",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 15,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质5",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 14,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质5",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 15,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质6",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 14,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质6",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 15,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {350},
				property = {
					renzhiName = "人质7",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 14,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {350},
				property = {
					renzhiName = "人质7",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 15,
				},
			},
		},
		enemys3 = {                                                     --第一波召唤的人质
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质8",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 14,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质8",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 15,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质9",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 14,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质9",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 15,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质10",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 14,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质10",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 15,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质11",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 14,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质11",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 15,
				},
			},
		},
		enemys4 = {                                                     --第一波召唤的人质
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质12",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 14,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质12",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 15,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质13",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 14,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质13",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 15,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质14",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 14,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质14",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 15,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质15",      --  一组统一标示
					type = "bangfei",
					placeName = "place4",
					id = 14,
				},
			},
			{
				time = 0.5,
				num = 1,
				delay = {0},
				pos = {1100},
				property = {
					renzhiName = "人质15",     --  一组统一标示
					type = "bangren",
					placeName = "place4",
					id = 15,
				},
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
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 5,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 80,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end
return waveClass