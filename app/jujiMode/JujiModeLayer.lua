local JujiPlayerCell = import(".JujiPlayerCell")

local JujiModeLayer = class("JujiModeLayer", function()
    return display.newLayer()
end)

function JujiModeLayer:ctor()
	self.jujiModel = md:getInstance("JujiModeModel")
	self.rankModel = md:getInstance("RankModel")
	self.user = md:getInstance("UserModel")
	self.rankTable = self.jujiModel:getRankData() 

	self:loadCCS()
	self:initUI()

    cc.EventProxy.new(self.user, self)
	    :addEventListener("REFRESH_PLAYERNAME_EVENT" , handler(self, self.refreshUI))

	self:setNodeEventEnabled(true)
end

function JujiModeLayer:onEnter()
	self:performWithDelay(handler(self,self.refreshListView),0.5)
	self:performWithDelay(handler(self,self.setUserName),0.5)
end



function JujiModeLayer:setUserName()
	if  self.user:getUserName() == "玩家自己" then
		ui:showPopup("InputBoxPopup",{opacity = 0})
	end
end

function JujiModeLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/JujiMode")
    local controlNode = cc.uiloader:load("main.json")
    self:addChild(controlNode)
end

function JujiModeLayer:initUI()
	self.listViewPlayer = cc.uiloader:seekNodeByName(self, "listViewPlayer")
	local btnBack = cc.uiloader:seekNodeByName(self, "btnBack")
	local btnReward = cc.uiloader:seekNodeByName(self, "raward")
	local btnStart = cc.uiloader:seekNodeByName(self, "start")
	local playerRank = cc.uiloader:seekNodeByName(self, "rank")
	self.playerName = cc.uiloader:seekNodeByName(self, "playerName")
	local playerPoint = cc.uiloader:seekNodeByName(self, "point")

	local myselfRecord = self.rankModel:getUserRankData("jujiLevel")
	local myselfRank = self.rankModel:getUserRank()
	playerRank:setString(myselfRank)
	self.playerName:setString(myselfRecord["name"])
	playerPoint:setString(myselfRecord["jujiLevel"] )

	btnBack:setTouchEnabled(true)
	addBtnEventListener(btnBack, function(event)
			if event.name == 'began' then
				return true
			elseif event.name == 'ended' then
				self:onClickBtnClose()
			end
		end)

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
	self.playerName:setString(self.user:getUserName())
end

function JujiModeLayer:onClickBtnStart()
	local fightData = { groupId = 60,levelId = 1, fightType = "jujiFight"}  --无限狙击
	ui:changeLayer("FightPlayer", {fightData = fightData})	
	ui:closePopup("JujiModeLayer")
end

function JujiModeLayer:checkNetWork()
	local isAvailable = network.isInternetConnectionAvailable()
	if isAvailable then
		print("network isAvailable")
	else
		ui:showPopup("commonPopup",
			 {type = "style1",content = "当前网络连接失败，连接网络后排名数据将会统计"},
			 {opacity = 0})
	end	
end

function JujiModeLayer:onClickBtnClose()
	self.listViewPlayer:setVisible(false)
	ui:closePopup("JujiModeLayer")
end

function JujiModeLayer:onClickBtnReward()
	print("JujiModeLayer:onClickBtnReward()")
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
        item:setItemSize(524, 88)
        self.listViewPlayer:addItem(item)
    end
    self.listViewPlayer:reload()
end

return JujiModeLayer