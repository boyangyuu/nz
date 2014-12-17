--import
import("..includes.functionUtils")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Actor         = import(".Actor")
local Guide         = import("..guide.GuideModel")
local Hero          = import(".Hero")
local Fight         = import(".Fight")

local GunView       = import(".GunView")
local FocusView     = import(".FocusView")
local MapView       = import(".MapView")
local HeroView      = import(".HeroView")

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
    self.fight      = app:getInstance(Fight)   
    self.fight:refreshData(properties) 
    self.hero       = app:getInstance(Hero)
    self.guide      = app:getInstance(Guide)
     

    --views
    self.focusView      = FocusView.new()
    self.mapView        = MapView.new()
    self.gunView        = GunView.new()
    self.heroView       = HeroView.new()
    self.touchIds       = {} --todo

    --ui
    self:initUI()

    --事件
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Hero.SKILL_DEFENCE_BEHURT_EVENT, handler(self, self.defenceBeHurtCallBack))
        :addEventListener(Hero.KILL_EVENT, handler(self, self.onHeroKill))
        :addEventListener(Fight.PAUSE_SWITCH_EVENT, handler(self, self.setPause))
        :addEventListener("changeGold", handler(self, self.changeGoldCount)) 
    self:scheduleUpdate()
    self:setNodeEventEnabled(true)
    
    ui:showPopup("DialogLayer",{},{anim = false})

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

function FightPlayer:fitArmoured()
    self:setControlsVisible()
    self.hero:dispatchEvent({name = Hero.SKILL_ARMOURED_START_EVENT})

end
local btnsIsShow = true
function FightPlayer:setControlsVisible()
    print("FightPlayer:setControlsVisible()")
    btnsIsShow = not btnsIsShow
    
    --gun
    self.layerGun:setVisible(btnsIsShow)
    
    --btn
    self.btnDefence:setVisible(btnsIsShow)
    self.btnRobot:setVisible(btnsIsShow)
    self.btnChange:setVisible(btnsIsShow)
    self.btnLei:setVisible(btnsIsShow)
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

    --load heroView
    local layerHero = cc.uiloader:seekNodeByName(self, "layerHero")
    addChildCenter(self.heroView, layerHero)
    self.heroView:setPosition(0, 0)

    --load focus
    self.focusNode = cc.uiloader:seekNodeByName(self, "fucusNode")
    addChildCenter(self.focusView, self.focusNode)

    --touch area
    self:initTouchArea()

    --res
    self:addArmatureFile()

    --guide
    scheduler.performWithDelayGlobal(handler(self, self.initGuide), 0.1)
end

--启动盾牌恢复
local resumeDefenceHandler = nil
function FightPlayer:launchDefenceResume()
    self.labelDefenceResume:setVisible(true)
    self:loadDefenceResumeBar()

    local function tick(dt)
        local t = self.defenceResumeLoadingBar:getPercentage()
        local t1 = tonumber(self.labelDefenceResume:getString())
        if 0 == t1 then
            scheduler.unscheduleGlobal(resumeDefenceHandler)
            self.defenceResumeLoadingBar:removeFromParent()
            self.labelDefenceResume:setVisible(false)
            self.labelDefenceResume:setString(90)
            self.hero:dispatchEvent({name = Hero.SKILL_DEFENCE_RESUME_EVENT, isResumeDefence = false})
            return
        end
        self.labelDefenceResume:setString(t1 - 1)
        self.defenceResumeLoadingBar:setPercentage(t - 1)
    end

    resumeDefenceHandler = scheduler.scheduleGlobal(tick, 0.03)
end

--盾牌受伤回调,盾牌血条变化方法
function FightPlayer:defenceBeHurtCallBack(event)
    self.loadingBarDefenceHp:setPercent(event.damage)
    if 100 <= event.damage then
        self.loadingBarDefenceHp:setPercent(0)
        self:launchDefenceResume()
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
    self.btnJu:setTouchEnabled(true)
    self.btnJu:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
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

        isTouch = self:checkBtnJu(point)
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
        self:fitArmoured()
    end
    return isTouch
end

function FightPlayer:checkbtnDefence(point)
    local rect = self.btnDefence:getCascadeBoundingBox()
    local isTouch = cc.rectContainsPoint(rect, point)
    if isTouch then
        print("-----------fit defence")
        self.hero:dispatchEvent({name = Hero.SKILL_DEFENCE_START_EVENT})
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
        local destPos = cc.p(self.focusNode:getPositionX() + w/2, 
            self.focusNode:getPositionY() + h/2)
        self.hero:dispatchEvent({name = Hero.SKILL_GRENADE_START_EVENT,throwPos = destPos})
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
    local rect = self.btnJu:getCascadeBoundingBox()  
    local isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        --切换狙击镜
        print("-----------switch ju")
        self:setControlsVisible()
        self.hero:dispatchEvent({name = Hero.GUN_SWITCH_JU_EVENT})
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
        self.hero:dispatchEvent({name = Hero.GUN_FIRE_EVENT,focusRangeNode = focusRangeNode})
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

function FightPlayer:addArmatureFile()
    --all enemys
    local enemyImgs = 
    {"anim_enemy_002", "jinzhanb", "zibaob", "boss01","boss02", "dunbing", 
        "sanbing01", "daodan", "zpbing"}
    local function dataLoaded(percent)
        print(" dataLoaded() percent:"..percent)
    end    

    local manager = ccs.ArmatureDataManager:getInstance()
    for i,v in ipairs(enemyImgs) do
        local src = "res/Fight/enemys/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, dataLoaded)
    end

    --all uiAnims
    local uiImgs = {"baotou", "hjwq", "huanzidan", "ruodiangj", "tanhao",
        "avatarhit", "blood1", "blood2", "gold", "shoulei"}
    for i,v in ipairs(uiImgs) do
        local src = "res/Fight/uiAnim/"..v.."/"..v..".csb"
        manager:addArmatureFileInfoAsync(src, dataLoaded)
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
    if tempChangeGoldHandler then 
        scheduler.unscheduleGlobal(tempChangeGoldHandler)
    end
    if resumeDefenceHandler then 
        scheduler.unscheduleGlobal(resumeDefenceHandler)
    end
end

return FightPlayer

