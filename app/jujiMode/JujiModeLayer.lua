local JujiPlayerCell = import(".JujiPlayerCell")

local JujiModeLayer = class("JujiModeLayer", function()
    return display.newLayer()
end)

function JujiModeLayer:ctor()
	self:loadCCS()
	self:initUI()
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
	--need Player Table, Waiting for YYB
	local table = {}

    removeAllItems(self.listViewPlayer)
    for i=1,#table do
        local item = self.listViewPlayer:newItem()
        local content = JujiPlayerCell.new(table[i])
        item:addContent(content)
        item:setItemSize(524, 88)
        self.listViewPlayer:addItem(item)
    end
    self.listViewPlayer:reload()
end

return JujiModeLayer