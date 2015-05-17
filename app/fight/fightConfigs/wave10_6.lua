local BaseWave = import(".BaseWave")
local waveClass = class("waveClass", BaseWave)

local waves = {
	
	{
		enemys = {                                                                -- 魔化鬼眼boss
			{
				descId = "renzb", --简介
				time = 2,	
				num = 1,
				pos = {550},
				delay = {4},
				property = { 
					type = "renzheBoss",
					placeName = "place1",
					missileId = 18, 
					missileOffsets = {cc.p(-150,50) ,cc.p(150, -50)},
					id = 1,
				},
			},
		},
	},

	
}


--enemy的关卡配置                                                    黄金镶嵌 麒麟之怒满级470  dps大于等于6  怪物数据
local enemys = {

	--狙击兵      --type = "juji",
	{id=4,image="jujib",demage=25,hp=1000000, rollRate=180,rollCd=3,fireRate=2, fireCd = 6,
	weak1=2},

	--盾兵         --type = "jin",
	{id=8,image="dunbing",demage=25,hp=1000000,fireRate=180,fireCd=5,speed=35, scale = 2.0 ,
	weak1=2, weak4=4},

	--自爆兵        --type = "bao",
	{id=9,image="zibaob",demage=40,hp=1000000,fireRate=30,speed=130,scale = 1.9,
	weak1=2},

	--越野车       type = "jipu" ,
	{id=12,image="yyc",demage=0,hp=1000000,walkRate=180,walkCd = 2.0,rollRate=240, rollCd = 1.5, fireRate=6, fireCd=8.0,
	weak1=2,    award = 60},	

	--黑衣忍者兵            冲锋伤害  type = "renzhe",
	{id=17,image="xiaorz",demage=40,hp=1000000,walkRate=100,walkCd = 1.0,rollRate=40, rollCd = 1.5,fireRate=180, fireCd=2.0, 
	shanRate = 120, shanCd = 4, chongRate = 120, chongCd = 4, weak1=2},	

	--飞镖
	{id=18,image="feibiao",demage=20,hp=1000000}, 

	--BOSS导弹          type = "missile",
	{id=20,image="daodan",demage=25,hp=1000000, weak1=1},

	--烟雾导弹           type = "dao_wu",
	{id=22,image="daodan03",demage=25,hp=1000000, weak1=1},           --打击者金武平均伤害5558

	--大黑导弹           type = "missile",
	{id=23,image="daodan02",demage=200,hp=1000000, weak1=1},

	--BOSS铁球
	{id=24,image="tieqiu",demage= 100,hp=1000000, weak1=1},

	--高级召唤医疗兵      type = "yiliao",
	{id=26,image="yiliaob",demage=25,hp=1000000,walkRate=180,walkCd=2,rollRate=180,rollCd=3,fireRate=180,fireCd=4,
	weak1=2},

	--蜘蛛网
	{id=27,image="zzw",demage=25,hp=1000000},



}

	--boss的关卡配置
local bosses = {
	--出场的boss
	{
		award = 100000,
		image = "renzb",                       --图片名字                                  魔化鬼眼
		--hp = 100000,
		hp = 1000000,
		fireRate = 60,               --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				 --扔飞镖,按飞镖伤害
		walkRate = 180,                    --移动频率
		walkCd = 2,                         --移动cd
		rollRate = 100,					--快速移动
		rollCd = 2,						--快速移动cd
		shanRate = 180, 				--瞬移
		shanCd	= 2,					

		chongfengDemage = 35,                --冲锋造成伤害
		weak1 = 1.2,						--头 弱点伤害倍数
		weak2 = 1.2,					--左腿 弱点伤害倍数
		weak3 = 1.2,					--右腿 弱点伤害倍数	
		
		skilltrigger = {   			          --技能触发(可以同时)
			feibiao1 = { 0.95,                --暴雨梨花针1
			},
			feibiao2 = { 0.75,                --暴雨梨花针2	
			},
			feibiao3 = { 0.50,                --暴雨梨花针3
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
			demage125 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage200 = {  
				0.60,
			},	
			demage300 = {  
				0.30,
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
					missileOffsets = {cc.p(-150,-150) , cc.p(0, 150) , cc.p(150, -150)},
					qiuId = 24,                   --铁球id
					id = 2,
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
					id = 3,            --boss里面id为1  ,以后有可能有很多boss     
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
					type = "duozuBoss",
					placeName = "place11",
					wangId    = 27,    --网ID
					missileId = 20,    --BOSS导弹
					missileOffsets = {cc.p(-150,-150) , cc.p(0, 150) , cc.p(150, -150)},
					id = 4,
				},
			},

		},
	},
---------------------------------------------------------------------------------------------第1波出场的boss    魔化鬼眼    id = 1
	{
		award = 50000,         ----boss产出金币数量
		image = "boss02_1",                              --CF肌肉boss
		hp = 1000000,
		demage = 3, 			--这个是没用的
		fireRate = 120,               --普攻频率
		fireCd = 3,                     --普攻cd
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd
		chongfengDemage = 25,                --冲锋造成伤害

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
			demage200 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {
				0.60,
			},	
			demage400 = {
				0.30,
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
---------------------------------------------------------------------------------------------------魔化鬼眼召唤的boss1 CF肌肉 id = 2
	{
		image = "boss01_2", --图片名字
		-- hp = 100000,
		award = 50000,                   --boss产出金币数量
		hp = 1000000,
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
				0.80,0.20,
			},

			
			demage150 = {  --伤害乘以2.0  备注不要超过三位数 比如demage1200是不行的
				0.90,
			},	
			demage300 = {  
				0.65,
			},	
			demage400 = {  
				0.30,
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


		enemys1 = {                                                     --第1波召唤
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {500,},
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
				pos = {500,},
				property = { 
					placeName = "place4" ,
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
				delay = {0.6,},
				pos = {800,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {900},
				delay = {0.9},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},
		enemys2 = {                                                     --第2波召唤
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {500,},
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
				pos = {500,},
				property = { 
					placeName = "place4" ,
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
				delay = {0.6,},
				pos = {800,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {900},
				delay = {0.9},
				property = {
					placeName = "place4" ,
					id = 17,
					type = "renzhe",
					missileId = 18,
				},
			},
		},
		enemys3 = {                                                     --第3波召唤
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {500,},
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
				pos = {500,},
				property = { 
					placeName = "place4" ,
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
				delay = {0.6,},
				pos = {800,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {900},
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
---------------------------------------------------------------------------------------------------魔化鬼眼召唤的boss2 紫炮   id = 3
	{
		image = "dzboss", --图片名字                                                             多足boss巨炮泰坦
		award = 50000,                   --boss产出金币数量
		hp = 1000000,
		fireRate = 60,                  --普攻频率
		fireCd = 4,                     --普攻cd
		demage = 0,  				    --
		walkRate = 60,                    --移动频率
		walkCd = 2,                         --移动cd				
		weak1 = 1.1,						--头 弱点伤害倍数
		weak2 = 1.1,					--左腿 弱点伤害倍数
		weak3 = 1.1,					--右腿 弱点伤害倍数	
		wudiTime = 5.0,					--无敌时间
		skilltrigger = {   			          --技能触发(可以同时)
			wudi = { 0.91, 0.71, 0.51 , 0.31, 0.11
			}, 

			zhaohuan = { 0.90, 0.70, 0.50, 0.30, 0.10,                  --召唤小兵
			},   

			wang = { 0.95,0.85,0.75,0.65,0.55,0.45,0.35,0.25,0.15        --网
			},

			daoDan1 = {                                            --大黑导弹
				0.95, 0.80, 0.75, 0.64, 0.55, 0.45, 0.34, 0.22, 0.15,
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
				0.60,
			},
			demage400 = {
				0.40,
			},			
		},


		daoDan1 = {
		    id = 23,                                  --大黑导弹
			type = "missile",  
			timeOffset = 0.06,                        --导弹间隔时间                 
			offsetPoses = {                           --目标偏移点
            	cc.p(0, 0),
        	},
        },


		enemys1 = {                                                   --第1波召唤混合兵
			{
				time = 0,
				num = 1,
				delay = {0,},
				pos = {400,},
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
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
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
				pos = {700,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
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
				pos = {400,},
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
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
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
				pos = {700,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
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
				pos = {400,},
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
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
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
				pos = {700,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
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
				pos = {400,},
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
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
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
				pos = {700,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
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
				pos = {400,},
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
				pos = {800,},
				delay = {0,},                                                     -- 吉普车
				property = {
					type = "jipu" ,
					id = 12,
					placeName = "place1",
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
				pos = {700,},
				property = { 
					placeName = "place11" ,
					type = "bao",                                                    --自爆兵
					id = 9,
					demageScale = 3 ,                   --伤害翻3倍	
				},
			},
			{
				time = 0,	
				num = 1,
				pos = {1000,},
				delay = {0,},
				property = {
					placeName = "place4" ,
					id = 4,
					type = "juji",                                                    --狙击兵
				},
			},
		},												
	},
---------------------------------------------------------------------------------------------------魔化鬼眼召唤的boss3 多足   id = 4
}
local limit = 10   				--此关敌人上限

local mapId = "map_1_6"

function waveClass:ctor()
	self.waves  = waves
	self.enemys = enemys
	self.bosses = bosses
	self.mapId  = mapId
	self.fightMode =  {
		type 	  = "puTong",

		--type 	  = "renZhi",
		--saveNums  = 3,                 --解救人质数量

		-- type 	  = "xianShi",
		-- limitTime = 60,                   --限时模式时长

		-- type 	  = "taoFan"
		-- limitNums = 5,                      --逃跑逃犯数量
	}
end

return waveClass