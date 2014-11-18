local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")
local WeaponListModel = class("WeaponListModel", cc.mvc.ModelBase)

local WeaponBag = class("WeaponBag", function()
	return display.newLayer()
end)

function WeaponBag:ctor(weaponid)
    self.weaponid = weaponid
    self.weaponed = nil
    self.weaponListModel = app:getInstance(WeaponListModel)
	self:loadCCS()
	self:initUI()
    self:refreshData()
end

function WeaponBag:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/WeaponList/wuqilan")
    local controlNode = cc.uiloader:load("wuqilan_1.ExportJson")
    -- controlNode:setPosition(0, 0)
    self.ui = controlNode
    self:addChild(controlNode)
end

function WeaponBag:initUI()

    local btnOff   = cc.uiloader:seekNodeByName(self, "btn_close")
    self.weapon1   = cc.uiloader:seekNodeByName(self, "Panel_weapon1")
    self.weapon2   = cc.uiloader:seekNodeByName(self, "Panel_weapon2")
	
    self.weapon1:setTouchEnabled(true)
    self.weapon2:setTouchEnabled(true)
	btnOff      :setTouchEnabled(true)
    self.weapon1:setTouchEnabled(true)
    self.weapon2:setTouchEnabled(true)

	addBtnEventListener(btnOff, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onClickBtnOff()

        end
    end)
    self.weapon1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            print("began")
            return true
        elseif event.name=='ended' then
            print("ended")
            self.weaponListModel:equipBag(self.weaponid,1)
            self:refreshData()
        end
    end)
    self.weapon2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=='began' then
            print("began")
            return true
        elseif event.name=='ended' then
            print("ended")
            self.weaponListModel:equipBag(self.weaponid,2)
            self:refreshData()
        end
    end)
end
-- self.weaponListModel:equip(weaponrecord)
function WeaponBag:refreshData()
    self.weaponed = self.weaponListModel:getGun()
    self.weapon1:removeAllChildren()
    self.weapon2:removeAllChildren()
    local img1rec = getRecord(getConfig("config/weapon_weapon.json"), "id", self.weaponed[1]["weaponid"])
    local img2rec = getRecord(getConfig("config/weapon_weapon.json"), "id", self.weaponed[2]["weaponid"])
    local img1 = cc.ui.UIImage.new("WeaponList/"..img1rec[1]["imgName"]..".png")
    local img2 = cc.ui.UIImage.new("WeaponList/"..img2rec[1]["imgName"]..".png")
    addChildCenter(img1, self.weapon1)
    addChildCenter(img2, self.weapon2)
end



function WeaponBag:onClickBtnOff()
    app:getInstance(PopupCommonLayer):onExit()
end

return WeaponBag