local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	{
		enemys = { 
			{
				descId = "yiliaob", --简介
				time = 2,
				num = 1,
				delay = {4},
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
				time = 6,
				num = 2,
				delay = {0,0.5},
				pos = {790,420},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 8,
				num = 3,
				delay = {0,0.5,1},
				pos = {640,900,320},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 10,	
				num = 3,
				pos = {230,330,510},
				delay = {0.5,0,1},
				property = {
					placeName = "place2" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 12,	
				num = 2,
				pos = {270,570},
				delay = {0.5,0},
				property = {
					placeName = "place2" ,         --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 12,
				num = 5,
				delay = {0,0.7,1.4,2.1,2.8,},
				pos = {220,300,500,700,900,},
				property = { 
					placeName = "place2" ,
					type = "bao",
					startState = "san",
					id = 4,
				},
			},
			{
				time = 14,	
				num = 3,
				pos = {1000,800,600},
				delay = {0,0.5,1},
				property = {
					placeName = "place3" ,         --普
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 15,
				num = 5,
				delay = {3.5,0,0.7,1.4,2.1},
				pos = {300,450,600,750,940},
				property = { 
					placeName = "place1" ,
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 15,	
				num = 3,
				delay = {0.9,0.5,0},
				pos = {970,870,570},
				property = {
					placeName = "place3" ,         --雷
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},
	{
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {790,420},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0,0.5,1},
				pos = {640,900,320},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {630},
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
				time = 9,	
				num = 3,
				pos = {230,330,510},
				delay = {0.5,0,1},
				property = {
					placeName = "place2" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {270,570},
				delay = {0.5,0},
				property = {
					placeName = "place2" ,         --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 10,
				delay = {0,0.7,1.4,2.1,2.8,3.5,0,0.7,1.4,2.1},
				pos = {220,300,380,460,540,620,700,780,860,940},
				property = { 
					placeName = "place1" ,
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {800},
				property = { 
					placeName = "place3",
					type = "yiliao",                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 12,	
				num = 3,
				pos = {1000,800,600},
				delay = {0,0.5,1},
				property = {
					placeName = "place3" ,         --普
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 13,
				num = 3,
				delay = {0.9,0.5,0},
				pos = {970,870,570},
				property = {
					placeName = "place3" ,         --雷
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},
	{
		enemys = { 
			{
				time = 2,
				num = 2,
				delay = {0,0.5},
				pos = {790,420},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 4,
				num = 3,
				delay = {0,0.5,1},
				pos = {640,900,320},
				property = { 
					placeName = "place2" ,
					type = "jin",                  --盾
					id = 8,
				},
			},
			{
				time = 6,
				num = 1,
				delay = {0},
				pos = {630},
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
				time = 9,	
				num = 3,
				pos = {230,330,510},
				delay = {0.5,0,1},
				property = {
					placeName = "place2" ,         --普
					startState = "rollright",
					id = 1,
				},
			},
			{
				time = 10,	
				num = 2,
				pos = {270,570},
				delay = {0.5,0},
				property = {
					placeName = "place2" ,         --雷
					startState = "rollright",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
			{
				time = 11,
				num = 10,
				delay = {0,0.7,1.4,2.1,2.8,3.5,0,0.7,1.4,2.1},
				pos = {220,300,380,460,540,620,700,780,860,940},
				property = { 
					placeName = "place1" ,
					type = "common",
					startState = "san",
					id = 1,
				},
			},
			{
				time = 12,
				num = 1,
				delay = {0},
				pos = {280},
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
				time = 12,
				num = 1,
				delay = {0},
				pos = {800},
				property = { 
					placeName = "place3",
					type = "yiliao",                --医疗兵
					startState = "enterright",       --从左面跑出来
					skillCd = 6.0,                  --回血cd
					skillValue = 0.3,               --回血百分比
					id = 25,
				},
			},
			{
				time = 13,	
				num = 3,
				pos = {1000,800,600},
				delay = {0,0.5,1},
				property = {
					placeName = "place3" ,         --普
					startState = "rollleft",
					id = 1,
				},
			},
			{
				time = 13,
				num = 3,
				delay = {0.9,0.5,0},
				pos = {970,870,570},
				property = {
					placeName = "place3" ,         --雷
					startState = "rollleft",
					id = 2,
					type = "dao",
					missileId = 3,
					missileType = "lei",
				},
			},
		},
	},

}




--enemy的关卡配置                                                    青铜镶嵌 MP5伤害85  dps大于等于2,远程2近战2 怪物数据
local enemys = {
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="anim_enemy_002",demage=8,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=180,fireCd=4, weak1=2,
	weak4=3},

	--手雷兵      --type = "dao",
	{id=2,image="shouleib",demage=0,hp=562,walkRate=180,walkCd=2,rollRate=180,rollCd=2,fireRate=240,fireCd=4, weak1=2},

	--手雷            --missileType = "lei",
	{id=3,image="shoulei",demage=8,hp=1, weak1=1},

	--自爆兵        --type = "bao",
	{id=4,image="zibaob",demage=10,hp=571,fireRate=30,speed=130,
	weak1=2, weak4=3},

    --导弹          --missileType = "daodan",
	{id=6,image="daodan",demage=15,hp=1, weak1=1},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=10,hp=5616,fireRate=180,fireCd=5,speed=35, weak1=2},

	--医疗兵      --type = "yiliao",
	{id=25,image="yiliaob",demage=8,hp=2500,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
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
