local BossResultLayer = class("BossResultLayer",function()
	return display.newLayer()
end)

function BossResultLayer:ctor(properties)
	self.chapterIndex = properties.chapterIndex
	self.waveIndex = properties.waveIndex
	self.properties = properties
	self:loadCCS()
	self:initUI()
end

function BossResultLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/BossMode/ResultLayer")
    local controlNode = cc.uiloader:load("bossResultLayer_1.ExportJson")
    self:addChild(controlNode,100)
end

function BossResultLayer:getAwards()
	local bossModeModel = md:getInstance("BossModeModel")
	local info = bossModeModel:getChapterModel(self.chapterIndex,self.waveIndex)
	assert(info, "getChapterModel is nil")

	local data = getUserData()
	if self.chapterIndex < data.bossMode.chapterIndex then
		table.remove(info,1)
	elseif self.chapterIndex == data.bossMode.chapterIndex then
		if self.waveIndex <= data.bossMode.waveIndex then
			table.remove(info,1)
		end
	end	
	return info
end

function BossResultLayer:initUI()
	local layerBtn = cc.uiloader:seekNodeByName(self, "layerBtn")
	local awardsTable = self:getAwards()
	local numTable = {}
	numTable["num1"] = cc.uiloader:seekNodeByName(self, "num1")
	numTable["num2"] = cc.uiloader:seekNodeByName(self, "num2")
	numTable["num3"] = cc.uiloader:seekNodeByName(self, "num3")
	numTable["num4"] = cc.uiloader:seekNodeByName(self, "num4")
	local waveNum    = cc.uiloader:seekNodeByName(self, "waveNum")
	for k,v in pairs(numTable) do
		v:setVisible(false)
	end

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

	for i=1,#awardsTable do
		local award = awardsTable[i]
		dump(award)
		for k,v in pairs(award) do
			numTable["num"..i]:setString("X"..v)
		    local icon = "icon_"..k..".png"
		    local skinIcon = ccs.Skin:createWithSpriteFrameName(icon)
		    armature:getBone("icon_"..i):addDisplay(skinIcon, 1)
		    armature:getBone("icon_"..i):changeDisplayWithIndex(1, true)
		end
	end

    waveNum:setString("d"..self.waveIndex.."b")
    local action = cc.MoveBy:create(0.3, cc.p(0,-100))
    waveNum:runAction(action)

    armature:getAnimation():setMovementEventCallFunc(
        function (armatureBack,movementType,movementId)
            if movementType == ccs.MovementEventType.complete then
                armature:getAnimation():play("chixu" , -1, 1)
				for k,v in pairs(numTable) do
					v:setVisible(true)
				end
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
	ui:closePopup("BossResultLayer")

	--closefunc
	if self.properties["closeFunc"] then 
		self.properties["closeFunc"]()
	end
end

return BossResultLayer