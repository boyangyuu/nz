
local NovicesBagPopup = class("NovicesBagPopup", function()
	return display.newLayer()
end)

function NovicesBagPopup:ctor()
	self:loadCSS()
	self:initButtons()
end

function NovicesBagPopup:loadCCS(  )
	local novicesBagNode = cc.uiloader:load("res/GiftBag/GiftBag/GiftBag_NovicesBag.ExportJson")
	self:addChild(novicesBagNode)
end

function NovicesBagPopup:initButtons()
	local 
end