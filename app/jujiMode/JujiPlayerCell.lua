local JujiPlayerCell = class("JujiPlayerCell", function()
    return display.newNode()
end)

function JujiPlayerCell:ctor(record)
	self.record = record
	self:initCellUI()
end

function JujiPlayerCell:initCellUI()
	cc.FileUtils:getInstance():addSearchPath("res/JujiMode/wuxianjuji")
    local controlNode = cc.uiloader:load("cellPlayer.json")
    controlNode:setPosition(0, 0)
    self:addChild(controlNode)

    local playerRank = cc.uiloader:seekNodeByName(self, "rank")
    local playerName = cc.uiloader:seekNodeByName(self, "playername")
    local playerPoint = cc.uiloader:seekNodeByName(self, "point")

    local playerNO1 = cc.uiloader:seekNodeByName(self, "icon_NO1")
    local playerNO2 = cc.uiloader:seekNodeByName(self, "icon_NO2")
    local playerNO3 = cc.uiloader:seekNodeByName(self, "icon_NO3")

    local detail = self.record["record"]
    playerRank:setString(self.record["rank"])
    playerName:setString(detail["name"])
    playerPoint:setString(detail["jujiLevel"]*100)

    if self.record["rank"] == 1 then
        playerNO1:setVisible(true)
        playerRank:setVisible(false)
    elseif self.record["rank"] == 2 then
        playerNO2:setVisible(true)        
        playerRank:setVisible(false)
    elseif self.record["rank"] == 3 then
        playerNO3:setVisible(true)
        playerRank:setVisible(false)
    end

end

return JujiPlayerCell