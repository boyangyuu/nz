--import
local scheduler = require("framework.scheduler")
local GunModel = import(".GunModel")
local Hero = import(".Hero")
local GunView = import(".GunView")

--k
local kBgMap = 10001
local kScaleBg = 2

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

    --btn area
    self:initBtnArea()
end

function FightPlayer:loadCCS()
    --load fightUI
    cc.FileUtils:getInstance():addSearchPath("res/fight/gun")
    cc.FileUtils:getInstance():addSearchPath("res/fight/map")
    cc.FileUtils:getInstance():addSearchPath("res/fight/fightLayer")
    local node = cc.uiloader:load("zhandou_demo_1.ExportJson")
    self.ui = node
    self:addChild(node)

    --load bg
    local layerBg = cc.uiloader:seekNodeByName(self, "layerBg")
    local level = "" 
    local bgMap = display.newSprite("map_demo"..level..".png") --todo
    bgMap:setTag(kBgMap)
    layerBg:setAnchorPoint(cc.p(0.0, 0.0))
    layerBg:addChild(bgMap)             --todo addchlldCenter

    --load gun 
    local layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    layerGun:addChild(self.gunView)
end

function FightPlayer:initTouchArea()
	--滑动层    
    local layerTouch = cc.uiloader:seekNodeByName(self, "layerTouch")
    layerTouch:setTouchEnabled(true)
    layerTouch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
        if event.name == "moved" then 
            return self:onTouchMoved(event)
        end
        return true
    end)   
end

function FightPlayer:initBtnArea()
    local layerBtn = cc.uiloader:seekNodeByName(self, "layerBtn")
    layerBtn:setTouchEnabled(true)
    layerBtn:setTouchSwallowEnabled(false)
    local btnFire = cc.uiloader:seekNodeByName(self, "btnFire")


    btnFire:onButtonPressed(function(event)
        print("onButtonClicked")
        self.gunBtnPressed = true
        --动画
        if btnFire:getChildByTag(1) then 
            btnFire:removeChildByTag(1)
        end
        local src = "fight/fightLayer/effectBtnFire/effect_gun_kaiqiang.ExportJson"
        local armature = app:getArmature("effect_gun_kaiqiang", src)
        armature:getAnimation():playWithIndex(0 , -1, 0)
        local function animationEvent(armatureBack,movementType,movementID)
            armature:removeFromParent()
        end
        armature:getAnimation():setMovementEventCallFunc(animationEvent)
        btnFire:addChild(armature)
        armature:setTag(1)
    end)    

    btnFire:onButtonRelease(function (event)
        print("onButtonRelease")
        self.gunBtnPressed = false
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
        and self.gunView
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
    print("fire")
    self.gunView:playFire()

    --target

    --..
end


----move----
function FightPlayer:onTouchMoved(event)
    local eventName, x, y, prevX, prevY = event.name, event.x, event.y, event.prevX, event.prevY
--    print("onTouchFocusArea", x ..";" .. y)
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
    local bgMap = layerBg:getChildByTag(kBgMap)
    local x, y = layerBg:getPosition()
    self:justBgPos(layerBg)

end

function FightPlayer:moveGun(x) 
    local layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    layerGun:setPositionX(x + 280)   --todo 需要改为美术资源提供
end

function FightPlayer:justBgPos(node)
    local layerBg = cc.uiloader:seekNodeByName(self, "layerBg")
    local bgMap = layerBg:getChildByTag(kBgMap)    
    local w, h = bgMap:getContentSize().width * kScaleBg, 
        bgMap:getContentSize().height * kScaleBg      
    local xL = (w - display.width) / 2  
    local yL = (h - display.height) / 2 
    local x, y = node:getPosition()
    
    --x
    if x <= display.width/2 - xL then
        x = display.width/2 - xL
    elseif x >= display.width/2 + xL then 
        x = display.width/2 + xL
    end

    --y
    if y <= display.height/2 - yL then
        y = display.height/2 - yL
    elseif y >= display.height/2 + yL then 
        y = display.height/2 + yL
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

