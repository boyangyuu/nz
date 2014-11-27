local ScrollViewCell = import("..includes.ScrollViewCell")
local StoreModel = import(".StoreModel")
local InlayModel = import("..inlay.InlayModel")
local PropModel = import(".PropModel")

local StoreCell = class("StoreCell", ScrollViewCell)

function StoreCell:ctor(parameter)
    self.inlayModel = app:getInstance(InlayModel)
    self.propModel = app:getInstance(PropModel)
    dump(self.propModel)
	self:initCellUI(parameter)
	self:initCellData(parameter)
end

function StoreCell:initCellUI(parameter)
	local record = parameter.record
	local type = parameter.celltype
	cc.FileUtils:getInstance():addSearchPath("res/Store")
	self.controlNode = cc.uiloader:load("cellstore.ExportJson")
	self.controlNode:setPosition(0, 0)
    self:addChild(self.controlNode)

end

function StoreCell:initCellData(parameter)
	local record = parameter.record
	local type = parameter.celltype

	local imgPanel = cc.uiloader:seekNodeByName(self.controlNode, "panelimg")
    local discount = cc.uiloader:seekNodeByName(self.controlNode, "discount")
    local discountlabel = cc.uiloader:seekNodeByName(self.controlNode, "discountlabel")
    local detail = cc.uiloader:seekNodeByName(self.controlNode, "detail")
    local describe = cc.uiloader:seekNodeByName(self.controlNode, "property")
    local price = cc.uiloader:seekNodeByName(self.controlNode, "price")
    local ownNum = cc.uiloader:seekNodeByName(self.controlNode, "ownnumber")
    local alreadylabel = cc.uiloader:seekNodeByName(self.controlNode, "already")
    local buynumber = cc.uiloader:seekNodeByName(self.controlNode, "buynumber")
    local icongold = cc.uiloader:seekNodeByName(self.controlNode, "icon_jibi")
    local icondiamond = cc.uiloader:seekNodeByName(self.controlNode, "icon_zuanshi")
    local iconyuan = cc.uiloader:seekNodeByName(self.controlNode, "icon_yuan")
    local redline = cc.uiloader:seekNodeByName(self.controlNode, "redline")

    icongold:setVisible(false)
    icondiamond:setVisible(false)
    iconyuan:setVisible(false)
    discount:setVisible(false)
    redline:setVisible(false)

    if type == "prop" then
    	icondiamond:setVisible(true)

	    local Img = cc.ui.UIImage.new(record["imgname"]..".png")
        addChildCenter(Img, imgPanel)
        detail:setString(record["name"])
        buynumber:setString("X "..record["buynum"])
        describe:setString(record["describe"])
        price:setString(record["price"])
        ownNum:setString(self.propModel:getPropNum(record["nameid"]))
	elseif type == "bank" then
		ownNum:setVisible(false)
		alreadylabel:setVisible(false)
		iconyuan:setVisible(true)
		discount:setVisible(true)
        redline:setVisible(true)

        local Img = cc.ui.UIImage.new(record["imgname"]..".png")
        addChildCenter(Img, imgPanel)
        detail:setString(record["name"])
        buynumber:setString("X "..record["number"])
        discountlabel:setString("+"..record["discount"].."%")
        describe:setString("原价："..record["costprice"].."元")
        price:setString(record["price"])
	elseif type == "inlay" then
		buynumber:setVisible(false)
		icongold:setVisible(true)

        local Img = cc.ui.UIImage.new(record["imgnam"]..".png")
        addChildCenter(Img, imgPanel)
        detail:setString(record["describe2"])
        describe:setString(record["describe2"]..record["valueDisplay"])
        price:setString(record["goldPrice"])
        ownNum:setString(self.inlayModel:getInlayNum(record["id"]))
	end

	local btnBuy = cc.uiloader:seekNodeByName(self.controlNode, "btnbuy")
    btnBuy:setTouchEnabled(true)
    addBtnEventListener(btnBuy, function(event)
            if event.name=='began' then
                -- print("btnBuy is begining!")
                return true
            elseif event.name=='ended' then
                -- print("btnBuy is pressed!")
                if type == "prop" then
                    self.propModel:buyProp(record["nameid"])
                    ownNum:setString(self.propModel:getPropNum(record["nameid"]))
                elseif type == "bank" then

                elseif type == "inlay" then
                    self.inlayModel:buyInlay(record["id"])
                    ownNum:setString(self.inlayModel:getInlayNum(record["id"]))
                end
            end
        end)

	

end

function StoreCell:initPropCell(record)
	-- body
end

return StoreCell