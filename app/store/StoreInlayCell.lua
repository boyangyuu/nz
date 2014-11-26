local ScrollViewCell = import("..includes.ScrollViewCell")
local StoreModel = import(".StoreModel")
local InlayModel = import("..inlay.InlayModel")


local StoreInlayCell = class("StoreInlayCell", ScrollViewCell)

function StoreInlayCell:ctor(record)
    self.inlayModel = app:getInstance(InlayModel)

	self:initCellUI(record)
end

function StoreInlayCell:initCellUI(record)
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	local controlNode = cc.uiloader:load("cell-xiangqian.ExportJson")
    local imgPanel = cc.uiloader:seekNodeByName(controlNode, "panelimg")
    local describe2 = cc.uiloader:seekNodeByName(controlNode, "detail")
    local describe1 = cc.uiloader:seekNodeByName(controlNode, "property")
    local valueDisplay = cc.uiloader:seekNodeByName(controlNode, "valuedisplay")
    local goldPrice = cc.uiloader:seekNodeByName(controlNode, "goldprice")
    local ownNum = cc.uiloader:seekNodeByName(controlNode, "ownnumber")

    local Img = cc.ui.UIImage.new(record["imgnam"]..".png")
    addChildCenter(Img, imgPanel)
    describe2:setString(record["describe2"])
    describe1:setString(record["describe1"])
    valueDisplay:setString(record["valueDisplay"])
    goldPrice:setString(record["goldPrice"])
    ownNum:setString(self.inlayModel:getInlayNum(record["id"]))

    local btnBuy = cc.uiloader:seekNodeByName(controlNode, "btnbuy")
    btnBuy:setTouchEnabled(true)
    addBtnEventListener(btnBuy, function(event)
            if event.name=='began' then
                -- print("btnBuy is begining!")
                return true
            elseif event.name=='ended' then
                -- print("btnBuy is pressed!")
                self.inlayModel:buyInlay(record["id"])
                ownNum:setString(self.inlayModel:getInlayNum(record["id"]))

            end
        end)

	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

return StoreInlayCell