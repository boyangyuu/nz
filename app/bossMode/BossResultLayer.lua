local BossResultLayer = class("BossResultLayer",function()
	return display.newLayer()
end)

function BossResultLayer:ctor()
	self.chapterIndex = 1
	self.waveIndex = 2
	self:loadCCS()
	self:initUI()
end

function BossResultLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/BossMode/ResultLayer")
    local controlNode = cc.uiloader:load("bossResultLayer_1.ExportJson")
    self:addChild(controlNode,100)
end

function BossResultLayer:initUI()
	local layerBtn     = cc.uiloader:seekNodeByName(self, "layerBtn")
	local partNum      = cc.uiloader:seekNodeByName(self, "partNum")
	local healthBagNum = cc.uiloader:seekNodeByName(self, "healthBagNum")
	local leiNum 	   = cc.uiloader:seekNodeByName(self, "leiNum")
	local moneyNum     = cc.uiloader:seekNodeByName(self, "moneyNum")
	partNum:setVisible(false)
	healthBagNum:setVisible(false)
	leiNum:setVisible(false)
	moneyNum:setVisible(false)

	local bossModeModel = md:getInstance("BossModeModel")
	local info = bossModeModel:getChapterModel(self.chapterIndex,self.waveIndex)
		dump(info)
	partNum:setString("X"..info["part"])
	healthBagNum:setString("X"..info["healthBag"])
	leiNum:setString("X"..info["lei"])
	moneyNum:setString("X"..info["money"])

	local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan.ExportJson"
    manager:addArmatureFileInfo(src)
    local plist = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan0.plist"
    local png   = "res/BossMode/wxboss_jiesuan/wxboss_jiesuan0.png"
    display.addSpriteFrames(plist, png)  

    local armature = ccs.Armature:create("wxboss_jiesuan")
    armature:setPosition(display.cx,display.cy)
    self:addChild(armature)
    armature:getAnimation():play("kaishi" , -1, 0)

    local numImg = "bossjs_0"..self.waveIndex..".png"
    local skin = ccs.Skin:createWithSpriteFrameName(numImg)
    armature:getBone("bossjs_01"):addDisplay(skin, 1)
    armature:getBone("bossjs_01"):changeDisplayWithIndex(1, true)

    armature:getAnimation():setMovementEventCallFunc(
        function (armatureBack,movementType,movementId)
            if movementType == ccs.MovementEventType.complete then
                armature:getAnimation():play("chixu" , -1, 1)
				partNum:setVisible(true)
				healthBagNum:setVisible(true)
				leiNum:setVisible(true)
				moneyNum:setVisible(true)
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