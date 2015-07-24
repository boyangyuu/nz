--[[
local BaseWave = import(".BaseWave")
local waveClass = class("waveExample", BaseWave)

-----------简介----------
				descId = "dunbing",
----------小蜘蛛---------
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
---------- 盾兵 ---------
			{                                                       
				time = 11,
				num = 4,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {100,230,460,590,720},
				property = {
					placeName = "place3",
					type = "jin", 
					id = 8,
				},
			},
---------- 导弹兵配置 ------
			{
				time = 12.5,
				num = 1,
				delay = {0},
				pos = {330},					
				property = {
					placeName = "place1",   
					id = 5,
					type = "dao",
					missileId = 6,
					missileType = "daodan",
				},
			},

---------- 伞兵------------
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
---------- 绑架人质配置 --------------------------------
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {130},
				property = { 
					placeName = "place6",
					type = "bangfei",
					renzhiName = "人质1",      --  一组统一标示
					id = 14,
				},
			},
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {130},
				property = { 
					placeName = "place6",
					type = "bangren",
					renzhiName = "人质1",     --  一组统一标示
					id = 15,
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失
				},
			},

			--------------
			{
				time = 11,
				num = 1,
				pos = {200},                               
				delay = {0},                            
				property = { 
					id = 10,
					type = "renzhi",
					placeName = "place5",
					startState = "enterleft", 
					lastTime = 5,                       -- 人质离开时间
					                    			     -- 人质
				},
			},


			--------------
			{
				time = 3.5,
				num = 1,
				delay = {0.1},
				pos = {0},                                 
				property = {                               --黄衣人质
					placeName = "place11",
					startState = "enterleft",
					type = "shangren",	
					id = 21,
					data = {
						{
							pos = 1000,
							time = 3,
							direct = "right",							
						},						
					},
				},
			},

---------- 逃犯配置 -----------------------------
			{ 
				time = 1,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					type = "taofan_qiu",
					placeName = "place6",
					id = 4,
					startState = "san",  --从伞进入
					data = {
						direct = "left", --向左逃跑
						{
							pos = -200,  --第一次藏身处 移动 -200
							time = 3,	 --隐藏时间 3s													
						},	
						{
							pos = -600,  --第2次藏身处 移动 - 600
							time = 4,	 --隐藏时间 4s													
						},											
					},		
					exit = "middle", --在屏幕中消失 不填表示屏幕外消失			
				},
			},
			{en
				time = 1,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
						{
							pos = 300,  --第一次藏身处 移动 600
							time = 3,   --隐藏时间 3s	
						},						
						{
							pos = 200,  --第一次藏身处 移动 200
							time = 3,   --隐藏时间 3s	
						},						
					},									
				},
			},	

			--囚犯            type = "taofan_qiu",
			{id=4,image="qiufan",demage=21,hp=11, weak1=1},	

	-----------------自爆兵----------

				{
				time = 14,
				num = 5,
				delay = {0,0.3,0.6,0.9,1.2},
				pos = {180,300,550,750,930},
				property = { 
					placeName = "place3" ,
					type = "bao",      --爆
					id = 9,	
				},
			},

	-----------------吉普车----------

			{
				time = 6,
				num = 1,
				pos = {300,},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place1",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},

---------- 飞机配置---------
			{
				time = 7,
				num = 1,
				pos = {450},
				delay = {0.2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place11",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 10.0,		                                    --持续时间		
				},
			},

---------- 汽油桶配置 -----------------------------
			{
				time = 1,
				num = 1,
				delay = {0.5},
				pos = {335},
				property = { 
					placeName = "place5",
					type = "bao_tong",
					id = 4,
				},
			},	

	--汽油桶           --type = "bao_tong",
	{id=4,image="qyt_01",demage=21111,hp=1,
	weak1=1},


---------- 狙击兵配置 -----------------------------
			{
				time = 1,
				num = 1,
				delay = {0.5},
				pos = {135},
				property = { 
					placeName = "place1",
					type = "juji",
					startState = "rollright",
					id = 21,
				},
			},
	--狙击兵      --type = "juji",
	{id=5,image="jujib",demage=20,hp=1120,rollRate=180,rollCd=3,fireRate=2, fireCd = 3,
	weak1=3},


---------- 医疗兵配置 -----------------------------
			{
				time = 1,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					placeName = "place1",
					type = "yiliao",
					startState = "enterright",
					skillCd = 5.0,
					skillValue = 30,
					id = 20,
				},
			},	

	--医疗兵      --type = "yiliao",
	{id=14,image="yiliaob",demage=20,hp=1110,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=3},

---------- 奖励兵配置 -----------------------------
			{
				time = 1.5,	                                               --奖励箱子
				num = 1,
				pos = {150},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 100,
					isStand = true,
					placeName = "place4",
				},
			},
			{
				time = 6,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "goldWeapon",         --黄金武器
					placeName = "place1",
				},
			},
			{
				time = 6,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "shouLei",            --手雷
					value = 1,
					placeName = "place1",
				},
			},
			{
				time = 6,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "coin",                 --金币
					value = 1000,
					placeName = "place1",
				},
			},						
			{
				time = 6,	                                               --金武奖励箱子
				num = 1,
				pos = {200},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 31,
					award = "healthBag",             --医疗包
					value = 1,
					placeName = "place1",
				},
			},		
	-- 金武箱子奖励  type = "awardSan",
	{id=11,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 

-----------------------------------------------------------------------------推荐武器
		adviseData = {
			type = "blt",   --goldJijia
			cost  = 450,    --钻石话费
			gunId = 10,      --武器id10  寒冰巴雷特
		}, 

---------------------------------------------------------推荐黄金机甲
		adviseData = {
			type = "goldJijia", --黄金机甲
			cost  = 450,  --钻石花费 
		},

--enemy的关卡配置                                                    白银难度对应怪物属性
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=16,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=375,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=3},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=375,
	weak1=3},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=4,hp=550,
	weak1=4, weak4=4},
                                                           
	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=562,walkRate=120,walkCd=2,fireRate=240,fireCd=5,
	weak1=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=25,hp=375,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵 盾兵到身前的比例
	{id=7,image="jinzhanb",demage=20,hp=936,fireRate=180,fireCd=4,speed=60,
	weak1=3},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=3744,fireRate=180,fireCd=5,speed=30,
	weak1=3},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=60,hp=562,fireRate=30,speed=70,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=10000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=3,    award = 60},

	--吉普       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=10000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--吉普车烟雾导弹          missileType = "dao_wu",
  	{id=13,image="daodan03",demage=25,hp=20000, weak1=1},

	--绑匪                                     140--左右移动距离       280--滚动距离
	{id=14,image="tufeib",demage=4,hp=160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4, weak1=3},

	--被绑架人        --type = "bangren",
	{id=15,image="hs", hp=1000, weak1=1},
	
	--近战boss兵         --type = "jin",
	{id=16,image="jinzhanb",demage=120,hp=20000,fireRate=60,fireCd=2,speed=40,scale = 3.0,
	weak1=3}, 

	--忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=50,hp=30000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 100, shanCd = 4, chongRate = 100, chongCd = 4, weak1=3, award = 10},	

	--飞镖
	{id=18,image="feibiao",demage=10,hp=2500},                             --scale = 3.0,  近战走到屏幕最近放缩比例
	
	--蜘蛛网
	{id=19,image="zzw",demage=10,hp=12500},

	--医疗兵      type = "yiliao",
	{id=20,image="yiliaob",demage=20,hp=25000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4.0,
	weak1=2},

	--狙击兵      --type = "juji",
	{id=21,image="jujib",demage=18,hp=3000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2}, 

	--黄衣人质商人      type = "shangren",
	{id=21,image="shangr_1",hp=1000, weak1=1},	--黄衣人质商人	

	-- 金武箱子奖励  type = "awardSan",
	{id=31,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励

	--金币绿气球   type = "jinbi",
	{id=33,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=34,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=35,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=18,hp=3000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2}, 
}


function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = "map_1_2"
	self.limit  = 10

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

]]