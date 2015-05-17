local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
			{
				time = 2,
				num = 1,
				pos = {350,},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 3,	
				num = 2,
				pos = {250,450},
				delay = {0,1},
				property = { 
					placeName = "place3",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place1",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入          逃犯
					data = {
						direct = "right", --向右逃跑
							{
							pos = 500,  --第一次藏身处 移动 600
							time = 1,   --隐藏时间 3s	
						},											
					},									
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {600,800,1000},
				delay = {0,0.5,1},
				property = { 
					placeName = "place4",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 7,	
				num = 3,
				pos = {250,430,610},
				delay = {0,0.5,1},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0,},
				pos = {1000,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},

			{
				time = 10,
				num = 2,
				delay = {0.5,1.0},
				pos = {250,500},
				property = { 
					placeName = "place3",
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
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "enterright", --从屏幕右侧进入           逃犯
					data = {
						direct = "left", --向左逃跑
						{
							pos = 700,  --第一次藏身处 移动 600
							time = 1,   --隐藏时间 3s	
						},	
																
					},									
				},
			},
			{
				time = 11,	
				num = 2,
				pos = {700,950},
				delay = {0,0.6},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 3,
				pos = {250,430,610},
				delay = {0,0.5,1},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 13,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入          逃犯
					data = {
						direct = "right", --向右逃跑
																		
					},									
				},
			},
			{
				time = 14,
				num = 2,
				delay = {0.5,0},
				pos = {250,900},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 15,	
				num = 3,
				pos = {620,810,1080},
				delay = {0,0.6,1},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 11,	                                               --奖励箱子
				num = 1,
				pos = {300},
				delay = {0},
				property = { 
					type = "awardSan",
					id = 21,
					--award = "goldWeapon",     --黄金武器
					award = "coin",                        --金币
					--award = "shouLei",        --手雷
					--award = "healthBag",                 --医疗包
					value = 500,
					placeName = "place3",
				},
			},                 
		},
	},
	{
		enemys = { 
			{
				time = 2,
				num = 3,
				delay = {0.3,0,0.6},
				pos = {380,680,980},
				property = {
					type = "jin",                      --盾
					placeName = "place2",  
					id = 8,
				},
			},
			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {600,800},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 3,
				num = 2,
				delay = {0,1},
				pos = {0,0},
				property = {
					type = "taofan_qiu",                    --逃犯
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑						
					},									
				},
			},
			{
				time = 3,
				num = 1,
				pos = {450,},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{ 
				time = 4,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {400,600,800},
				property = { 
					type = "taofan_qiu",
					placeName = "place3",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "left", --向左逃跑
											
					},
				},
			},
			{
				time = 4,	
				num = 3,
				pos = {250,450,600},
				delay = {0,0.5,1},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 5,	
				num = 3,
				pos = {980,850,650},
				delay = {0,0.5,1},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0,},
				pos = {1000,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 9,	
				num = 3,
				pos = {250,370,480},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 9,	
				num = 3,
				pos = {1030,930,790},
				delay = {0,0.6,1.6},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,
				num = 2,
				delay = {0,1},
				pos = {0,0},
				property = {
					type = "taofan_qiu",                    --逃犯
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑						
					},									
				},
			},
			{
				time = 9,
				num = 2,
				delay = {0.5,0},
				pos = {350,600},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 10,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.6},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 11,	
				num = 3,
				pos = {250,450,680},
				delay = {0,0.5,1},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
				},
			},		
			{
				time = 12,	
				num = 2,
				pos = {1000,750},
				delay = {0,0.8},
				property = {
					placeName = "place4", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0},
				pos = {0},
				property = {
					type = "taofan_qiu",                    --逃犯
					placeName = "place4",
					id = 4,
					startState = "enterright", --从屏幕右侧进入
					data = {
						direct = "left", --向左逃跑																
					},									
				},
			},
			{
				time = 14,
				num = 2,
				delay = {0.5,0},
				pos = {250,600},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},	
			{
				time = 15,	
				num = 1,
				pos = {980},
				delay = {0,},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			}, 
			{
				time = 11,	                                               --奖励箱子
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
					value = 500,
					placeName = "place3",
				},
			},                                
		},
	},	
	{
		enemys = {                                           
			{
				time = 2,
				num = 3,
				delay = {0.3,0,0.6},
				pos = {380,680,980},
				property = {
					type = "jin",                       --盾
					placeName = "place2",  
					id = 8,
				},
			},
			{
				time = 2.5,
				num = 3,
				delay = {0, 0.7, 1.4},
				pos = {750,850,1000},	
				property = { 
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 3,
				num = 1,
				pos = {450,},
				delay = {0,},                         
				property = {
					type = "jipu" ,                -- 吉普车
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		--持续时间			
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0,0.7,1.5},
				pos = {0,0,0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入        逃犯
					data = {
						direct = "right", --向右逃跑
												
					},									
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0,},
				pos = {350,},
				property = { 
					placeName = "place3" ,
					type = "yiliao",                                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},
			{
				time = 8,
				num = 1,
				delay = {0,},
				pos = {1000,},
				property = { 
					placeName = "place4" ,
					type = "yiliao",                                --医疗兵
					startState = "enterright",       --从右面跑出来
					skillCd = 5.0,                  --回血cd
					skillValue = 0.3,              --回血百分比
					id = 10,
				},
			},	
			{
				time = 4,
				num = 3,
				delay = {0,0.7, 1.4},
				pos = {450,550,650},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},
			},	
			{
				time = 5,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},                                        
			{
				time = 6,	
				num = 3,
				pos = {350,550,750},
				delay = {0,0.5,1.0},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place4",
				},
			},                                 
			{
				time = 7,
				num = 3,
				delay = {0, 0.6, 1.4},
				pos = {260,340,430,},	
				property = { 
					placeName = "place1", 
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0, 1.4, 0.7},
				pos = {770,850,970},	
				property = { 
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0,0.7,1.4},
				pos = {0,0,0},
				property = {
					type = "taofan_qiu",                    --逃犯
					placeName = "place4",
					id = 4,
					startState = "enterright", --从屏幕右侧进入
					data = {
						direct = "left", --向左逃跑																
					},									
				},
			},
			{
				time = 9,	
				num = 1,
				pos = {300},
				delay = {0.5},
				property = { 
					placeName = "place4",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 10,
				num = 2,
				delay = {0.2,1.0},
				pos = {550,700},					
				property = {
					placeName = "place3",  
					startState = "rollleft",
					id = 1,
				},
			},
			{ 
				time = 12,
				num = 2,
				pos = {450,850},
				delay = {2,0},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "right", --向左逃跑
											
					},
				},
			},
			{ 
				time = 12,
				num = 2,
				pos = {350,600,},
				delay = {3,1,},
				property = { 
					type = "taofan_qiu",
					placeName = "place2",
					id = 4,
					startState = "san",  --从伞进入                          伞落下的逃犯
					data = {
						direct = "left", --向右逃跑
											
					},
				},
			},
			{ 
				time = 12,
				num = 4,
				pos = {300,400,550,700},
				delay = {3.5,2.5,1.5,0.5,},
				property = { 
					type = "common",
					startState = "san",
					id = 1,
					placeName = "place2",
				},
			},
			{
				time = 11,	                                               --奖励箱子
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
					value = 500,
					placeName = "place3",
				},
			},
		},
	},
	
}

--enemy的关卡配置                                        黄金镶嵌 m4a1满级180  dps大于等于5  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=15,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=3,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=10000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=20,hp=600,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=5,hp=30000, weak1=2, weak4=3,},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=20,hp=50000,fireRate=180,fireCd=5,speed= 40,
	weak1=2},

	--医疗兵      type = "yiliao",
	{id=10,image="yiliaob",demage=20,hp=25000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=100000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},
                                                         
	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=25,hp=5000, weak1=1},

	-- 金武箱子奖励  type = "awardSan",
	{id=21,image="dl_xz",hp=1, weak1=1},	--金武箱子奖励 

}



local mapId = "map_1_2"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "taoFan",
		limitNums = 5,                      --逃跑逃犯数量
	}

end

return waveClass