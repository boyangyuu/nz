
local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0
local StoreLayer   = import("..store.StoreLayer")

local StorePopup = class("StorePopup",function()
	local layer = display.newColorLayer(LayerColor_BLACK)
	layer:setOpacity(kOpacity)
	return layer
end)

function StorePopup:ctor()
	self.userModel   = md:getInstance("UserModel")

	--events
    cc.EventProxy.new(self.userModel , self)
        :addEventListener("REFRESH_MONEY_EVENT", handler(self, self.refreshMoney))

	--ui
	self:loadCCS()
end

function StorePopup:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/shopUI.ExportJson")
	self:addChild(self.root)

	--storeLayer
	local layerContent = cc.uiloader:seekNodeByName(self.root, "layerContent")
	local layer = StoreLayer.new()
	layer:setPosition(0, 30)
	layer:onShow()
	layerContent:addChild(layer)

	--btn
	local buttonClose = cc.uiloader:seekNodeByName(self.root, "buttonClose")
    addBtnEventListener(buttonClose, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	self:closePopup()
        end
    end)

    self:refreshMoney()
end

function StorePopup:refreshMoney(event)
    --stone and money
    local labelStoneNum = cc.uiloader:seekNodeByName(self.root, "labelStoneNum")
    labelStoneNum:setString(self.userModel:getDiamond())

    local labelCoinNum = cc.uiloader:seekNodeByName(self.root, "labelCoinNum")
    labelCoinNum:setString(self.userModel:getMoney())
end

function StorePopup:closePopup(event)
	ui:closePopup("StorePopup", {animName = "scale"})
end

return StorePopup