local PauseModel = class("PauseModel",cc.mvc.ModelBase)

PauseModel.PAUSESCENE_SHOW_EVENT     = "SCENE_SHOW_EVENT"
PauseModel.PAUSESCENE_CLOSE_EVENT    = "SCENE_CLOSE_EVENT"

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
	self:initPauseScene()
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
	
	self:dispatchEvent({name = PauseModel.PAUSESCENE_SHOW_EVENT, layerCls = layerCls,
		opacity = opacity, anim = anim,isNotScrenCapture = isNotScrenCapture,
		properties = properties})

end

function PauseModel:closePopup()
	print(" PauseModel:closePopup()")
	self.isShowPauseScene = true
	self:dispatchEvent({name = PauseModel.PAUSESCENE_CLOSE_EVENT})
end

function PauseModel:getLayerCls(layerId)
	local cls = layerClasses[layerId]
	assert(cls, "cls is nil cls id:"..layerId)
	return cls
end

function PauseModel:initPauseScene()
	if not self.isShowPauseScene then return end
	self.isShowPauseScene = false
	local pauseScene = require("app.pause.PauseScene").new()
	local director = cc.Director:getInstance()
	director:pushScene(pauseScene)
end


return PauseModel