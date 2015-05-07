local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“我”的实体

]]

--import
local Actor         = import(".Actor")
local Gun           = import(".Gun")
local Hero          = class("Hero", Actor)

--events

--effect
Hero.EFFECT_HURT_BOMB_EVENT      = "EFFECT_HURT_BOMB_EVENT"    --效果_导弹炸屏幕
Hero.EFFECT_HURT_BOLI_EVENT      = "EFFECT_HURT_BOLI_EVENT"    --效果_玻璃
Hero.EFFECT_HURT_YAN_EVENT       = "EFFECT_HURT_YAN_EVENT"     --效果_烟雾
Hero.EFFECT_KEEPKILL_EVENT       = "EFFECT_KEEPKILL_EVENT"     --效果_连杀
Hero.EFFECT_GUIDE_EVENT          = "EFFECT_GUIDE_EVENT"        --效果_引导

--skill
Hero.SKILL_ROBOT_START_EVENT      = "SKILL_ROBOT_START_EVENT"    --机甲开启
Hero.SKILL_DEFENCE_SWITCH_EVENT   = "SKILL_DEFENCE_SWITCH_EVENT" --护盾开启
Hero.SKILL_DEFENCE_BEHURT_EVENT   = "SKILL_DEFENCE_BEHURT_EVENT" --护盾被攻击
Hero.SKILL_DEFENCE_RESUME_EVENT   = "SKILL_DEFENCE_RESUME_EVENT" --护盾回血完毕

Hero.SKILL_GRENADE_ARRIVE_EVENT   = "SKILL_GRENADE_ARRIVE_EVENT" --扔手雷结束
Hero.SKILL_GRENADE_START_EVENT    = "SKILL_GRENADE_START_EVENT"  --扔手雷开启

--enemy
Hero.ENEMY_ATTACK_MUTI_EVENT    = "ENEMY_ATTACK_MUTI_EVENT"   --群攻
Hero.ENEMY_KILL_ENEMY_EVENT     = "ENEMY_KILL_ENEMY_EVENT"  --杀死敌人      
Hero.ENEMY_KILL_HEAD_EVENT      = "ENEMY_KILL_HEAD_EVENT"   --爆头
Hero.ENEMY_KILL_BOSS_EVENT      = "ENEMY_KILL_BOSS_EVENT"   --杀死boss 
Hero.ENEMY_KILL_CALL_EVENT       = "ENEMY_KILL_CALL_EVENT"   --杀死召唤 

Hero.ENEMY_ADD_EVENT            = "ENEMY_ADD_EVENT"
Hero.ENEMY_WAVE_ADD_EVENT       = "ENEMY_WAVE_ADD_EVENT"
Hero.ENEMY_ADD_MISSILE_EVENT    = "ENEMY_ADD_MISSILE_EVENT"

--gun
Hero.GUN_RELOAD_EVENT           = "GUN_RELOAD_EVENT" 
Hero.GUN_BULLET_EVENT           = "GUN_BULLET_EVENT"             
Hero.GUN_CHANGE_EVENT           = "GUN_CHANGE_EVENT"
Hero.GUN_FIRE_EVENT             = "GUN_FIRE_EVENT"

--hp
Hero.AWARD_GOLD_INCREASE_EVENT  = "AWARD_GOLD_INCREASE_EVENT"
Hero.HP_STATE_EVENT             = "HP_STATE_EVENT"


function Hero:ctor(properties)
    --instance
    self.fightInlay = md:createInstance("FightInlay")
    Hero.super.ctor(self, properties)
    
    --init
    self.bags = {}
    self:initGuns()
    self.isReloading = false
    self.killCnt = 0
    self.killKeepCnt = 0
    self.killGoldIndex = 1
    self.isLessHp = false
end

--枪械相关
function Hero:initGuns()
    self.bags["bag1"] = Gun.new({bagIndex = "bag1"}) 
    self.bags["bag2"] = Gun.new({bagIndex = "bag2"})

    --ju
    local levelModel = md:getInstance("LevelDetailModel")
    local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    local isJuLevel = fight:isJujiFight()
    print("Hero:initGuns( isJuLevel", isJuLevel)
    if isJuLevel then 
        self.bags["bag1"] = Gun.new({bagIndex = "bag3"}) 
        self.bags["bag2"] = Gun.new({bagIndex = "bag3"})
    end
    self.isGun1 = self:isPreferBag1()
    local bagIndex = self:getCurBagIndex()
    self:setGun(bagIndex)     
end

function Hero:getCurBagIndex()
    local bagIndex = nil
    if self.isGun1 then 
        bagIndex = "bag1"
    else
        bagIndex = "bag2"
    end   
    return bagIndex   
end

function Hero:getGun()
    return self.gun
end

function Hero:changeGun()
    self.isGun1 = not self.isGun1
    local bagIndex = nil
    if self.isGun1 then 
        bagIndex = "bag1"
    else
        bagIndex = "bag2"
    end
    print("change gun bagIndex", bagIndex)
    self:setGun(bagIndex)
    self:dispatchEvent({name = Hero.GUN_CHANGE_EVENT, bagIndex = bagIndex})

    --refresh bulletNum
    local bulletNum = self.gun:getCurBulletNum()
    self:dispatchEvent({name = Hero.GUN_BULLET_EVENT, num = bulletNum})
end

function Hero:changeTempGun(configid)
    local bagIndex = self:getCurBagIndex()
    
    -- self.oriGun = clone(self.bags[bagIndex])  --旧枪  
    self.bags[bagIndex] = Gun.new({bagIndex = bagIndex ,configId = configid}) 

    --refresh
    self:setGun(bagIndex)
    self:dispatchEvent({name = Hero.GUN_CHANGE_EVENT, bagIndex = bagIndex})
    local bulletNum = self.gun:getCurBulletNum()
    self:dispatchEvent({name = Hero.GUN_BULLET_EVENT, num = bulletNum})    

    --hide change
end

function Hero:isPreferBag1()
    local data = getUserData()
    return data["fight"].isPreferBag1
end

function Hero:setPreferBagIndex(bagIndex)
    local isPreferBag1 =  bagIndex == "bag1"
    local data = getUserData()
    data["fight"].isPreferBag1 =  isPreferBag1 
    setUserData(data)
end

function Hero:setGun(bagIndex)
    self.gun = self.bags[bagIndex]
    print("function Hero:setGun(bagIndex)")

    --prefer
    self:setPreferBagIndex(bagIndex)
end

function Hero:getCooldown()
    return self.gun:getCooldown()
end

function Hero:killEnemyAward(enemyPos, award)
    self:dispatchEvent({name = self.AWARD_GOLD_INCREASE_EVENT, 
                        value = award})
    self:dispatchEvent({name = Hero.ENEMY_KILL_ENEMY_EVENT, 
        enemyPos = enemyPos, award = award})
end

function Hero:killEnemy()
    --check keep kill
    self.killCnt = self.killCnt + 1
    self:checkKeepKill()    
end

function Hero:checkKeepKill()
    self.killKeepCnt = self.killKeepCnt + 1
    if self.killKeepCnt >= define.kHeroKillKeepCnt then
        self:dispatchEvent{name = Hero.EFFECT_KEEPKILL_EVENT, 
            count = self.killKeepCnt}
    end
    if self.keepKillHandler then 
        scheduler.unscheduleGlobal(self.keepKillHandler)
        self.keepKillHandler = nil
    end
    self.keepKillHandler = scheduler.scheduleGlobal(handler(self, self.restoreKeepKill), define.kHeroKillKeepCd)
end

function Hero:restoreKeepKill()
    self.killKeepCnt = 0
end

function Hero:getKillCnt()
    return self.killCnt
end

function Hero:canFire()
    local isCanFire = Hero.super.canFire(self)
    local isCanGunFire = not self:getIsReloading()
    return isCanFire and isCanGunFire
end

function Hero:getIsReloading()
    return self.isReloading 
end

function Hero:setIsReloading(isReloading)
    self.isReloading = isReloading
end

--镶嵌相关
function Hero:getFightInlay()
    return self.fightInlay
end

function Hero:getDemage()
    local baseDemage = self.gun:getDemage()
    local value = 0

    local robot   = md:getInstance("Robot")
    if robot:getIsRoboting() then
        return robot:getDemage()    
    end
    
    --inlay
    local scale, isInlayed = self.fightInlay:getInlayedValue("bullet")
    if isInlayed then
        value = baseDemage + baseDemage * scale
    else
        value = baseDemage
    end

    --crit
    local critNum = self.gun:getCritPercent() * 100
    -- print("critNum:", critNum)
    if critNum > math.random(0, 100) then 
        value = value * define.kHeroCritScale
    end

    return value
end

--hp相关
function Hero:doRelive()
    self.fsm__:doEvent("relive") --todo
end

function Hero:getMaxHp()
    local kMaxHp = define.kHeroBaseHp 
    local baseMaxHp = Hero.super.getMaxHp(self)
    local valueMaxHp = 0.0
    local value, isInlayed = self.fightInlay:getInlayedValue("blood")
    if isInlayed then 
        valueMaxHp = kMaxHp + kMaxHp * value
    else
        valueMaxHp = kMaxHp
    end
    return valueMaxHp
end

function Hero:decreaseHp(hp)
    if self:isDead() then return end
    if self:getIsPause() then 
        return 
    end

    local defence = md:getInstance("Defence")
    local robot   = md:getInstance("Robot")
    if defence:getIsDefending() then 
        defence:onHitted(hp)
    elseif robot:getIsRoboting() then
        robot:onHitted()
    elseif self:isHelpHp(hp) then
        Hero.super.decreaseHp(self, hp)
        self:helpFullHp()
    else
        Hero.super.decreaseHp(self, hp)
    end
end

function Hero:onHpChange()
    local maxHp = self:getMaxHp()
    local hp    = self:getHp()
    local isLess = (hp / maxHp) < define.kHeroHpLess
    if self.isLessHp ~= isLess then 
        self.isLessHp = isLess
        self:dispatchEvent({name = Hero.HP_STATE_EVENT, 
            isLessHp = self.isLessHp})
    end
end

function Hero:getIsLessHp()
    return self.isLessHp
end

function Hero:getIsPause()
    return self.isPause or false
end

function Hero:setIsPause(isPause)
    self.isPause = isPause
end

function Hero:isHelpHp(demage)
    if self:isDead() then return false end
    local defence   = md:getInstance("Defence")
    local isDefenceAble =  defence:getIsAble() and 
                not defence:getIsDefending()
    local maxhp = self:getMaxHp()
    local desthp = self:getHp() - demage
    local destPer = desthp / maxhp
    local isLessHp =  destPer < define.kBuyFullHpTime  

    --致死 
    if desthp <= 0 then return false end 
    
    return isDefenceAble and isLessHp 
end

--如果有盾 则 return true
function Hero:helpFullHp()
    --暂停
    if self.isHelped then return end 
    self.isHelped = true
    self.isPause = true
    local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:stopFire()

    --pop
    ui:showPopup("commonPopup",
        {type = "style3", content = "是否立即回复生命？",
             callfuncCofirm =  handler(self, self.showTuhao),
             callfuncClose  =  handler(self, self.onDenyFullHp)},
         { opacity = 0})      
end

function Hero:showTuhao()
    local buyModel = md:getInstance("BuyModel")
    buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.onBuyFullHp),
                    deneyBuyFunc = handler(self, self.onDenyFullHp), isNotPopup = true,isNotPopKefu = true}
                    ,"战斗界面_10%血")    
end

function Hero:onBuyFullHp()
    --clear pause
    self.isPause = false

    print("立即回复生命 function Hero:onBuyFullHp()")
    local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:pauseFight(false)

    self:setFullHp()

    --refresh 买礼包时候需要刷新
    local fightProp = md:getInstance("FightProp")
    fightProp:refreshData()

    --um
    local levelInfo = fight:getLevelInfo()    
    local umData = {}
    umData[levelInfo] = "满血"
    um:event("关卡道具使用", umData)    
end

function Hero:onDenyFullHp()
    --clear pause
    self.isPause = false

    print("立即回复生命 function Hero:onDenyFullHp()")
    local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:pauseFight(false)

    local defence   = md:getInstance("Defence")
    defence:startDefence()    
end

--map
function Hero:setMapZoom(scale)
    self.mapZoom = scale
end

function Hero:getMapZoom()
    return self.mapZoom or 1.0
end

return Hero