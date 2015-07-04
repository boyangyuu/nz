local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				time = 2,
				num = 3,
				delay = {0,1,0.5},
				pos = {300,600,900},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 3,
				num = 1,
				pos = {400,},
				delay = {0,},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		--持续时间			
				},
			},
			{
				time = 4,
				num = 1,
				delay = {0.5},
				pos = {800},
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
				time = 4.5,
				num = 1,
				delay = {0.5},
				pos = {250},
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
				time = 5,
				num = 1,
				delay = {0},
				pos = {430},
				property = { 
					placeName = "place2",
					type = "yiliao",
					startState = "enterleft",       --从左面跑出来      医疗兵
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 6,	
				num = 2,
				pos = {250,350},
				delay = {0,1.5},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 7,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place5",
					id = 4,
					startState = "enterright", --从屏幕左侧进入
					data = {
						direct = "left", --向右逃跑
						{
							pos = 700,  --第一次藏身处 移动 600
							time = 2,   --隐藏时间 3s
						},
																
					},							
				},
			},
			{
				time = 9,
				num = 2,
				delay = {0.2,0},
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
				time = 10,	
				num = 2,
				pos = {700,950},
				delay = {0,0.7},
				property = {
					placeName = "place3", 
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 11,
				num = 1,
				delay = {0},
				pos = {430},
				property = { 
					placeName = "place2",
					type = "yiliao",
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
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
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入
					data = {
						direct = "right", --向右逃跑
																		
					},									
				},
			},
			{
				time = 14,
				num = 2,
				delay = {0.2,0.9},
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
				pos = {760,910,980},
				delay = {0,1.6,0.8},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},                                                                       
		},
	},	
	{                                                                               
		enemys = { 
			{
				time = 2,
				num = 3,
				delay = {0,1,0.5},
				pos = {300,600,900},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 3,
				num = 1,
				pos = {550},
				delay = {0.5,},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 40.0,		--持续时间
					--demageScale = 2                    --伤害翻1.5倍
				},
			},
			-- {
			-- 	time = 4,
			-- 	num = 1,
			-- 	pos = {450},
			-- 	delay = {0.2},                         -- 飞机
			-- 	property = {
			-- 		type = "feiji" ,
			-- 		id = 11,
			-- 		placeName = "place11",
			-- 		missileId = 6,
			-- 		missileType = "daodan",
			-- 		missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
			-- 		startState = "enterleft",
			-- 		lastTime = 40.0,		                                    --持续时间			
			-- 	},
			-- },				
			{
				time = 4,
				num = 1,
				delay = {0.5},
				pos = {800},
				property = { 
					placeName = "place2",
					id = 2,
					startState = "rollleft",
					type = "dao",
					missileId = 3,
					missileType = "lei",
					--demageScale = 2                    --伤害翻1.5倍
				},
			},
			{
				time = 6,	
				num = 2,
				pos = {250,450},
				delay = {0,1.8},
				property = { 
					placeName = "place4",
					startState = "rollright",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},
			{ 
				time = 7,
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
				time = 8,	
				num = 3,
				pos = {820,760,550},
				delay = {0,1.6,0.8},
				property = { 
					placeName = "place2",
					startState = "rollleft",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},		                                                      		
			{
				time = 9,
				num = 2,
				delay = {0,0.5},
				pos = {430,800},
				property = { 
					placeName = "place2",
					type = "yiliao",
					startState = "enterleft",       --从左面跑出来      医疗兵
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 9,
				num = 2,
				delay = {0.2,0.9},
				pos = {250,500},
				property = { 
					placeName = "place3",
					id = 2,
					startState = "rollright",
					type = "dao",
					missileId = 3,
					missileType = "lei",
					--demageScale = 2                    --伤害翻1.2倍
				},
			},	
			{
				time = 10,
				num = 1,
				pos = {400,},
				delay = {0,},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		--持续时间			
				},
			},	
			{
				time = 10,	
				num = 3,
				pos = {250,350,430},
				delay = {0,1.5,0.8},
				property = { 
					placeName = "place1",
					startState = "rollright",
					id = 1,
					--demageScale = 2                    --伤害翻1.2倍
				},
			},		
			{
				time = 11,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入       逃犯
					data = {
						direct = "right", --向右逃跑						
					},									
				},
			},
			{
				time = 12,
				num = 2,
				delay = {0.2,0.9},
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
				time = 13,
				num = 1,
				delay = {0},
				pos = {430},
				property = { 
					placeName = "place2",
					type = "yiliao",
					startState = "enterleft",       --从左面跑出来      医疗兵
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 13,
				num = 1,
				delay = {0.5},
				pos = {0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterright", --从屏幕左侧进入         逃犯
					data = {
						direct = "left", --向右逃跑
																	
					},									
				},
			},
			{
				time = 14,	
				num = 3,
				pos = {700,840,980},
				delay = {0,0.6,1.3},
				property = {
					placeName = "place2", 
					startState = "rollleft",
					id = 1,
				},
			},
		},
	},	
	{
		enemys = {                                           
			{
				time = 2,
				num = 3,
				delay = {0,1,0.5},
				pos = {300,600,900},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},		                                                           
			{
				time = 3,
				num = 1,
				pos = {400,},
				delay = {0,},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		--持续时间			
				},
			},
			{
				time = 3.5,
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
				time = 4,
				num = 1,
				delay = {0},
				pos = {430},
				property = { 
					placeName = "place2",
					type = "yiliao",
					startState = "enterleft",       --从左面跑出来      医疗兵
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 4,
				num = 2,
				delay = {0.5,1.5},
				pos = {0,0},
				property = {
					type = "taofan_qiu", 
					placeName = "place4",
					id = 4,
					startState = "enterleft", --从屏幕左侧进入             逃犯
					data = {
						direct = "right", --向右逃跑
												
					},									
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
				num = 1,
				delay = {0},
				pos = {850},
				property = { 
					placeName = "place4",
					type = "yiliao",
					startState = "enterleft",       --从左面跑出来      医疗兵
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
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
				time = 11,
				num = 1,
				pos = {600,},
				delay = {0,},                            -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place12",
					missileId = 13,
					missileType = "dao_wu",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 50.0,		--持续时间			
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
		},
	},

}



--enemy的关卡配置                                                    M4A1 6级白银镶嵌   1枪伤害621  dps大于等于2  怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=8,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=3000,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=100,
	weak1=1},

	--囚犯            type = "taofan_qiu",
	{id=4,image="qiufan",demage=5,hp=3000, weak1=2, weak4= 4,},
	                                                          
    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=10,hp=100,
	weak1=1},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=10,hp=10000,fireRate=180,fireCd=5,speed=35, weak1=2},

	-- --飞机         type = "feiji" ,
	-- {id=11,image="feiji",demage=0,hp=15000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=60, fireCd=4.0,
	-- weak1=2,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=15000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate= 6, fireCd=8.0,
	weak1=2,    award = 60},

	--吉普车烟雾导弹          missileType = "dao_wu",
	{id=13,image="daodan03",demage=10,hp=100, weak1=1},

	--医疗兵      --type = "yiliao",
	{id=25,image="yiliaob",demage=8,hp=6000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},
                           

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
		--type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		type 	  = "taoFan",
		limitNums = 4,                      --逃跑逃犯数量

	}
end

return waveClass
