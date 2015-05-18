

local BuyConfigs = import(".BuyConfigs")

local StoneLessPopup = class("StoneLessPopup", function()
	return display.newLayer()
end)

function StoneLessPopup:ctor(properties)
	--instance
	self.buyModel = md:getInstance("BuyModel")
	self.properties = properties
	self:loadCCS()
end

function StoneLessPopup:loadCCS()    
    self.node = cc.uiloader:load("res/gouMai/boneLess.ExportJson")
    local image = cc.uiloader:seekNodeByName(self.node, "image")
    self:addChild(self.node)
    -- self.node
    image:scale(0.0)
    local action = transition.sequence({
        cc.ScaleTo:create(0.3, 1),
        cc.DelayTime:create(0.2),
        cc.CallFunc:create(function()
            self:close()
            end),
        })
    image:runAction(action)
end

function StoneLessPopup:close()
	ui:closePopup("StoneLessPopup",{animName = "normal"})
end

return StoneLessPopup
