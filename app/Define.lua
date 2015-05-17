

local Define = class("Define", cc.mvc.ModelBase)

---------------------- 怪物 --------------------------
--手雷兵 远程兵 
Define.kEnemyWalkSpeed 			= 10.0       --左右移动速度
Define.kEnemyWalkWidth 			= 300 * 1	--左右移动距离原来140改为200
Define.kEnemyRollSpeed 			= 20.0	   --滚动速度 每帧率
Define.kEnemyRollWidth 			= 500 * 1   --滚动距离
Define.kLeiEnemySanSpeed 	    = 50.0 		--伞速

--狙击兵
Define.kJujiEnemyFocusTime 		    = 1.0 		--狙击兵瞄准时间

--近战兵(狼牙棒兵 盾兵)
Define.kJinEnemyWalkPos  		= -180		-- 相对地图的y轴位置
Define.kJinEnemyScale	  		= 1.7		-- 到身前的比例
Define.kJinEnemyWalkSpeed 		= 80.0 		--每秒前进像素(默认值)
Define.kJinEnemySanSpeed        = 100   	--伞速

--自爆兵
Define.kBaoEnemyWalkSpeed 		= 70.0 		--每秒前进速度
Define.kBaoEnemyScale	  		= 1.2		-- 到身前的比例
Define.kBaoEnemySanSpeed	  	= 100.0		-- 伞降落速度
Define.kBaoDemageOtherEnemys 	= 10        --伤害值
Define.kBaoRangeW 				= 200	    --自爆范围
Define.kBaoRangeH 				= 200	     --自爆范围

--汽油桶
Define.kBaoTongRangeW 			= 500	    --自爆范围
Define.kBaoTongRangeH 			= 500	     --自爆范围

--人质 护士
Define.kHushiSpeed				= 350.0    --人质跑动速度 像素/s
Define.kHushiRunTime			= 1.2      --跑动时间
Define.kHushiWalkTime			= 0.6      --行走时间

--人质 黄人
Define.kShangrenSpeed			= 250		--武器商人黄跑动速度

--土匪兵 绑架
Define.kTufeiSpeed				= 200	   --行走速度
Define.kTufeiWalkTime			= 0.6      --行走时间

--人质 被绑架的人
Define.kBangrenSpeed			= 200	   --逃跑速度

--逃犯兵
Define.kQiufanSpeed             = 200       --逃跑速度
Define.kQiufanJuSpeed           = 80        --逃跑速度
Define.kQiufanSanSpeed 		    = 50.0 		--伞降落速度

--忍者兵
Define.kRenzheWalkSpeed			= 200.0    --忍者移动速度 像素/s
Define.kRenzheSpeed				= 600.0    --忍者跑动速度 像素/s
Define.kRenzheRunTime			= 2.0       --忍者跑步时间
Define.kRenzheWalkTime			= 0.5   	--忍者行走时间
Define.kRenzheShanTime			= 3.0   	--忍者瞬移时间
Define.kRenzheShanOffsetMin		= 300 		--忍者瞬移最小距离 
Define.kRenzheShanOffsetMax		= 600		--忍者瞬移最大距离 

--蓝色boss 红色boss
Define.kBlueBossWalkTime			= 1.0    --小范围移动时间(与配置动画时间是对应的 不能改)

--飞机兵 
Define.kfeijiSpeed				= 500.0  --速度
Define.kfeijiRunTime 			= 1.0	 --大范围移动时间
Define.kfeijiWalkTime			= 0.6    --小范围移动时间

--吉普车兵
Define.kjipuSpeed				= 400.0  --速度
Define.kjipuRunTime 			= 1.0	 --大范围移动时间
Define.kjipuWalkTime			= 0.6    --小范围移动时间

--奖励兵
Define.kAwardSanTime			= 5.0    	--箱子落地持续时间
Define.kAwardEnemySanSpeed		= 50.0      --伞速

--导弹
Define.kMissileDaoTime				= 2.5    --导弹飞行时间
Define.kMissileTieqiuTime           = 2.0    --铁球和汽车飞行时间
Define.kMissileLeiTime				= 2.5    --手雷飞行时间 
Define.kYanEffectTime				= 5      --烟雾白屏时间 

--飞镖
Define.kMissileFeibiaTime		= 1.0        --飞过来的时间
Define.kMissileFeibiaScale      = 1.5        --飞镖飞到屏幕的大小

--蜘蛛网
Define.kMissileWangTime			= 1    --飞过来的时间
Define.kMissileWangHitTime      = 1    -- 攻击间隔


--------------------------玩家---------------------------------
--hero
Define.kHeroBaseHp 				= 100.0  --角色血量
Define.kHeroCritScale 			= 3.0  --暴击倍数
Define.kHeroHpLess 				= 0.15  --血量剩下0.1的时候 飘红
Define.kHeroHelper				= 0  	--默认回血0/s
Define.kHeroHpBag				= 200   --回血包
Define.kHeroHpCost				= 40  	--回血包价格
Define.kHeroHpBagCd				= 10    --回血包cd
Define.kHeroKillKeepCnt			= 1 	--启动连杀动画 
Define.kHeroKillKeepCd			= 3.0 	--连杀cd 2秒清空连杀

--黄金武器
Define.kGoldTime 				= 8     --黄金武器激活时间

--机甲
Define.kRobotCoolDownTime 		= 0.05   --robot 冷却时间
Define.kRobotDemage			 	= 700    --机甲伤害
Define.kRobotTime			 	= 10.0   --机甲持续时间
Define.kRobotTimeRelieve		= 5.0    --复活 机甲持续时间
Define.kRobotRangeH				= 40.0   --机甲攻击范围框高
Define.kRobotRangeW				= 80.0   --机甲攻击范围框宽


--自爆兵爆炸
Define.kBaoRangeW 				= 200	--自爆范围宽
Define.kBaoRangeH 				= 200	--自爆范围高

--角色扔的手雷
Define.kLeiRangeW 				= 300	--手雷范围宽
Define.kLeiRangeH 				= 150	--手雷范围高
Define.kLeiDemage 				= 3500.0	--手雷伤害
Define.kLeiTime				    = 1.0	--手雷飞行时间
Define.kShouLeiCd    			= 0.2  -- 手雷cd

--盾牌
Define.cdTimes 					= 15.0   --十秒恢复完毕
Define.kDefenceHp				= 65    --盾牌血量

--奖励
Define.kKillEnemyAwardGold     	= 10	--杀敌奖励
Define.kGoldCoinValue			= 3.33		--单个金币值为3

--购买相关
Define.kBuyFullHpTime 			= 0.11  -- 10%血  

--狙击枪
Define.kJuRange 				= 4.0  -- 狙击镜放大的范围

--引导
Define.kGuideActiveJijia	 	= 0.30  --boss还有百分之30血时 触发机甲

--enenmy动画缩放比例
Define.kEnemyAnimScale      	= 1 / 0.7


--------------------------战斗---------------------------------
Define.kJujiReliveCosts         = {20, 40, 40, 60, 80, 100,}  --无限狙击模式复活
Define.kBossReliveCosts         = {20, 40, 40, 60, 80, 100,}  --boss竞技模式复活
Define.kLevelReliveCosts        = {20, 40, 60, 80,} 				--普通关卡模式复活

function Define:ctor()
    Define.super.ctor(self) 
end

return Define

