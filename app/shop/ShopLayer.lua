--
-- Author: Fangzhongzheng
-- Date: 2014-11-10 14:15:37
--
local ShopLayer = class("ShopLayer", function()
    return display.newLayer()
end)

function ShopLayer:ctor()
	self:initUI()

	-- 设置储存蒙层的变量
	self.variable = nil
end

function ShopLayer:initUI()
	cc.FileUtils:getInstance():addSearchPath("res/InlayShop/")
	local shopRootNode = cc.uiloader:load("shop.ExportJson")
	self.inventoryBtn  = cc.uiloader:seekNodeByName(shopRootNode, "inventoryBtn")
	self.inventoryMask = cc.uiloader:seekNodeByName(shopRootNode, "inventoryMask")
	self.bankBtn       = cc.uiloader:seekNodeByName(shopRootNode, "bankBtn")
	self.bankMask      = cc.uiloader:seekNodeByName(shopRootNode, "bankMask")
	self.inlayBtn      = cc.uiloader:seekNodeByName(shopRootNode, "inlayBtn")
	self.inlayMask     = cc.uiloader:seekNodeByName(shopRootNode, "inlayMask")
	self:addChild(shopRootNode)

	self.inventoryBtn :setTouchEnabled(true)
	self.bankBtn      :setTouchEnabled(true)
	self.inlayBtn     :setTouchEnabled(true)
	self.inventoryMask:setTouchEnabled(true)
	self.bankMask     :setTouchEnabled(true)
	self.inlayMask    :setTouchEnabled(true)
	self.inventoryMask:setTouchSwallowEnabled(false)
	self.bankMask     :setTouchSwallowEnabled(false)
	self.inlayMask    :setTouchSwallowEnabled(false)

	self.inventoryBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
        	return true
        elseif event.name=='ended' then
        	self:refreshColor(self.inventoryMask)
        end
    end)
    self.bankBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
        	return true
        elseif event.name=='ended' then
        	self:refreshColor(self.bankMask)
        end
    end)
    self.inlayBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
        	return true
        elseif event.name=='ended' then
        	self:refreshColor(self.inlayMask)
        end
    end)
end

function ShopLayer:refreshColor(mask)
	if self.variable == nil then
		mask:setVisible(false)
		self.variable = mask
	else
		self.variable:setVisible(true)
		mask:setVisible(false)
		self.variable = mask
	end
end

return ShopLayer