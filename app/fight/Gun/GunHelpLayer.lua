local GunHelpLayer = class("GunHelpLayer", function()
	return display.newLayer()
end)

function GunHelpLayer:ctor()
    self.fightGun = md:getInstance("FightGun")

    cc.EventProxy.new(self.fightGun, self)
        :addEventListener(self.fightGun.HELP_START_EVENT, handler(self, self.onShow))
        
	self:loadCCS()
    self:setTouchSwallowEnabled(true)
    self:setVisible(false)
end

function GunHelpLayer:loadCCS()
	self.node = cc.uiloader:load("res/fight/helpWeapon/helpWeapon.ExportJson")
    self:addChild(self.node)
    self:setVisible(false)
    self.label_name = cc.uiloader:seekNodeByName(self, "label_name")
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
    self:setVisible(true)
    --refresh ui
    self.gunDisplay:removeAllChildren()
    -- self.label_name: 

    --gun icon
    self.gunId = event.gunId
    local record = getRecordByKey("config/weapon_weapon.json", "id", self.gunId)[1]
    assert(record, "record is nil id is "..self.gunId)
    local icon = display.newSprite("#icon_"..record["imgName"]..".png")    
    icon:setScaleX(0.2)
    icon:setScaleY(0.2)
    icon:scaleTo(0.7, 0.7)
    addChildCenter(icon, self.gunDisplay)    

    --action
    local x,y = self.node:getPosition()
    self.node:setPositionY(display.height1)
    self.node:moveTo(1.0, x, y)
end

function GunHelpLayer:onClickGet()
    print("function GunHelpLayer:onClickGet()")
    self:setVisible(false)
    self.fightGun:changeHelpGun(self.gunId)
end

return GunHelpLayer