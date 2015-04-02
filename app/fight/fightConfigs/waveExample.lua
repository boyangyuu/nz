local BaseWave = import(".BaseWave")
local waveClass = class("waveExample", BaseWave)


-- 绑架人质配置 --
	{
		time = 1,
		num = 1,
		delay = {0},
		pos = {130},
		property = { 
			placeName = "place6",
			type = "bangfei",
			renzhiName = "1",
			id = 1,
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
			renzhiName = "1",
			id = 4,
		},
	},
	--普通兵                                      140--左右移动距离       280--滚动距离
	{id=1,image="tufeib",demage=1,hp=160,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=3,
	weak1=3},

	--绑人         --type = "bangren",
	{id=4,image="hs",demage=2,hp=111, weak1=1},	

-- 绑架人质配置结束 --



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

	--伞兵       --type = "san",
	{id=4,image="sanbing01",demage=0,hp=562,
	weak1=3},	                                                           

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
	{id=9,image="zibaob",demage=60,hp=562,fireRate=30,speed=120,
	weak1=3},	

	
	--人质         type = "renzhi",                                             speakRate =120,speakCd = 5.0,人质喊话cd
	{id=10,image="hs",demage=0,hp=6666,walkRate=120,walkCd = 1.0,rollRate=180,rollCd=2, speakRate =240,speakCd = 5.0,
	weak1=1},

	--飞机         type = "feiji" ,
	{id=11,image="feiji",demage=0,hp=10000, walkRate=180,walkCd = 2.0,rollRate=120, rollCd = 1.5, fireRate=180, fireCd=4.0,
	weak1=3,    award = 60},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=10000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=120, fireCd=3.0,
	weak1=3,    award = 60},

	--金币绿气球   type = "jinbi",
	{id=13,image="qiqiu03",hp=1,weak1=3,award = 9},	--award = 9   金币数量为9	

	--金币蓝气球   type = "jinbi",
	{id=14,image="qiqiu02",hp=1,weak1=3,award = 15},	--award = 15  金币数量为15

	--金币黄气球   type = "jinbi",
	{id=15,image="qiqiu01",hp=1,weak1=3,award = 30},	--award = 30  金币数量为30
	
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
