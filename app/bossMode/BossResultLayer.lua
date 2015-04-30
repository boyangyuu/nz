local BossResultLayer = class("BossResultLayer",function()
	return display.newLayer()
end)

function BossResultLayer:ctor(properties)
	self.properties = properties
	self:initUI()
end

function BossResultLayer:initUI()
	local layerBtn = display.newLayer()
	layerBtn:setContentSize(200, 100)
	layerBtn:setPosition(610,10)
	self:addChild(layerBtn,300)


	self:setPosition(-130,80)
	local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan.ExportJson"
    manager:addArmatureFileInfo(src)
    local plist = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan0.plist"
    local png   = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan0.png"
    display.addSpriteFrames(plist, png)  

    arm = ccs.Armature:create("wxboss_jiesuan")
    arm:setAnchorPoint(1,1)
    addChildCenter(arm, self)
    arm:getAnimation():play("kaishi" , -1, 0)

    local numImg = "bossjs_0"..self.properties.waveIndex..".png"
    local skin = ccs.Skin:createWithSpriteFrameName(numImg)
    arm:getBone("bossjs_01"):addDisplay(skin, 1)
    arm:getBone("bossjs_01"):changeDisplayWithIndex(1, true)

    arm:getAnimation():setMovementEventCallFunc(
        function ( armatureBack,movementType,movementId ) 
            if movementType == ccs.MovementEventType.complete then
                arm:getAnimation():play("chixu" , -1, 1)
                layerBtn:setTouchEnabled(true)
                addBtnEventListener(layerBtn, function(event)
					if event.name == 'began' then
						return true
					elseif event.name == 'ended' then
						self:onClickBtnGet()
					end
				end)
            end
        end)
end

function BossResultLayer:onClickBtnGet()
	print("aaa")
	ui:closePopup("BossResultLayer")
end

return BossResultLayer