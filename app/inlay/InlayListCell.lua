local ScrollViewCell = import("..includes.ScrollViewCell")
local InlayModel = import(".InlayModel")

local InlayListCell = class("InlayListCell", ScrollViewCell)

function InlayListCell:ctor(record)
    self.inlayModel = app:getInstance(InlayModel)

	self:initCellUI(record)
end

function InlayListCell:initCellUI(record)
	cc.FileUtils:getInstance():addSearchPath("res/InlayShop")
	local controlNode = cc.uiloader:load("cell.ExportJson")
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
    local btnLoad = cc.uiloader:seekNodeByName(controlNode, "btnload")
    btnBuy:setTouchEnabled(true)
    btnLoad:setTouchEnabled(true)
    addBtnEventListener(btnBuy, function(event)
            if event.name=='began' then
                -- print("btnBuy is begining!")
                return true
            elseif event.name=='ended' then
                -- print("btnBuy is pressed!")
                self.inlayModel:buyInlay(record["id"])
            end
        end)
    addBtnEventListener(btnLoad, function(event)
            if event.name=='began' then
                -- print("btnLoad is begining!")
                return true
            elseif event.name=='ended' then
                print("btnLoad is pressed!")
                self.inlayModel:equipInlay(record["id"],true)

            end
        end)

	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end


return InlayListCell