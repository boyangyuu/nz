import("..includes.functionUtils")

local WeaponListCell = import(".WeaponListCell")
local WeaponListModel = import(".WeaponListModel")
local WeaponBag = import(".WeaponBag")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local WeaponListLayer = class("WeaponListLayer", function()
	return display.newLayer()
end)

local kMaxBullet = 100
local kMaxAccuracy = 100
local kMaxSpeed = 1

function WeaponListLayer:ctor()

    -- instance
    self.selectedContent = nil
    self.selectedCellId  = 3
    self.weaponId = nil
    self.weaponListModel = app:getInstance(WeaponListModel)
    
    --events
    cc.EventProxy.new(self.weaponListModel, self)
        :addEventListener(WeaponListModel.REFRESHBTN_EVENT, handler(self, self.refresh))
    
    -- ui
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList/")
	self:loadCCS()
	self:initUI()

    -- 点开页面默认选择某个武器
      self:refreshComment(self.selectedCellId)
    
end

-- loadCCS
function WeaponListLayer:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/WeaponList/wuqiku")
    local controlNode = cc.uiloader:load("wuqiku.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)
end

function WeaponListLayer:initUI()
    self.weaponLV         = cc.uiloader:seekNodeByName(self, "listviewweapon")
    self.layerbutton      = cc.uiloader:seekNodeByName(self, "panelbutton")
    self.paneldetail      = cc.uiloader:seekNodeByName(self, "paneldetail")

    self.layerGun         = cc.uiloader:seekNodeByName(self, "imgweapon")

    self.labelPercent     = cc.uiloader:seekNodeByName(self, "labelpercent")
    self.btnEquiped       = cc.uiloader:seekNodeByName(self.layerbutton, "btnequiped")
    self.btnEquip         = cc.uiloader:seekNodeByName(self.layerbutton, "btnequip")
    self.btnUpgrade       = cc.uiloader:seekNodeByName(self.layerbutton, "btnupgrade")
    self.btnFull          = cc.uiloader:seekNodeByName(self.layerbutton, "btnfull")
    self.btnOncefull      = cc.uiloader:seekNodeByName(self.layerbutton, "btnoncefull")
    self.btnBuy           = cc.uiloader:seekNodeByName(self.layerbutton, "btnbuy")
    self.equipedone       = cc.uiloader:seekNodeByName(self, "bag1")
    self.equipedtwo       = cc.uiloader:seekNodeByName(self, "bag2")
    self.equipedone:setVisible(false)
    self.equipedtwo:setVisible(false)
    
    self.weaponLV:onTouch(handler(self,self.touchListener))
    self:loadWeaponList(self.weaponLV, getConfig("config/weapon_weapon.json"))
    self.btnBuy:setTouchEnabled(true)
    self.btnUpgrade:setTouchEnabled(true)
    self.btnOncefull:setTouchEnabled(true)
    self.btnEquip:setTouchEnabled(true)
    addBtnEventListener(self.btnBuy, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:buyWeapon(self.weaponId)
        end
    end)
    addBtnEventListener(self.btnUpgrade, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:intensify(self.weaponId)
        end
    end)
    addBtnEventListener(self.btnOncefull, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onceFull(self.weaponId)
        end
    end)
    addBtnEventListener(self.btnEquip, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:equip(self.weaponId)
        end
    end)
end


-------------- ListView  --------------
-- 初始化ListView
function WeaponListLayer:loadWeaponList(weaponListView, weaponTable)
	for i=1, #weaponTable do
		-- local weaponRecord = getConfigByID("config/weapon_weapon.json", i)
		local weaponRecord = self.weaponListModel:getWeaponRecord(i)
        local item = weaponListView:newItem()
		-- local item
		local content
		if weaponTable[i] then
			content = WeaponListCell.new(weaponRecord)
		end
		item:addContent(content)
		item:setItemSize(280, 140)
		weaponListView:addItem(item)
	end
	weaponListView:reload()
end

-- ListView 点击事件
function WeaponListLayer:touchListener(event)
    if "clicked" == event.name then
     self:refreshComment(event.itemPos)
    end
end

function WeaponListLayer:refresh(event)
    -- dump(event, "WeaponListLayer:refresh(event)")
    self:refreshComment(self.selectedCellId)
    self:showButton(event)
end

-- 通过index选择Cell  refreshComment(cellIndex)  
function WeaponListLayer:refreshComment(index)
    local stars = {}
    for i=1,10 do
        stars[i] = cc.uiloader:seekNodeByName(self.paneldetail, "icon_sx0"..i)
        stars[i]:setVisible(false)
    end

    local labelDamage = cc.uiloader:seekNodeByName(self.paneldetail, "labeldamage")

    local progBullet = cc.uiloader:seekNodeByName(self.paneldetail, "progressbullet")
    local progAccuracy = cc.uiloader:seekNodeByName(self.paneldetail, "progressaccuracy")
    local progReload = cc.uiloader:seekNodeByName(self.paneldetail, "progressreload")

    local progBulletNext   = cc.uiloader:seekNodeByName(self.paneldetail, "progressbulletnext")
    local progAccuracyNext = cc.uiloader:seekNodeByName(self.paneldetail, "progressaccuracynext")
    local progReloadNext   = cc.uiloader:seekNodeByName(self.paneldetail, "progressreloadnext")

    local progReloadMax   = cc.uiloader:seekNodeByName(self.paneldetail, "progressreloadmax")
    local progBulletMax   = cc.uiloader:seekNodeByName(self.paneldetail, "progressbulletmax")
    local progAccuracyMax   = cc.uiloader:seekNodeByName(self.paneldetail, "progressaccuracymax")

    local labelName        = cc.uiloader:seekNodeByName(self.paneldetail, "labelname")
    local labelDescribe    = cc.uiloader:seekNodeByName(self.paneldetail, "labeldescribe")

    if index == nil then index = self.selectedCellId end
    
    self.selectedCellId = index

    -- refresh 选择状态
    local itemContent = self.weaponLV.items_[index]:getContent()
    if self.selectedContent == nil then
        self.selectedContent = itemContent
    else
        self.selectedContent:setSelected(false)
        self.selectedContent = itemContent
    end
    itemContent:setSelected(true)

    -- refresh 详情内容
    for k,v in pairs(stars) do
            v:setVisible(false)
    end
    self.layerGun:removeAllChildren()
    self.weaponrecord = WeaponListModel:getWeaponRecord(index)
    self.weaponId = self.weaponrecord["id"]
    labelName:setString(self.weaponrecord["name"])
    labelDescribe:setString(self.weaponrecord["describe"])
    local weaponImg = display.newSprite("#icon_"..self.weaponrecord["imgName"]..".png")
    weaponImg:setScale(1.2)
    addChildCenter(weaponImg, self.layerGun)

    local bulletNum = self.weaponListModel:getWeaponProperity(self.weaponId).bulletNum
    local accuracy = self.weaponListModel:getWeaponProperity(self.weaponId).accuracy
    local reloadTime = self.weaponListModel:getWeaponProperity(self.weaponId).reloadTime
    local demage = self.weaponListModel:getWeaponProperity(self.weaponId).demage

    local bulletNumNext = self.weaponListModel:getWeaponProperity(self.weaponId,"nextLevel").bulletNum
    local accuracyNext = self.weaponListModel:getWeaponProperity(self.weaponId,"nextLevel").accuracy
    local reloadTimeNext = self.weaponListModel:getWeaponProperity(self.weaponId,"nextLevel").reloadTime
    local demageNext = self.weaponListModel:getWeaponProperity(self.weaponId,"nextLevel").demage

    local bulletNumMax = self.weaponListModel:getWeaponProperity(self.weaponId,10).bulletNum
    local accuracyMax = self.weaponListModel:getWeaponProperity(self.weaponId,10).accuracy
    local reloadTimeMax = self.weaponListModel:getWeaponProperity(self.weaponId,10).reloadTime
    local demageMax = self.weaponListModel:getWeaponProperity(self.weaponId,10).demage



    progBullet:setPercent(bulletNum/kMaxBullet*100)
    progAccuracy:setPercent(accuracy/kMaxAccuracy*100)
    progReload  :setPercent((kMaxSpeed/reloadTime)*100)

    progBulletNext  :setPercent(bulletNumNext/kMaxBullet*100)
    progAccuracyNext:setPercent(accuracyNext/kMaxAccuracy*100)
    progReloadNext  :setPercent((kMaxSpeed/reloadTimeNext)*100)

    progBulletMax:setPercent(bulletNumMax/kMaxBullet*100)
    progReloadMax:setPercent((kMaxSpeed/reloadTimeMax)*100)
    progAccuracyMax:setPercent(accuracyMax/kMaxAccuracy*100)

    labelDamage :setString(demage)
    local num = ((demageNext-demage)/demageMax*100)-((demageNext-demage)/demageMax*100)%0.01
    self.labelPercent:setString(num.."%")
    local x = tonumber(self.weaponListModel:getIntenlevel(self.weaponId))
    if x == 0 then
        for k,v in pairs(stars) do
            v:setVisible(false)
        end
    else
        for k,v in pairs(stars) do
            if k<x+1 then
                v:setVisible(true)
            end
        end
    end

    -- refresh button
    self:showButton()
end
------------- 

-- 从数据获取当前weapon装备状态判断显示button
function WeaponListLayer:showButton()
    local weaponid = self.weaponId
    self.btnEquiped:setVisible(false)
    self.labelPercent:setVisible(true)
    if self.weaponListModel:isWeaponExist(weaponid) then
        self.btnBuy:setVisible(false)
        self.btnEquip:setVisible(true)
        if self.weaponListModel:isFull(weaponid) then
            self.btnFull:setVisible(true)
            self.btnOncefull:setVisible(false)
            self.btnUpgrade:setVisible(false)
            self.labelPercent:setVisible(false)
        else
            self.btnFull:setVisible(false)
            self.btnOncefull:setVisible(true)
            self.btnUpgrade:setVisible(true)
        end
    else
        self.btnFull:setVisible(false)
        self.btnOncefull:setVisible(false)
        self.btnUpgrade:setVisible(false)
        self.btnBuy:setVisible(true)
        self.btnEquip:setVisible(false)
    end
    if self.weaponListModel:isWeaponed(weaponid) ~= 0 then
        self.btnEquiped:setVisible(true)
        self.btnEquip:setVisible(false)
        if self.weaponListModel:isWeaponed(weaponid) == 1 then
            self.equipedtwo:setVisible(false)
            self.equipedone:setVisible(true)
        else
            self.equipedone:setVisible(false)
            self.equipedtwo:setVisible(true)
        end
    end
end              

-- 购买事件
function WeaponListLayer:buyWeapon(weaponid)
    self.weaponListModel:buyWeapon(weaponid)
end

-- 升级事件
function WeaponListLayer:intensify(weaponid)
    self.weaponListModel:intensify(weaponid)
end

-- 一键满级事件
function WeaponListLayer:onceFull(weaponid)
    self.weaponListModel:onceFull(weaponid)
end

-- 装备事件
function WeaponListLayer:equip(weaponid)
    -- app:getInstance(PopupCommonLayer):showPopup(WeaponBag.new(weaponid),0)
    ui:showPopup("WeaponBag",{weaponid = weaponid},{opacity = 0})
-- id = WeaponBag.new(weaponid),opacity = 0
end

return WeaponListLayer