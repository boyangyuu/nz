local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		adviseData = {
			type = "m134",   --goldJijia
			cost  = 120,    --钻石话费
			gunId = 8,      --武器id8  加特林
		},
------------------------------------------------推荐武器
		enemys = {                                                   --第一波召唤的自爆兵
			{
				time = 2,	
				num = 3,
				pos = {50,350,650},
				delay = {0.7,0,1.4},
				property = {
					placeName = "place2" ,
					id = 9,
					type = "bao",
				},
			},
			{
				time = 8,	
				num = 4,
				pos = {360,560,860,1050},
				delay = {1,0,0.7,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
        	{
				descId = "boss01",  --简介                            
				time = 16,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",                                                 --盾牌boss
					placeName = "place1",
					missileId = 20,            --BOSS导弹ID
					id = 1,            --boss里面id为1  ,以后有可能有很多bossi         
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 20,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place4",
				},
			},
			{
				time = 30,	                                               --奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place5",
				},
			},
			{
				time = 40,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 50,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 300,
					placeName = "place4",
				},
			},
		},
	},
-----------------------------------------------------------------------------------------------------------第1个盾牌boss  id = 1
	{
		adviseData = {
			type = "m134",   --goldJijia
			cost  = 120,    --钻石话费
			gunId = 8,      --武器id8  加特林
		},
-----------------------------------------------推荐武器
		enemys = { 
			{
				time = 2,	
				num = 2,
				pos = {400,1000,},
				delay = {0.5,0,},
				property = {
					placeName = "place5" ,
					id = 4,
					type = "juji",
				},
			},
			{
				time = 8,	
				num = 3,
				pos = {300,700,1100},
				delay = {0,0.7,1.4},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",
				},
			},                                                              
			{
				descId = "boss01_1", --简介                           
				time = 16,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",                                                 --红枪boss
					placeName = "place1",
					missileId = 20,            --BOSS导弹ID
					id = 2,            --boss里面id为1  ,以后有可能有很多boss         
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 20,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place4",
				},
			},
			{
				time = 30,	                                               --奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place5",
				},
			},
			{
				time = 40,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 50,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 300,
					placeName = "place4",
				},
			},
		},
	},
-----------------------------------------------------------------------------------------------------------第2个红枪boss  id = 2
	{
		adviseData = {
			type = "m134",   --goldJijia
			cost  = 120,    --钻石话费
			gunId = 8,      --武器id8  加特林
		},
-----------------------------------------------推荐武器
		enemys = { 
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质16",      --  一组统一标示
					type = "bangfei",
					placeName = "place6",
					id = 29,
				},
			},
			{
				time = 2,
				num = 1,
				delay = {0},
				pos = {500},
				property = {
					renzhiName = "人质16",     --  一组统一标示
					type = "bangren",
					placeName = "place6",
					id = 30,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质17",      --  一组统一标示
					type = "bangfei",
					placeName = "place5",
					id = 29,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {900},
				property = {
					renzhiName = "人质17",     --  一组统一标示
					type = "bangren",
					placeName = "place5",
					id = 30,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质18",      --  一组统一标示
					type = "bangfei",
					placeName = "place7",
					id = 29,
				},
			},
			{
				time = 10,
				num = 1,
				delay = {0},
				pos = {700},
				property = {
					renzhiName = "人质18",     --  一组统一标示
					type = "bangren",
					placeName = "place7",
					id = 30,
				},
			},                                                                
			{
				descId = "boss01_2", --简介                            
				time = 16,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",                                                  -- 紫炮boss
					placeName = "place1",
					missileId = 20,            --BOSS导弹ID
					id = 3,            --boss里面id为1  ,以后有可能有很多boss     
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 20,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place4",
				},
			},
			{
				time = 30,	                                               --奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place5",
				},
			},
			{
				time = 40,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 50,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 300,
					placeName = "place4",
				},
			},
		},
	},
-----------------------------------------------------------------------------------------------------------第3个紫炮boss  id = 3
	{
		enemys = {                                                            
			{
				descId = "boss02",--简介                          
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "chongBoss",                                            --冲锋蓝boss
					placeName = "place1",
					missileId = 20,                 --导弹id    
					missileOffsets = {cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) },    
					qiuId = 25,                   --汽车id
					-- qiuTime = 10,                 --铁球飞行到脸前的时间
					id = 4,                --boss里面id为1  ,以后有可能有很多boss 
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 20,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place4",
				},
			},
			{
				time = 30,	                                               --奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place5",
				},
			},
			{
				time = 40,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 50,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 300,
					placeName = "place4",
				},
			},		
		},
	},
----------------------------------------------------------------------------------------------------------第4个冲锋蓝boss	id = 4
	{
		enemys = { 
			{
				time = 2,
				num = 1,
				delay = {0,},
				pos = {600,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			}, 
			{
				time = 10,
				num = 1,
				delay = {0,},
				pos = {1050,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},                                                              
			{
				descId = "boss02_1",--简介
				time = 16,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "chongBoss",                                         -- CF肌肉 boss
					placeName = "place1",
					missileId = 20,                 --导弹id
					missileOffsets = {cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) },
					qiuId = 24,                   --铁球id
					-- qiuTime = 10,                 --铁球飞行到脸前的时间
					id = 5,
				},
			},	
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 20,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place4",
				},
			},
			{
				time = 30,	                                               --奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place5",
				},
			},
			{
				time = 40,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 50,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 300,
					placeName = "place4",
				},
			},	
		},
	},
----------------------------------------------------------------------------------------------------------第5个CF肌肉 boss id = 5
	{
		enemys = {                                                                
			{
				descId = "boss02_2",--简介                            
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "chongBoss",                                           --  冲锋黄boss
					placeName = "place1",
					missileId = 20,                 --导弹id
					missileOffsets = {cc.p(-150,-100), cc.p(0, 150), cc.p(150, -100), },
					qiuId = 24,                   --铁球id
					-- qiuTime = 10,                 --铁球飞行到脸前的时间
					id = 6,
				},
			},
			{
				time = 10,	                                               --奖励箱子
				num = 1,
				pos = {350},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 20,	                                               --奖励箱子
				num = 1,
				pos = {550},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					placeName = "place4",
				},
			},
			{
				time = 30,	                                               --奖励箱子
				num = 1,
				pos = {900},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place5",
				},
			},
			{
				time = 40,	                                               --奖励箱子
				num = 1,
				pos = {600},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 200,
					placeName = "place3",
				},
			},
			{
				time = 50,	                                               --奖励箱子
				num = 1,
				pos = {400},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 300,
					placeName = "place4",
				},
			},		
		},
	},
-----------------------------------------------------------------------------------------------------------第6个冲锋黄boss id = 6
	{
		enemys = {                                                               
			{
				descId = "nvrenzb", --简介
				time = 2,	
				num = 1,
				pos = {650},
				delay = {4},
				property = { 
					type = "renzheBoss",                                            --女忍者
					placeName = "place11",
					missileId = 18, 
					missileOffsets = {cc.p(-200, 0), cc.p(200, 0)},
					id = 7,
				},
			},
		},
	},
-----------------------------------------------------------------------------------------------------------第7个女忍者boss id = 7
	{
		enemys = {                                                                 
			{
				descId = "renzb", --简介
				time = 2,	
				num = 1,
				pos = {650},
				delay = {4},
				property = { 
					type = "renzheBoss",                                              --鬼眼
					placeName = "place11",
					missileId = 18, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50)},
					id = 8,
				},
			},
		},
	},
-----------------------------------------------------------------------------------------------------------第8个鬼眼boss id = 8
	{	
		enemys = {                                                               
			{
				descId = "dzboss", --简介
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "duozuBoss",                                              -- 多足蜘蛛boss
					placeName = "place1",
					wangId    = 27,    --网ID
					missileId = 20,    --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(0, 150) , cc.p(150, -150)},
					id = 9,
				},
			},
		},
	},
----------------------------------------------------------------------------------------------------------第9个多足蜘蛛boss id = 9
	{	
		enemys = {                                                                
			{
				descId = "dzboss_1", --简介               
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "duozuBoss",                                                  -- 毒刺boss
					placeName = "place1",
					wangId    = 27,     --网ID
					missileId = 23,     --大黑导弹
					missileOffsets = {cc.p(-150,-150) ,  },
					id = 10,
				},
			},
		},
	},
---------------------------------------------------------------------------------------------------------第10个毒刺boss id = 10

	{	
			--推荐黄金机甲
		adviseData = {
			type = "goldJijia", --黄金机甲
			cost  = 450,  --钻石花费 
		},
		enemys = {                                                             
			{
				descId = "renzb_01", --简介
				time = 2,	
				num = 1,
				pos = {550},
				delay = {4},
				property = { 
					type = "renzheBoss",                                              -- 魔化鬼眼boss
					placeName = "place1",
					missileId = 18, 
					missileOffsets = {cc.p(-150,50) , cc.p(150, -50)},
					id = 11,
				},
			},
		},
	},
--------------------------------------------------------------------------------------------------------第11波魔化鬼眼boss id = 11
	{
		enemys = {                                                                
			{
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "chongBoss",                                                    -- CF肌肉 boss
					placeName = "place1",
					missileId = 20,                 --导弹id
					missileOffsets = {cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) },
					qiuId = 24,                   --铁球id
					id = 12,
				},
			},		
		},
	},
--------------------------------------------------------------------------------------------魔化鬼眼召唤的boss1   CF肌肉 boss id = 12
	{
		enemys = {                                                                
			{
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "boss",                                                        -- 紫炮boss
					placeName = "place1",
					missileId = 20,            --BOSS导弹ID
					id = 13,            --boss里面id为1  ,以后有可能有很多boss     
				},
			},
		},
	},
---------------------------------------------------------------------------------------------魔化鬼眼召唤的boss2    紫炮boss  id = 13
	{	
		enemys = {                                                               
			{
				time = 2,	
				num = 1,
				pos = {500},
				delay = {4},
				property = { 
					type = "duozuBoss",                                                  -- 多足蜘蛛boss
					placeName = "place1",
					wangId    = 27,    --网ID
					missileId = 20,    --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(0, 150) , cc.p(150, -150)},
					id = 14,
				},
			},
		},
	},
--------------------------------------------------------------------------------------------魔化鬼眼召唤的boss3  多足蜘蛛boss id = 14
}


--enemy的关卡配置                                                    黄金镶嵌 m4a1满级  dps大于等于7  怪物数据
local enemys = {

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=40,hp=30000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=15,hp=50000,fireRate=180,fireCd=6,speed=35, scale = 2.0 ,
	weak1=2, weak4=4},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=50,hp=10000,fireRate=30,speed=100,scale = 1.8,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=50000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=6, fireCd=8.0,
	weak1=2,    award = 60},

	--鬼眼分身           冲锋伤害  type = "renzhe",
	{id=16,image="renzb",demage=40,hp=50000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},	

	--黑衣忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=35000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=15,hp=5000}, 

	--BOSS导弹          type = "missile",
	{id=20,image="daodan",demage=25,hp=5000, weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=25,hp=10000, weak1=1},           --打击者金武平均伤害5558

	--大黑导弹           type = "missile",
	{id=23,image="daodan02",demage=100,hp=10000, weak1=1},

	--BOSS铁球
	{id=24,image="tieqiu",demage= 100,hp=11000, weak1=1},

	--boss扔的汽车
	{id=25,image="qiche",demage=100,hp=11000,weak1=1},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=30,hp=30000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--蜘蛛网
	{id=27,image="zzw",demage=15,hp=20000},

	--小蜘蛛   --type = "bao",
	{id=28,image="xiaozz",demage=25,hp=3000, speed=75, weak1=1},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=29,image="tufeib",demage=35,hp=20000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=2},

	--被绑架人        --type = "bangren",
	{id=30,image="hs", hp=4000, weak1=1},

	

}

	--boss的关卡配置
local bosses = {
	{
		image = "boss01", --图片名字
		award = 10000,                   --boss产出金币数量
		hp = 100000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,                  --0就不普通攻击了
		fireCd = 2,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间
		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 15, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)
                       
			-- wudi = {0.91,0.71,0.51,0.31                    --无敌
			-- },                                        

			saoShe = { 0.90, 0.63, 0.35 },                --调用普通攻击的伤害  扫射 

			zhaohuan = {0.95, 0.70, 0.40 },                         --召唤小怪 

			moveLeftFire = { 0.85 , 0.30 },
			moveRightFire = { 0.60, },
			

			daoDan1 = {                                            --两发导弹
				0.99, 0.45, 0.10
			},
			daoDan2 = {                                            --两发导弹
				0.80, 0.50, 0.20
			},
			daoDan3 = {                                            --两发导弹
				0.75, 0.25, 0.15
			},

			weak1 = {
				0.60,
			},	
			weak2 = {
				0.40,
			},	
			weak3 = {
				0.80, 0.20,
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

		daoDan1 = {
		
		    id = 20,                                 --boss导弹
			type = "missile",                  
			offsetPoses = {
                cc.p(-300, 0), cc.p(300, 0), 
           }               
		},
		daoDan2 = {
			id = 20,                                 --boss导弹
			type = "missile",
			offsetPoses = {
                cc.p(0, 0), cc.p(0, -500), 
           }               
		},
		daoDan3 = {
			id = 20,                                 --boss导弹
			type = "missile",                        
			offsetPoses = {
                cc.p(-300, -300), cc.p(300, -300), 
           }               
		},


		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 0,	
				num = 3,
				pos = {360,660,960},
				delay = {0.7,0,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
		},
		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 0,	
				num = 4,
				pos = {360,560,860,1050},
				delay = {1,0,0.7,1.4},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
				},
			},
		},
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 0,	
				num = 5,
				pos = {420,620,830,920,1100},
				delay = {1.4,0,0.7,1.4,0.3},
				property = {
					placeName = "place3" ,
					id = 9,
					type = "bao",
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
--------------------------------------------------------------------------------------------------第1个出场的boss 盾牌	id = 1
	{
		image = "boss01_1", --图片名字
		award = 1000,                   --boss产出金币数量
		hp = 100000,
		demage = 5,
		fireRate = 60,                  --0就不普通攻击了
		fireCd = 3,  		
		walkRate = 120,
		walkCd = 2,         --移动cd	
		wudiTime = 6 , 	
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射10下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)


                                    
			wudi = {0.91, 0.51, 0.31,                        --无敌
			},                                        

			saoShe = { 0.75, 0.50, 0.30 , 0.10,   --调用普通攻击的伤害  扫射
			}, 

			zhaohuan = {0.95, 0.65, 0.35,},                           --召唤 

			moveLeftFire = {
				0.85, 0.55, 0.25, 
			},
			-- moveRightFire = {
			-- 	0.75, 0.35,
			-- },

			daoDan1 = {                                            --两发导弹
				0.99, 0.70, 0.40, 0.10,
			},

			weak1 = {
				0.70,0.50,0.10
			},	
			weak2 = {
				0.80,0.60,0.30
			},	
			weak3 = {
				0.90,0.40,0.20
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
		
		daoDan1 = {
		    id = 20,                                 --boss导弹
			type = "missile", 
			timeOffset = 0.1,                        --导弹间隔时间 
            flyTime = 6.0,                           --导弹飞到脸前的时间 
            srcPoses = {
						cc.p(-150, 0), cc.p(-75, -150), cc.p(75,-150), cc.p(150, 0),
			}, 
			offsetPoses = { 
						cc.p(-200, 0), cc.p(-120, -200), cc.p(120,-200), cc.p(200, 0),
			},
		},

		enemys1 = {                                                   --第一波召唤的自爆兵
			{
				time = 0,	
				num = 2,
				pos = {400,1000,},
				delay = {0.5,0,},
				property = {
					placeName = "place5" ,
					id = 4,
					type = "juji",
				},
			},
		},
		enemys2 = {                                                      --第二波召唤的兵
			{
				time = 0,	
				num = 4,
				pos = {300,500,900,1100},
				delay = {1,0,0.7,1.4},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",
				},
			},
		},
		enemys3 = {                                                      --第三波召唤的兵
			{
				time = 0,	
				num = 5,
				pos = {300,500,700,900,1100},
				delay = {1.4,0,0.7,1.4,0.3},
				property = {
					placeName = "place3" ,
					id = 4,
					type = "juji",
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
--------------------------------------------------------------------------------------------------第2个出场的boss 红枪  id = 2
	{
		image = "boss01_2", --图片名字                         紫炮
		award = 1000,                   --boss产出金币数量
		hp = 100000,
		demage = 5,                        --普通攻击伤害
		fireRate = 60,
		fireCd = 3,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间
		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 10, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)

			saoShe = { 0.89, 0.69, 0.49, 0.29, },                --调用普通攻击的伤害  扫射
                       
			wudi = {0.90, 0.70, 0.50, 0.30,},                    --无敌                                        
 
			zhaohuan = {0.91, 0.71, 0.51, 0.31, },                         --召唤小怪 

			moveLeftFire = { 0.85 , 0.40, },
			moveRightFire = { 0.60, 0.20, },
			

			daoDan1 = {                                            --两发导弹
				0.99, 0.88, 0.68, 0.48, 0.28, 0.15,
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
				0.70,
			},	
			demage300 = {  
				0.40,
			},							
		},

		daoDan1 = {
		    id = 22,                                 --boss导弹
			type = "dao_wu",                 
			offsetPoses = {
                cc.p(-250, -30), cc.p(0, -30), cc.p(250, -30), 
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
					id = 29,
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
					id = 30,
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
---------------------------------------------------------------------------------------------------第3个出场的boss 紫炮	id = 3
	{
		image = "boss02", --图片名字
		award = 2000,                   --boss产出金币数量
		hp = 200000,
		demage = 3, 		         	--这个是没用的
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 120,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 30,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数

		
		skilltrigger = {   			          --技能触发(可以同时)

			moveRightFire = {
				0.73, 0.33, 
			},
			moveLeftFire = {
				0.93, 0.53,
			},
			chongfeng = {
				0.86, 0.66, 0.46, 0.26, 0.13,
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
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage250 = {
				0.70,
			},	
			demage350 = {
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
--------------------------------------------------------------------------------------------------第4个出场的boss 冲锋蓝 id = 4
	{
		award = 2000,         ----boss产出金币数量
		image = "boss02_1",                              --CF肌肉boss
		hp = 150000,
		demage = 3, 			--这个是没用的
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd

		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd

		chongfengDemage = 30,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数               

		
		skilltrigger = {   			          --技能触发(可以同时)

			moveLeftFire = {
				0.90, 0.55,
			},
			moveRightFire = {
				0.75, 0.35,
			},
			chongfeng = {
			    0.85, 0.65, 0.45, 0.25, 0.10,
			},
			tieqiu = {
				0.80, 0.60, 0.40, 0.20, 0.05,
			},
			zhaohuan = { 0.95, 0.70, 0.50, 0.30,                      --召唤小兵
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

		enemys1 = {                                                   --第1波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {800,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
		},
		enemys2 = {                                                   --第2波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {260,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {860,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
		},
		enemys3 = {                                                   --第3波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {470,},
				property = { 
					placeName = "place6" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
		},
		enemys4 = {                                                   --第4波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {370,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {950,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.05,               --回血百分比
					id = 26,
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
---------------------------------------------------------------------------------------------------第5个出场的boss CF肌肉 id = 5
	{
		award = 2000,         ----boss产出金币数量
		image = "boss02_2",    --蓝boss变色黄boss
		hp = 200000,
		demage = 3, 			--这个是没用的
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd
		chongfengDemage = 30,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					    --手 弱点伤害倍数               

		
		skilltrigger = {   			          --技能触发(可以同时)

			daoDan1 = {                                            --烟雾导弹
				0.95, 0.70, 0.50, 0.30, 0.15,
			},
			moveLeftFire = {
				0.90, 0.55,
			},
			moveRightFire = {
				0.75, 0.35,
			},
			chongfeng = {
			    0.85, 0.65, 0.45, 0.25, 0.10,
			},
			tieqiu = {
				0.80, 0.60, 0.40, 0.20, 0.05,
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

		daoDan1 = {
		    id = 22,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 0.06,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            cc.p(-200, -200), cc.p(-200, 200), cc.p(200, 200), cc.p(200, -200), 
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
---------------------------------------------------------------------------------------------------第6个出场的boss 冲锋黄 id = 6
	{
		image = "nvrenzb",                       --图片名字                            红衣女忍者
		award = 2000,                   --boss产出金币数量
		hp = 250000,
		fireRate = 120,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --
		walkRate = 100,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 40,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
					                                           
			chongfeng = { 0.95, 0.70, 0.55, 0.45, 0.35, 0.25, 0.15     --冲锋
			},
			zhaohuan =  { 0.90, 0.50, 0.30,                    --召唤分身
			},
			feibiao1 =  { 0.80,                --暴雨梨花针1
			},
			feibiao2 =  { 0.60,                --暴雨梨花针2	
			},
			feibiao3 =  { 0.40,                --暴雨梨花针3
			},
			feibiao4 =  { 0.20,                --暴雨梨花针4
			},

			weak3 = {                               --右腿 技能触发(可以同时)
				0.70,0.40,0.10,                       
			},	
			weak2 = {                               --左腿 技能触发(可以同时)
				0.80,0.60,0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.50,0.30,                       
			},
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.60,
			},	
			demage300 = {  
				0.40,
			},	
			
		},

		feibiao1 = {     --srcPoses= 初始位置       --offsetPoses =偏移                   --暴雨梨花针1
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			},               
		},

		feibiao2 = {
			srcPoses = {
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105), 
						cc.p(-150, 0),  cc.p(-105, 105), cc.p(0, 150), cc.p(105, -105), 
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105),      
			}, 
			offsetPoses = {
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),
			            cc.p(-210, 0), cc.p(-147, 147), cc.p(0, 210), cc.p(147, 147),
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),			
			},               
		},

		feibiao3 = {
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			}, 
		},

		feibiao4 = {
			srcPoses = {
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105), 
						cc.p(-150, 0),  cc.p(-105, 105), cc.p(0, 150), cc.p(105, -105), 
						cc.p(150, 0), cc.p(105, 105), cc.p(0, -150),  cc.p(-105, -105),      
			}, 
			offsetPoses = {
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),
			            cc.p(-210, 0), cc.p(-147, 147), cc.p(0, 210), cc.p(147, 147),
			            cc.p(210, 0), cc.p(147, -147), cc.p(0, -210), cc.p(-147, -147),			
			}, 
		},

		enemys1 = {                                                   --第一波召唤的忍者兵
			{
				time = 0,	
				num = 1,
				pos = {400},
				delay = {0},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 0,	
				num = 1,
				pos = {900},
				delay = {0.5},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 0.5,	
				num = 1,
				pos = {680},
				delay = {0.5},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	

		enemys2 = {                                                   --第二波召唤的忍者兵
			{
				time = 0,	
				num = 1,
				pos = {1000},
				delay = {0},
				property = {
					placeName = "place5" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 0.5,	
				num = 1,
				pos = {700},
				delay = {0.4},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 1,	
				num = 1,
				pos = {400},
				delay = {0.6},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
		},	

		enemys3 = {                                                   --第三波召唤的忍者兵
			{
				time = 0,	
				num = 1,
				pos = {700},
				delay = {0},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 0.5,	
				num = 1,
				pos = {1000},
				delay = {0},
				property = {
					placeName = "place5" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			
			{
				time = 1,	
				num = 1,
				pos = {500},
				delay = {0},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	

			{
				time = 1.5,	
				num = 1,
				pos = {300},
				delay = {0},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	
	},
---------------------------------------------------------------------------------------------------第7个出场的boss 女忍者  id = 7
	{
		award = 2000,
		image = "renzb",                       --图片名字                                  鬼眼
		hp = 250000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --扔飞镖,按飞镖伤害
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 40,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
			feibiao1 = { 0.90,                --暴雨梨花针1
			},
			feibiao2 = { 0.70,                --暴雨梨花针2	
			},
			feibiao3 = { 0.40,                --暴雨梨花针3
			},						
			zhaohuan = { 0.88, 0.60, 0.30                    --召唤分身
			},                                           
			chongfeng = { 0.99, 0.80,0.65, 0.55, 0.45, 0.35, 0.25, 0.15     --冲锋
			},

			weak3 = {                               --右腿 技能触发(可以同时)
				0.70,0.40,0.10,                       
			},	
			weak2 = {                               --左腿 技能触发(可以同时)
				0.80,0.60,0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.50,0.30,                       
			},
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.70,
			},	
			demage300 = {  
				0.40,
			},	
						
		},

		feibiao1 = {     --srcPoses= 初始位置       --offsetPoses =偏移                   --暴雨梨花针1
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			},               
		},

		feibiao2 = {
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			},               
		},
		feibiao3 = {
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			}, 
		},

		enemys1 = {                                                   --第一波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0},
				property = {
					placeName = "place3" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {800},
				delay = {0.5},
				property = {
					placeName = "place5" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	

		enemys2 = {                                                   --第二波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0},
				property = {
					placeName = "place4" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {700},
				delay = {0.5},
				property = {
					placeName = "place5" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {1000},
				delay = {1},
				property = {
					placeName = "place3" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},	
		},	

		enemys3 = {                                                   --第三波召唤的忍者兵
			{
				time = 2,	
				num = 1,
				pos = {900},
				delay = {0},
				property = {
					placeName = "place3" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0.5},
				property = {
					placeName = "place4" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {600},
				delay = {1},
				property = {
					placeName = "place5" ,
					id = 16,
					type = "renzhe",
					missileId = 18,
				},
			},	
		},
	},
---------------------------------------------------------------------------------------------------第8个出场的boss 鬼眼   id = 8
	{
		image = "dzboss", --图片名字                                                             多足boss巨炮泰坦
		award = 2000,                   --boss产出金币数量
		hp = 300000,
		fireRate = 180,                  --普攻频率
		fireCd = 6,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 3.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)

			-- wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15        --网
			-- },
			wudi = { 0.89, 0.69, 0.49, 0.29, 0.09,
			}, 

			zhaohuan = { 0.90, 0.70, 0.50, 0.30, 0.10,                  --召唤小兵
			},   

			daoDan1 = {                                                   --大黑导弹
				0.99, 0.80, 0.60, 0.40, 0.20, 
			},


			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage300 = {
				0.70,
			},
			demage400 = {
				0.40,
			},			
		},


		daoDan1 = {
		    id = 23,                                  --大黑导弹
			type = "missile",  
			timeOffset = 2.5,                        --导弹间隔时间                 
			offsetPoses = {                           --目标偏移点
            	cc.p( -250, -200),cc.p( 200, -250), cc.p( 200, 200),
        	},
        },


		enemys1 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},	

		enemys2 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys3 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys4 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys5 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},												
	},
---------------------------------------------------------------------------------------------------第9个出场的boss 多足   id = 9
	{
		image = "dzboss_1", --图片名字                                                             --毒刺boss
		award = 2000,                   --boss产出金币数量
		hp = 300000,
		fireRate = 6,                  --普攻频率
		fireCd = 10,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 4.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)
			-- wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15                    --网
			-- },

			wudi = { 0.89, 0.69, 0.49, 0.29, 0.09,
			}, 

			zhaohuan = { 0.90, 0.70, 0.50, 0.30, 0.10,                   --召唤小兵
			},   

			daoDan1 = {                                            --3发烟雾导弹
				0.95, 0.80, 0.60, 0.40, 0.20,
			},



			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage300 = {
				0.70,
			},
			demage400 = {
				0.40,
			},			
		},

		daoDan1 = {
		    id = 22,                                  --烟雾
			type = "dao_wu",  
			timeOffset = 3.0,                        --导弹间隔时间                 
			offsetPoses = {                  --目标点
            	cc.p(250, 150), cc.p(170, -200), cc.p(-250, -100),
        	},
        },


		enemys1 = { 
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			}, 
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {1050,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},                                                 --第1波召唤蜘蛛兵
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 28,	
				},
			},
		},	
		enemys2 = {                                                   --第2波召唤蜘蛛兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			}, 
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {1050,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 28,	
				},
			},
	    },	
		enemys3 = {                                                   --第3波召唤蜘蛛兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			}, 
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {1050,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 28,
				},
			},
		},
		enemys4 = {                                                   --第4波召唤蜘蛛兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			}, 
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {1050,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 28,	
				},
			},
		},
		enemys5 = {                                                   --第5波召唤蜘蛛兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			}, 
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {1050,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 20,
				delay = {0.1,0.2,0.3,0.4,0.5,0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.5,0.9,1.5,2.0,2.5,3.0},
				pos = {300,400,450,550,600,750,850,950,1000,1100,300,400,500,600,700,800,900,1000,1100,950},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 28,	
				},
			},
		},
	},
---------------------------------------------------------------------------------------------------第10个出场的boss 毒刺  id = 10
	{
		award = 2000,
		image = "renzb_01",                       --图片名字                                  魔化鬼眼
		hp = 300000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --扔飞镖,按飞镖伤害
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 40,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
			feibiao1 = { 0.95, 0.75, 0.50, 0.30,                --暴雨梨花针1
			},					
			zhaohuan = { 0.90, 0.60, 0.30                    --召唤分身
			},                                           
			chongfeng = { 0.99, 0.80, 0.65, 0.55, 0.45, 0.35, 0.25, 0.15     --冲锋
			},

			weak3 = {                               --右腿 技能触发(可以同时)
				0.70,0.40,0.10,                       
			},	
			weak2 = {                               --左腿 技能触发(可以同时)
				0.80,0.60,0.20,                        
			},
			weak1 = {                               --头 技能触发(可以同时)
				0.90,0.50,0.30,                       
			},
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.70,
			},	
			demage400 = {  
				0.40,
			},	
						
		},

		feibiao1 = {     --srcPoses= 初始位置       --offsetPoses =偏移                   --暴雨梨花针1
			srcPoses = {
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),
						cc.p(0, -150), cc.p(105, -105), cc.p(150, 0), cc.p(105, 105), 
						cc.p(0, 150), cc.p(-105, 105), cc.p(-150, 0), cc.p(-105, -105),           
			}, 
			offsetPoses = {
			            cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
						cc.p(0, -200), cc.p(140, -140), cc.p(200, 0), cc.p(140, 140),
						cc.p(0, 200), cc.p(-140, 140), cc.p(-200, 0), cc.p(-140, -140),
			},               
		},


		enemys1 = {                                                   --第一波召唤的BOSS
			{
				time = 0,	
				num = 1,
				pos = {500},
				delay = {0},
				property = { 
					type = "chongBoss",                                  -- CF肌肉 boss
					placeName = "place1",
					missileId = 20,                 --导弹id
					missileOffsets = {cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) },
					qiuId = 24,                   --铁球id
					id = 12,
				},
			},	
			
		},	

		enemys2 = {                                                   --第二波召唤的BOSS
			{
				time = 0,	
				num = 1,
				pos = {500},
				delay = {0},
				property = { 
					type = "boss",                                 -- 紫炮boss
					placeName = "place1",
					missileId = 20,            --BOSS导弹ID
					id = 13,            --boss里面id为1  ,以后有可能有很多boss     
				},
			},

		},	

		enemys3 = {                                                   --第三波召唤的BOSS
			{
				time = 0,	
				num = 1,
				pos = {500},
				delay = {0},
				property = { 
					type = "duozuBoss",                             --多足兔子脸
					placeName = "place11",
					wangId    = 27,    --网ID
					missileId = 20,    --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(0, 150) , cc.p(150, -150)},
					id = 14,
				},
			},

		},
	},
---------------------------------------------------------------------------------------------第11波出场的boss    魔化鬼眼    id = 11
	{
		award = 1000,         ----boss产出金币数量
		image = "boss02_1",                              --CF肌肉boss
		hp = 150000,
		demage = 3, 			--这个是没用的
		fireRate = 60,               --普攻频率
		fireCd = 3,                     --普攻cd
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd
		chongfengDemage = 30,                --冲锋造成伤害

		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--手 弱点伤害倍数               

		
		skilltrigger = {   			          --技能触发(可以同时)

			moveLeftFire = {
				0.90, 0.55,
			},
			moveRightFire = {
				0.75, 0.35,
			},
			chongfeng = {
			    0.85, 0.65, 0.45, 0.25, 0.10,
			},
			tieqiu = {
				0.80, 0.60, 0.40, 0.20, 0.05,
			},
			zhaohuan = { 0.95, 0.70, 0.50, 0.30,                      --召唤小兵
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

		enemys1 = {                                                   --第1波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {800,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
		},
		enemys2 = {                                                   --第2波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {260,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {860,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
		},
		enemys3 = {                                                   --第3波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {470,},
				property = { 
					placeName = "place6" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
		},
		enemys4 = {                                                   --第4波召唤医疗兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {370,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {950,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
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
---------------------------------------------------------------------------------------------------魔化鬼眼召唤的boss1 CF肌肉 id = 12
	{
		image = "boss01_2", --图片名字
		award = 1000,                   --boss产出金币数量
		hp = 150000,
		demage = 5,                        --普通攻击伤害
		fireRate = 30,
		fireCd = 2,  		
		walkRate = 120,
		walkCd = 1,         --移动cd	
		wudiTime = 5 , 	    --无敌时间
		
		saoFireOffset = 0.1, 		--扫射时间间隔
		saoFireTimes = 15, 			--一次扫射5下
		weak1 = 1.2,					--手  弱点伤害倍数
		weak2 = 1.2,					--腹  弱点伤害倍数
		weak3 = 1.2,					--头  弱点伤害倍数
		skilltrigger = {   			   --技能触发(可以同时)                
			                                        
			saoShe = { 0.92, 0.72, 0.42 },                --调用普通攻击的伤害  扫射 

			wudi = {0.91, 0.71, 0.41, 0.31, },                    --无敌

			zhaohuan = {0.90, 0.70, 0.40, },                         --召唤小怪 

			moveLeftFire = { 0.80 , 0.30, },
			moveRightFire = { 0.60, },
			

			daoDan1 = {                                            --两发导弹
				0.99, 0.65, 0.35,
			},

			daoDan2 = {                                            --两发导弹
				0.85, 0.55, 0.25,
			},

			daoDan3 = {                                            --两发导弹
				0.75, 0.45, 0.15,
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
				0.70,
			},	
			demage300 = {  
				0.40,
			},							
		},

		daoDan1 = {
		    id = 22,                                 --boss导弹
			type = "dao_wu",                  
			offsetPoses = {
                cc.p(-300, 0), cc.p(300, 0), 
            }               
		},
		daoDan2 = {
			id = 22,                                 --boss导弹
			type = "dao_wu",
			offsetPoses = {
                cc.p(-300, -100), cc.p(300, -100), 
            }               
		},
		daoDan3 = {
			id = 22,                                 --boss导弹
			type = "dao_wu",                       
			offsetPoses = {
                cc.p(-300, -200), cc.p(300, -200), 
            }               
		},


		enemys1 = {                                                     --第1波召唤
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place5" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
			{
				time = 0,
				num = 1,
				delay = {0.3,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0.6,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {550},
				delay = {0.9},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},
		enemys2 = {                                                     --第1波召唤
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place5" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
			{
				time = 0,
				num = 1,
				delay = {0.3,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0.6,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {550},
				delay = {0.9},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},
		enemys3 = {                                                     --第1波召唤
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {700,},
				property = { 
					placeName = "place5" ,
					type = "jin",                  --盾
					id = 8,
				},
			},	
			{
				time = 0,
				num = 1,
				delay = {0.3,},
				pos = {300,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",     --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0.6,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {550},
				delay = {0.9},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
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
---------------------------------------------------------------------------------------------------魔化鬼眼召唤的boss2 紫炮   id = 13
	{
		image = "dzboss", --图片名字                                                             多足boss巨炮泰坦
		award = 1000,                   --boss产出金币数量
		hp = 300000,
		fireRate = 180,                  --普攻频率
		fireCd = 6,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 3.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)

			-- wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15        --网
			-- },
			wudi = { 0.89, 0.69, 0.49, 0.29, 0.09,
			}, 

			zhaohuan = { 0.90, 0.70, 0.50, 0.30, 0.10,                  --召唤小兵
			},   

			daoDan1 = {                                                   --大黑导弹
				0.99, 0.80, 0.60, 0.40, 0.20, 
			},


			weak3 = { 0.70,0.40,0.10,                              --右腿 技能触发(可以同时)          
			},	
			weak2 = { 0.80,0.60,0.20,                                --左腿 技能触发(可以同时)	                      
			},
			weak1 = { 0.90,0.50,0.30,                             --头 技能触发(可以同时)	                        
			},
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},
			demage300 = {
				0.70,
			},
			demage400 = {
				0.40,
			},			
		},


		daoDan1 = {
		    id = 23,                                  --大黑导弹
			type = "missile",  
			timeOffset = 2.0,                        --导弹间隔时间                 
			offsetPoses = {                           --目标偏移点
            	cc.p( -250, -200),cc.p( 200, -250), cc.p( 200, 200),
        	},
        },


		enemys1 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},	

		enemys2 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys3 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys4 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},

		enemys5 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {300,},
				property = { 
					placeName = "place5" ,
					type = "yiliao",                                              --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.1,               --回血百分比
					id = 26,
				},
			},
			{
				time = 0,
				num = 1,
				pos = {400,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place11",
					missileId = 22,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {900,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1100,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},												
	},
---------------------------------------------------------------------------------------------------魔化鬼眼召唤的boss3 多足   id = 14
}

local mapId = "map_1_6"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "bossContest",
	}

	self:randomWaves()
end

function waveClass:randomWaves()
	local waves = {}
	local order = {}
	--order[1] = math.random(8,8) 	
	order[1] = math.random(1,3)
	order[2] = math.random(4,6)
	order[3] = math.random(7,8)
	order[4] = math.random(9,10)
	order[5] = math.random(11, 11)  
	dump(order, "order")

	for i,index in ipairs(order) do
		waves[i] = self.waves[index]
	end
	self.waves = waves	
end

return waveClass