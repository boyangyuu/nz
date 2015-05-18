

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

end

function StoneLessPopup:close()
	ui:closePopup("StoneLessPopup",{animName = "normal"})
end

return StoneLessPopup
