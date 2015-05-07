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
	self:refreshListView()
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

    btnReward:onButtonClicked(function()
        self:onClickBtnReward()
    end)
    btnStart:onButtonClicked(function()
        self:onClickBtnStart()
    end)
end

function JujiModeLayer:onClickBtnStart()

end

function JujiModeLayer:onClickBtnClose()
	ui:closePopup("JujiModeLayer")
end

function JujiModeLayer:onClickBtnReward()
	
end

function JujiModeLayer:refreshListView(index)
    removeAllItems(self.listViewPlayer)
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