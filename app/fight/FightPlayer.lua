--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local DialogLayer       = import("..dialog.DialogLayer")
local FightDescLayer    = import(".fightDesc.FightDescLayer")
local GunView           = import(".GunView")
local FocusView         = import(".FocusView")
local MapView           = import(".MapView")
local HeroLayer         = import(".HeroLayer")
local InfoLayer         = import(".InfoLayer")
local FightControlLayer = import(".FightControlLayer")
local GunSkillLayer     = import(".Gun.GunSkillLayer")

local KFightConfig = {
    -- scaleMoveBg = 1.0, 
    scaleMoveBg = 2.0, --todoyyy
    scaleMoveFocus = 2.3,
    scaleMoveGun = 2.3, 
}

local FightPlayer = class("FightPlayer", function ()
	return display.newLayer()
end)

--定义事件

function FightPlayer:ctor(properties)
    --instance
    -- dump(properties, "properties")    
    local fightFactory = md:getInstance("FightFactory")
    fightFactory:refreshData(properties.fightData)
    self.fight      = fightFactory:getFight()
    self.fight:refreshData(properties.fightData)
    
    self.user       = md:getInstance("UserModel")
    self.hero       = md:getInstance("Hero")
    self.guide      = md:getInstance("Guide")
    self.dialog     = md:getInstance("DialogModel")
    self.defence    = md:getInstance("Defence")
    self.inlay      = md:getInstance("FightInlay")
    self.fightProp  = md:getInstance("FightProp")
    local propModel = md:getInstance("PropModel")
    local inlayModel = md:getInstance("InlayModel")

    --datas
    self.tempChangeGoldHandler = nil
    self.resumeDefenceHandler = nil
    self.btnFireSch = nil
    self.touchFireId = nil
    self.checkLongFireTimes = 0

    --views
    self.focusView      = FocusView.new()
    self.mapView        = MapView.new()
    self.gunView        = GunView.new()
    self.heroLayer      = HeroLayer.new()
    self.infoLayer      = InfoLayer.new() 
    self.gunSkillLayer  = GunSkillLayer.new()
    self.fightControlLayer = FightControlLayer.new()
    self.isControlVisible = true
    
    --ui
    self:initUI()

    --事件
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    
    cc.EventProxy.new(self.user, self)
        :addEventListener(self.user.REFRESH_MONEY_EVENT, handler(self, self.refreshUserMoney))

    cc.EventProxy.new(self.hero, self)
        :addEventListener(self.hero.KILL_EVENT, handler(self, self.onHeroKill))
        :addEventListener(self.hero.AWARD_GOLD_INCREASE_EVENT, handler(self, self.changeGoldCount)) 
        :addEventListener(self.hero.FIRE_EVENT, handler(self, self.onHeroFire))
    cc.EventProxy.new(self.fight, self)
        :addEventListener(self.fight.PAUSE_SWITCH_EVENT, handler(self, self.setPause))
        :addEventListener(self.fight.CONTROL_HIDE_EVENT, handler(self, self.hideControl))
        :addEventListener(self.fight.CONTROL_SHOW_EVENT, handler(self, self.showControl))
        :addEventListener(self.fight.CONTROL_SET_EVENT,  handler(self, self.setComponentVisible))
        :addEventListener(self.fight.FIGHT_RESUMEPOS_EVENT, handler(self, self.onResumePos))
        :addEventListener(self.fight.FIGHT_FIRE_PAUSE_EVENT, handler(self, self.stopFire))
       
    cc.EventProxy.new(propModel, self)
        :addEventListener(propModel.PROP_UPDATE_EVENT, handler(self, self.refreshPropData))

    cc.EventProxy.new(inlayModel, self)
        :addEventListener(inlayModel.REFRESH_INLAY_EVENT, handler(self, self.refreshPropData))


    cc.EventProxy.new(self.defence, self)
        :addEventListener(self.defence.DEFENCE_BEHURTED_EVENT, handler(self, self.onDefenceBeHurt))
        :addEventListener(self.defence.DEFENCE_BROKEN_EVENT, handler(self, self.startDefenceResume))

    local map = md:getInstance("Map")       
    cc.EventProxy.new(map, self)
         :addEventListener(map.GUN_OPEN_JU_EVENT, handler(self, self.onJuOpen))
         :addEventListener(map.GUN_CLOSE_JU_EVENT, handler(self, self.onJuClose))

    self:setNodeEventEnabled(true)   
end

function FightPlayer:setPause(event)
    local isPause = event.isPause
    local layerTouch = cc.uiloader:seekNodeByName(self, "layerTouch")
    layerTouch:setTouchEnabled(not isPause)  
end

function FightPlayer:changeGoldCount(event)
    local lastTotalGold =  self.fight:getGoldValue() 
    self.fight:addGoldValue(event.value)

    local function changeGold()
        local totalGold = self.fight:getGoldValue()
        if self.curGold < totalGold then
            self.curGold = self.curGold + 10
            self.labelGold:setString(self.curGold)
        else
            if self.tempChangeGoldHandler then
                scheduler.unscheduleGlobal(self.tempChangeGoldHandler)
                self.tempChangeGoldHandler = nil
            end
        end
    end
    if self.tempChangeGoldHandler then
        scheduler.unscheduleGlobal(self.tempChangeGoldHandler)
    end
    self.tempChangeGoldHandler = scheduler.scheduleGlobal(changeGold, 0.01)
end

function FightPlayer:showControl(event)
    self.isControlVisible = true
    --gunView
    self.layerGun:setVisible(true)
    
    --btn
    self.btnDefence:setVisible(true)
    self.btnChange:setVisible(true)

    self.btnRobot:setVisible(true)
    self.label_jijiaNum:setVisible(true)

    self.btnGold:setVisible(true)
    self.label_gold:setVisible(true)

    self.btnLei:setVisible(true)
    self.label_leiNum:setVisible(true)

    local levelModel = md:getInstance("LevelDetailModel")
    local gid, lid= self.fight:getCurGroupAndLevel()
    local isju = self.fight:isJujiFight()
    if isju then 
        self.btnChange:setVisible(false) 
    end
end

function FightPlayer:hideControl(event)
    self.isControlVisible = false
    --gunView
    self.layerGun:setVisible(false)
    
    --btn
    self.btnDefence:setVisible(false)
    self.btnChange:setVisible(false)

    self.btnRobot:setVisible(false)
    self.label_jijiaNum:setVisible(false)

    self.btnGold:setVisible(false)
    self.label_gold:setVisible(false)

    self.btnLei:setVisible(false)
    self.label_leiNum:setVisible(false)
end

function FightPlayer:setComponentVisible(event)
    local comps = event.comps
    for i,v in pairs(comps) do
        self[i]:setVisible(v)
    end
end

function FightPlayer:initUI()
    --load fightUI  
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui")
    local node = cc.uiloader:load("mainUI.ExportJson")

    self.ui = node
    self:addChild(node)

    --load map layerMap
    self.layerMap = cc.uiloader:seekNodeByName(self, "layerMap")
    addChildCenter(self.mapView, self.layerMap) 

    --money and diamond
    self:refreshUserMoney()    

    --load gun 
    self.layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    self.layerGun:addChild(self.gunView)

    --load HeroLayer
    local layerHero = cc.uiloader:seekNodeByName(self, "layerHero")
    layerHero:addChild(self.heroLayer)

    --load layerGunInfo
    local layerGunInfo = cc.uiloader:seekNodeByName(self, "layerGunInfo")
    layerGunInfo:addChild(self.gunSkillLayer)
    layerGunInfo:addChild(self.infoLayer)
    layerGunInfo:addChild(self.fightControlLayer)
    
    --load focus
    self.focusNode = cc.uiloader:seekNodeByName(self, "fucusNode")
    addChildCenter(self.focusView, self.focusNode)

    --touch area
    self:initTouchArea()

    --dialogy
    local dialogLayer = DialogLayer.new()
    local layerDialog = cc.uiloader:seekNodeByName(self, "layerDialog") 
    layerDialog:addChild(dialogLayer)

    --dialogy
    local fightDescLayer = FightDescLayer.new()
    local layerDialog = cc.uiloader:seekNodeByName(self, "layerDialog") 
    layerDialog:addChild(fightDescLayer)

    --guide
    scheduler.performWithDelayGlobal(handler(self, self.initGuide1), 0.1)
    scheduler.performWithDelayGlobal(handler(self, self.initGuideChange), 0.1)    
    scheduler.performWithDelayGlobal(handler(self, self.initGuideDun), 0.1)    
    scheduler.performWithDelayGlobal(handler(self, self.initGuide3), 0.1)    
    scheduler.performWithDelayGlobal(handler(self, self.initGuide4), 0.1)    
end

function FightPlayer:refreshUserMoney(event)
    self.curGold    = self.fight:getGoldValue()
    self.curDiamond = md:getInstance("UserModel"):getDiamond()

    --gold
    self.labelGold = cc.uiloader:seekNodeByName(self, "labelGoldCount")
    self.labelGold:setString(self.curGold)

    --stone
    self.labelDiamond = cc.uiloader:seekNodeByName(self, "labelDiamondCount")
    self.labelDiamond:setString(self.curDiamond)    
end

--启动盾牌恢复
function FightPlayer:startDefenceResume(event)
    print("unction FightPlayer:startDefenceResume(event)")
    self.labelDefenceResume:setVisible(true)
    
    --受伤
    self.defenceDemage:setPercentH(0)

    --恢复
    self.defenceBar:setVisible(true)
    self.defenceBar:setPercentage(100)
    local kResumeValue = 1  --每次恢复点数
    local function tick(dt)
        local t = self.defenceBar:getPercentage()
        local t1 = tonumber(self.labelDefenceResume:getString())
        if 0 == t1 then
            scheduler.unscheduleGlobal(self.resumeDefenceHandler)
            self.defenceBar:setVisible(false)
            self.labelDefenceResume:setVisible(false)
            self.labelDefenceResume:setString(90)
            self.defence:setIsAble(true)
            return
        end
        self.labelDefenceResume:setString(t1 - kResumeValue)
        self.defenceBar:setPercentage(t - kResumeValue)
    end
    local cdTimes = define.cdTimes
    local percentTimes = cdTimes/100
    self.resumeDefenceHandler = scheduler.scheduleGlobal(tick, percentTimes)
end

function FightPlayer:onDefenceBeHurt(event)
    local percent = event.percent * 100
    self.defenceDemage:setPercentH(percent)
end

function FightPlayer:onHeroKill(event)
    --todo
    self:onCancelledFire()

    --fight 
    self.fight:willFail(0.0)
end

function FightPlayer:initTouchArea()
    --[[
    多点触摸:layerTouch为母层 包含btn
    ]]

	--control    
    local layerTouch = cc.uiloader:seekNodeByName(self, "layerTouch")
    layerTouch:setTouchEnabled(true)  
    layerTouch:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --move区域
    self.layerControl = cc.uiloader:seekNodeByName(self, "layerControl")
    layerTouch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        --guide
        local guide   = md:getInstance("Guide")
        local guideid = guide:getCurGroupId() 
        local isUntouch = guideid == "fight01_move" or guideid == "fight01_fire"
        if isUntouch then return end
        if event.name == "began" or event.name == "added" then
            self:onMutiTouchBegin(event)
        elseif event.name == "ended" or event.name == "cancelled" or event.name == "removed" then
            self:onMutiTouchEnd(event)
        elseif event.name == "moved" then 
            self:onTouchMoved(event)
        end
        return true
    end) 

    -- btn
    self:initBtns()
end

function FightPlayer:initDefence()
    --受伤
    self.defenceDemage = cc.uiloader:seekNodeByName(self, "loadingBarDefenceHp")

    --恢复
    self.labelDefenceResume = cc.uiloader:seekNodeByName(self, "labelDefenceHp")
    self.labelDefenceResume:setVisible(false)

    self.defenceBar = display.newProgressTimer("#btn_dun03.png", display.PROGRESS_TIMER_RADIAL)
    self.btnDefence:addChild(self.defenceBar)
    self.defenceBar:setOpacity(170)
    self.defenceBar:setAnchorPoint(0.0,0.0)
    self.defenceBar:setReverseDirection(true)
    self.defenceBar:setScale(2)
    self.defenceBar:setPercentage(100)
    self.defenceBar:setVisible(false)
end

function FightPlayer:initBtns()
    --btnfire   
    self.btnFire = cc.uiloader:seekNodeByName(self, "btnFire")

    --btnChange
    self.btnChange = cc.uiloader:seekNodeByName(self, "btnChange")

    --btnDefence
    self.btnDefence = cc.uiloader:seekNodeByName(self, "btnDun")
    self:initDefence()

    --btnRobot
    self.btnRobot = cc.uiloader:seekNodeByName(self, "btnRobot")
    self.label_jijiaNum = cc.uiloader:seekNodeByName(self, "label_jijiaNum")
    local num = self.fightProp:getRobotNum()
    self.label_jijiaNum:setString(num) 
    
    --btnLei
    self.btnLei = cc.uiloader:seekNodeByName(self, "btnLei")
    self.label_leiNum = cc.uiloader:seekNodeByName(self, "label_shouleiNum")
    local num = self.fightProp:getLeiNum()
    self.label_leiNum:setString(num)   

    --btnJu
    self.btnJu = cc.uiloader:seekNodeByName(self, "btnJun")
    self.btnJu:setVisible(false)

    --btnGold
    self.btnGold = cc.uiloader:seekNodeByName(self, "btnGold")
    self.label_gold = cc.uiloader:seekNodeByName(self, "label_gold")    
    self.label_gold:setColor(cc.c3b(255, 146, 0))
    local num = self.fightProp:getGoldNum()
    self.label_gold:setString(num)
end

---- touch and btn----
function FightPlayer:onMutiTouchBegin(event)
    --check
    if event.points == nil then return false end
    for id, point in pairs(event.points) do
        local eventName = event.name 
        local isTouch = self:checkBtnFire(id, point, eventName)
        if isTouch then return true end

        isTouch = self:checkBtnChange(point)
        if isTouch then return true end        

        isTouch = self:checkbtnRobot(point)
        if isTouch then return true end

        isTouch = self:checkBtnDefence(point)
        if isTouch then return true end 

        isTouch = self:checkBtnLei(point)
        if isTouch then return true end

        isTouch = self:checkBtnJu(point)
        if isTouch then return true end

        isTouch = self:checkBtnGold(point)
        if isTouch then return true end
    end
    if event.points["0"] then 
        self:checkJuOpen(event.points["0"])
    end
    return false
end

function FightPlayer:checkJuOpen(point)
    local isju = self.fight:isJujiFight()
    if not isju then return end
    local map    = md:getInstance("Map")
    local isOpen = map:getIsOpenJu()
    if isOpen then return end 
    local pos = cc.p(point.x, point.y)
    map:setIsOpenJu(true, pos)      
end

function FightPlayer:onJuClose(event)
    self.btnLei:setVisible(false)
    self.label_leiNum:setVisible(false)
    self.gunView:setVisible(true)
    self.focusNode:setVisible(false)
    self.btnJu:setVisible(false)
end

function FightPlayer:onJuOpen(event)
    self.btnLei:setVisible(true)
    self.label_leiNum:setVisible(true)
    self.gunView:setVisible(false)
    self.focusNode:setVisible(true)
    self.btnJu:setVisible(true)
end

function FightPlayer:checkJujiControl()
    local isju = self.fight:isJujiFight()
    if isju then 
        self.btnJu:setVisible(false)
        self.btnChange:setVisible(false)
        self.btnRobot:setVisible(false)
        self.label_jijiaNum:setVisible(false)        
    end 
end

function FightPlayer:onMutiTouchEnd(event)
    for id,point in pairs(event.points) do
         self:checkBtnFire(id, point, event.name)
    end
end

function FightPlayer:checkBtnJu(point,eventName)
    if self.btnJu:isVisible() == false then return end 
    local rect = self.btnJu:getCascadeBoundingBox()  
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        --切换狙击镜
        addBtnEffect(self.btnJu)
        local map = md:getInstance("Map")
        local isOpen = map:getIsOpenJu()
        map:setIsOpenJu(not isOpen)
    end
    return isTouch
end

function FightPlayer:checkBtnGold(point, eventName)
    if self.btnGold:isVisible() == false then return end 
    local rect = self.btnGold:getCascadeBoundingBox()  
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then
        addBtnEffect(self.btnGold)
        self.fightProp:costGoldWeapon()
    end
    return isTouch
end

function FightPlayer:checkbtnRobot(point)
    if not self.btnRobot:isVisible() then return end
    local rect = self.btnRobot:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        addBtnEffect(self.btnRobot)

        --cost      
        self.fightProp:costRobot()
    end
    return isTouch
end

function FightPlayer:checkBtnLei(point)
    if not self.btnLei:isVisible() then return end    
    local rect = self.btnLei:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if self.isShouLeing then return end
    local function restore()
        self.isShouLeing = false
    end
    self:performWithDelay(restore, define.kShouLeiCd)

    if isTouch then
        self.isShouLeing = true
        addBtnEffect(self.btnLei)

        --cost
        local pWorld = self.focusNode:convertToWorldSpace(cc.p(0,0))
        local function callfunc()
            self.hero:dispatchEvent({name = self.hero.SKILL_GRENADE_START_EVENT,
                focusWorld = pWorld})
        end        
        self.fightProp:costLei(callfunc)
    end
    return isTouch
end

function FightPlayer:refreshPropData(event)
    local fightProp = md:getInstance("FightProp")
    
    --jijia
    local numjijia = fightProp:getRobotNum()
    self.label_jijiaNum:setString(numjijia)
    
    --lei
    local numlei   = fightProp:getLeiNum()
    self.label_leiNum:setString(numlei)

    --gold
    local numGold   = fightProp:getGoldNum()
    self.label_gold:setString(numGold)
end

function FightPlayer:checkBtnDefence(point)

    if not self.btnDefence:isVisible() then return end
    local rect = self.btnDefence:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        addBtnEffect(self.btnDefence)
        self.defence:switchStatus()
    end
    return isTouch
end

function FightPlayer:checkBtnChange(point)
    assert( point , "invalid params")
    if not self.btnChange:isVisible() then return end
    local rect = self.btnChange:getCascadeBoundingBox()  
    isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        --换枪
        addBtnEffect(self.btnChange)
        self.hero:changeGun()
    end    
    return isTouch    
end

function FightPlayer:onTouchMoved(event)
    local  x, y, prevX, prevY 
    for i,v in pairs(event.points) do
        local isBtnTouchPoint = false
        if not self.layerControl:getCascadeBoundingBox():containsPoint(cc.p(v.x, v.y)) then 
            isBtnTouchPoint = true
        end 
        if isBtnTouchPoint == false then 
            x, y, prevX, prevY = v.x, v.y, v.prevX, v.prevY
            local offsetX = x - prevX 
            local offsetY = y - prevY         
            --处理瞄准
            self:moveFocus(offsetX, offsetY)
            
            --处理滑屏
            self:moveBgLayer(offsetX, offsetY)
        end
    end
end

----attack----
function FightPlayer:checkBtnFire(id,point,eventName)
    if eventName == "moved" then return false end
    local isend  = eventName == "ended" or eventName == "cancelled" or eventName == "removed"
    local rect = self.btnFire:getCascadeBoundingBox()      
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y)) 
    
    --in touch
    if not self:checkJuFire() then
        return isTouch
    end

    if isTouch  then
        if self.touchFireId == nil and 
            (eventName == "added" or eventName == "began") then
            self.touchFireId = id
        end
        if self.touchFireId == id and not isend then
            self.hero.fsm__:doEvent("ready")
            self:onBtnFire()
            self.btnFireSch = self:schedule(handler(self, self.onBtnFire), 0.01)
        end
    end
   
    -- not in touch
    if self.touchFireId == id and isend then
        self.touchFireId = nil
        self:onCancelledFire()     
    end          
    return isTouch
end

function FightPlayer:checkJuFire()
    --检查狙                   是狙图 则开狙击镜 延迟1秒 可以自由开火
    local isJuLevel = self.fight:isJujiFight()
    local map           = md:getInstance("Map")
    local isOpenJu      = map:getIsOpenJu() 
    if isJuLevel and not isOpenJu then 
        return false
    end 
    return true
end

function FightPlayer:onBtnFire()
    local robot = md:getInstance("Robot")
    local isRobot = robot:getIsRoboting()
    if isRobot then
        if robot:isCoolDownDone() then
            self:robotFire()
        end
    else
        if self:isCoolDownDone() then 
            self:checkFire()
        end        
    end 

    --btn armature
    if self.btnArmature ~= nil then return end
    self.btnArmature = ccs.Armature:create("effect_gun_kaiqiang")
    self.btnArmature:getAnimation():playWithIndex(0 , -1, 1)
    local function animationEvent(armatureBack,movementType,movementID)
        if movementType == ccs.MovementEventType.loopComplete then
            self.btnArmature:removeFromParent()
            self.btnArmature = nil
        end
    end

    self.btnArmature:getAnimation():setMovementEventCallFunc(animationEvent)
    addChildCenter(self.btnArmature, self.btnFire)
end

function FightPlayer:onCancelledFire()
    self:checkLongFire()

    --robot ju
    local robot         = md:getInstance("Robot")
    local isRobot       = robot:getIsRoboting()
    if isRobot then
        robot:stopFire()
    else
        self.gunView:stopFire()
    end
    self.focusView:stopFire()

    --sch
    if self.btnFireSch then
        transition.removeAction(self.btnFireSch)
    end
    self.touchFireId = nil 
end

function FightPlayer:checkLongFire()
    local gid = self.fight:getGroupId()
    local isCheck = (gid == 1 or gid == 2 ) and not self.fight:isJujiFight()
    if self.checkLongFireTimes >= 4 or not isCheck then 
        return 
    end

    local function checkFireTime()
        if self.touchFireId then
            self.checkLongFireTimes = self.checkLongFireTimes + 1
            self.hero:dispatchEvent({name = self.hero.EFFECT_FIGHTTIPS_EVENT,
                strTips = "长按连击，可增加伤害!"})
            -- self.hero:dispatchEvent({name = self.hero.EFFECT_GUIDE_EVENT, animName = "saoshe"})
        end
    end
    local action = nil
    local function removeSch()
        transition.removeAction(action) 
    end
    action = self:schedule(checkFireTime, 0.1)
    self:performWithDelay(removeSch, 0.3)
end

function FightPlayer:stopFire(event)
    self:onCancelledFire()
end

function FightPlayer:isCoolDownDone()
    if self.hero:canFire() then 
        return true 
    end

    return false
end
 
function FightPlayer:checkFire()
    self:fire()
end
 
function FightPlayer:robotFire()
    local robot = md:getInstance("Robot")
    if not robot:isCoolDownDone() then return end
    robot:fire()
    self.focusView:playFire()
    local focusRangeNode = self.focusView:getFocusRange()
    self.hero:dispatchEvent({name = self.hero.GUN_FIRE_EVENT,focusRangeNode = focusRangeNode})
end

function FightPlayer:fire()
    --hero 控制cooldown
    if self.gunView:canShot() then  --todo
        self.hero:fire() 
    end    
end

function FightPlayer:onHeroFire(event)
    local focusRangeNode = self.focusView:getFocusRange()
    self.focusView:playFire()

    --gun 
    local pWorldGun = self.layerGun:convertToWorldSpace(cc.p(0,0))
    self.hero:dispatchEvent({name = self.hero.GUN_FIRE_EVENT,
        focusRangeNode = focusRangeNode, pWorldGun = pWorldGun})    
end

----move----
function FightPlayer:onResumePos(event)
    self.focusNode:setPosition(display.width/2, display.height1/2)
    self.layerGun:setPositionX(display.width/2 + 200)
    self.layerMap:setPosition(0, 0)
    self:justBgPos()
end

function FightPlayer:moveFocus(offsetX, offsetY)
    --check ju
    if self.fight:isJujiFight() then return end
    if 1 == 1 then return end

    local focusNode = self.focusNode
    local xOri, yOri = focusNode:getPosition()
    local scale = KFightConfig.scaleMoveFocus
    offsetX = xOri + offsetX * scale
    offsetY = yOri + offsetY * scale
    focusNode:setPosition(offsetX, offsetY)
    self:justFocusPos(focusNode)

    --变红 todoyby
    local x, y = focusNode:getPosition()
    self:moveGun(x - xOri,y - yOri)
end

function FightPlayer:moveBgLayer(offsetX, offsetY)
    local map = md:getInstance("Map")
    local isNotMove = map:isNotMoveMap()
    if isNotMove then return end    

    local isOpenJu = map:getIsOpenJu()
    --todo
    local scale = isOpenJu and KFightConfig.scaleMoveBg * define.kJuRange  or KFightConfig.scaleMoveBg 
    local kScale = KFightConfig.scaleMoveBg
    local scale = isOpenJu and kScale * 1 or kScale
    local layerMap = self.layerMap
    local xOri, yOri = layerMap:getPosition()
    layerMap:setPosition(xOri - offsetX * scale, yOri - offsetY * scale)

    local x, y = layerMap:getPosition()
    self:justBgPos()
end

function FightPlayer:moveGun(offsetX, offsetY)
    local layerGun = self.layerGun
    local xOri, yOri = layerGun:getPosition()
    -- layerGun:setPositionX(offsetX + xOri)
    layerGun:setPosition(offsetX + xOri, offsetY + yOri)
end

function FightPlayer:justBgPos()
    local layerMap = self.layerMap
    local bgMap = self.mapView
    local box = bgMap:getBoundingBox()
    local map = md:getInstance("Map")
    local isNotMove = map:isNotMoveMap()
    if isNotMove then return end    

    local isOpenJu = map:getIsOpenJu()
    local scale = isOpenJu and define.kJuRange or 1.0

    local w, h = bgMap:getBgSize().width * scale  ,
        bgMap:getBgSize().height * scale
    local offset = bgMap:getBgOffset()
    local xL = (w - display.width1) / 2  
    local yL1 = -(h - display.height1 + offset.y * 2) / 2 
    local yL2 = (h - display.height1 - offset.y * 2) / 2
    local x, y = layerMap:getPosition()

    --x
    if x <= -xL then
        x = -xL
    elseif x >= xL  then 
        x = xL
    end

    --y
    if y <= yL1  then  --上限
        y = yL1
    elseif y >=  yL2  then  --下限
        y = yL2
    end    
    layerMap:setPosition(x, y)    
end

function FightPlayer:justFocusPos(node)
    local x, y = node:getPosition()

    if x <= 0 then 
        x = 0
    end

    if x >= display.width1 then 
        x = display.width1
    end
    
    if y <= 0 then 
        y = 0
    end
    if y >= display.height1 then 
        y = display.height1
    end
    node:setPosition(x, y)
end

function FightPlayer:initGuide1()
    --check   
    local isDone = self.guide:isDone("fight01_move")
    local gid, lid= self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 0 and gid == 0
    if isDone or not isWillGuide then 
        return 
    end    

    --hidebtn
    self.btnDefence:setVisible(false)
    self.btnChange:setVisible(false)
    self.btnRobot:setVisible(false)
    self.btnLei:setVisible(false)
    self.btnGold:setVisible(false)
    self.label_gold:setVisible(false)
    self.label_jijiaNum:setVisible(false)
    self.label_leiNum:setVisible(false)
    self.label_gold:setVisible(false)
    self.infoLayer:setVisible(false)

    --touch
    self.guide:setTouchSwallow(false)

    --move
    local function checkGuideFire()
        self:onCancelledFire()       
        self.guide:check("fight01_fire")


        local comps = {btnLei = true, label_leiNum =  true,}
        self.fight:dispatchEvent({name = self.fight.CONTROL_SET_EVENT,
            comps = comps})           
        
        self.layerMap:setPosition(40, 85)
    end

    self.guide:addClickListener({
        id = "fight_move",
        groupId = "fight01_move",
        rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent)
            -- checkGuideFire()
            self:performWithDelay(checkGuideFire, 4.0)
        end
     })
    
    --fire
    self.guide:addClickListener({
        id = "fight_fire",
        groupId = "fight01_fire",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self:fire()
            scheduler.performWithDelayGlobal(handler(self, self.onCancelledFire), 0.05)
        end
    })  


    --扔雷
    self.guide:addClickListener( {
        id = "fight_lei",
        groupId = "fight01_lei",
        rect = self.btnLei:getBoundingBox(),
        endfunc = function (touchEvent)
            local pWorld = self.focusNode:convertToWorldSpace(cc.p(0,0))
            self.hero:dispatchEvent({name = self.hero.SKILL_GRENADE_START_EVENT,
                    focusWorld = pWorld})
        end
    })  
    
    --黄金武器
    self.guide:addClickListener( {
        id = "fight_gold",
        groupId = "fight01_gold",
        rect = self.btnGold:getBoundingBox(),
        endfunc = function (touchEvent)
            local fightInlay = md:getInstance("FightInlay")
            fightInlay:activeGoldOnCost()
        end
    })     
end

function FightPlayer:initGuideChange()
    local isDone = self.guide:isDone("fight_change")
    local gid, lid= self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 1 and gid == 1
    if isDone or not isWillGuide then 
        return 
    end    

    --换枪
    self.guide:addClickListener( {
        id = "fight_change",
        groupId = "fight_change",
        rect = self.btnChange:getBoundingBox(),
        endfunc = function (touchEvent)
            for id, point in pairs(touchEvent.points) do
                self:checkBtnChange(point)
            end            
        end
    })  
end

function FightPlayer:initGuideDun()
    local isDone = self.guide:isDone("fight_dun")
    local gid, lid= self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 1 and gid == 1
    if isDone or not isWillGuide then 
        return 
    end 

    --盾牌 
    self.guide:addClickListener( {
        id = "fight_dun",
        groupId = "fight_dun",
        rect = self.btnDefence:getBoundingBox(),
        endfunc = function (touchEvent)
            for id, point in pairs(touchEvent.points) do
                self:checkBtnDefence(point)
            end           
        end
    }) 
end

function FightPlayer:initGuide3()
    local isDone = self.guide:isDone("fightJu")
    local gid, lid = self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 5 and gid == 1
    if isDone or not isWillGuide then return end   

    self.guide:addClickListener({
        id = "fightJu_open",
        groupId = "fightJu",
        rect = cc.rect(display.width1/2 - 60, display.height1/2 - 60,
                        120, 120),
        endfunc = function (touchEvent)
            local map = md:getInstance("Map")
            map:setIsOpenJu(true, cc.p(display.width1/2, display.height1/2))            
        end
     })    

    self.guide:addClickListener({
        id = "fightJu_fire",
        groupId = "fightJu",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self.gunView:fire()
            self.hero:fire()
            scheduler.performWithDelayGlobal(handler(self, self.onCancelledFire), 0.2)
        end
     })    

    self.guide:addClickListener({
        id = "fightJu_close",
        groupId = "fightJu",
        rect = self.btnJu:getBoundingBox(),
        endfunc = function (touchEvent)
            local map = md:getInstance("Map")
            map:setIsOpenJu(false)          
        end
     })    

    self.guide:addClickListener({
        id = "fightJu_finish",
        groupId = "fightJu",
        rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent) 
            self:onCancelledFire()    
        end
     })        
end

function FightPlayer:initGuide4()
    --check     
    local isDone = self.guide:isDone("fight01_jijia")
    local gid, lid = self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 0 and gid == 0
    if isDone or not isWillGuide then return end

    --机甲
    self.btnRobot:setVisible(false)
    self.label_jijiaNum:setVisible(false)
    
    --btn
    self.guide:addClickListener({
        id = "fight01_jijia",
        groupId = "fight01_jijia",
        rect = self.btnRobot:getBoundingBox(),
        endfunc = function (touchEvent)
            addBtnEffect(self.btnRobot)
            self.fightProp:costRobot()
        end
    })   
end

function FightPlayer:onEnter()
    --start fight
    self.fight:beginFight()    

    --music
    local src = "res/Music/bg/bjyx.wav"
    audio.playMusic(src, true)
    
    --show
    self:checkJujiControl()
end


function FightPlayer:onCleanup()
     audio:stopAllSounds()
     self:removeAllSchs()
     audio.stopMusic()
end

function FightPlayer:removeAllSchs()
    if self.tempChangeGoldHandler then 
        scheduler.unscheduleGlobal(self.tempChangeGoldHandler)
        self.tempChangeGoldHandler = nil
    end
    if self.resumeDefenceHandler then 
        scheduler.unscheduleGlobal(self.resumeDefenceHandler)
        self.resumeDefenceHandler= nil
    end
end

return FightPlayer

