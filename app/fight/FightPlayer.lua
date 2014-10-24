--import
import("..includes.functionUtils")
local scheduler = require("framework.scheduler")
local ViewUtils = import("..ViewUtils")
local GunModel = import(".GunModel")
local Hero = import(".Hero")
local GunView = import(".GunView")
local FocusView = import(".FocusView")
local MapView = import(".MapView")

local KFightConfig = {
    scaleMoveBg = 0.3, 
    scaleMoveFocus = 1.3,
    scaleMoveGun = 1.3, 
}

local FightPlayer = class("FightPlayer", function ()
	return display.newLayer()
end)


function FightPlayer:ctor()
    --model 
    self.hero = app:getInstance(Hero)
    self.gunView = GunView.new()
    self.focusView = FocusView.new()
    self.mapView = MapView:new()

    --instance
    self.gunBtnPressed = false

    --ui
    self:initUI()

    --帧事件
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()    
end

function FightPlayer:initUI()
    self:loadCCS()
	
	--touch area
	self:initTouchArea()

end

function FightPlayer:loadCCS()
    --load fightUI
    cc.FileUtils:getInstance():addSearchPath("res/Fight/map")  
    cc.FileUtils:getInstance():addSearchPath("res/Fight/fightLayer/ui/zhandou_demo_1")
    local node = cc.uiloader:load("zhandou_demo_1.ExportJson")
    self.ui = node
    self:addChild(node)

    --load map
    local layerBg = cc.uiloader:seekNodeByName(self, "layerBg")
    ViewUtils:addChildCenter(self.mapView, layerBg) 

    --load gun 
    local layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    layerGun:addChild(self.gunView)

    --load focus
    local focusNode = cc.uiloader:seekNodeByName(self, "fucusNode")
    addChildCenter(self.focusView, focusNode)
end

function FightPlayer:initTouchArea()
	--control    
    local layerTouch = cc.uiloader:seekNodeByName(self, "layerTouch")
    layerTouch:setTouchEnabled(true)  
    local layerControl = display.newScale9Sprite()
    layerControl:setContentSize(cc.size(936, 640))
    layerControl:setPosition(0, 0)
    layerControl:setAnchorPoint(0, 0)
    layerControl:setOpacity(0)
    layerTouch:addChild(layerControl)
    layerControl:setTouchEnabled(true)
    layerControl:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    layerControl:setTouchSwallowEnabled(false)
    layerControl:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        printf("%s %s [TARGETING]", "button1", event.name)
        if event.name == "ended" or event.name == "cancelled" then
            print("-----------------------------")
        elseif event.name == "moved" then 
            self:onTouchMoved(event)
            print("")
        end
        return true
    end)    

    --btn
    self:initFireBtn()
end

function FightPlayer:initFireBtn()
    --btnfire    
    local btnFire = cc.uiloader:seekNodeByName(self, "btnFire")
    dump(btnFire, "btnFire")
    btnFire:setTouchEnabled(true)
    btnFire:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)    
    btnFire:setTouchSwallowEnabled(true)
    btnFire:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        printf("%s %s [TARGETING]", "btnFire", event.name)
        if event.name == "began" or event.name == "added" then
            print("onButtonClicked")
            self.gunBtnPressed = true
            --动画
            if btnFire:getChildByTag(1) then 
                btnFire:removeChildByTag(1)
            end
            local src = "fight/fightLayer/effectBtnFire/effect_gun_kaiqiang.ExportJson"
            local armature = getArmature("effect_gun_kaiqiang", src)
            armature:getAnimation():playWithIndex(0 , -1, 0)
            local function animationEvent(armatureBack,movementType,movementID)
                armature:removeFromParent()
            end
            armature:getAnimation():setMovementEventCallFunc(animationEvent)
            addChildCenter(armature, btnFire)
            armature:setTag(1)            
        end
        if event.name == "cancelled" or event.name == "ended" then
            print("onButtonRelease")
            self:onCancelledFire()
            self.gunBtnPressed = false
        end        
        return true
    end)

end

----attack----
function FightPlayer:tick(dt)
    --gun
    if self:canGunShot() then 
        self:fire()
    end
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
    self.gunView:playFire()

    --focus
    self.focusView:playFire()
end

function FightPlayer:onCancelledFire()
    self.focusView:stopFire()
end

----touch----
function FightPlayer:printTouch(event)
    print("printTouch:", event.name)
    for id, point in ipairs(event.points) do
        local str = string.format("id: %s, x: %0.2f, y: %0.2f", point.id, point.x, point.y)
        print(str)
    end
end

function FightPlayer:onTouchMoved(event)
    -- dump(event, "onTouchMoved")
    local  x, y, prevX, prevY 
    for i,v in pairs(event.points) do
        x, y, prevX, prevY = v.x, v.y, v.prevX, v.prevY
        -- print("onTouchMoved", i .. " : " .. x ..";" .. y)
    end
    local offsetX = x - prevX 
    local offsetY = y - prevY

    --处理瞄准
    self:moveFocus(offsetX, offsetY)
    
    --处理滑屏
    self:moveBgLayer(offsetX, offsetY)

    return true
end

function FightPlayer:moveFocus(offsetX, offsetY)
    local focusNode = cc.uiloader:seekNodeByName(self, "fucusNode")
    local xOri, yOri = focusNode:getPosition()
    local scale = KFightConfig.scaleMoveFocus
    focusNode:setPosition(xOri + offsetX*scale, yOri + offsetY*scale)
    self:justFocusPos(focusNode)
    local x, y = focusNode:getPosition()
    self:moveGun(x)
end

function FightPlayer:moveBgLayer(offsetX, offsetY)
    local layerBg = cc.uiloader:seekNodeByName(self, "layerBg")
    local xOri, yOri = layerBg:getPosition()
    local scale = KFightConfig.scaleMoveBg
    layerBg:setPosition(xOri + offsetX * scale, yOri + offsetY * scale)
    local x, y = layerBg:getPosition()
    print(x,y)
    self:justBgPos(layerBg)


end

function FightPlayer:moveGun(x) 
    local layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    layerGun:setPositionX(x + 280)   --todo 需要改为美术资源提供
end

function FightPlayer:justBgPos(node)
    local layerBg = cc.uiloader:seekNodeByName(self, "layerBg")
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

