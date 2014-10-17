local KFightConfig = {
    scaleMoveBg = 0.3, 
    scaleMoveFocus = 1.3,
    scaleMoveGun = 1.3, 
}



local FightLayer = class("FightPlayer", function ()
	return display.newLayer()
end)


function FightLayer:ctor()
    self:initUI()
end

function FightLayer:initUI()
    self:loadCCS()
	
	--touch area
	self:initTouchArea()

    --btn area
    self:initBtnArea()
end

function FightLayer:loadCCS()
    --load fightUI
    cc.FileUtils:getInstance():addSearchPath("res/Fight/NewUi_1")
    local node = cc.uiloader:load("NewUi_1.ExportJson")
    self.ui = node
    self:addChild(node)

    --load bg  todo
    
    --load gun todo 需要封装为类
    
    --test
    -- cc.FileUtils:getInstance():addSearchPath("res/GameFightScene/")
    -- local node1 = cc.uiloader:load("publish/FightScene.json")
    -- self:addChild(node1)
    -- -- "hero" 是结点名称
    -- -- 1 是 "hero"这个结点下的第一个组件
    -- local hero = cc.uiloader:seekComponents(self, "hero", 1)
    -- hero:getAnimation():play("attack")    
    
end

function FightLayer:initTouchArea()
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

function FightLayer:initBtnArea()
    print("btnFire button click")
    local layerBtn = cc.uiloader:seekNodeByName(self, "layerBtn")
    layerBtn:setTouchEnabled(true)
    layerBtn:setTouchSwallowEnabled(false)
    local btnFire = cc.uiloader:seekNodeByName(self, "btnFire")

--    --anim todo 优化搜索和查找
    btnFire:onButtonClicked(function(event)
        print("btnFire button click")
--        ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("res/Fight/anim_btnFire02/anim_btnFire020.png", 
--            "res/Fight/anim_btnFire02/anim_btnFire020.plist", "res/Fight/anim_btnFire02/anim_btnFire02.ExportJson")
--        local armature = ccs.Armature:create("anim_btnFire02")
--        armature:getAnimation():play("Animation1")
--        btnFire:addChild(armature)
        cc.FileUtils:getInstance():addSearchPath("res/Fight/anim_btnFire02")
        local btnAnim = cc.uiloader:load("anim_btnFire02.ExportJson")
        btnAnim:getAnimation():play("Animation1")
        btnFire:addChild(btnAnim)

    end)    
end

function FightLayer:onTouchMoved(event)
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

function FightLayer:moveFocus(offsetX, offsetY)
    local focusNode = cc.uiloader:seekNodeByName(self, "focusGun")
    local xOri, yOri = focusNode:getPosition()
    local scale = KFightConfig.scaleMoveFocus
    focusNode:setPosition(xOri + offsetX*scale, yOri + offsetY*scale)
    self:justFocusPos(focusNode)
    local x, y = focusNode:getPosition()
    self:moveGun(x)
end

function FightLayer:moveBgLayer(offsetX, offsetY)
    local bgFightNode = cc.uiloader:seekNodeByName(self, "bgFight")
    local xOri, yOri = bgFightNode:getPosition()
    local scale = KFightConfig.scaleMoveBg
    bgFightNode:setPosition(xOri + offsetX * scale, yOri + offsetY * scale)
    self:justBgPos(bgFightNode)

end

function FightLayer:moveGun(x) 
    local layerGun = cc.uiloader:seekNodeByName(self, "layerGun")
    layerGun:setPositionX(x + 280)   --todo 需要改为美术资源提供
end

function FightLayer:justBgPos(node)
    local w, h = node:getBoundingBox().width, 
        node:getBoundingBox().height 
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

function FightLayer:justFocusPos(node)
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

return FightLayer

