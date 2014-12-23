--import
import("..includes.functionUtils")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local DialogLayer   = import("..dialog.DialogLayer")

local GunView       = import(".GunView")
local FocusView     = import(".FocusView")
local MapView       = import(".MapView")
local HeroLayer      = import(".HeroLayer")
local InfoLayer      = import(".InfoLayer")

local KFightConfig = {
    scaleMoveBg = 0.3, 
    scaleMoveFocus = 2.3,
    scaleMoveGun = 2.3, 
}

local FightPlayer = class("FightPlayer", function ()
	return display.newLayer()
end)

--定义事件

function FightPlayer:ctor(properties)
    --instance
    self.fight      = md:getInstance("Fight")
    self.fight:refreshData(properties) 
    self.hero       = md:getInstance("Hero")
    self.guide      = md:getInstance("Guide")
    self.dialog     = md:getInstance("DialogModel")
    self.defence    = md:getInstance("Defence")


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
        :addEventListener(self.hero.SKILL_DEFENCE_BEHURT_EVENT, handler(self, self.onDefenceBeHurt))
        :addEventListener(self.hero.KILL_EVENT, handler(self, self.onHeroKill))
        :addEventListener("changeGold", handler(self, self.changeGoldCount)) 
    
    cc.EventProxy.new(self.fight, self)
        :addEventListener(self.fight.PAUSE_SWITCH_EVENT, handler(self, self.setPause))
        :addEventListener(self.fight.CONTROL_HIDE_EVENT, handler(self, self.hideControl))
        :addEventListener(self.fight.CONTROL_SHOW_EVENT, handler(self, self.showControl))
        :addEventListener(self.fight.RESULT_WIN_EVENT,  handler(self, self.onResultWin))
        :addEventListener(self.fight.RESULT_FAIL_EVENT, handler(self, self.onResultFail))
    cc.EventProxy.new(self.defence, self)
        :addEventListener(self.defence.DEFENCE_BROKEN_EVENT, handler(self, self.startDefenceResume))
    
    self:scheduleUpdate()
    self:setNodeEventEnabled(true)
    
end

function FightPlayer:setPause(event)
    local isPause = event.isPause
    local layerTouch = cc.uiloader:seekNodeByName(self, "layerTouch")
    layerTouch:setTouchEnabled(not isPause)  
end

local tempChangeGoldHandler = nil
local curGold = 0
function FightPlayer:changeGoldCount(event)
    local totolGold = event.goldCount
    local function changeGold()
        if curGold < totolGold then
            curGold = curGold + 1
            self.labelGold:setString(curGold)
        else
            if tempChangeGoldHandler then
                scheduler.unscheduleGlobal(tempChangeGoldHandler)
                tempChangeGoldHandler = nil
            end
        end
    end
    if tempChangeGoldHandler then
        scheduler.unscheduleGlobal(tempChangeGoldHandler)
    end
    tempChangeGoldHandler = scheduler.scheduleGlobal(changeGold, 0.01)
end

function FightPlayer:onClickRobot()
    self:hideControl()
    self.hero:dispatchEvent({name = self.hero.SKILL_ROBOT_START_EVENT})
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
end

function FightPlayer:hideControl(event)
    self.isControlVisible = false
    --gun
    self.layerGun:setVisible(false)
    
    --btn
    self.btnDefence:setVisible(false)
    self.btnRobot:setVisible(false)
    self.btnChange:setVisible(false)
    self.btnLei:setVisible(false)
end

function FightPlayer:initUI()
    --load fightUI  
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui")
    local node = cc.uiloader:load("mainUI.ExportJson")

    self.ui = node
    self:addChild(node)

    --load map
    self.layerBg = cc.uiloader:seekNodeByName(self, "layerBg")
    addChildCenter(self.mapView, self.layerBg) 

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

    --guide
    scheduler.performWithDelayGlobal(handler(self, self.initGuide), 0.1)

    self:initDialog()
end

--启动盾牌恢复
local resumeDefenceHandler = nil
function FightPlayer:startDefenceResume(event)
    self.labelDefenceResume:setVisible(true)
    self:loadDefenceResumeBar()

    local kResumeValue = 1  --每次恢复点数
    local function tick(dt)
        local t = self.defenceResumeLoadingBar:getPercentage()
        local t1 = tonumber(self.labelDefenceResume:getString())
        if 0 == t1 then
            print("盾牌恢复成功")
            scheduler.unscheduleGlobal(resumeDefenceHandler)
            self.defenceResumeLoadingBar:removeFromParent()
            self.labelDefenceResume:setVisible(false)
            self.labelDefenceResume:setString(90)
            self.defence:setIsAble(true)
            
            return
        end
        self.labelDefenceResume:setString(t1 - kResumeValue)
        self.defenceResumeLoadingBar:setPercentage(t - kResumeValue)
    end

    resumeDefenceHandler = scheduler.scheduleGlobal(tick, 0.03)
end

function FightPlayer:onDefenceBeHurt(event)
    local percent = event.hurtedPercent * 100
    self.loadingBarDefenceHp:setPercent(percent)
    if 100 <= percent then
        self.loadingBarDefenceHp:setPercent(0)
        self.defence:setIsAble(false)
        -- self:startDefenceResume()
    end
end

function FightPlayer:onHeroKill(event)
    --todo
    self:onCancelledFire()

    --fight 
    self.fight:setResult(false)
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

    layerTouch:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function(event)
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

--加载defenceResume bar 控件
function FightPlayer:loadDefenceResumeBar()
    self.defenceResumeLoadingBar = display.newProgressTimer("#btn_dun03.png", display.PROGRESS_TIMER_RADIAL)
    self:addChild(self.defenceResumeLoadingBar)
    self.defenceResumeLoadingBar:setOpacity(130)
    self.defenceResumeLoadingBar:setPosition(1052, 370)
    self.defenceResumeLoadingBar:setReverseDirection(true)
    self.defenceResumeLoadingBar:setScale(2)
    self.defenceResumeLoadingBar:setPercentage(100)
end


function FightPlayer:initBtns()
    --btnfire   
    self.btnFire = cc.uiloader:seekNodeByName(self, "btnFire")
    self.btnFire:setTouchEnabled(true)  
    self.btnFire:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnChange
    self.btnChange = cc.uiloader:seekNodeByName(self, "btnChange")
    self.btnChange:setTouchEnabled(true)
    -- self.btnChange:setBlendFunc(cc.BLEND_SRC, cc.BLEND_SRC)  
    -- -- self.btnChange:setBlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA)
    self.btnChange:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnDefence
    self.btnDefence = cc.uiloader:seekNodeByName(self, "btnDun")
    self.btnDefence:setTouchEnabled(true)
    self.btnDefence:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --loadingBarDefenceHp
    self.loadingBarDefenceHp = cc.uiloader:seekNodeByName(self, "loadingBarDefenceHp")
    self.loadingBarDefenceHp:removeFromParent()
    self.loadingBarDefenceHp:setDirection(2)
    self:addChild(self.loadingBarDefenceHp)
    self.loadingBarDefenceHp:setPosition(1052, 373) --todo yanxin

    --labelDefenceHp
    self.labelDefenceResume = cc.uiloader:seekNodeByName(self, "labelDefenceHp")
    self.labelDefenceResume:setVisible(false)

    --btnRobot
    self.btnRobot = cc.uiloader:seekNodeByName(self, "btnRobot")
    self.btnRobot:setTouchEnabled(true)
    self.btnRobot:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnLei
    self.btnLei = cc.uiloader:seekNodeByName(self, "btnLei")
    self.btnLei:setTouchEnabled(true)
    self.btnLei:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    
    --btnJu
    self.btnJu = cc.uiloader:seekNodeByName(self, "btnJun")
    self.btnJu:setVisible(false)
    self.btnJu:setTouchEnabled(true)
    self.btnJu:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnGold
    self.btnGold = cc.uiloader:seekNodeByName(self, "btnGold")
    self.btnGold:setTouchEnabled(true)
    self.btnGold:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)    
end

---- touch and btn----
function FightPlayer:onMutiTouchBegin(event)
     -- dump(event, "event onMutiTouchBegin")

    --check
    if event.points == nil then return false end
    for id, point in pairs(event.points) do
        local isTouch = self:checkBtnFire(id, point)
        if isTouch then return true end

        isTouch = self:checkBtnChange(point)
        if isTouch then return true end        

        isTouch = self:checkbtnRobot(point)
        if isTouch then return true end

        isTouch = self:checkbtnDefence(point)
        if isTouch then return true end 

        isTouch = self:checkBtnLei(point)
        if isTouch then return true end

        -- isTouch = self:checkBtnJu(point)
        -- if isTouch then return true end

        isTouch = self:checkBtnGold(point)
        if isTouch then return true end
    end
    return false
end

function FightPlayer:onMutiTouchEnd(event)
    for id,point in pairs(event.points) do
         self:checkBtnFire(id, point, "ended")
    end
end

function FightPlayer:checkbtnRobot(point)
    assert( point, "invalid params")
    local rect = self.btnRobot:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        self:onClickRobot()
    end
    return isTouch
end

function FightPlayer:checkbtnDefence(point)
    local rect = self.btnDefence:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        self.defence:switchStatus()
    end
    return isTouch
end

function FightPlayer:checkBtnLei(point)
    assert( point, "invalid parames")
    local rect = self.btnLei:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        local w, h = self.focusNode:getCascadeBoundingBox().width, 
                self.focusNode:getCascadeBoundingBox().height
        local destPos = cc.p(self.focusNode:getPositionX(), 
            self.focusNode:getPositionY())
        self.hero:dispatchEvent({name = self.hero.SKILL_GRENADE_START_EVENT,throwPos = destPos})
    end
end

function FightPlayer:checkBtnChange(point)
    assert( point , "invalid params")
    local rect = self.btnChange:getCascadeBoundingBox()      
    isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        --换枪
        self.hero:changeGun()
    end    
    return isTouch    
end

function FightPlayer:checkBtnFire(id,point,eventName)
    if eventName == "moved" then return end
    if (eventName == "ended" or eventName == "cancelled" or eventName == "removed") 
        and id == self.touchIds["fire"] then
        self:onCancelledFire()
        self.touchIds["fire"] = nil 
        return
    end
    assert(id and point , "invalid params")
    local isTouch
    local rect = self.btnFire:getCascadeBoundingBox()      
    isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then
        self.touchIds["fire"]  = id
        self.btnFireSch =  scheduler.scheduleGlobal(handler(self, self.onBtnFire), 0.01)
    end    
    return isTouch
end

function FightPlayer:onBtnFire()
    -- print("ightPlayer:onBtnFire()")
    if self:canGunShot() then 
        self:fire()
    end

    --动画
    if self.btnArmature ~= nil then return end
    local src = "Fight/fightLayer/effect_gun_kaiqiang/effect_gun_kaiqiang.ExportJson"
    self.btnArmature = getArmature("effect_gun_kaiqiang", src)
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
    self.gunView:stopFire()
    self.focusView:stopFire()
    
    --sch
    if self.btnFireSch then
        scheduler.unscheduleGlobal(self.btnFireSch)
    end

    -- --anim
    -- self.btnArmature:removeFromParent()
    -- self.btnArmature = nil
end

function FightPlayer:checkBtnJu(point,eventName)
    -- if self.btnJu:getVisible() == false then return end 
    local rect = self.btnJu:getCascadeBoundingBox()  
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        --切换狙击镜
        print("-----------switch ju")
        if self.isControlVisible then 
            self:hideControl()
        else
            self:showControl()
        end
        self.hero:dispatchEvent({name = self.hero.GUN_SWITCH_JU_EVENT})
    end
    return isTouch
end

function FightPlayer:checkBtnGold(point, eventName)
    local rect = self.btnGold:getCascadeBoundingBox()  
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        print("点击黄金枪 购买")
        -- self.hero:activeGoldForever()
        self.hero:activeGold()
    end
    return isTouch    
end


function FightPlayer:onTouchMoved(event)
    -- print("FightPlayer:onTouchMoved(event)")
    -- dump(event, "onTouchMoved")
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
function FightPlayer:tick(dt)
    --gun
end

function FightPlayer:canGunShot()
    if  self.hero:canFire() then 
        return true 
    end

    return false
end
 
function FightPlayer:fire()
    -- print("FightPlayer:fire()")

    --hero 控制cooldown
    self.hero:fire()

    --gun
    if  self.gunView:canShot() then 
        self.gunView:fire()
        self.focusView:playFire()
        local focusRangeNode = self.focusView:getFocusRange()
        --todo 发命令
        self.hero:dispatchEvent({name = self.hero.GUN_FIRE_EVENT,focusRangeNode = focusRangeNode})
    end
end

----move----
function FightPlayer:moveFocus(offsetX, offsetY)
    local focusNode = self.focusNode
    local xOri, yOri = focusNode:getPosition()
    local scale = KFightConfig.scaleMoveFocus
    focusNode:setPosition(xOri + offsetX*scale, yOri + offsetY*scale)
    self:justFocusPos(focusNode)
    local x, y = focusNode:getPosition()
    self:moveGun(x)
end

function FightPlayer:moveBgLayer(offsetX, offsetY)
    local layerBg = self.layerBg
    local xOri, yOri = layerBg:getPosition()
    local scale = KFightConfig.scaleMoveBg
    layerBg:setPosition(xOri - offsetX * scale, yOri - offsetY * scale)
    local x, y = layerBg:getPosition()
    self:justBgPos(layerBg)
end

function FightPlayer:moveGun(x) 
    local layerGun = self.layerGun
    layerGun:setPositionX(x + 280)   --todo 需要改为美术资源提供
end

function FightPlayer:justBgPos(node)
    local layerBg = self.layerBg
    local bgMap = self.mapView  
    local w, h = bgMap:getSize().width , 
        bgMap:getSize().height
    local xL = (w - display.width1) / 2  
    local yL = (h - display.height1) / 2 
    local x, y = node:getPosition()

    --x
    if x <= -xL then
        x = -xL
    elseif x >= xL  then 
        x = xL
    end

    --y
    if y <= -yL  then
        y = -yL
    elseif y >=  yL  then 
        y = yL
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

function FightPlayer:initDialog()

    local dialogLayer = DialogLayer:new()
    -- dialogLayer:setPositionY(display.offset)
    self:addChild(dialogLayer, 600)

    local groupID = self.fight:getGroupId()
    local levelID = self.fight:getLevelId()
    local isExist = self.dialog:check(groupID,"level"..levelID,"forward")
    dump(isExist)
    if isExist then
        self.dialog:startDialog("forward")
    end



end

function FightPlayer:initGuide()
    --check   
    local isDone = self.guide:check("fight")
    if isDone then return end

    --move
    local isMoveGuideUnDone = true
    self.guide:addClickListener({
        id = "fight_move",
        groupId = "fight",
        rect = self.btnJu:getBoundingBox(),
        endfunc = function (touchEvent)
            if touchEvent.name == "moved" and isMoveGuideUnDone then
                isMoveGuideUnDone = false
                print("ight_mov self.guide:doGuideNext()")
                self.focusNode:moveBy(1.0, 0, -40)
                self.guide:doGuideNext()
                self.guide:hideGuideForTime(2.0)
            end
        end
     })
    
    --开枪1次
    self.guide:addClickListener({
        id = "fight_fire1",
        groupId = "fight",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self.gunView:fire()
            self.hero:fire()
        end
    })  

    --开枪1秒
    self.guide:addClickListener({
        id = "fight_fire2",
        groupId = "fight",
        rect = self.btnFire:getBoundingBox(),
        endfunc = function (touchEvent)
            self:onGuideFire(touchEvent)
        end
    })  

    --扔雷
    self.guide:addClickListener( {
        id = "fight_throw",
        groupId = "fight",
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
        groupId = "fight",
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
        groupId = "fight",
        rect = cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent)

        end
    })     

end

local time_begin = nil
local schGuideFire
local isGuideFireBegin = false
function FightPlayer:onGuideFire(touchEvent)
    print("os.time()", os.time())
    local name = touchEvent.name
    
    --检查长按时间
    local function onGuideFireCheckFunc()
        local timeNow = os.time()
        if time_begin and (timeNow - time_begin) >=  1.0 then 
            print("长按射击引导完成")
            print("time_begin:", time_begin)
            scheduler.unscheduleGlobal(schGuideFire)
            self:onCancelledFire()
            self.guide:doGuideNext()
            self.guide:hideGuideForTime(2.0)
        end
    end

    --开始计时
    if name == "began"  then
        print("开始计时") 
        isGuideFireBegin = true
        time_begin = os.time()
        schGuideFire = scheduler.scheduleUpdateGlobal(onGuideFireCheckFunc) 
    end

    --停止计时
    if name == "ended" or name == "cancelled" then
        if isGuideFireBegin == false then return end 
        print("停止计时")
        time_begin = nil
        if schGuideFire then 
            scheduler.unscheduleGlobal(schGuideFire)
        end
    end

    --响应事件
    for id, point in pairs(touchEvent.points) do
        print("name", name)
        self:checkBtnFire(id, point,name)
    end
end

function FightPlayer:onEnter()

end

function FightPlayer:onExit()
    self:removeAllSchs()
end

function FightPlayer:onResultFail()
    self:removeAllSchs()
end

function FightPlayer:onResultWin()
    self:removeAllSchs()
end

function FightPlayer:removeAllSchs()
    if tempChangeGoldHandler then 
        scheduler.unscheduleGlobal(tempChangeGoldHandler)
    end
    if resumeDefenceHandler then 
        scheduler.unscheduleGlobal(resumeDefenceHandler)
    end
    if self.btnFireSch then
        scheduler.unscheduleGlobal(self.btnFireSch)
    end
end

return FightPlayer

