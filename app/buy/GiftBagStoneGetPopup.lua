

local GiftBagStoneGetPopup = class("GiftBagStoneGetPopup", function()
	return display.newLayer()
end)

function GiftBagStoneGetPopup:ctor(property)
	dump(property, "property")
	--instance
	self.property = property
	self:loadCCS()
end

function GiftBagStoneGetPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/WeaponNotify")
    self.ui = cc.uiloader:load("giftGet.ExportJson")
    self:addChild(self.ui)

    local btnGet = cc.uiloader:seekNodeByName(self.ui, "btnGet")
    btnGet:onButtonClicked(function()
        self:onBtnGetClicked()
    end)  

    --armature
    local src = "res/WeaponNotify/hdxkwq/hdxkwq.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    local plist = "res/WeaponNotify/hdxkwq/hdxkwq0.plist"
    local png = "res/WeaponNotify/hdxkwq/hdxkwq0.png"
    display.addSpriteFrames(plist,png)

    local armature = ccs.Armature:create("hdxkwq")
    -- local skin1 = ccs.Skin:create("icon_hql.png")
    -- local skin1 = ccs.Skin:create("icon_libao2.png")
    -- local bone = armature:getBone("icon_hql")
    -- bone:addDisplay(skin1, 1)
    -- bone:changeDisplayWithIndex(1, true)
    local layerContent = cc.uiloader:seekNodeByName(self.ui, "layerContent")
    layerContent:addChild(armature)

    armature:getAnimation():setMovementEventCallFunc(
	    function (armatureBack,movementType,movement) 
	        if movementType == ccs.MovementEventType.complete then
	            armature:getAnimation():play("chixu_xsdc" , -1, 1)
	        end
	    end)
    armature:getAnimation():play("start_xsdc" , -1, 0)    
end

function GiftBagStoneGetPopup:onBtnGetClicked()
	self:onClickClose()
end

function GiftBagStoneGetPopup:onClickClose()
	ui:closePopup("GiftBagStoneGetPopup")
end

return GiftBagStoneGetPopup
