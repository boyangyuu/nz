local GunHelpLayer = class("GunHelpLayer", function()
	return display.newLayer()
end)

function GunHelpLayer:ctor()
    self.fightGun = md:getInstance("FightGun")

    cc.EventProxy.new(self.fightGun, self)
        :addEventListener(self.fightGun.HELP_START_EVENT, handler(self, self.onShow))
        
	self:loadCCS()
    self:setTouchSwallowEnabled(false)
    self.node:setVisible(false)
end

function GunHelpLayer:loadCCS()
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo("res/Fight/uiAnim/yd_saos/yd_saos.csb")
    display.addSpriteFrames("res/Fight/uiAnim/yd_saos/yd_saos0.plist", 
        "res/Fight/uiAnim/yd_saos/yd_saos0.png")     
    manager:addArmatureFileInfo("res/Fight/uiAnim/yd_saosan/yd_saosan.csb")
    display.addSpriteFrames("res/Fight/uiAnim/yd_saosan/yd_saosan0.plist", 
        "res/Fight/uiAnim/yd_saosan/yd_saosan0.png")     


	self.node = cc.uiloader:load("res/fight/helpWeapon/helpWeapon.ExportJson")
    self:addChild(self.node)
    self.nameNode = cc.uiloader:seekNodeByName(self, "nameNode")
    self.btnGet     = cc.uiloader:seekNodeByName(self, "btnGet")
    self.gunDisplay = cc.uiloader:seekNodeByName(self, "gunDisplay")
    self.btnGet:onButtonPressed(function( event )
        event.target:setScale(1.2)
    end)
    :onButtonRelease(function( event )
        event.target:setScale(1.0)
    end)
    :onButtonClicked(function()
         self:onClickGet()
    end)
end

function GunHelpLayer:onShow(event)
    self.node:setVisible(true)
    --refresh ui
    self.gunDisplay:removeAllChildren()

    --armature
    local armature = ccs.Armature:create("yd_saosan")
    armature:getAnimation():play("yd_saosan", -1, 1)
    self.btnGet:addChild(armature, 10)

    --gun icon
    self.gunId = event.gunId
    local record = getRecordByKey("config/weapon_weapon.json", "id", self.gunId)[1]
    assert(record, "record is nil id is "..self.gunId)
    local icon = display.newSprite("#icon_"..record["imgName"]..".png")    
    icon:setScaleX(0.2)
    icon:setScaleY(0.2)
    icon:scaleTo(0.7, 0.7)
    addChildCenter(icon, self.gunDisplay)    

    --gun name 
    local nameImg = display.newSprite("#name_"..record["imgName"]..".png")
    nameImg:setAnchorPoint(0.5,0.5)
    self.nameNode:addChild(nameImg)

    --action
    local x,y = self.node:getPosition()
    self.node:setPositionY(display.height1)
    self.node:moveTo(1.0, x, y)
end

function GunHelpLayer:onClickGet()
    print("function GunHelpLayer:onClickGet()")
    self.node:setVisible(false)
    self.fightGun:changeHelpGun(self.gunId)
    if self.gunId == 8 then
        print("function GunHelpLayer:onClickGe111")
        self:showHelpDesc()
    end
end

function GunHelpLayer:showHelpDesc()
    local armature = ccs.Armature:create("yd_saos")
    armature:setPosition(cc.p(690, 465))
    armature:getAnimation():play("shan", -1, 1)
    self:addChild(armature, 10)

    local removeFunc = function ()
        armature:removeSelf()
        armature = nil
    end
    self:performWithDelay(removeFunc, 10.0)
end

return GunHelpLayer