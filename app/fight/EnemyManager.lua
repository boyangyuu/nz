
--EnemyManager
local EnemyManager = class("EnemyManager", cc.mvc.ModelBase)

--event
EnemyManager.ENEMY_KILL_BANGFEI_EVENT       = "ENEMY_KILL_BANGFEI_EVENT"   --杀死召唤 

function EnemyManager:ctor(properties)
    EnemyManager.super.ctor(self, properties)
end

return EnemyManager

