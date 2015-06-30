
local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0
local StoreLayer   = import("..store.StoreLayer")

local FightStorePopup = class("FightStorePopup",function()
	return display.newColorLayer(LayerColor_BLACK)
end)

function FightStorePopup:ctor(property)

	--ui
	self:loadCCS()
end 

function FightStorePopup:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/shopUI.ExportJson")
	self:addChild(self.root)

	--storeLayer
	local layerContent = cc.uiloader:seekNodeByName(self.root, "layerContent")	
	local layer = StoreLayer.new()
	layer:setPosition(0, 30)
	layer:onShow()
	layerContent:addChild(layer)

	local buttonClose = cc.uiloader:seekNodeByName(self.root, "buttonClose")
    buttonClose:onButtonClicked(function()
         self:closePopup()
    end)		
end

function FightStorePopup:closePopup(event)
	ui:closePopup("FightStorePopup", {animName = "scale"})
end

return FightStorePopup