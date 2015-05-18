

local BuyConfigs = import(".BuyConfigs")

local BuyTipsPopup = class("BuyTipsPopup", function()
	return display.newLayer()
end)

function BuyTipsPopup:ctor(properties)
	--instance
	self.buyModel = md:getInstance("BuyModel")
	self.properties = properties
    self.type       = properties["type"] 
	self:loadCCS()
end

function BuyTipsPopup:loadCCS() 
    self.node = cc.uiloader:load("res/gouMai/".. self.type  ..".ExportJson")
    local image = cc.uiloader:seekNodeByName(self.node, "image")
    self:addChild(self.node)
    -- self.node
    image:scale(0.0)
    local action = transition.sequence({
        cc.ScaleTo:create(0.3, 1),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function()
            self:close()
            end),
        })
    image:runAction(action)
end

function BuyTipsPopup:close()
	ui:closePopup("BuyTipsPopup",{animName = "normal"})
end

return BuyTipsPopup
