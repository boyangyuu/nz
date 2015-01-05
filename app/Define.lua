

local Define = class("Define", cc.mvc.ModelBase)

--fight

--黄金武器
Define.kGoldActivate 			= 20    --黄金武器激活

--自爆兵
Define.kBaoDemageOtherEnemys 	= 10  --自爆兵伤害值

--机甲
Define.kRobotCoolDownTime 		= 0.1   --robot 冷却时间
Define.kRobotDemage			 	= 30    --机甲伤害
Define.kRobotTime			 	= 10.0   --机甲持续时间

--手雷
Define.kBaoRangeW 				= 200	--手雷范围
Define.kBaoRangeH 				= 200	--手雷范围

--盾牌
Define.cdTimes 					= 10.0   --十秒恢复完毕

--奖励
Define.kKillEnemyAwardGold     	= 10	--杀敌奖励

function Define:ctor()
    Define.super.ctor(self) 
end

return Define

