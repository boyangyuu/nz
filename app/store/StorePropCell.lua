local ScrollViewCell = import("..includes.ScrollViewCell")
local StoreModel = import(".StoreModel")

local StorePropCell = class("StorePropCell", ScrollViewCell)

function StorePropCell:ctor(record)
	self:initCellUI(record)
end

function StorePropCell:initCellUI(record)
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	local controlNode = cc.uiloader:load("cell-daoju.ExportJson")
    local imgPanel = cc.uiloader:seekNodeByName(controlNode, "panelimg")
    local goldPrice = cc.uiloader:seekNodeByName(controlNode, "goldprice")
    local name = cc.uiloader:seekNodeByName(controlNode, "name")
    local Img = cc.ui.UIImage.new(record["imgname"]..".png")
    addChildCenter(Img, imgPanel)
	goldPrice:setString(record["price"])
	name:setString(record["name"])
	
	local btnBuy = cc.uiloader:seekNodeByName(controlNode, "btnbuy")
    btnBuy:setTouchEnabled(true)
    addBtnEventListener(btnBuy, function(event)
            if event.name=='began' then
                -- print("btnBuy is begining!")
                return true
            elseif event.name=='ended' then
                -- print("btnBuy is pressed!")
            end
        end)

	controlNode:setPosition(0, 0)
    self:addChild(controlNode)
end

return StorePropCell