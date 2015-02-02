--import
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local DialogLayer   = import("..dialog.DialogLayer")
local FightDescLayer = import(".fightDesc.FightDescLayer")
local GunView       = import(".GunView")
local FocusView     = import(".FocusView")
local MapView       = import(".MapView")
local HeroLayer      = import(".HeroLayer")
local InfoLayer      = import(".InfoLayer")

local KFightConfig = {
    scaleMoveBg = 1.0, 
    scaleMoveFocus = 2.3,
    scaleMoveGun = 2.3, 
}

local FightPlayer = class("FightPlayer", function ()
	return display.newLayer()
end)

--定义事件

function FightPlayer:ctor(properties)
    --instance
    -- print("FightPlayer:ctor(properties)")
    self.fight      = md:getInstance("Fight")
    self.fight:refreshData(properties)
    self.fight:beginFight()
    self.hero       = md:getInstance("Hero")
    self.guide      = md:getInstance("Guide")
    self.dialog     = md:getInstance("DialogModel")

    self.defence    = md:getInstance("Defence")
    self.inlay      = md:getInstance("FightInlay")
    self.fightProp  = md:getInstance("FightProp")

    --datas
    self.curGold    = 0
    self.tempChangeGoldHandler = nil
    self.resumeDefenceHandler = nil
    self.btnFireSch = nil
    self.touchFireId = nil

    --views
    self.focusView      = FocusView.new()
    self.mapView        = MapView.new()
    self.gunView        = GunView.new()
    self.heroLayer      = HeroLayer.new()
    self.infoLayer      = InfoLayer.new() 
    self.touchIds       = {} --todo
    self.isControlVisible = true
    --ui
    self:initUI()

    --事件
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    cc.EventProxy.new(self.hero, self)
        
        :addEventListener(self.hero.KILL_EVENT, handler(self, self.onHeroKill))
        :addEventListener(self.hero.AWARD_GOLD_INCREASE_EVENT, handler(self, self.changeGoldCount)) 
        :addEventListener(self.hero.FIRE_EVENT, handler(self, self.onHeroFire))
    cc.EventProxy.new(self.fight, self)
        :addEventListener(self.fight.PAUSE_SWITCH_EVENT, handler(self, self.setPause))
        :addEventListener(self.fight.CONTROL_HIDE_EVENT, handler(self, self.hideControl))
        :addEventListener(self.fight.CONTROL_SHOW_EVENT, handler(self, self.showControl))
        :addEventListener(self.fight.CONTROL_SET_EVENT,  handler(self, self.setComponentVisible))
        :addEventListener(self.fight.RESULT_WIN_EVENT,  handler(self, self.onResultWin))
        :addEventListener(self.fight.RESULT_FAIL_EVENT, handler(self, self.onResultFail))
        :addEventListener(self.fight.FIGHT_RESUMEPOS_EVENT, handler(self, self.onResumePos))
        :addEventListener(self.fight.FIGHT_FIRE_PAUSE_EVENT, handler(self, self.stopFire))
       
    cc.EventProxy.new(self.fightProp, self)
        :addEventListener(self.fightProp.PROP_UPDATE_EVENT, handler(self, self.refreshPropData))

    cc.EventProxy.new(self.defence, self)
        :addEventListener(self.defence.DEFENCE_BEHURTED_EVENT, handler(self, self.onDefenceBeHurt))
        :addEventListener(self.defence.DEFENCE_BROKEN_EVENT, handler(self, self.startDefenceResume))
    
    self:scheduleUpdate()
    self:setNodeEventEnabled(true)
    
end

function FightPlayer:setPause(event)
    local isPause = event.isPause
    local layerTouch = cc.uiloader:seekNodeByName(self, "layerTouch")
    layerTouch:setTouchEnabled(not isPause)  
end

function FightPlayer:changeGoldCount(event)
    local lastTotalGold =  self.fight:getGoldValue() 
    local totalGold = event.value + lastTotalGold
    self.fight:setGoldValue(totalGold)

    local function changeGold()
        local totalGold = self.fight:getGoldValue()
        if self.curGold < totalGold then
            self.curGold = self.curGold + 1
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
    --gun
    self.layerGun:setVisible(true)
    
    --btn
    self.btnDefence:setVisible(true)
    self.btnRobot:setVisible(true)

    self.btnChange:setVisible(true)
    self.btnLei:setVisible(true)
    self.label_jijiaNum:setVisible(true)
    self.label_leiNum:setVisible(true)
    self.label_gold:setVisible(true)   

    local levelModel = md:getInstance("LevelDetailModel")
    local isju = levelModel:isJujiFight()
    if isju then 
        self.btnChange:setVisible(false) 
    end
end

function FightPlayer:hideControl(event)
    self.isControlVisible = false
    --gun
    self.layerGun:setVisible(false)
    
    --btn
    self.btnDefence:setVisible(false)
    self.btnChange:setVisible(false)
    self.btnRobot:setVisible(false)
    self.btnLei:setVisible(false)
    self.label_jijiaNum:setVisible(false)
    self.label_leiNum:setVisible(false)
    self.label_gold:setVisible(true)
end

function FightPlayer:setComponentVisible(event)
    local comps = event.comps
    -- dump(comps, "comps")
    for i,v in pairs(comps) do
        self[i]:setVisible(v)
        -- print(i,v)
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

    --gold
    self.labelGold = cc.uiloader:seekNodeByName(self, "labelGoldCount")

    --load gun 
    self.layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    self.layerGun:addChild(self.gunView)

    --load HeroLayer
    local layerHero = cc.uiloader:seekNodeByName(self, "layerHero")
    addChildCenter(self.heroLayer, layerHero)
    self.heroLayer:setPosition(0, 0)

    --load layerGunInfo
    local layerGunInfo = cc.uiloader:seekNodeByName(self, "layerGunInfo")
    addChildCenter(self.infoLayer, layerGunInfo)
    self.infoLayer:setPosition(0, 0)

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
    scheduler.performWithDelayGlobal(handler(self, self.initGuide2), 0.1)    
    scheduler.performWithDelayGlobal(handler(self, self.initGuide3), 0.1)    
    scheduler.performWithDelayGlobal(handler(self, self.initGuide4), 0.1)    
end

--启动盾牌恢复
function FightPlayer:startDefenceResume(event)
    -- print("function FightPlayer:startDefenceResume(event)")
    self.labelDefenceResume:setVisible(true)
    
    --受伤
    self.defenceDemage:setPercent(0)

    --恢复
    self.defenceBar:setVisible(true)

    local kResumeValue = 1  --每次恢复点数
    local function tick(dt)
        local t = self.defenceBar:getPercentage()
        local t1 = tonumber(self.labelDefenceResume:getString())
        if 0 == t1 then
            -- print("盾牌恢复成功")
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
    -- print("percent,", percent)
    self.defenceDemage:setPercent(percent)
end

function FightPlayer:onHeroKill(event)
    --todo
    self:onCancelledFire()

    --fight 
    self.fight:onFail()
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

    -- layerTouch:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function(event)
    layerTouch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
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
    --defence demage self.defenceDemage
    self.defenceDemage = cc.uiloader:seekNodeByName(self, "loadingBarDefenceHp")
    
    --恢复
    self.labelDefenceResume = cc.uiloader:seekNodeByName(self, "labelDefenceHp")
    self.labelDefenceResume:setVisible(false)

    self.defenceBar = display.newProgressTimer("#btn_dun03.png", display.PROGRESS_TIMER_RADIAL)
    self.btnDefence:addChild(self.defenceBar)
    self.defenceBar:setOpacity(130)
    self.defenceBar:setAnchorPoint(0.0,0.0)
    self.defenceBar:setReverseDirection(true)
    self.defenceBar:setScale(2)
    self.defenceBar:setPercentage(100)
    self.defenceBar:setVisible(false)
end

function FightPlayer:initBtns()
    --btnfire   
    self.btnFire = cc.uiloader:seekNodeByName(self, "btnFire")
    -- self.btnFire:setTouchEnabled(true)  
    -- self.btnFire:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnChange
    self.btnChange = cc.uiloader:seekNodeByName(self, "btnChange")
    self.btnChange:setTouchEnabled(true)
    self.btnChange:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnDefence
    self.btnDefence = cc.uiloader:seekNodeByName(self, "btnDun")
    self.btnDefence:setTouchEnabled(true)
    self.btnDefence:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self:initDefence()

    --btnRobot
    self.btnRobot = cc.uiloader:seekNodeByName(self, "btnRobot")
    self.btnRobot:setTouchEnabled(true)
    self.btnRobot:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self.label_jijiaNum = cc.uiloader:seekNodeByName(self, "label_jijiaNum")
    local num = self.fightProp:getRobotNum()
    self.label_jijiaNum:setString(num) 
    
    --btnLei
    self.btnLei = cc.uiloader:seekNodeByName(self, "btnLei")
    self.btnLei:setTouchEnabled(true)
    self.btnLei:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self.label_leiNum = cc.uiloader:seekNodeByName(self, "label_shouleiNum")
    local num = self.fightProp:getLeiNum()
    self.label_leiNum:setString(num)   

    --btnJu
    self.btnJu = cc.uiloader:seekNodeByName(self, "btnJun")
    self.btnJu:setVisible(false)
    self.btnJu:setTouchEnabled(true)
    self.btnJu:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnGold
    self.btnGold = cc.uiloader:seekNodeByName(self, "btnGold")
    self.btnGold:setTouchEnabled(true)
    self.btnGold:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self.label_gold = cc.uiloader:seekNodeByName(self, "label_gold")    
    self.label_gold:setColor(cc.c3b(255, 146, 0))
    local num = self.fightProp:getGoldNum()
    self.label_gold:setString(num)
end

---- touch and btn----
function FightPlayer:onMutiTouchBegin(event)
     -- dump(event, "event onMutiTouchBegin")

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

        isTouch = self:checkbtnDefence(point)
        if isTouch then return true end 

        isTouch = self:checkBtnLei(point)
        if isTouch then return true end

        isTouch = self:checkBtnJu(point)
        if isTouch then return true end

        isTouch = self:checkBtnGold(point)
        if isTouch then return true end
      
    end
    return false
end

function FightPlayer:onMutiTouchEnd(event)
    for id,point in pairs(event.points) do
         self:checkBtnFire(id, point, event.name)
    end
end

function FightPlayer:checkBtnJu(point,eventName)
    print("function FightPlayer:checkBtnJu(point,eventName)")
    if self.btnJu:isVisible() == false then return end 
    local rect = self.btnJu:getCascadeBoundingBox()  
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        --切换狙击镜
        print("-----------switch ju")
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
        print("点击黄金枪 购买")
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
        local function callfunc()
            local robot = md:getInstance("Robot")
            robot:startRobot()
        end        
        self.fightProp:costRobot(callfunc)
    end
    return isTouch
end

function FightPlayer:checkBtnLei(point)
    if not self.btnLei:isVisible() then return end    
    local rect = self.btnLei:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        addBtnEffect(self.btnLei)

        local w, h = self.focusNode:getCascadeBoundingBox().width, 
                self.focusNode:getCascadeBoundingBox().height
        local destPos = cc.p(self.focusNode:getPositionX(), 
            self.focusNode:getPositionY())

        --cost
        local function callfunc()
            self.hero:dispatchEvent({name = self.hero.SKILL_GRENADE_START_EVENT,
                throwPos = destPos})
        end        
        self.fightProp:costLei(callfunc)
    end
end

function FightPlayer:refreshPropData(event)
    print("function FightPlayer:refreshPropData(event)")
    local fightProp = md:getInstance("FightProp")
    
    --jijia
    local numjijia = fightProp:getRobotNum()
    self.label_jijiaNum:setString(numjijia)
    
    --lei
    local numlei   = fightProp:getLeiNum()
    -- print("numjijia:"..numjijia.."numlei:"..numlei)
    self.label_leiNum:setString(numlei)

    --gold
    local numGold   = fightProp:getGoldNum()
    self.label_gold:setString(numGold)
end

function FightPlayer:checkbtnDefence(point)
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
    print("eventName:"..eventName.."  id:"..id)
    local isend  = eventName == "ended" or eventName == "cancelled" or eventName == "removed"
    local rect = self.btnFire:getCascadeBoundingBox()      
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y)) 
    
    --in touch
    if isTouch then
        local isOpenJu = self:checkJuFire()
        if isOpenJu then return false end 
    end

    if isTouch  then
        if self.touchFireId == nil and 
            (eventName == "added" or eventName == "began") then
            self.touchFireId = id
            -- print("self.touchFireId set "..id) 
        end
        if self.touchFireId == id and not isend then
            -- self.btnFireSch =  scheduler.scheduleGlobal(
            --     handler(self, self.onBtnFire), 0.05)
            -- self:onBtnFire()
            self.hero.fsm__:doEvent("ready")
            self.btnFireSch = self:schedule(handler(self, self.onBtnFire), 0.05)
            -- self.btnFireSch =  scheduler.scheduleGlobal(
            --     handler(self, self.onBtnFire), 0.05)
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
    local levelModel = md:getInstance("LevelDetailModel")
    local isJuLevel = levelModel:isJujiFight()
    local map           = md:getInstance("Map")
    local isOpenJu      = map:getIsOpenJu()

    local isJuAble      = map:getIsJuAble()    
    if isJuLevel and not isOpenJu then 
        map:setIsOpenJu(true)
        return true
    end 
    return false
end

function FightPlayer:onBtnFire()
    local robot = md:getInstance("Robot")
    local isRobot = robot:getIsRoboting()
    print("onBtnFire", onBtnFire)
    -- self.hero.fsm__:doEvent("ready")
    -- self.hero:fire()
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
    -- print("FightPlayer:onCancelledFire()")

    --robot ju
    local robot         = md:getInstance("Robot")
    local isRobot       = robot:getIsRoboting()

    -- local levelModel    = md:getInstance("LevelDetailModel")
    -- local isJuLevel     = levelModel:isJujiFight()

    if  isRobot then
        robot:stopFire()
    else
        self.gunView:stopFire()
    end
    self.focusView:stopFire()

    --sch
    if self.btnFireSch then
        -- scheduler.unscheduleGlobal(self.btnFireSch)
        transition.removeAction(self.btnFireSch)
    end
end

function FightPlayer:stopFire(event)
    self:onCancelledFire()
end

function FightPlayer:tick(dt)
    --gun
end

function FightPlayer:isCoolDownDone()
    if self.hero:canFire() then 
        return true 
    end

    return false
end
 
function FightPlayer:checkFire()
    print("FightPlayer:fire()")
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
    self.hero:dispatchEvent({name = self.hero.GUN_FIRE_EVENT,focusRangeNode = focusRangeNode})    
end

----move----
function FightPlayer:onResumePos(event)
    self.focusNode:setPosition(display.width/2, display.height1/2)
    self.layerGun:setPositionX(display.width/2 + 200)
    self.layerMap:setPosition(0, 0)
    self:justBgPos(self.layerMap)
end

function FightPlayer:moveFocus(offsetX, offsetY)
    local focusNode = self.focusNode
    local xOri, yOri = focusNode:getPosition()
    local scale = KFightConfig.scaleMoveFocus
    offsetX = xOri + offsetX * scale
    offsetY = yOri + offsetY * scale
    focusNode:setPosition(offsetX, offsetY)
    self:justFocusPos(focusNode)
    local x, y = focusNode:getPosition()
    self:moveGun(x - xOri,y - yOri)
end

function FightPlayer:moveBgLayer(offsetX, offsetY)
    local map = md:getInstance("Map")
    local isNotMove = map:isNotMoveMap()
    if isNotMove then return end    

    local isOpenJu = map:getIsOpenJu()
    local scale = isOpenJu and KFightConfig.scaleMoveBg * define.kJuRange  or KFightConfig.scaleMoveBg 

    local layerMap = self.layerMap
    local xOri, yOri = layerMap:getPosition()
    layerMap:setPosition(xOri - offsetX * scale, yOri - offsetY * scale)

    local x, y = layerMap:getPosition()
    self:justBgPos(layerMap)
end

function FightPlayer:moveGun(offsetX, offsetY)
    local layerGun = self.layerGun
    local xOri, yOri = layerGun:getPosition()
    layerGun:setPositionX(offsetX + xOri)
end

function FightPlayer:justBgPos(node)
    local layerMap = self.layerMap
    local bgMap = self.mapView
    local box = bgMap:getBoundingBox()
    -- dump(box, "box")
    -- print("bgMap pos", )  
    local map = md:getInstance("Map")
    local isNotMove = map:isNotMoveMap()
    if isNotMove then return end    

    local isOpenJu = map:getIsOpenJu()
    local scale = isOpenJu and define.kJuRange or 1.0

    local w, h = bgMap:getBgSize().width* scale  ,
        bgMap:getBgSize().height  * scale
    -- print("w", w)
    -- print("h", h)
    local offset = bgMap:getBgOffset()
    local xL = (w - display.width1) / 2  
    local yL1 = -(h - display.height1 + offset.y * 2) / 2 
    local yL2 = (h - display.height1 - offset.y * 2) / 2
    local x, y = node:getPosition()

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
    node:setPosition(x, y)    
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
    local isDone = self.guide:isDone("fight01")
    local gid, lid= self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 1 and gid == 1
    print("isDone", isDone)
    if isDone or not isWillGuide then 
        return 
    end    

    print("function FightPlayer:initGuide1()")
    self.focusNode:setPosition(cc.p(500,230))

    --inlay 
    local inlayModel = md:getInstance("InlayModel")
    inlayModel:buyInlay(24,false,1) 
    inlayModel:buyInlay(20,false,1) 
    inlayModel:equipInlay(24,false) 
    inlayModel:equipInlay(20,false) 
    self.hero:setFullHp()

    --move
    local isMoveGuideUnDone = true
    local rect_guidemove = cc.rect(70, 40, 300, 100)
    self.guide:addClickListener({
        id = "fight_move",
        groupId = "fight01",
        rect = rect_guidemove,
        endfunc = function (touchEvent)
            if touchEvent.name == "moved" and isMoveGuideUnDone then
                isMoveGuideUnDone = false
                -- print("ight_mov self.guide:doGuideNext()")
                -- self.focusNode:setPosition(cc.p(500,230))
                self.focusNode:moveTo(1.0,588, 230)
                self.guide:doGuideNext()
                self.guide:hideGuideForTime(2.0)
            end
        end
     })
    
    --开枪1次
    self.guide:addClickListener({
        id = "fight_fire1",
        groupId = "fight01",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self:fire()
            scheduler.performWithDelayGlobal(handler(self, self.onCancelledFire), 0.05)
        end
    })  

    --开枪1秒
    self.guide:addClickListener({
        id = "fight_fire2",
        groupId = "fight01",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self:onGuideFire(touchEvent)
        end
    })  

    --扔雷
    self.guide:addClickListener( {
        id = "fight_throw",
        groupId = "fight01",
        rect = self.btnLei:getBoundingBox(),
        endfunc = function (touchEvent)
            for id, point in pairs(touchEvent.points) do
                self:checkBtnLei(point)
            end
        end
    })  

    --换枪
    self.guide:addClickListener( {
        id = "fight_change",
        groupId = "fight01",
        rect = self.btnChange:getBoundingBox(),
        endfunc = function (touchEvent)
            for id, point in pairs(touchEvent.points) do
                self:checkBtnChange(point)
            end
        end
    })     

    --结束
    self.guide:addClickListener( {
        id = "fight_finish",
        groupId = "fight01",
        rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent)
            self:onCancelledFire() 
            self.touchFireId = nil                 
        end
    })     
      
end

function FightPlayer:onGuideFire(touchEvent)
    -- print("os.time()", os.time())
    local name = touchEvent.name
    local limitTime = 0.9
    
    --检查长按时间
    local function onGuideFireCheckFunc()
        local timeNow = os.time()
        if self.time_begin and (timeNow - self.time_begin) >=  limitTime then 
            -- print("长按射击引导完成")
            -- print("self.time_begin:", self.time_begin)
            scheduler.unscheduleGlobal(self.schGuideFire)
            self:onCancelledFire()
            self.guide:doGuideNext()
            self.guide:hideGuideForTime(2.0)
        end
    end

    --开始计时
    if name == "began"  then
        print("开始计时") 
        self.isGuideFireBegin = true
        self.time_begin = os.time()
        self.schGuideFire = scheduler.scheduleUpdateGlobal(onGuideFireCheckFunc) 
    end

    --停止计时
    if name == "ended" or name == "cancelled" then
        if self.isGuideFireBegin == false then return end 
        -- print("停止计时")
        self.time_begin = nil
        if self.schGuideFire then 
            scheduler.unscheduleGlobal(self.schGuideFire)
        end
    end

    --响应事件
    for id, point in pairs(touchEvent.points) do
        -- print("name", name)
        self:checkBtnFire(id, point,name)
    end
end


function FightPlayer:initGuide2()
    --check   
    local isDone = self.guide:isDone("fight02_dun")
    local gid, lid = self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 2 and gid == 1
    print("function FightPlayer:initGuide4()", isDone)    
    if isDone or not isWillGuide then return end
    
    --盾
    self.guide:addClickListener({
        id = "fight02_dun",
        groupId = "fight02_dun",
        rect = self.btnDefence:getBoundingBox(),
        endfunc = function (touchEvent)
            self.defence:setIsAble(true) 
            self.defence:startDefence()   
        end
    })    

    
end

function FightPlayer:initGuide4()
    --check     
    local isDone = self.guide:isDone("fight02")
    local gid, lid = self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 2 and gid == 1
    if isDone or not isWillGuide then return end

    --机甲
    self.guide:addClickListener({
        id = "fight02_jijia",
        groupId = "fight02",
        rect = self.btnRobot:getBoundingBox(),
        endfunc = function (touchEvent)
            addBtnEffect(self.btnRobot)
            local robot = md:getInstance("Robot")
            -- print("！！！！！！！fight02_jijia")
            robot:startRobot()  
        end
    })   
end

function FightPlayer:initGuide3()
    local isDone = self.guide:isDone("fight04")
    local gid, lid = self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 4 and gid == 1
    if isDone or not isWillGuide then return end   

    self.guide:addClickListener({
        id = "fight04_open",
        groupId = "fight04",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            local map = md:getInstance("Map")
            map:setIsOpenJu(true)            
        end
     })    

    self.guide:addClickListener({
        id = "fight04_fire",
        groupId = "fight04",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self.gunView:fire()
            self.hero:fire()
            scheduler.performWithDelayGlobal(handler(self, self.onCancelledFire), 0.2)
        end
     })    

    self.guide:addClickListener({
        id = "fight04_close",
        groupId = "fight04",
        rect = self.btnJu:getBoundingBox(),
        endfunc = function (touchEvent)
            local map = md:getInstance("Map")
            map:setIsOpenJu(false)          
        end
     })    

    self.guide:addClickListener({
        id = "fight04_finish",
        groupId = "fight04",
        rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent) 
            self:onCancelledFire() 
            self.touchFireId = nil       
        end
     })        

end

function FightPlayer:onEnter()
    local src = "res/Music/bg/bjyx.wav"
    audio.playMusic(src, true)

    local levelModel = md:getInstance("LevelDetailModel")
    local isju = levelModel:isJujiFight()
    if isju then 
        self.btnRobot:setVisible(false)
        self.label_jijiaNum:setVisible(false)       
    end 
end

function FightPlayer:onCleanup()
    -- FightPlayer.super.onCleanup(self)
    print("FightPlayer:onCleanup()")
    self:removeAllSchs()
end

function FightPlayer:onResultFail()
    self:removeAllSchs()
end

function FightPlayer:onResultWin()
    self:removeAllSchs()
end

function FightPlayer:removeAllSchs()
    -- print("function FightPlayer:removeAllSchs()")
    if self.tempChangeGoldHandler then 
        scheduler.unscheduleGlobal(self.tempChangeGoldHandler)
        self.tempChangeGoldHandler = nil
    end
    if self.resumeDefenceHandler then 
        scheduler.unscheduleGlobal(self.resumeDefenceHandler)
        self.resumeDefenceHandler= nil
    end
    -- if self.btnFireSch then
    --     scheduler.unscheduleGlobal(self.btnFireSch)
    --     self.btnFireSch = nil
    -- end
end

return FightPlayer

