local LayerColor_BLACK = cc.c4b(0, 0, 0, 0)
local kOpacity = 200.0

local WeaponNotifyLayer = class("WeaponNotifyLayer", function()
	local layer = display.newColorLayer(LayerColor_BLACK)
	layer:setOpacity(kOpacity)
	return layer
end)


--[[
		ui:showPopup("WeaponNotifyLayer",
			 {type = "gun",weaponId = 3},{opacity = 255})
]]
function WeaponNotifyLayer:ctor(properties)
	self.weaponListModel = md:getInstance("WeaponListModel")
	self.properties = properties
	self:loadCCS()
	self:initUI(properties)
	self:setLocalZOrder(100)
end

function WeaponNotifyLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/WeaponNotify")
    local controlNode = cc.uiloader:load("huoqujiangli_1.ExportJson")
    self:addChild(controlNode)
end

function WeaponNotifyLayer:initUI(properties)
    local btnGet = cc.uiloader:seekNodeByName(self, "btnGet")
    local labelSuipian = cc.uiloader:seekNodeByName(self, "labelSuipian")
    local labelGun = cc.uiloader:seekNodeByName(self, "labelGun")
    local panelAnim = cc.uiloader:seekNodeByName(self, "panelAnim")
    btnGet:onButtonClicked(function()
        self:onBtnGetClicked()
    end)

	-- Anim
    local src = "res/WeaponNotify/hdxkwq/hdxkwq.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/WeaponNotify/hdxkwq/hdxkwq0.plist"
    local png = "res/WeaponNotify/hdxkwq/hdxkwq0.png"
    display.addSpriteFrames(plist,png)

    local armature = ccs.Armature:create("hdxkwq")
    panelAnim:addChild(armature,100)

	if properties.type == "gun" then
		local imgName = self.weaponListModel:getWeaponImgByID(properties.weaponId)
		local weaponName = self.weaponListModel:getWeaponNameByID(properties.weaponId)
		local skin = ccs.Skin:createWithSpriteFrameName("icon_"..imgName..".png")
	    armature:getBone("icon_wuqi"):addDisplay(skin, 1)
	    armature:getBone("icon_wuqi"):changeDisplayWithIndex(1, true)


		armature:getAnimation():setMovementEventCallFunc(   
         function (armatureBack,movementType,movement) 
            if movementType == ccs.MovementEventType.complete then
                armature:getAnimation():play("chixu" , -1, 1)
            end 
        end)
	    armature:getAnimation():play("start" , -1, 0)

		labelGun:enableOutline(cc.c4b(0, 0, 0,255), 1)
		labelGun:setString(weaponName)
	    labelSuipian:setVisible(false)

	elseif properties.type == "suipian" then
		math.randomseed(os.time())
	    local rans = math.random(1,5)
		local skin = ccs.Skin:createWithSpriteFrameName("icon_lingjian0"..rans..".png")
	    armature:getBone("icon_wuqi"):addDisplay(skin, 1)
	    armature:getBone("icon_wuqi"):changeDisplayWithIndex(1, true)

		armature:getAnimation():setMovementEventCallFunc(   
         function (armatureBack,movementType,movement) 
            if movementType == ccs.MovementEventType.complete then
                armature:getAnimation():play("chixu02" , -1, 1)
            end
        end)
	    armature:getAnimation():play("start02" , -1, 0)

		local weaponName = self.weaponListModel:getWeaponNameByID(properties.weaponId)
		labelSuipian:enableOutline(cc.c4b(0, 0, 0,255), 1)
	    labelSuipian:setString(weaponName.."零件")
	    labelGun:setVisible(false)
    elseif properties.type == "goldGift" then
    	labelSuipian:setVisible(false)
    	labelGun:setVisible(false)
		cc.FileUtils:getInstance():addSearchPath("res/GiftBag/GiftBag")
		local skin1 = ccs.Skin:create("icon_libao2.png")
		local skin2 = ccs.Skin:create("icon_libao1.png")
		local skin3 = ccs.Skin:create("icon_libao3.png")
	    armature:getBone("icon_libao1"):addDisplay(skin1, 1)
	    armature:getBone("icon_libao2"):addDisplay(skin2, 1)
	    armature:getBone("icon_libao3"):addDisplay(skin3, 1)
	    armature:getBone("icon_libao1"):changeDisplayWithIndex(1, true)
	    armature:getBone("icon_libao2"):changeDisplayWithIndex(1, true)
	    armature:getBone("icon_libao3"):changeDisplayWithIndex(1, true)
		armature:getAnimation():setMovementEventCallFunc(   
         function (armatureBack,movementType,movement) 
            if movementType == ccs.MovementEventType.complete then
                armature:getAnimation():play("chixu03" , -1, 1)
            end
        end)
	    armature:getAnimation():play("start03" , -1, 0)
	end
end

function WeaponNotifyLayer:onBtnGetClicked()
	local onCloseFunc = self.properties["onCloseFunc"]
	ui:closePopup("WeaponNotifyLayer", {onCloseFunc = onCloseFunc})
end

return WeaponNotifyLayer