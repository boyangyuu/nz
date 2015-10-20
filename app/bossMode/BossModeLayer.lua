local BossModeConfigs = import(".BossModeConfigs")

local BossModeLayer = class("BossModeLayer", function()
    return display.newLayer()
end)

function BossModeLayer:ctor(properties)
	self:loadCCS()
	self:initUI()

	self.bossModeModel = md:getInstance("BossModeModel")
	self.weaponListModel = md:getInstance("WeaponListModel")
	self.inlayModel 	 = md:getInstance("InlayModel")
	self.userModel        = md:getInstance("UserModel")
	self.buyModel = md:getInstance("BuyModel")

	cc.EventProxy.new(self.bossModeModel , self)
     :addEventListener(self.bossModeModel.REFRESH_BOSSLAYER_EVENT, handler(self, self.refreshUI))

	self.choseChapter = 1
	if properties.chapterIndex then
		self.choseChapter = properties.chapterIndex
	end
	self.toward = nil
	self:refreshUI()
end

function BossModeLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/BossMode/wuxianboss")
    local controlNode = cc.uiloader:load("wuxianboss.json")
    self:addChild(controlNode)
end

function BossModeLayer:initUI()
	self.panelMain = cc.uiloader:seekNodeByName(self, "panelMain")
	self.panelDown = cc.uiloader:seekNodeByName(self, "panelDown")

	local panelWeapon = cc.uiloader:seekNodeByName(self, "panelWeapon")
	self.panelChapter = cc.uiloader:seekNodeByName(self.panelMain, "panelChapter")

	--gun
	self.panelGun = cc.uiloader:seekNodeByName(self.panelMain, "panelGun")
	self.skillIcon = cc.uiloader:seekNodeByName(self.panelMain, "skillIcon")

	self.partsImg = {}
	for i=1,5 do
		self.partsImg[i] = cc.uiloader:seekNodeByName(panelWeapon, "panel0"..i)
	end

	--btn
	self.btnGet = cc.uiloader:seekNodeByName(self, "btnGet")
	local btnStart = cc.uiloader:seekNodeByName(self, "btnStart")
	self.btnPre = cc.uiloader:seekNodeByName(self, "btnPre")
	self.btnNext = cc.uiloader:seekNodeByName(self, "btnNext")
	self.btnNext:setTouchEnabled(true)
	self.btnPre:setTouchEnabled(true)
	btnStart:setTouchEnabled(true)
	self.btnGet:setTouchEnabled(true)
	addBtnEventListener(self.btnNext, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:onClickBtnNext()
		end
	end)
	addBtnEventListener(self.btnPre, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:onClickBtnPre()
		end
	end)
	addBtnEventListener(btnStart, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:onClickBtnStart()
		end
	end)
	addBtnEventListener(self.btnGet, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:onClickBtnGet()
		end
	end)
end

function BossModeLayer:refreshUI(event)
	self.btnPre:setVisible(true)
	self.btnNext:setVisible(true)
	if self.bossModeModel:checkPre(self.choseChapter-1) == false then
		self.btnPre:setVisible(false)
	end
	if self.bossModeModel:checkNext(self.choseChapter+1) == false then
		self.btnNext:setVisible(false)
	end

	local actionDown = cc.MoveBy:create(0.2, cc.p(0,-200))
	local actionUp = cc.MoveBy:create(0.2, cc.p(0,200))
 	local actionNext = cc.MoveBy:create(0.2, cc.p(-1136,0))
	local actionNextChange = cc.MoveBy:create(0, cc.p(1136*2,0))
 	local actionPre = cc.MoveBy:create(0.2, cc.p(1136,0))
	local actionPreChange = cc.MoveBy:create(0, cc.p(-1136*2,0))

	if self.toward == "next" then
		self.panelMain:runAction(
			transition.sequence({actionNext, actionNextChange,
				cc.CallFunc:create(function()
					self:refreshContent()
					end),actionNext}))
		self.panelDown:runAction(
			transition.sequence({actionDown,actionUp}))
	elseif self.toward == "pre" then
		self.panelMain:runAction(
			transition.sequence({actionPre, actionPreChange,
				cc.CallFunc:create(function()
					self:refreshContent()
					end),actionPre}))
		self.panelDown:runAction(
			transition.sequence({actionDown,actionUp}))

	else
		self:refreshContent()
	end
end

function BossModeLayer:refreshContent()

	self.choseInfo = self.bossModeModel:getInfo(self.choseChapter)

	--gun
	self.panelGun:removeAllChildren()
	local weaponId = self.choseInfo["weaponId"]
	local imgName = self.weaponListModel:getWeaponImgByID(weaponId)
	local weaponImg = display.newSprite("#icon_"..imgName..".png")
	weaponImg:setRotation(10)
	weaponImg:setScale(0.85)
	addChildCenter(weaponImg, self.panelGun)

	local gunArmature = ccs.Armature:create("icon"..imgName.."_tx")
	gunArmature:setScale(0.78)
    addChildCenter(gunArmature,self.panelGun)
    gunArmature:getAnimation():play("bosschixu" , -1, 1)

	self.skillIcon:removeAllChildren()
	local skillIconImg = display.newSprite("#skill2_"..imgName..".png")
	skillIconImg:setScale(0.8)
	addChildCenter(skillIconImg, self.skillIcon)

	--
	self.panelChapter:removeAllChildren()
    local bossBtnNode = cc.uiloader:load("res/BossMode/wuxianboss/chapter"..self.choseChapter..".json")

    local btnChapter = {}
    for i=1,5 do
		btnChapter[i] = cc.uiloader:seekNodeByName(bossBtnNode, "part"..i)
		btnChapter[i]:setTouchEnabled(true)
		addBtnEventListener(btnChapter[i], function(event)
			if event.name == 'began' then
				return true
			elseif event.name == 'ended' then
				self:onClickBtnAward(i)
			end
		end)
    end
    self.panelChapter:addChild(bossBtnNode)

    --btn
    self.btnGet:setButtonEnabled(true)
    local isGetWeapon = self.weaponListModel:isWeaponExist(self.choseInfo["weaponId"])
    if isGetWeapon then
    	self.btnGet:setButtonEnabled(false)
    end

    --lingjian
    local alreadyGet = self.bossModeModel:getAlreadyWave(self.choseChapter)
 	for k,v in pairs(self.partsImg) do
    	local lingjianImg = display.newSprite("#icon_"..imgName.."0"..k..".png")
    	lingjianImg:setColor(cc.c3b(100, 100, 100))
    	if k <= alreadyGet then
			lingjianImg:setColor(cc.c3b(255, 255, 255))
    	end
    	if isGetWeapon then
    		lingjianImg:setColor(cc.c3b(255, 255, 255))
    	end

    	lingjianImg:setScale(0.75)
    	addChildCenter(lingjianImg,v)
    end
end

function BossModeLayer:onClickBtnAward(i)
	self.bossModeModel = md:getInstance("BossModeModel")
	local awardsTable = self.bossModeModel:getChapterModel(self.choseChapter,i)
	local reward = {}
	for i=1,#awardsTable do
		local award = awardsTable[i]
		for k,v in pairs(award) do
			reward[k] = v
		end
	end
	local bujianName = {LanguageManager.getStringForKey("string_hint12"), LanguageManager.getStringForKey("string_hint13"),
					LanguageManager.getStringForKey("string_hint14"), LanguageManager.getStringForKey("string_hint15"), LanguageManager.getStringForKey("string_hint16")}
	local msg = LanguageManager.getStringForKey("string_hint17").. (bujianName[i] or 0)
	.. LanguageManager.getStringForKey("string_hint18")..(reward["lei"] or 0)
	..LanguageManager.getStringForKey("string_hint19")..(reward["healthBag"] or 0)
	..LanguageManager.getStringForKey("string_hint20")..(reward["money"] or 0)

	ui:showPopup("commonPopup",
	 {type = "style1",content = msg},
	 {opacity = 0})
end

function BossModeLayer:onClickBtnClose()
	ui:closePopup("BossModeLayer")
end

function BossModeLayer:onClickBtnNext()
	self.toward = "next"
	self.choseChapter = self.choseChapter + 1
	self.bossModeModel:refreshInfo()
end

function BossModeLayer:onClickBtnPre()
	self.toward = "pre"
	self.choseChapter = self.choseChapter - 1
	self.bossModeModel:refreshInfo()
end

function BossModeLayer:onClickBtnStart()
	local data = getUserData()
	if self.choseChapter > data.bossMode.chapterIndex then
		ui:showPopup("commonPopup",
			 {type = "style1",content = LanguageManager.getStringForKey("string_hint21")},
			 {opacity = 100})
		return
	end
	local weaponListModel = md:getInstance("WeaponListModel")
	local isRpgExist = weaponListModel:isWeaponExist(7)
	local isM134Exist = weaponListModel:isWeaponExist(8)
	local isHQLExist = weaponListModel:isWeaponExist(9)
	local isBJExist = weaponListModel:isWeaponExist(9)
	local isRpgLevelFull = weaponListModel:isFull(7)
	local isM134LevelFull = weaponListModel:isFull(8)
	local isRpgSatisfied = isRpgExist and isRpgLevelFull
	local isM134Satisfied = isM134Exist and isM134LevelFull
	local data = {type = "m134"}
	if not(isRpgSatisfied or isM134Satisfied or isHQLExist or isBJExist) then
		ui:showPopup("BossAdvisePopup",
	        data,
	        {animName = "scale"})
		return
	else
		local data = getUserData()
		local isDone = self.userModel:getUserLevel() >= 5
		if isDone and table.nums(data.inlay.inlayed) == 0 then
			ui:showPopup("commonPopup",
				 {type = "style5",
				 callfuncQuickInlay = handler(self,self.onClickQuickInlay),
				 callfuncGoldWeapon = handler(self,self.onClickGoldWeapon),
				 callfuncClose = handler(self,self.onClickCloseInlayNoti)})
		else
			self:startGame()
		end
	end

end

function BossModeLayer:onClickGoldWeapon()
	function confirmPopGoldGift()
		self.inlayModel:equipAllInlays()
		self:startGame()
	end

	local goldweaponNum = self.inlayModel:getGoldWeaponNum()
	if goldweaponNum > 0 then
        self.inlayModel:equipAllInlays()
        self:startGame()
	else
		if device.platform == "ios" then
			ui:showPopup("commonPopup",
    				 {type = "style2", content = LanguageManager.getStringForKey("string_hint22")},
    				 {opacity = 155})
			return
		end
		ui:showPopup("StoneBuyPopup",
	         {name = LanguageManager.getStringForKey("string_hint31"),
	         price = 40,
	         onClickConfirm = confirmPopGoldGift},
	         {animName = "moveDown", opacity = 150})
    end
end

function BossModeLayer:onClickQuickInlay()
	self.inlayModel:equipAllInlays()
	self:startGame()
end

function BossModeLayer:onClickCloseInlayNoti()
	self:startGame()
end

function BossModeLayer:startGame()
	local fightData = {groupId = 50, levelId = 1,
		fightType = "bossFight", chapterIndex = self.choseChapter}
	ui:changeLayer("FightPlayer", {fightData = fightData})
end
function BossModeLayer:onClickBtnGet()
	self.bossModeModel:setWeapon(self.choseChapter)
	-- self.bossModeModel:refreshInfo()
	self:refreshContent()
	if self.btnGet:isButtonEnabled() then
		ui:showPopup("commonPopup",
			 {type = "style1",content = LanguageManager.getStringForKey("string_hint23")},
			 {opacity = 100})
	end
end

return BossModeLayer