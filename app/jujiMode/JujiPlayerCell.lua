local JujiPlayerCell = class("JujiPlayerCell", function()
    return display.newNode()
end)

function JujiPlayerCell:ctor(record)
	self.record = record
	self:initCellUI()
end

function JujiPlayerCell:initCellUI()
	cc.FileUtils:getInstance():addSearchPath("res/JujiMode")
    local controlNode = cc.uiloader:load("cellPlayer.ExportJson")
    self:addChild(controlNode)

    local playerRank = cc.uiloader:seekNodeByName(self, "rank")
    local playerName = cc.uiloader:seekNodeByName(self, "playername")
    local playerPoint = cc.uiloader:seekNodeByName(self, "point")

    local playerNO1 = cc.uiloader:seekNodeByName(self, "icon_NO1")
    local playerNO2 = cc.uiloader:seekNodeByName(self, "icon_NO2")
    local playerNO3 = cc.uiloader:seekNodeByName(self, "icon_NO3")

    playerRank:setString("aqfqefc")
    playerName:setString("aqfqefc")
    playerPoint:setString("aqfqefc")
end

return JujiPlayerCell