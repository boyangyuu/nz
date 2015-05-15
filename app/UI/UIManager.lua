local UI = class("UIManager",cc.mvc.ModelBase)

-- 定义事件
UI.LAYER_CHANGE_EVENT 	= "LAYER_CHANGE_EVENT"
UI.LAYER_PAUSE_EVENT 	= "LAYER_PAUSE_EVENT"

UI.POPUP_SHOW_EVENT   	= "POPUP_SHOW_EVENT"
UI.POPUP_CLOSE_EVENT   	= "POPUP_CLOSE_EVENT"
UI.POPUP_CLOSEALL_EVENT = "POPUP_CLOSEALL_EVENT"

UI.LOAD_SHOW_EVENT 		= "LOAD_SHOW_EVENT"
UI.LOAD_HIDE_EVENT 		= "LOAD_HIDE_EVENT"

UI.PAUSESCENE_SHOW_EVENT     = "SCENE_SHOW_EVENT"
UI.PAUSESCENE_CLOSE_EVENT    = "SCENE_CLOSE_EVENT"

--保存layer
local layerClasses = {}
-- layerClasses["LoadingLayer"] 		 = import("..load.LoadingLayer")
layerClasses["FightPlayer"] 		 = import("..fight.FightPlayer")
layerClasses["WeaponBag"] 		     = import("..weaponList.WeaponBag")
layerClasses["HomeBarLayer"]		 = import("..homeBar.HomeBarLayer")
layerClasses["FightResultLayer"]     = import("..fightResult.FightResultLayer")
layerClasses["LevelDetailLayer"] 	 = import("..levelDetail.LevelDetailLayer")
layerClasses["DialogLayer"] 		 = import("..dialog.DialogLayer")
layerClasses["StartLayer"]           = import("..start.StartLayer")

layerClasses["storyLayer"]           = import("..start.StoryLayer")

layerClasses["DailyLoginLayer"]      = import("..dailyLogin.DailyLoginLayer")

--fight
layerClasses["FightResultFailPopup"] = import("..fightResult.FightResultFailPopup")
layerClasses["JujiModeLayer"]        = import("..jujiMode.JujiModeLayer")
layerClasses["JujiResultLayer"]      = import("..jujiMode.JujiResultLayer")
layerClasses["GunHelpPopup"]         = import("..fight.Gun.GunHelpPopup")
layerClasses["FightAdvisePopup"]     = import("..fight.fightTips.FightAdvisePopup")
layerClasses["FightRelivePopup"]     = import("..fight.fightTips.FightRelivePopup")

layerClasses["AboutPopup"]           = import("..start.AboutPopup")
layerClasses["commonPopup"] 		 = import("..commonPopup.commonPopup")
layerClasses["WeaponNotifyLayer"]    = import("..weaponNotify.WeaponNotifyLayer")

-- giftBag
layerClasses["GiftBagPopup"]      	 = import("..buy.GiftBagPopup")

--jujiFight
layerClasses["BossModeLayer"]        = import("..bossMode.BossModeLayer")
layerClasses["BossResultLayer"]      = import("..bossMode.BossResultLayer")
layerClasses["JujiAwardPopup"]       = import("..jujiMode.JujiAwardPopup")



function UI:ctor(properties)
    UI.super.ctor(self, properties) 
	--instance
end

function UI:changeLayer(layerId, properties)
	print("function UI:changeLayer(layerId)")
	local loadingType = nil
	if properties then loadingType = properties.loadingType end
	if loadingType == nil and layerId ==  "FightPlayer" then 
		loadingType = "fight" 
	elseif loadingType == nil and layerId == "HomeBarLayer" then 
		loadingType = "home"
	else
		
	end

	local layerCls = self:getLayerCls(layerId)
	self:dispatchEvent({name = UI.LAYER_CHANGE_EVENT, layerCls = layerCls,
		 loadingType = loadingType, properties = properties})
end

function UI:showPopup(layerId, properties, extra)
	local opacity 
	local anim
	local animName
	local isPauseScene
	local isPauseSecond
	if extra then 
		opacity = extra.opacity
		anim = extra.anim
		animName = extra.animName
	end
	local layerCls = self:getLayerCls(layerId)
	self:dispatchEvent({name = UI.POPUP_SHOW_EVENT, layerCls = layerCls, 
		opacity = opacity, anim = anim, animName = animName,
		properties = properties})

	--pause rootLayer
	self:setPause(true)
end

function UI:closePopup(layerId,eventData)
	self:dispatchEvent({name = UI.POPUP_CLOSE_EVENT, layerId = layerId, eventData = eventData})
end

function UI:closeAllPopups()
	self:dispatchEvent({name = UI.POPUP_CLOSEALL_EVENT})

	--resume rootLayer
	self:setPause(false)
end

function UI:setPause(isPause)
	print("function UI:setPause(isPause)")
	self:dispatchEvent({name = UI.LAYER_PAUSE_EVENT, isPause = isPause})

end

function UI:getLayerCls(layerId)
	local cls = layerClasses[layerId]
	assert(cls, "cls is nil cls id:"..layerId)
	return cls
end

function UI:showLoad(type)
	self:dispatchEvent({name = UI.LOAD_SHOW_EVENT,type = type})
end

function UI:hideLoad()
	self:dispatchEvent({name = UI.LOAD_HIDE_EVENT})
end

return UI

