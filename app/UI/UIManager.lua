local UI = class("UIManager",cc.mvc.ModelBase)

-- 定义事件
UI.LAYER_CHANGE_EVENT 	= "LAYER_CHANGE_EVENT"
UI.POPUP_SHOW_EVENT   	= "POPUP_SHOW_EVENT"
UI.POPUP_CLOSE_EVENT   	= "POPUP_CLOSE_EVENT"

--保存layer
local layerClasses = {}
layerClasses["FightPlayer"] 		 = import("..fight.FightPlayer")
layerClasses["WeaponBag"] 		 	 = import("..weaponList.WeaponBag")
layerClasses["HomeBarLayer"]		 = import("..homeBar.HomeBarLayer")
layerClasses["FightResultLayer"]     = import("..fightResult.FightResultLayer")
layerClasses["LevelDetailLayer"] 	 = import("..levelDetail.LevelDetailLayer")
layerClasses["FightResultPopup"] 	 = import("..fightResult.FightResultPopup")
layerClasses["FightResultFailPopup"] = import("..fightResult.FightResultFailPopup")
layerClasses["DialogLayer"] 		 = import("..dialog.DialogLayer")

function UI:ctor(properties)
    UI.super.ctor(self, properties) 
	--instance
end

function UI:changeLayer(layerId, properties)
	print("function UI:changeLayer(layerId)")
	local layer = self:createLayer(layerId, properties)
	self:dispatchEvent({name = UI.LAYER_CHANGE_EVENT, layer = layer})
end

function UI:showPopup(layerId, properties, extra)
	local opacity 
	local anim
	if extra then 
		opacity = extra.opacity
		anim = extra.anim
	end

	local layer = self:createLayer(layerId, properties)
	
	self:dispatchEvent({name = UI.POPUP_SHOW_EVENT, layer = layer, 
		opacity = opacity, anim = anim})
end

function UI:closePopup(layerId)
	self:dispatchEvent({name = UI.POPUP_CLOSE_EVENT, layerId = layerId})
end

function UI:createLayer(layerId, properties)
	local cls = layerClasses[layerId]
	assert(cls, "cls is nil cls id:"..layerId)
	return cls.new(properties)
end

return UI

