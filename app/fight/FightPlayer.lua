--import
import("..includes.functionUtils")
local scheduler = require("framework.scheduler")
local Hero = import(".Hero")
local GunView = import(".GunView")
local FocusView = import(".FocusView")
local MapView = import(".MapView")
local HeroView = import(".HeroView")

local KFightConfig = {
    scaleMoveBg = 0.3, 
    scaleMoveFocus = 1.3,
    scaleMoveGun = 1.3, 
}

local FightPlayer = class("FightPlayer", function ()
	return display.newLayer()
end)

--定义事件

function FightPlayer:ctor()
    --instance
    self.hero = app:getInstance(Hero)
    self.focusView = app:getInstance(FocusView)
    self.mapView = MapView.new()
    self.gunView = GunView.new({id = 1})
    self.heroView = HeroView.new()
    self.gunBtnPressed = false
    self.touchs = {}
    
    --ui
    self:initUI()

    --事件
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()   
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

    --load gun 
    self.layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    self.layerGun:addChild(self.gunView)

    --load heroView
    local heroView = cc.uiloader:seekNodeByName(self, "self.heroView")
    addChildCenter(heroView, self.heroView)
    
    --load focus
    self.focusNode = cc.uiloader:seekNodeByName(self, "fucusNode")
    addChildCenter(self.focusView, self.focusNode)

    --touch area
    self:initTouchArea()

    --init panel
    self:initBar()    
    
end

function FightPlayer:initBar()
    --blood
    self.heroBlood = cc.uiloader:seekNodeByName(self, "heroBlood")
    local bloodValue = cc.uiloader:seekNodeByName(self.heroBlood, "bloodValue")
    local bloodBg = cc.uiloader:seekNodeByName(self.heroBlood, "bloodBg")
    local size = bloodBg:getContentSize()
    bloodValue:setLayoutSize(size.width, size.height)

    --gold
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
    drawBoundingBox(self, layerTouch, cc.c4f(0, 1.0, 0, 1.0))

    -- btn
    self:initBtns()
end

function FightPlayer:initBtns()
    --btnfire   
    self.btnFire = cc.uiloader:seekNodeByName(self, "btnFire")
    self.btnFire:setTouchEnabled(true)  
    self.btnFire:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)

    --btnChange
    self.btnChange = cc.uiloader:seekNodeByName(self, "btnChange")
    self.btnChange:setTouchEnabled(true)  
    self.btnChange:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
end

---- touch and btn----
function FightPlayer:onMutiTouchBegin(event)
    --check
    dump(event, "event onMutiTouchBegin")
    for id,point in pairs(event.points) do
        local isTouch = self:checkBtnFire(id, point, "begin")
        if isTouch then return true end

        isTouch = self:checkBtnChange(id, point, "begin")
        if isTouch then return true end        
    end
    return false
end

function FightPlayer:onMutiTouchEnd(event)
    for id,point in pairs(event.points) do
        if id == self.touchs["fire"] then
            self:checkBtnFire(nil, nil, "ended")
        end
    end
end

function FightPlayer:checkBtnChange(id,point,eventName)
    assert(id and point , "invalid params")
    local rect = self.btnChange:getCascadeBoundingBox()      
    isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        self.touchs["change"] = id 
        --换枪
        self.gunView:playChange(math.random(1, 2))
    end    
    return isTouch    
end

function FightPlayer:checkBtnFire(id,point,eventName)
    if eventName == "ended" then
        self:onCancelledFire()
        self.gunBtnPressed = false
        self.touchs["fire"] = nil 
        return
    end
    assert(id and point , "invalid params")
    local isTouch
    local rect = self.btnFire:getCascadeBoundingBox()      
    isTouch = cc.rectContainsPoint(rect, cc.p(point.x, point.y))     
    if isTouch then 
        self.touchs["fire"] = id 
        self.gunBtnPressed = true
        --动画
        if self.btnFire:getChildByTag(1) then 
            self.btnFire:removeChildByTag(1)
        end
        local src = "Fight/fightLayer/effectBtnFire/effect_gun_kaiqiang.ExportJson"
        local armature = getArmature("effect_gun_kaiqiang", src)
        armature:getAnimation():playWithIndex(0 , -1, 0)
        local function animationEvent(armatureBack,movementType,movementID)
            armature:removeFromParent()
        end
        armature:getAnimation():setMovementEventCallFunc(animationEvent)
        addChildCenter(armature, self.btnFire)
        armature:setTag(1)
    end    
    return isTouch
end

function FightPlayer:onTouchMoved(event)
    -- dump(event, "onTouchMoved")
    -- dump(self.touchs, "self.touchs")
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
    if self:canGunShot() then 
        self:fire()
    end

    --hero血量
    local bloodPer = self.hero:getHp() / self.hero:getMaxHp()
    local bloodValue = cc.uiloader:seekNodeByName(self.heroBlood, "bloodValue")
    local bloodBg = cc.uiloader:seekNodeByName(self.heroBlood, "bloodBg")
    local size = bloodBg:getContentSize()
    bloodValue:setLayoutSize(size.width * bloodPer, size.height)

    --hero各种状态

end

function FightPlayer:canGunShot()
    if  self.hero:canFire() 
        and self.gunBtnPressed
    then 
        return true 
    end

    return false
end
 
function FightPlayer:fire()
    --hero
    self.hero:fire()

    --gun
    if  self.gunView:canShot() then 
        self.gunView:fire()
        self.focusView:playFire()
    end

end

function FightPlayer:onCancelledFire()
    self.gunView:stopFire()
    self.focusView:stopFire()
end

----move----
function FightPlayer:printTouch(event)
    -- print("printTouch:", event.name)
    -- for id, point in ipairs(event.points) do
    --     local str = string.format("id: %s, x: %0.2f, y: %0.2f", point.id, point.x, point.y)
    --     print(str)
    -- end
end

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

    local xL = (w - display.width) / 2  
    local yL = (h - display.height) / 2 
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
    local offsetX, offsetY = node:getBoundingBox().width/2, 
            node:getBoundingBox().height/2 
    local x, y = node:getPosition()
    if x <= offsetX then
    	x = offsetX
    elseif x >= display.width - offsetX then 
        x = display.width - offsetX
    end
    
    if y <= offsetY then 
        y = offsetY 
    elseif y >= display.height - offsetY then 
        y = display.height - offsetY
    end
    node:setPosition(x, y)
end

return FightPlayer

