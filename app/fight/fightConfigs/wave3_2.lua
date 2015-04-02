local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	-- {
	-- 	enemys = { 
	-- 		{
	-- 			time = 2,
	-- 			num = 2,
	-- 			pos = {200,600},
	-- 			delay = {0,0.5},                            -- 吉普车
	-- 			property = {
	-- 				type = "jipu" ,
	-- 				id = 12,
	-- 				placeName = "place12",
	-- 				missileId = 6,
	-- 				missileType = "daodan",
	-- 				missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
	-- 				startState = "enterleft",
	-- 				lastTime = 50.0,		--持续时间			
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 4,
	-- 			num = 1,
	-- 			delay = {0.5},
	-- 			pos = {800},
	-- 			property = { 
	-- 				placeName = "place2",
	-- 				id = 2,
	-- 				startState = "rollleft",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 5,
	-- 			num = 1,
	-- 			delay = {0.5},
	-- 			pos = {250},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 5,	
	-- 			num = 2,
	-- 			pos = {250,350},
	-- 			delay = {0,1.5},
	-- 			property = { 
	-- 				placeName = "place4",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},

	-- 		{
	-- 			time = 6,	
	-- 			num = 3,
	-- 			pos = {830,780,700},
	-- 			delay = {0,1.6,0.9},
	-- 			property = { 
	-- 				placeName = "place2",
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 6,	
	-- 			num = 3,
	-- 			pos = {220,360,300},
	-- 			delay = {0,1.5,0.8},
	-- 			property = { 
	-- 				placeName = "place1",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 7,	
	-- 			num = 3,
	-- 			pos = {820,750,650},
	-- 			delay = {0,1.6,0.8},
	-- 			property = {
	-- 				placeName = "place4", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 7,
	-- 			num = 2,
	-- 			delay = {0.2,0},
	-- 			pos = {250,900},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 9,	
	-- 			num = 2,
	-- 			pos = {700,950},
	-- 			delay = {0,0.7},
	-- 			property = {
	-- 				placeName = "place3", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 9,	
	-- 			num = 3,
	-- 			pos = {290,450,300},
	-- 			delay = {0,1.5,0.8},
	-- 			property = { 
	-- 				placeName = "place2",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 10,	
	-- 			num = 2,
	-- 			pos = {1000,750},
	-- 			delay = {0,0.8},
	-- 			property = {
	-- 				placeName = "place4", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 10,
	-- 			num = 2,
	-- 			delay = {0.2,0.9},
	-- 			pos = {250,900},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 11,	
	-- 			num = 3,
	-- 			pos = {760,910,980},
	-- 			delay = {0,1.6,0.8},
	-- 			property = {
	-- 				placeName = "place2", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 			},
	-- 		},                                                                       	-- 以上是第三波第三批 31
	-- 	},
	-- },	

	-- {                                                                                    --第四波
	-- 	enemys = { 
	-- 		{
	-- 			time = 2,
	-- 			num = 2,
	-- 			pos = {200,550},
	-- 			delay = {0.5,1},                            -- 吉普车
	-- 			property = {
	-- 				type = "jipu" ,
	-- 				id = 12,
	-- 				placeName = "place12",
	-- 				missileId = 6,
	-- 				missileType = "daodan",
	-- 				missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
	-- 				startState = "enterleft",
	-- 				lastTime = 40.0,		--持续时间
	-- 				--demageScale = 2                    --伤害翻1.5倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 4,
	-- 			num = 1,
	-- 			pos = {450},
	-- 			delay = {0.2},                         -- 飞机
	-- 			property = {
	-- 				type = "feiji" ,
	-- 				id = 11,
	-- 				placeName = "place11",
	-- 				missileId = 6,
	-- 				missileType = "daodan",
	-- 				missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
	-- 				startState = "enterleft",
	-- 				lastTime = 40.0,		                                    --持续时间			
	-- 			},
	-- 		},				
	-- 		{
	-- 			time = 6,
	-- 			num = 1,
	-- 			delay = {0.5},
	-- 			pos = {800},
	-- 			property = { 
	-- 				placeName = "place2",
	-- 				id = 2,
	-- 				startState = "rollleft",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 				--demageScale = 2                    --伤害翻1.5倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 7,
	-- 			num = 1,
	-- 			delay = {0.8},
	-- 			pos = {250},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 		        --demageScale = 2                    --伤害翻1.5倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 7,	
	-- 			num = 2,
	-- 			pos = {250,450},
	-- 			delay = {0,1.8},
	-- 			property = { 
	-- 				placeName = "place4",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},

	-- 		{
	-- 			time = 8,	
	-- 			num = 3,
	-- 			pos = {820,760,550},
	-- 			delay = {0,1.6,0.8},
	-- 			property = { 
	-- 				placeName = "place2",
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},		                                                       -- 以上是第四波第一批 11
	-- 		{
	-- 			time = 8,	
	-- 			num = 3,
	-- 			pos = {250,450,330},
	-- 			delay = {0,1.5,0.8},
	-- 			property = { 
	-- 				placeName = "place1",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 9,	
	-- 			num = 3,
	-- 			pos = {850,750,680},
	-- 			delay = {0,0.6,1.3},
	-- 			property = {
	-- 				placeName = "place4", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 9,
	-- 			num = 2,
	-- 			delay = {0.2,0.9},
	-- 			pos = {250,500},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 10,	
	-- 			num = 2,
	-- 			pos = {800,950},
	-- 			delay = {0,0.6},
	-- 			property = {
	-- 				placeName = "place3", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},					                                             -- 以上是第四波第二批 21
	-- 		{
	-- 			time = 10,	
	-- 			num = 3,
	-- 			pos = {250,350,430},
	-- 			delay = {0,1.5,0.8},
	-- 			property = { 
	-- 				placeName = "place1",
	-- 				startState = "rollright",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},		
	-- 		{
	-- 			time = 11,	
	-- 			num = 2,
	-- 			pos = {1000,750},
	-- 			delay = {0,0.8},
	-- 			property = {
	-- 				placeName = "place4", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},
	-- 		{
	-- 			time = 11,
	-- 			num = 2,
	-- 			delay = {0.2,0.9},
	-- 			pos = {250,900},
	-- 			property = { 
	-- 				placeName = "place3",
	-- 				id = 2,
	-- 				startState = "rollright",
	-- 				type = "dao",
	-- 				missileId = 3,
	-- 				missileType = "lei",
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},	
	-- 		{
	-- 			time = 12,	
	-- 			num = 3,
	-- 			pos = {700,840,980},
	-- 			delay = {0,0.6,1.3},
	-- 			property = {
	-- 				placeName = "place2", 
	-- 				startState = "rollleft",
	-- 				id = 1,
	-- 				--demageScale = 2                    --伤害翻1.2倍
	-- 			},
	-- 		},                                                                         	-- 以上是第四波第三批 31
	-- 	},
	-- },	

	{
		enemys = {  
			-- 忍者 白银 （3条）      血量（ -100 - 100）
			--      黄金 （3条）      血量（100）
			{
				time = 3,	
				num = 1,
				pos = {368},
				delay = {0.4},
				property = { 
					type = "renzheBoss",
					placeName = "place13",
					missileId = 18, 
					missileOffsets = {cc.p(-250, 0) , cc.p(0, 0), cc.p(250, 0)},
					id = 1,
				},
			},
		},
	},

}



--enemy的关卡配置                                                    黄金镶嵌 MP5满级  dps大于等于7 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=28,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=27,hp=1000,
	weak1=1},

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=10000,
	weak1=2},	                                                           

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=25000,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=35,hp=3000,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=12,hp=30000,fireRate=180,fireCd=4,speed=80,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=15,hp=70000,fireRate=180,fireCd=5,speed=60,
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=15,hp=5000,fireRate=30,speed=100,
	weak1=2},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=2},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=100000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=120, fireCd=3.0,
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
	{id=16,image="jinzhanb",demage=9,hp=100000,fireRate=120,fireCd=3,speed=40,scale = 2.5 ,
	weak1=2},                                                          --scale = 3.0,  近战走到屏幕最近放缩比例

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=35,hp=50000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=10,hp=5000},                             

	--铁球
	{id=19,image="tieqiu",demage=20,hp=8000},

	--小蜘蛛   --type = "bao",
	{id=20,image="xiaozz",demage=15,hp=5000, speed=150,weak1=1}, 

	--烟雾导弹
	{id=21,image="daodan03",demage=1,hp=8000, weak1=1},   

	--大导弹          --missileType = "daodan",
	{id=22,image="daodan02",demage=10,hp=500, weak1=1},	

}



	--boss的关卡配置
local bosses = {
	--第一个出场的boss
	{
		image = "renzb",                       --图片名字         红衣女忍者
		award = 40000,                   --boss产出金币数量
		hp = 200000,
		fireRate = 120,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --
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
			demage300 = {  
				0.20,
			},			
		},

		feibiao1 = {     --srcPoses= 初始位置       --offsetPoses =偏移                   --暴雨梨花针1
			srcPoses = {
						cc.p(0, 150), cc.p(-130, 130), cc.p(-150, 0), cc.p(-130, -130),
						cc.p(0, -150), cc.p(130, -130), cc.p(150, 0), cc.p(130, 130),            
			}, 
			offsetPoses = {
			            cc.p(0, 300), cc.p(-260, 260), cc.p(-300, 0), cc.p(-260, -260),
						cc.p(0, -300), cc.p(260, -260), cc.p(300, 0), cc.p(260, 260),
			},               
		},

		feibiao2 = {
			srcPoses = {
						cc.p(150, 0), cc.p(130, 130), cc.p(0, -150),  cc.p(-130, -130), 
						cc.p(-150, 0),  cc.p(-130, 130), cc.p(0, 150), cc.p(130, -130),      
			}, 
			offsetPoses = {
			            cc.p(300, 0), cc.p(260, -260), cc.p(0, -300), cc.p(-260, -260),
			            cc.p(-300, 0), cc.p(-260, 260), cc.p(0, 300), cc.p(260, 260),			
			},               
		},

		feibiao3 = {
			srcPoses = {
						cc.p(-200, 50), cc.p(-100, 50), cc.p(0, 50), cc.p(100, 50), cc.p(200, 50),
						cc.p(-200, -50), cc.p(-100, -50), cc.p(0, -50), cc.p(100, -50), cc.p(200, -50),       
			}, 
			offsetPoses = {
			            cc.p(-250, 200), cc.p(-150, 200), cc.p(50, 200), cc.p(150, 200), cc.p(250, 200),
						cc.p(-250, -200), cc.p(-150, -200), cc.p(50, -200), cc.p(150, -200), cc.p(250, -200),
			}, 
		},

		feibiao4 = {
			srcPoses = {
						cc.p(-100, 100), cc.p(100, -100), cc.p(100, 100), cc.p(-100, -100),
						cc.p(-100, 100), cc.p(100, -100), cc.p(100, 100), cc.p(-100, -100), 
						cc.p(-100, 100), cc.p(100, -100), cc.p(100, 100), cc.p(-100, -100),      
			}, 
			offsetPoses = {
			            cc.p(-200, 200), cc.p(200, -200), cc.p(200, 200), cc.p(-200, -200),
						cc.p(-200, 200), cc.p(200, -200), cc.p(200, 200), cc.p(-200, -200),
						cc.p(-200, 200), cc.p(200, -200), cc.p(200, 200), cc.p(-200, -200),
			}, 
		},

		enemys1 = {                                                   --第一波召唤的忍者兵
			{
				time = 0,	
				num = 1,
				pos = {400},
				delay = {0.2},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 0,	
				num = 1,
				pos = {800},
				delay = {0.2},
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
				time = 1,	
				num = 1,
				pos = {400},
				delay = {0.2},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 1,	
				num = 1,
				pos = {700},
				delay = {0.4},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 1,	
				num = 1,
				pos = {1000},
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
				time = 2,	
				num = 1,
				pos = {900},
				delay = {0.2},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {400},
				delay = {0.4},
				property = {
					placeName = "place1" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
			{
				time = 2,	
				num = 1,
				pos = {600},
				delay = {0.6},
				property = {
					placeName = "place2" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},	
			{
				time = 2,	
				num = 1,
				pos = {750},
				delay = {0.8},
				property = {
					placeName = "place3" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},	
	},
	-- {

	-- 	image = "boss02_2", --图片名字
	-- 	hp = 150000,
	-- 	award = 20000,                   --boss产出金币数量
	-- 	demage = 3, 			--这个是没用的 需要告诉俊松
	-- 	fireRate = 100,               --普攻频率
	-- 	fireCd = 3,                     --普攻cd

	-- 	walkRate = 120,                    --移动频率
	-- 	walkCd = 2,                         --移动cd
	-- 	chongfengDemage = 25,                --冲锋造成伤害
	-- 	weak1 = 1.2,						--头 弱点伤害倍数
	-- 	weak2 = 1.2,					--手 弱点伤害倍数

		
	-- 	skilltrigger = {   			          --技能触发(可以同时)
	-- 		moveLeftFire = {
	-- 			0.80, 0.40,
	-- 		},
	-- 		moveRightFire = {
	-- 			0.60, 0.20, 
	-- 		},
	-- 		chongfeng = {
	-- 		    0.95,0.90,0.85,0.70,0.55,0.50, 0.35, 0.10
	-- 		},
	-- 		tieqiu = {
	-- 		    0.99,0.75, 0.65,0.45, 0.30,
	-- 		},	


	-- 		weak2 = {                               --手 技能触发(可以同时)
	-- 			0.80,0.40,                       
	-- 		},
	-- 		weak1 = {                               --头 技能触发(可以同时)
	-- 			0.60,0.20,                       
	-- 		},
	-- 		demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
	-- 			0.85,
	-- 		},	
	-- 		demage250 = {  
	-- 			0.60,
	-- 		},	
	-- 		demage300 = {  
	-- 			0.50,
	-- 		},						
	-- 	},
	-- 	getMoveLeftAction = function ()
	-- 		local move1 = cc.MoveBy:create(10/60, cc.p(0, 0))
	-- 		local move2 = cc.MoveBy:create(15/60, cc.p(-18, 0))
	-- 		local move3 = cc.MoveBy:create(13/60, cc.p(-45, 0))	
	-- 		local move4 = cc.MoveBy:create(7/60, cc.p(-12, 0))
	-- 		local move5 = cc.MoveBy:create(15/60, cc.p(-4, 0))
	-- 		return cc.Sequence:create(move1, move2, move3, move4, move5)
	-- 	end,

	-- 	getMoveRightAction = function ()
	-- 		local move1 = cc.MoveBy:create(10/60, cc.p(10, 0))
	-- 		local move2 = cc.MoveBy:create(15/60, cc.p(30, 0))
	-- 		local move3 = cc.MoveBy:create(10/60, cc.p(10, 0))	
	-- 		local move4 = cc.MoveBy:create(15/60, cc.p(12, 0))
	-- 		local move5 = cc.MoveBy:create(10/60, cc.p(4, 0))
	-- 		return cc.Sequence:create(move1, move2, move3, move4, move5)
	-- 	end,
	-- },
}

local mapId = "map_1_2"
local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.limit  = limit
	self.fightMode =  {
		type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass
