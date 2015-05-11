local JujiPlayerCell = import(".JujiPlayerCell")

local JujiModeLayer = class("JujiModeLayer", function()
    return display.newLayer()
end)

function JujiModeLayer:ctor()
	self.jujiModel = md:getInstance("JujiModeModel")
	self.rankModel = md:getInstance("RankModel")
	self.rankTable = self.jujiModel:getRankData()

	self:loadCCS()
	self:initUI()
	self:setNodeEventEnabled(true)
end

function JujiModeLayer:onEnter()
	self:performWithDelay(handler(self,self.refreshListView),0.3)
end

function JujiModeLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/JujiMode")
    local controlNode = cc.uiloader:load("main.ExportJson")
    self:addChild(controlNode)
end

function JujiModeLayer:initUI()
	self.listViewPlayer = cc.uiloader:seekNodeByName(self, "listViewPlayer")
	local btnBack = cc.uiloader:seekNodeByName(self, "btnBack")
	local btnReward = cc.uiloader:seekNodeByName(self, "raward")
	local btnStart = cc.uiloader:seekNodeByName(self, "start")
	local playerRank = cc.uiloader:seekNodeByName(self, "rank")
	local playerName = cc.uiloader:seekNodeByName(self, "playerName")
	local playerPoint = cc.uiloader:seekNodeByName(self, "point")

	local myselfRecord = self.rankModel:getUserRankData("jujiLevel")
	local myselfRank = self.rankModel:getUserRank()
	playerRank:setString(myselfRank)
	playerName:setString(myselfRecord["name"])
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

function JujiModeLayer:onClickBtnStart()
	local isAvailable = network.isInternetConnectionAvailable()
	if isAvailable then
		print("JujiModeLayer:onClickBtnStart()")
	else
		ui:showPopup("commonPopup",
			 {type = "style1",content = "当前网络连接失败，连接网络后数据将会统计"},
			 {opacity = 0})
	end
end

function JujiModeLayer:onClickBtnClose()
	self.listViewPlayer:setVisible(false)
	ui:closePopup("JujiModeLayer")
end

function JujiModeLayer:onClickBtnReward()
	print("JujiModeLayer:onClickBtnReward()")
end

function JujiModeLayer:refreshListView()
    for i=1,#self.rankTable do
        local item = self.listViewPlayer:newItem()
        local content = JujiPlayerCell.new({record = self.rankTable[i],rank = i})
        item:addContent(content)
        item:setItemSize(524, 88)
        self.listViewPlayer:addItem(item)
    end
    self.listViewPlayer:reload()
end

return JujiModeLayer