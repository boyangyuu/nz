local ScrollViewCell = import("..includes.ScrollViewCell")
local InlayModel = import(".InlayModel")

local InlayListCell = class("InlayListCell", ScrollViewCell)

function InlayListCell:ctor(record)
    self.inlayModel = app:getInstance(InlayModel)
	self:initCellUI(record)
end

function InlayListCell:initCellUI(record)
	cc.FileUtils:getInstance():addSearchPath("res/InlayShop/")
	local controlNode = cc.uiloader:load("xiangqian_type.json")
    local imgPanel = cc.uiloader:seekNodeByName(controlNode, "imgPanel")
    local Img = cc.ui.UIImage.new(record["imgnam"]..".png")
    addChildCenter(Img, imgPanel)

    local btnBuy = cc.uiloader:seekNodeByName(controlNode, "buyBtn")
    local btnLoad = cc.uiloader:seekNodeByName(controlNode, "loadBtn")
    addBtnEventListener(btnBuy, function(event)
            if event.name=='began' then
                print("btnBuy is begining!")
                return true
            elseif event.name=='ended' then
                print("btnBuy is pressed!")
            end
        end)
    addBtnEventListener(btnLoad, function(event)
            if event.name=='began' then
                print("btnLoad is begining!")
                return true
            elseif event.name=='ended' then
                print("btnLoad is pressed!")
                self.inlayModel:refreshBtnIcon(record["type"],record["id"])
            end
        end)

	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

return InlayListCell