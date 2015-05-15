local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = {
		    {   
		    	descId = "feiji", --简介
				time = 2,
				num = 1,
				pos = {670},
				delay = {2},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},
			{
				time = 8,
				num = 4,
				delay = {0.5,1,0,1.5},
				pos = {480,680,850,1050},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 10,
				num = 5,
				delay = {1.1,0.6,1.7,0.3,1.8},
				pos = {350,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},
			{
				time = 13,	
				num = 5,
				pos = {355,420,510,770,900},
				delay = {0,0.9,0.5,0.6,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {650},
				property = { 
					placeName = "place3",
					type = "yiliao",                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 15,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},	
			{
				time = 16,
				num = 2,
				delay = {0.5,1},
				pos = {250,320},
				property = { 
					placeName = "place3" ,
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},                                                          
			},	
			{
				time = 17,
				num = 2,
				delay = {0.5,1},
				pos = {980,1100},
				property = { 
					placeName = "place4" ,
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},                                                          
			},
			{
				time = 18,
				num = 3,
				delay = {0.5,1,0},
				pos = {450,560,690},
				property = { 
					placeName = "place4" ,
					id = 1,
					startState = "rollright",	
				},                                                     
			},
			{
				time = 19,
				num = 3,
				delay = {0.5,1.5,1},
				pos = {220,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},
			{
				time = 20,
				num = 3,
				delay = {0,1.1,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 21,
				num = 1,
				delay = {0},
				pos = {300},
				property = { 
					placeName = "place2",
					type = "yiliao",                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 22,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},	
			{
				time = 24,	
				num = 5,
				pos = {420,560,700,880,990},
				delay = {1.4,0.6,0,1,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 26,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},                                                                          
			},	
			{
				time = 30,
				num = 4,
				delay = {0,0.7,1.4,1.8},
				pos = {600,500,400,300},					
				property = {
					placeName = "place2",  
					type = "common",
					startState = "san",
					id = 1,
				},                                                                     
			},	
		},	
	},
	{
		enemys = {
		    {
				time = 0,
				num = 1,
				pos = {670},
				delay = {0},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},
			{
				time = 8,
				num = 4,
				delay = {0.5,1,0,1.5},
				pos = {480,680,850,1050},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 10,
				num = 5,
				delay = {1.1,0.6,1.7,0.3,1.8},
				pos = {350,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},
			{
				time = 13,	
				num = 5,
				pos = {355,420,510,770,900},
				delay = {0,0.9,0.5,0.6,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {680},
				property = { 
					placeName = "place3",
					type = "yiliao",                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 15,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},	
			{
				time = 16,
				num = 2,
				delay = {0.5,1},
				pos = {250,320},
				property = { 
					placeName = "place3" ,
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},                                                          
			},	
			{
				time = 17,
				num = 2,
				delay = {0.5,1},
				pos = {980,1100},
				property = { 
					placeName = "place4" ,
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},                                                          
			},
			{
				time = 18,
				num = 3,
				delay = {0.5,1,0},
				pos = {450,560,690},
				property = { 
					placeName = "place4" ,
					id = 1,
					startState = "rollright",	
				},                                                     
			},
			{
				time = 19,
				num = 3,
				delay = {0.5,1.5,1},
				pos = {220,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},
			{
				time = 20,
				num = 3,
				delay = {0,1.1,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 21,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					placeName = "place2",
					type = "yiliao",                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 22,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},	
			{
				time = 24,	
				num = 5,
				pos = {420,560,700,880,990},
				delay = {1.4,0.6,0,1,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 26,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},                                                                          
			},	
			{
				time = 30,
				num = 4,
				delay = {0,0.7,1.4,1.8},
				pos = {600,500,400,300},					
				property = {
					placeName = "place2",  
					type = "common",
					startState = "san",
					id = 1,
				},                                                                     
			},	
		},	
	},
	{
		enemys = {
		    {
				time = 0,
				num = 1,
				pos = {670},
				delay = {0},                         -- 飞机
				property = {
					type = "feiji" ,
					id = 11,
					placeName = "place10",
					missileId = 6,
					missileType = "daodan",
					missileOffsets = {cc.p(250,-250), cc.p(-150, -150)},	--炮筒位置发出xy轴偏移值,第一个位置右一,第二位置个右二
					startState = "enterleft",
					lastTime = 60.0,		                                    --持续时间			
				},
			},
			{
				time = 8,
				num = 4,
				delay = {0.5,1,0,1.5},
				pos = {480,680,850,1050},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 10,
				num = 5,
				delay = {1.1,0.6,1.7,0.3,1.8},
				pos = {350,550,660,760,1050},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},
			{
				time = 13,	
				num = 5,
				pos = {355,420,510,770,900},
				delay = {0,0.9,0.5,0.6,1.5},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 14,
				num = 1,
				delay = {0},
				pos = {680},
				property = { 
					placeName = "place3",
					type = "yiliao",                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 15,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},	
			{
				time = 16,
				num = 2,
				delay = {0.5,1},
				pos = {250,320},
				property = { 
					placeName = "place3" ,
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",	
				},                                                          
			},	
			{
				time = 17,
				num = 2,
				delay = {0.5,1},
				pos = {980,1100},
				property = { 
					placeName = "place4" ,
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},                                                          
			},
			{
				time = 18,
				num = 3,
				delay = {0.5,1,0},
				pos = {450,560,690},
				property = { 
					placeName = "place4" ,
					id = 1,
					startState = "rollright",	
				},                                                     
			},
			{
				time = 19,
				num = 3,
				delay = {0.5,1.5,1},
				pos = {220,550,600},
				property = { 
					placeName = "place2" ,
					type = "dao",
					id = 5,
					missileId = 6,
					missileType = "daodan",
				},                                                          
			},
			{
				time = 20,
				num = 3,
				delay = {0,1.1,0.5},
				pos = {400,680,960},
				property = { 
					placeName = "place3" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 21,
				num = 1,
				delay = {0},
				pos = {330},
				property = { 
					placeName = "place2",
					type = "yiliao",                --医疗兵
					startState = "enterleft",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 22,
				num = 10,
				delay = {0.2,0.9,1.7,2.5,3.3,0.3,1.8,4.0,4.5,5.1},
				pos = {350,460,600,1050,570,456,780,666,510,980},
				property = { 
					placeName = "place3" ,
					type = "bao",                  --爆
					id = 9,
					startState = "san",	
				},
			},	
			{
				time = 24,	
				num = 5,
				pos = {420,560,700,880,990},
				delay = {1.4,0.6,0,1,2.1},
				property = {
					placeName = "place3" ,         --近
					id = 7,
					type = "jin",
				},
			},
			{
				time = 26,
				num = 5,
				delay = {0.7,1.4,1.8, 2.1,2.8},
				pos = {350,550,600,800,950},					
				property = {
					placeName = "place3",  
					type = "common",
					startState = "san",
					id = 1,
				},                                                                          
			},	
			{
				time = 30,
				num = 4,
				delay = {0,0.7,1.4,1.8},
				pos = {600,500,400,300},					
				property = {
					placeName = "place2",  
					type = "common",
					startState = "san",
					id = 1,
				},                                                                     
			},	
		},	
	},

}




--enemy的关卡配置                                                    白银镶嵌 MP5伤害90  dps大于等于3,远程2近战2 怪物数据 
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=8,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4,
	weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1,
	weak1=1},

	--导弹兵      --type = "dao",
	{id=5,image="zpbing",demage=0,hp=750,walkRate=120,walkCd=2,fireRate=240,fireCd=4,
	weak1=2},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=8,hp=150,
	weak1=1},	

	--近战兵         --type = "jin",          180-- 相对地图的y轴位置       1.7-- 狼牙棒兵  近战兵到身前的比例
	{id=7,image="jinzhanb",demage=6,hp=1123,fireRate=180,fireCd=4,speed=40,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=6,hp=5616,fireRate=180,fireCd=4,speed=40, scale = 1.8,--盾兵到身前的比例
	weak1=2},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=12,hp=750,fireRate=30,speed=120,
	weak1=2},	

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=12800, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=60, fireCd=4.0,
	weak1=2,    award = 60},

	--医疗兵      --type = "yiliao",
	{id=25,image="yiliaob",demage=8,hp=1123,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

}



local mapId = "map_1_6"

local limit = 10   				--此关敌人上限

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		-- type 	  = "puTong",

		-- type 	  = "renZhi",
		-- saveNums  = 4,                 --解救人质数量

		type 	  = "xianShi",
		limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}

end
return waveClass