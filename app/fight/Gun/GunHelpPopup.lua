local GunHelpPopup = class("GunHelpPopup", function()
	return display.newLayer()
end)

function GunHelpPopup:ctor(properties)
    self.fightGun = md:getInstance("FightGun")
    self.gunId = properties.gunId

    cc.EventProxy.new(self.fightGun, self)
        :addEventListener(self.fightGun.HELP_START_EVENT, handler(self, self.onShow))
    self:loadCCS()
    self:onShow()
end

function GunHelpPopup:loadCCS()
    local manager = ccs.ArmatureDataManager:getInstance() 
    manager:addArmatureFileInfo("res/Fight/uiAnim/yd_saosan/yd_saosan.ExportJson")
    display.addSpriteFrames("res/Fight/uiAnim/yd_saosan/yd_saosan0.plist", 
        "res/Fight/uiAnim/yd_saosan/yd_saosan0.png")     

	self.node = cc.uiloader:load("res/Fight/fightLayer/fightTips/helpWeapon.ExportJson")
    self:addChild(self.node)
    self.nameNode   = cc.uiloader:seekNodeByName(self.node, "nameNode")
    self.btnGet     = cc.uiloader:seekNodeByName(self.node, "btnGet")
    self.gunDisplay = cc.uiloader:seekNodeByName(self.node, "gunDisplay")
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

function GunHelpPopup:onShow(event)
    --refresh ui
    self.gunDisplay:removeAllChildren()

    --armature
    local armature = ccs.Armature:create("yd_saosan")
    armature:getAnimation():play("yd_saosan", -1, 1)
    self.btnGet:addChild(armature, 10)

    --gun icon
    local record = getRecordByKey("config/weapon_weapon.json", "id", self.gunId)[1]
    assert(record, "record is nil id is "..self.gunId)
    local icon = display.newSprite("#icon_"..record["imgName"]..".png")    
    addChildCenter(icon, self.gunDisplay)    

    --gun name 
    local nameImg = display.newSprite("#name_"..record["imgName"]..".png")
    nameImg:setAnchorPoint(0.5,0.5)
    self.nameNode:addChild(nameImg)

    --action
    local x,y = self.node:getPosition()
    self.node:setPositionY(display.height1)
    self.node:moveTo(1.0, x, y)

    --pause
    local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:pauseFight(true)    
end

function GunHelpPopup:onClickGet()
    self.fightGun:changeHelpGun(self.gunId)

    --pause
    local fightFactory =    md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
    fight:pauseFight(false)

    --check
    if self.gunId == 9 then 
        local hero = md:getInstance("Hero")
        hero:dispatchEvent({name = hero.EFFECT_GUIDE_EVENT, animName = "saoshe"})
    end
    
    --close
    ui:closePopup("GunHelpPopup", {animName = "normal"})
end


return GunHelpPopup