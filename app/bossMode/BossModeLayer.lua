local BossModeConfigs = import(".BossModeConfigs")

local BossModeLayer = class("BossModeLayer", function()
    return display.newLayer()
end)

function BossModeLayer:ctor()
	self:loadCCS()
	self:initUI()

	self.bossModeModel = md:getInstance("BossModeModel")
	self.weaponListModel = md:getInstance("WeaponListModel")

	cc.EventProxy.new(self.bossModeModel , self)
     :addEventListener(self.bossModeModel.REFRESH_BOSSLAYER_EVENT, handler(self, self.refreshUI))

	self.choseChapter = 1
	self.toward = nil
	self:refreshUI()
end

function BossModeLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/BossMode")
    local controlNode = cc.uiloader:load("wuxianboss.ExportJson")
    self:addChild(controlNode)
end

function BossModeLayer:initUI()
	self.panelMain = cc.uiloader:seekNodeByName(self, "panelMain")
	self.panelDown = cc.uiloader:seekNodeByName(self, "panelDown")

	local panelWeapon = cc.uiloader:seekNodeByName(self, "panelWeapon")
	self.panelChapter = cc.uiloader:seekNodeByName(self, "panelChapter")

	--boss
	self.panelBoss = cc.uiloader:seekNodeByName(self, "panelBoss")

	--gun
	self.panelGun = cc.uiloader:seekNodeByName(panelWeapon, "panelGun")

	local parts = {"Danjia","Zhuti","Guan","Tuo","Miaozhun"}
	self.partsImg = {}
	for k,v in pairs(parts) do
		self.partsImg[v] = cc.uiloader:seekNodeByName(panelWeapon, "panel"..v)
	end

	--btn
	local btnGet = cc.uiloader:seekNodeByName(self, "btnGet")
	local btnStart = cc.uiloader:seekNodeByName(self, "btnStart")
	self.btnPre = cc.uiloader:seekNodeByName(self, "btnPre")
	self.btnNext = cc.uiloader:seekNodeByName(self, "btnNext")
	local btnClose = cc.uiloader:seekNodeByName(self, "btnClose")
	self.btnNext:setTouchEnabled(true)
	self.btnPre:setTouchEnabled(true)
	btnClose:setTouchEnabled(true)
	btnStart:setTouchEnabled(true)
	btnGet:setTouchEnabled(true)
	addBtnEventListener(btnClose, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:onClickBtnClose()
		end
	end)
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
	addBtnEventListener(btnGet, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			self:onClickBtnGet()
		end
	end)
end

function BossModeLayer:refreshUI(event)
	local actionDown = cc.MoveBy:create(0.3, cc.p(0,-200))
	local actionUp = cc.MoveBy:create(0.3, cc.p(0,200))
 	local actionNext = cc.MoveBy:create(0.3, cc.p(-1136,0))
	local actionNextChange = cc.MoveBy:create(0, cc.p(1136*2,0))
 	local actionPre = cc.MoveBy:create(0.3, cc.p(1136,0))
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
	self.btnPre:setVisible(true)
	self.btnNext:setVisible(true)
	if self.bossModeModel:checkPre(self.choseChapter-1) == false then
		self.btnPre:setVisible(false)
	elseif self.bossModeModel:checkNext(self.choseChapter+1) == false then
		self.btnNext:setVisible(false)
	end

	self.choseInfo = self.bossModeModel:getInfo(self.choseChapter)

	--gun
	self.panelGun:removeAllChildren()
	local weaponId = self.choseInfo["weaponid"]
	local imgName = self.weaponListModel:getWeaponImgByID(weaponId)
	local weaponImg = display.newSprite("#icon_"..imgName..".png")
	addChildCenter(weaponImg, self.panelGun)

	--bossPlay
	self.panelBoss:removeAllChildren()
	local armature = nil
	local enemyPlay = self.choseInfo["bossplay"]
	local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay..".ExportJson"
    manager:addArmatureFileInfo(src)
    local plist = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay.."0.plist"
    local png   = "res/Fight/enemys/"..enemyPlay.."/"..enemyPlay.."0.png"
    display.addSpriteFrames(plist, png)          

	armature = ccs.Armature:create(enemyPlay)
	addChildCenter(armature, self.panelBoss)
	armature:getAnimation():play("stand" , -1, 1)

	--
	self.panelChapter:removeAllChildren()
    local bossBtnNode = cc.uiloader:load("res/BossMode/chapter"..self.choseChapter..".ExportJson")
    self.panelChapter:addChild(bossBtnNode)
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

end

function BossModeLayer:onClickBtnGet()

end


return BossModeLayer