local ScrollViewCell = import("..includes.ScrollViewCell")

local InlayListCell = class("InlayListCell", ScrollViewCell)

function InlayListCell:ctor(record)
	self:initCellUI(record)
end

function InlayListCell:initCellUI(record)
	dump(record)
	cc.FileUtils:getInstance():addSearchPath("res/InlayShop/")
	local controlNode = cc.uiloader:load("xiangqian_type.json")
    local imgPanel = cc.uiloader:seekNodeByName(controlNode, "imgPanel")
    -- print(record["imgName"])
    -- local x = record["imgName"]..".png"
    local Img = cc.ui.UIImage.new(x)
    -- addChildCenter(Img, imgPanel)
	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

return InlayListCell