import("..includes.functionUtils")

local WeaponListCell = import(".WeaponListCell")
local WeaponListModel = import(".WeaponListModel")
local WeaponBag = import(".WeaponBag")
local PopupCommonLayer = import("..popupCommon.PopupCommonLayer")

local WeaponListLayer = class("WeaponListLayer", function()
	return display.newLayer()
end)


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
    cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
    local controlNode = cc.uiloader:load("gunzb_1.json")
    self.ui = controlNode
    self:addChild(controlNode)
end

function WeaponListLayer:initUI()
    self.weaponLV         = cc.uiloader:seekNodeByName(self, "ListView_49")
    self.labelName        = cc.uiloader:seekNodeByName(self, "label_name")
    self.labelDescribe    = cc.uiloader:seekNodeByName(self, "label_describe")
    self.layerGun         = cc.uiloader:seekNodeByName(self, "panel_gun")
    self.progBullet       = cc.uiloader:seekNodeByName(self, "progress_bullet")
    self.progAccuracy     = cc.uiloader:seekNodeByName(self, "progress_accuracy")
    self.progReload       = cc.uiloader:seekNodeByName(self, "progress_reload")
    self.progBulletNext   = cc.uiloader:seekNodeByName(self, "progress_bulletnext")
    self.progAccuracyNext = cc.uiloader:seekNodeByName(self, "progress_accuracynext")
    self.progReloadNext   = cc.uiloader:seekNodeByName(self, "progress_reloadnext")
    self.labelDamage      = cc.uiloader:seekNodeByName(self, "Label_damage")
    self.labelPercent     = cc.uiloader:seekNodeByName(self, "Label_percent")
    self.btnEquiped       = cc.uiloader:seekNodeByName(self, "btn_equiped")
    self.btnEquip         = cc.uiloader:seekNodeByName(self, "btn_equip")
    self.btnUpgrade       = cc.uiloader:seekNodeByName(self, "btn_upgrade")
    self.btnFull          = cc.uiloader:seekNodeByName(self, "btn_full")
    self.btnOncefull      = cc.uiloader:seekNodeByName(self, "btn_oncefull")
    self.btnBuy           = cc.uiloader:seekNodeByName(self, "btn_buy")
    self.labelEquiped     = cc.uiloader:seekNodeByName(self, "Label_15")
    self.stars = {}
    for i=1,10 do
        local star = cc.uiloader:seekNodeByName(self, "icon_sx0"..i)
        star:setVisible(false)
        table.insert(self.stars,star)
    end
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
            self:strengthen(self.weaponId)
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
		item:setItemSize(120, 140)
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
    if index == nil then index = self.selectedCellId end
    
    self.selectedCellId = index

    -- 选择状态
    local itemContent = self.weaponLV.items_[index]:getContent()
    if self.selectedContent == nil then
        self.selectedContent = itemContent
    else
        self.selectedContent:setSelected(false)
        self.selectedContent = itemContent
    end
    itemContent:setSelected(true)

    -- 详情内容
    for k,v in pairs(self.stars) do
            v:setVisible(false)
    end
    self.layerGun:removeAllChildren()
    self.weaponrecord = WeaponListModel:getWeaponRecord(index)
    self.weaponId = self.weaponrecord["id"]
    self.labelName:setString(self.weaponrecord["name"])
    self.labelDescribe:setString(self.weaponrecord["describe"])
    local weaponImg = cc.ui.UIImage.new("WeaponList/"..self.weaponrecord["imgName"]..".png")
    weaponImg:setLayoutSize(430, 180)
    addChildCenter(weaponImg, self.layerGun)
    local bulletNum,accuracy,reloadTime,demage,bulletNumNext,accuracyNext,
    reloadTimeNext,demageNext,demageMax = self.weaponListModel:getWeaponProperity(self.weaponId)
    self.progBullet  :setPercent(bulletNum/85*100)
    self.progAccuracy:setPercent(accuracy/99*100)
    self.progReload  :setPercent((1-reloadTime/4.2)*100)
    self.progBulletNext  :setPercent(bulletNumNext/85*100)
    self.progAccuracyNext:setPercent(accuracyNext/99*100)
    self.progReloadNext  :setPercent((1-reloadTimeNext/4.2)*100)
    self.labelDamage :setString(demage)
    local num = ((demageNext-demage)/demageMax*100)-((demageNext-demage)/demageMax*100)%0.01
    self.labelPercent:setString(num.."%")
    local x = tonumber(self.weaponListModel:getIntenlevel(self.weaponId))
    if x == 0 then
        for k,v in pairs(self.stars) do
            v:setVisible(false)
        end
    else
        for k,v in pairs(self.stars) do
            if k<x+1 then
                v:setVisible(true)
            end
        end
    end
    self.weaponListModel:getWeaponProperity(self.weaponId)
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
        self.btnUpgrade:setVisible(false)
        self.btnBuy:setVisible(true)
        self.btnEquip:setVisible(false)
    end
    if self.weaponListModel:isWeaponed(weaponid) ~= 0 then
        self.btnEquiped:setVisible(true)
        self.btnEquip:setVisible(false)
        self.labelEquiped:setString(self.weaponListModel:isWeaponed(weaponid))    
    end
end              

-- 购买事件
function WeaponListLayer:buyWeapon(weaponid)
    self.weaponListModel:buyWeapon(weaponid)
end

-- 升级事件
function WeaponListLayer:strengthen(weaponid)
    self.weaponListModel:strengthen(weaponid)
end

-- 一键满级事件
function WeaponListLayer:onceFull(weaponid)
    self.weaponListModel:onceFull(weaponid)
end

-- 装备事件
function WeaponListLayer:equip(weaponid)
   app:getInstance(PopupCommonLayer):showPopup(WeaponBag.new(weaponid),0)
end

return WeaponListLayer