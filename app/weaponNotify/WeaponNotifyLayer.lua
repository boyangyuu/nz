local LayerColor_BLACK = cc.c4b(0, 0, 0, 180)

local WeaponNotifyLayer = class("WeaponNotifyLayer", function()
	return display.newColorLayer(LayerColor_BLACK)
end)


--[[
		ui:showPopup("WeaponNotifyLayer",
			 {type = "gun",weaponId = 3})
]]
function WeaponNotifyLayer:ctor(properties)
	self.weaponListModel = md:getInstance("WeaponListModel")

	self.properties = properties
	self:loadCCS()
	self:initUI(properties)
end

function WeaponNotifyLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/WeaponNotify")
    local controlNode = cc.uiloader:load("huoqujiangli_1.ExportJson")
    self:addChild(controlNode)
end

function WeaponNotifyLayer:initUI(properties)


    local btnGet = cc.uiloader:seekNodeByName(self, "btnGet")
    local labelName = cc.uiloader:seekNodeByName(self, "labelName")
    local panelAnim = cc.uiloader:seekNodeByName(self, "panelAnim")
    btnGet:onButtonClicked(function()
        self:onBtnGetClicked()
    end)


	-- Anim
    local src = "res/WeaponNotify/hdxkwq/hdxkwq.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/WeaponNotify/hdxkwq/hdxkwq0.plist"
    local png = "WeaponNotify/Start/hdxkwq/hdxkwq0.png"
    display.addSpriteFrames(plist,png)

    local armature = ccs.Armature:create("hdxkwq")
    panelAnim:addChild(armature,100)



	if properties.type == "gun" then
		local imgName = self.weaponListModel:getWeaponImgByID(properties.weaponId)
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

	    labelName:setVisible(false)

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
	    labelName:setString(weaponName.."零件")
	end

end

function WeaponNotifyLayer:onBtnGetClicked()
	ui:closePopup("WeaponNotifyLayer")

	--guide
	local guide = md:getInstance("Guide")
	guide:check("afterfight01")	
	guide:check("afterfight03")	
end

return WeaponNotifyLayer