local StoreLoadLayer = class("StoreLoadLayer", function()
    return display.newLayer()
end)

function StoreLoadLayer:ctor()
    self.buyModel = md:getInstance("BuyModel")
    cc.EventProxy.new(self.buyModel, self)
        :addEventListener(self.buyModel.BUY_SUCCESS_EVENT, handler(self, self.close))
        :addEventListener(self.buyModel.BUY_FAIL_EVENT, handler(self, self.close))

    self:initUI()
end

function StoreLoadLayer:initUI()
    local manager = ccs.ArmatureDataManager:getInstance()
    local src = "res/Store/buy_loading/buy_loading.ExportJson"
    manager:addArmatureFileInfo(src)
    local plist = "res/Store/buy_loading/buy_loading0.plist"
    local png   = "res/Store/buy_loading/buy_loading0.png"
    display.addSpriteFrames(plist, png)

    local armature = ccs.Armature:create("buy_loading")
    armature:setPosition(569,320)
    self:addChild(armature)
    armature:getAnimation():play("Animation1" , -1, 1)
end

function StoreLoadLayer:close()
    ui:closePopup("StoreLoadLayer",{animName = "normal"})
end

return StoreLoadLayer