local layers = {}

layers["FightPlayer"]  = import("..fight.FightPlayer")
local HomeBarLayer = import("..homeBar.HomeBarLayer")
local FightResultLayer = import("..fightResult.FightResultLayer")
local LayerColor_BLACK = cc.c4b(0, 122, 44, 0)

local RootLayer = class("RootLayer", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function RootLayer:ctor()
	--instance


    --root
    -- self.curLayer = FightPlayer.new()  --todo 战斗 homebar 等都放在commentNode上
    self.curLayer = HomeBarLayer.new()
    self:addChild(self.curLayer)

	--event
	cc.EventProxy.new(ui, self)
		:addEventListener(ui.LAYER_CHANGE_EVENT, handler(self, self.switchLayer))
		-- :addEventListener(UI.POPUP_SHOW_EVENT, handler(self, self.showPopup))
		-- :addEventListener(UI.POPUP_EXIT_EVENT, handler(self, self.exitPopup))

end

function RootLayer:switchLayer(event)
	dump(event, "event")
	local layerId = event.layerId
	print("layerId:", layerId)
	local layer = layers[layerId].new()
	assert(layer, "layer is nil id:"..layerId)
	self:removeAllChildren()
	self:addChild(layer)
end

function RootLayer:createLayer()
	
end

-- function RootLayer:showPopup()
	
-- end

-- function RootLayer:exitPopup()
	
-- end

function RootLayer:checkLoadLayer()
	
end

return RootLayer