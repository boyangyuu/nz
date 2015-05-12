local JujiResultLayer = class("JujiResultLayer",function()
	return display.newLayer()
end)

function JujiResultLayer:ctor(properties)
	self.groupIndex = properties.groupIndex
	self.properties = properties
	self:loadCCS()
	self:initUI()
end

function JujiResultLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/BossMode/ResultLayer")
    local controlNode = cc.uiloader:load("bossResultLayer_1.ExportJson")
    self:addChild(controlNode,100)
end

function JujiResultLayer:getAwards()
	local jujiModeModel = md:getInstance("JujiModeModel")
	local info = jujiModeModel:getAwardTable(self.groupIndex)
	assert(info, "getAwardTable is nil")

	-- local data = getUserData()
	-- if self.chapterIndex < data.bossMode.chapterIndex then
	-- 	table.remove(info,1)
	-- elseif self.chapterIndex == data.bossMode.chapterIndex then
	-- 	if self.waveIndex <= data.bossMode.waveIndex then
	-- 		table.remove(info,1)
	-- 	end
	-- end	
	
	return info
end

function JujiResultLayer:initUI()
	local layerBtn = cc.uiloader:seekNodeByName(self, "layerBtn")
	self.awardsTable = self:getAwards()
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

	for i=1,#self.awardsTable do
		local award = self.awardsTable[i]
		dump(award)
		for k,v in pairs(award) do
			numTable["num"..i]:setString("X"..v)
		    local icon = "icon_"..k..".png"
		    local skinIcon = ccs.Skin:createWithSpriteFrameName(icon)
		    armature:getBone("icon_"..i):addDisplay(skinIcon, 1)
		    armature:getBone("icon_"..i):changeDisplayWithIndex(1, true)
		end
	end

    waveNum:setString("d"..self.groupIndex.."b")
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

function JujiResultLayer:onClickBtnGet()
	local userModel = md:getInstance("UserModel")
	local propModel = md:getInstance("PropModel")
	for i=1,#self.awardsTable do
		local award = self.awardsTable[i]
		for k,v in pairs(award) do
			if k == "healthBag" then
				propModel:addProp("hpBag",v)
			elseif k == "lei" then
				propModel:addProp("lei",v)
			elseif k == "money" then
				userModel:addMoney(v)
			end
		end
	end

	ui:closePopup("JujiResultLayer")

	--closefunc
	if self.properties["closeFunc"] then 
		self.properties["closeFunc"]()
	end
end

return JujiResultLayer