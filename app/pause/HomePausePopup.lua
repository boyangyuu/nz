local LayerColor_BLACK = cc.c4b(0, 0, 0, 255)

local HomePopup = class("HomePopup", function()
    return display.newColorLayer(LayerColor_BLACK)
end)

function HomePopup:ctor(properties)
	self:initLayer()
end

function HomePopup:initLayer()
	cc.ui.UILabel.new({
        UILabelType = 2, text = "请触屏继续...", size = 35, color = cc.c3b(255, 255, 255)})
    :align(display.CENTER, display.cx, display.cy)
    :addTo(self)

   	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
			if event.name == "began" then
				print("btncall is pressed!")
				return true
			elseif event.name == "ended" then
				pm:closePopup()
			end
		end)
end

return HomePopup