local JujiPlayerCell = import(".JujiPlayerCell")

local JujiModeLayer = class("JujiModeLayer", function()
    return display.newLayer()
end)

function JujiModeLayer:ctor()
	self.jujiModel = md:getInstance("JujiModeModel")
	self.rankModel = md:getInstance("RankModel")
	self.userModel = md:getInstance("UserModel")
	self.inlayModel = md:getInstance("InlayModel")
	self.buyModel = md:getInstance("BuyModel")
	self.rankTable = self.jujiModel:getRankData()

	self:loadCCS()
	self:initUI()

    cc.EventProxy.new(self.userModel, self)
	    :addEventListener(self.userModel.REFRESH_PLAYERNAME_EVENT,
	     handler(self, self.refreshUI))

	self:setNodeEventEnabled(true)
end

function JujiModeLayer:onEnter()
	self:performWithDelay(handler(self,self.refreshListView),0.5)
	self:performWithDelay(handler(self,self.checkUserName),0.5)
end

function JujiModeLayer:checkUserName()
	if  self.userModel:getUserName() == LanguageManager.getStringForKey("string_hint162") then
		ui:showPopup("InputBoxPopup",
			{content = LanguageManager.getStringForKey("string_hint163"),
			 onClickConfirm = handler(self, self.onClickConfirm_InputName)},
			 {opacity = 0})
	end
end

function JujiModeLayer:onClickConfirm_InputName(event)
	dump(event, "event")
    local user = md:getInstance("UserModel")
	user:setUserName(event.inputString)
end

function JujiModeLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/JujiMode/wuxianjuji")
    local controlNode = cc.uiloader:load("main.json")
    self:addChild(controlNode)
end

function JujiModeLayer:initUI()
    local src = "res/JujiMode/zhoujiangli/zhoujiangli.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/JujiMode/zhoujiangli/zhoujiangli0.plist"
    local png = "res/JujiMode/zhoujiangli/zhoujiangli0.png"
    display.addSpriteFrames(plist,png)

	self.listViewPlayer = cc.uiloader:seekNodeByName(self, "listViewPlayer")
	local btnReward = cc.uiloader:seekNodeByName(self, "raward")
	local btnStart = cc.uiloader:seekNodeByName(self, "start")
	local playerRank = cc.uiloader:seekNodeByName(self, "rank")
	self.playerName = cc.uiloader:seekNodeByName(self, "playerName")
	local playerPoint = cc.uiloader:seekNodeByName(self, "point")
	self.notiReward = cc.uiloader:seekNodeByName(self, "noti")

	local armature = ccs.Armature:create("zhoujiangli")
    armature:setPosition(cc.p(-100,0))
    btnReward:addChild(armature,100)
    armature:getAnimation():play("zhoujiangli" , -1, 1)

	local myselfRecord = self.rankModel:getUserRankData("jujiLevel")
	local myselfRank = self.rankModel:getUserRank()
	playerRank:setString(myselfRank)
	self.playerName:setString(myselfRecord["name"])
	playerPoint:setString(myselfRecord["jujiLevel"]*100 )

    btnReward:onButtonPressed(function( event )
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function( event )
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    :onButtonClicked(function()
        self:onClickBtnReward()
    end)
    btnStart:onButtonPressed(function( event )
        event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
    end)
    :onButtonRelease(function( event )
        event.target:runAction(cc.ScaleTo:create(0.1, 1))
    end)
    :onButtonClicked(function()
        self:onClickBtnStart()
    end)
end

function JujiModeLayer:refreshUI(event)
	self.playerName:setString(self.userModel:getUserName())
end

function JujiModeLayer:onClickBtnStart()
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

function JujiModeLayer:onClickGoldWeapon()
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

function JujiModeLayer:onClickQuickInlay()
	self.inlayModel:equipAllInlays()
	self:startGame()
end

function JujiModeLayer:onClickCloseInlayNoti()
	self:startGame()
end
function JujiModeLayer:startGame()
	local fightData = { groupId = 60,levelId = 1, fightType = "jujiFight"}  --无限狙击
	ui:changeLayer("FightPlayer", {fightData = fightData})
end

function JujiModeLayer:checkNetWork()
	local isAvailable = network.isInternetConnectionAvailable()
	if isAvailable then
		print("network isAvailable")
	else
		ui:showPopup("commonPopup",
			 {type = "style1",content = LanguageManager.getStringForKey("string_hint164")},
			 {opacity = 0})
	end
end

function JujiModeLayer:onClickBtnReward()
	print("JujiModeLayer:onClickBtnReward()")
	self.notiReward:setVisible(false)
	ui:showPopup("JujiAwardPopup")
end

function JujiModeLayer:refreshListView()
	--net
	self:checkNetWork()

	--list
    for i=1, 20 do
        local content = JujiPlayerCell.new({record = self.rankTable[i],rank = i})
        local item = self.listViewPlayer:newItem()
        item:addContent(content)
        item:setItemSize(392, 68)
        self.listViewPlayer:addItem(item)
    end
    self.listViewPlayer:reload()
end

return JujiModeLayer