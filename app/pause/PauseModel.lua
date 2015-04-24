local PauseModel = class("PauseModel",cc.mvc.ModelBase)

PauseModel.PAUSELAYER_SHOW_EVENT     = "SCENE_SHOW_EVENT"
PauseModel.PAUSELAYER_CLOSE_EVENT    = "SCENE_CLOSE_EVENT"

local layerClasses = {}
layerClasses["FightPausePopup"] 		 = import("..pause.FightPausePopup")
layerClasses["HomePausePopup"] 		 = import("..pause.HomePausePopup")
layerClasses["MapPausePopup"]       = import("..pause.MapPausePopup")

function PauseModel:ctor(properties)
    PauseModel.super.ctor(self, properties) 
	--instance
	self.isShowPauseScene = true
end

function PauseModel:showPopup(layerId, properties, extra)
	local opacity 
	local anim
	local animName
	if extra then 
		opacity = extra.opacity
		anim = extra.anim
		animName = extra.animName
		isNotScrenCapture = extra.isNotScrenCapture
	end

	local layerCls = self:getLayerCls(layerId)
	
	self:dispatchEvent({name = PauseModel.PAUSELAYER_SHOW_EVENT, layerCls = layerCls,
		opacity = opacity, anim = anim, properties = properties})

end

function PauseModel:closePopup()
	self.isShowPauseScene = true
	self:dispatchEvent({name = PauseModel.PAUSELAYER_CLOSE_EVENT})
end

function PauseModel:getLayerCls(layerId)
	local cls = layerClasses[layerId]
	assert(cls, "cls is nil cls id:"..layerId)
	return cls
end


return PauseModel