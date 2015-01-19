import("..includes.functionUtils")
local scheduler          = require(cc.PACKAGE_NAME .. ".scheduler")

local WeaponListCell = import(".WeaponListCell")
local WeaponBag = import(".WeaponBag")

local WeaponListLayer = class("WeaponListLayer", function()
	return display.newLayer()
end)

local kMaxBullet = 200
local kMaxAccuracy = 100
local kMaxSpeed = 1

function WeaponListLayer:ctor()

    -- instance
    self.selectedContent = nil
    self.selectedCellId  = 1
    self.weaponId = nil
    self.weaponListModel = md:getInstance("WeaponListModel")
    self.commonPopModel = md:getInstance("commonPopModel")
    self.userModel = md:getInstance("UserModel")
    --events
    cc.EventProxy.new(self.weaponListModel, self)
        :addEventListener(self.weaponListModel.REFRESHBTN_EVENT, handler(self, self.refresh))
    -- ui
	cc.FileUtils:getInstance():addSearchPath("res/WeaponList/")
	self:loadCCS()
	self:initUI()

    -- 点开页面默认选择某个武器
    print("self:refreshComment(self.selectedCellId)")
      self:refreshComment(self.selectedCellId)
    
end

-- loadCCS
function WeaponListLayer:loadCCS()
    -- load control bar
    cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
    local controlNode = cc.uiloader:load("wuqiku.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

    -- anim
    local src = "res/WeaponList/btbuyanim/bt_goumai.csb"
    local starsrc = "res/FightResult/anim/gkjs_xing/gkjs_xing.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(starsrc)

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
    self.equipedju       = cc.uiloader:seekNodeByName(self, "bag3")
    self.upgradecost      = cc.uiloader:seekNodeByName(self, "upgradecost")
    self.buycost      = cc.uiloader:seekNodeByName(self, "buycost")
    self.damagepluse      = cc.uiloader:seekNodeByName(self, "damagepluse")

    local shanghai = cc.uiloader:seekNodeByName(self, "shanghai")
    local jingzhun = cc.uiloader:seekNodeByName(self, "jingzhun")
    local huandan = cc.uiloader:seekNodeByName(self, "huandan")
    local danjia = cc.uiloader:seekNodeByName(self, "danjia")
    local zhuangbei = cc.uiloader:seekNodeByName(self, "zhuangbei")
    local yimanji = cc.uiloader:seekNodeByName(self, "yimanji")
    local shengji = cc.uiloader:seekNodeByName(self, "shengji")
    local goumai = cc.uiloader:seekNodeByName(self, "goumai")
    local yijianmanji = cc.uiloader:seekNodeByName(self, "yijianmanji")
    self.buycost:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.upgradecost:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.damagepluse:enableOutline(cc.c4b(0, 255, 79,255), 2)
    self.damagepluse:setColor(cc.c3b(0, 255, 79))
    yijianmanji:enableOutline(cc.c4b(0, 0, 0,255), 2)
    shanghai:enableOutline(cc.c4b(0, 0, 0,255), 2)
    jingzhun:enableOutline(cc.c4b(0, 0, 0,255), 2)
    huandan:enableOutline(cc.c4b(0, 0, 0,255), 2)
    danjia:enableOutline(cc.c4b(0, 0, 0,255), 2)
    zhuangbei:enableOutline(cc.c4b(0, 0, 0,255), 2)
    yimanji:enableOutline(cc.c4b(0, 0, 0,255), 2)
    shengji:enableOutline(cc.c4b(0, 0, 0,255), 2)
    goumai:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.stars = {}
    for i=1,10 do
        self.stars[i] = cc.uiloader:seekNodeByName(self.paneldetail, "icon_sx0"..i)
        self.stars[i]:setVisible(false)
    end

    self.panlStars = {}
    for i=1,10 do
        self.panlStars[i] = cc.uiloader:seekNodeByName(self.paneldetail, "Panel_x_"..i)
    end

    self.labelDamage = cc.uiloader:seekNodeByName(self.paneldetail, "labeldamage")

    self.progBullet = cc.uiloader:seekNodeByName(self.paneldetail, "progressbullet")
    self.progAccuracy = cc.uiloader:seekNodeByName(self.paneldetail, "progressaccuracy")
    self.progReload = cc.uiloader:seekNodeByName(self.paneldetail, "progressreload")

    self.progBulletNext   = cc.uiloader:seekNodeByName(self.paneldetail, "progressbulletnext")
    self.progAccuracyNext = cc.uiloader:seekNodeByName(self.paneldetail, "progressaccuracynext")
    self.progReloadNext   = cc.uiloader:seekNodeByName(self.paneldetail, "progressreloadnext")

    self.progReloadMax   = cc.uiloader:seekNodeByName(self.paneldetail, "progressreloadmax")
    self.progBulletMax   = cc.uiloader:seekNodeByName(self.paneldetail, "progressbulletmax")
    self.progAccuracyMax   = cc.uiloader:seekNodeByName(self.paneldetail, "progressaccuracymax")

    self.labelName        = cc.uiloader:seekNodeByName(self.paneldetail, "labelname")
    self.labelDescribe    = cc.uiloader:seekNodeByName(self.paneldetail, "labeldescribe")

    self.equipedone:setVisible(false)
    self.equipedtwo:setVisible(false)
    
    self.weaponLV:onTouch(handler(self,self.touchListener))
    local configTab = getConfig("config/weapon_weapon.json")
    self:loadWeaponList(self.weaponLV, configTab)
    self.btnBuy:setTouchEnabled(true)
    self.btnUpgrade:setTouchEnabled(true)
    self.btnOncefull:setTouchEnabled(true)
    self.btnEquip:setTouchEnabled(true)
    self.btnEquiped:setTouchEnabled(true)
    addBtnEventListener(self.btnBuy, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then

            if self.userModel:costDiamond(self.weaponrecord["cost"]) then
                ui:showPopup("commonPopup",
                    {type = "style3", content = "是否花费60钻石升级购买该武器？",
                     callfuncCofirm =  handler(self, self.buyWeapon),
                     callfuncClose  =  handler(self, self.closePopup)},
                     { opacity = 155})

            else
                local buy = md:getInstance("BuyModel")
                buy:buy("weaponGiftBag", {weaponId = self.weaponId})
            end

            

            -- if self.userModel:costDiamond(self.weaponrecord["cost"]) then
            --     self:buyWeapon(self.weaponId)
            -- end
        end
    end)
    addBtnEventListener(self.btnUpgrade, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            local nextlevel = self.weaponListModel:getIntenlevel(self.weaponId)+1
            -- ui:showPopup("commonPopup",
            --  {type = "style3", title = "提示",content = "是否花费"..self.costupgrade.."G升级到"..nextlevel.."星"},
            --  {opacity = 155})
            if self.userModel:costMoney(self.costupgrade) then
                self:intensify(self.weaponId)
                local armature = ccs.Armature:create("wqsj")
                addChildCenter(armature, self.layerGun)
                armature:getAnimation():setMovementEventCallFunc(
                function ( armatureBack,movementType,movement) 
                    if movementType == ccs.MovementEventType.complete then
                        armatureBack:stopAllActions()
                        armatureBack:removeFromParent() 
                    end 
                end)
                armature:getAnimation():play("wqsj" , -1, 0)

            end
        end
    end)
    addBtnEventListener(self.btnOncefull, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:onceFull(self.weaponId)
            -- todo 改为buymodel
            -- local data = getUserData()
            -- if not data.giftBag.weaponGiftBag then
            --     ui:showPopup("GiftBagPopup",{popupName = "weaponGiftBag",callBack = function()
            --     self:onceFull(self.weaponId)
            --     end})
            -- end
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

    addBtnEventListener(self.btnEquiped, function(event)
        if event.name=='began' then
            print("offbtn is begining!")
            return true
        elseif event.name=='ended' then
            self:equip(self.weaponId)
        end
    end)

    --anim
    local armature = ccs.Armature:create("bt_goumai")
    local oncearmature = ccs.Armature:create("bt_goumai")
    addChildCenter(armature, self.btnBuy)
    addChildCenter(oncearmature, self.btnOncefull)
    armature:getAnimation():play("yjmj" , -1, 1)
    oncearmature:getAnimation():play("yjmj" , -1, 1)

end


-------------- ListView  --------------
-- 初始化ListView
function WeaponListLayer:loadWeaponList(weaponListView, weaponTable)
	for i=1, #weaponTable do
		local weaponRecord = self.weaponListModel:getWeaponRecord(i)
        local item = weaponListView:newItem()
		-- local item
		local content
		if weaponTable[i] then
			content = WeaponListCell.new({weaponRecord = weaponRecord})
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
    self:refreshComment(self.selectedCellId,event.star,event.intenlevel)
    self:showButton(event)
end

-- 通过index选择Cell  refreshComment(cellIndex)  
function WeaponListLayer:refreshComment(index,refreshStar,intenlevel)
    for k,v in pairs(self.panlStars) do
        if self.starArmature then
            v:removeAllChildren()
        end
    end


    if index == nil then index = self.selectedCellId end
    
    self.selectedCellId = index

    -- refresh 详情内容
    for k,v in pairs(self.stars) do
            v:setVisible(false)
    end
    self.layerGun:removeAllChildren()
    self.weaponrecord = self.weaponListModel:getWeaponRecord(index)
    self.weaponId = self.weaponrecord["id"]
    self.labelName:setString(self.weaponrecord["name"])
    self.buycost:setString(self.weaponrecord["cost"])
    self.labelDescribe:setString(self.weaponrecord["describe"])
    local weaponImg = display.newSprite("#icon_"..self.weaponrecord["imgName"]..".png")
    addChildCenter(weaponImg, self.layerGun)
    local imageName = self.weaponrecord["imgName"]
    local weaponSpc = cc.uiloader:load("res/WeaponList/wutexing/wutexing_"..imageName..".ExportJson")
    if weaponSpc then
        self.layerGun:addChild(weaponSpc)
    end

    local weaponproperity = self.weaponListModel:getWeaponProperity(self.weaponId)
    local weaponproperitynext = self.weaponListModel:getWeaponProperity(self.weaponId,"nextLevel")
    local weaponproperitymax = self.weaponListModel:getWeaponProperity(self.weaponId,"maxLevel")

    local bulletNum = weaponproperity.bulletNum
    local accuracy = weaponproperity.accuracy
    local reloadTime = weaponproperity.reloadTime
    local demage = weaponproperity.demage

    local bulletNumNext = weaponproperitynext.bulletNum
    local accuracyNext = weaponproperitynext.accuracy
    local reloadTimeNext = weaponproperitynext.reloadTime
    local demageNext = weaponproperitynext.demage

    local bulletNumMax = weaponproperitymax.bulletNum
    local accuracyMax = weaponproperitymax.accuracy
    local reloadTimeMax = weaponproperitymax.reloadTime
    local demageMax = weaponproperitymax.demage

    self.costupgrade = weaponproperitynext.upgradecost
    self.upgradecost:setString(self.costupgrade)

    self.progBullet:setPercent(bulletNum/kMaxBullet*100)
    self.progAccuracy:setPercent(accuracy/kMaxAccuracy*100)
    self.progReload  :setPercent((kMaxSpeed/reloadTime)*100)

    self.progBulletNext  :setPercent(bulletNumNext/kMaxBullet*100)
    self.progAccuracyNext:setPercent(accuracyNext/kMaxAccuracy*100)
    self.progReloadNext  :setPercent((kMaxSpeed/reloadTimeNext)*100)

    self.progBulletNext:setBreath()
    self.progAccuracyNext:setBreath()
    self.progReloadNext:setBreath()

    self.progBulletMax:setPercent(bulletNumMax/kMaxBullet*100)
    self.progReloadMax:setPercent((kMaxSpeed/reloadTimeMax)*100)
    self.progAccuracyMax:setPercent(accuracyMax/kMaxAccuracy*100)
    self.labelDamage:setScale(0.7)
    self.labelDamage :setString(demage)
    local num = ((demageNext-demage)/demageMax*100)-((demageNext-demage)/demageMax*100)%0.01
    self.labelPercent:setString(num.."%")
    self.damagepluse:setString("+"..demageNext-demage)
    local action = transition.sequence({
        cc.FadeOut:create(1),
        cc.FadeIn:create(1),})
    self.damagepluse:runAction(cc.RepeatForever:create(action))


    self:playstar(refreshStar,intenlevel)

    -- refresh 选择状态
    local itemContent = self.weaponLV.items_[index]:getContent()
    if self.selectedContent == nil then
        self.selectedContent = itemContent
    else
        self.selectedContent:setSelected(false)
        self.selectedContent = itemContent
    end

    self.selectedContent:setOwned(self.weaponId)

    itemContent:setSelected(true)

    -- refresh button
    self:showButton()
end
------------- 
function WeaponListLayer:playstar(refreshStar,intenlevel)
    local curLevel = tonumber(self.weaponListModel:getIntenlevel(self.weaponId))
    if curLevel == 0 then
        for k,v in pairs(self.stars) do
            v:setVisible(false)
        end
    else
        if refreshStar then
            local toLevel
            if intenlevel then
                toLevel = 10
                curLevel = intenlevel+1
            else
                toLevel = curLevel
            end
            local ind = 0
            for i=curLevel,toLevel do
                local delay = ind * 0.1
                ind = ind + 1
                function delayStar( )
                    self.starArmature = ccs.Armature:create("gkjs_xing")
                    self.starArmature:setPosition(19.5,19)
                    self.starArmature:setScale(0.448,0.452)
                    self.panlStars[i]:addChild(self.starArmature)
                    self.starArmature:getAnimation():play("gkjs_xing" , -1, 0)
                end
                scheduler.performWithDelayGlobal(delayStar, delay)
            end
        end 
        for k,v in pairs(self.stars) do
            if k<curLevel+1 then
                v:setVisible(true)
            end
        end
    end
end


-- 从数据获取当前weapon装备状态判断显示button
function WeaponListLayer:showButton()
    local weaponid = self.weaponId
    self.btnEquiped:setVisible(false)
    self.labelPercent:setVisible(true)
    self.damagepluse:setVisible(true)
    if self.weaponListModel:isWeaponExist(weaponid) then
            self.progBulletNext:setVisible(true)
        self.progAccuracyNext:setVisible(true)
        self.progReloadNext:setVisible(true)

        self.btnBuy:setVisible(false)
        self.btnEquip:setVisible(true)
        if self.weaponListModel:isFull(weaponid) then
            self.btnFull:setVisible(true)
            self.btnOncefull:setVisible(false)
            self.btnUpgrade:setVisible(false)
            self.labelPercent:setVisible(false)
            self.damagepluse:setVisible(false)
        else
            self.btnFull:setVisible(false)
            self.btnOncefull:setVisible(true)
            self.btnUpgrade:setVisible(true)
        end
    else
        self.progBulletNext:setVisible(false)
        self.progAccuracyNext:setVisible(false)
        self.progReloadNext:setVisible(false)
        self.damagepluse:setVisible(false)
        self.labelPercent:setVisible(false)
        self.btnFull:setVisible(false)
        self.btnOncefull:setVisible(false)
        self.btnUpgrade:setVisible(false)
        self.btnBuy:setVisible(true)
        self.btnEquip:setVisible(false)
    end
    if self.weaponListModel:getWeaponStatus(weaponid) ~= 0 then
        self.btnEquiped:setVisible(true)
        self.btnEquip:setVisible(false)
        local status = self.weaponListModel:getWeaponStatus(weaponid)
        if status == 1 then
            self.equipedju:setVisible(false)
            self.equipedtwo:setVisible(false)
            self.equipedone:setVisible(true)
        elseif status == 2 then
            self.equipedju:setVisible(false)
            self.equipedone:setVisible(false)
            self.equipedtwo:setVisible(true)
        elseif status == 3 then
            self.equipedju:setVisible(true)
            self.equipedone:setVisible(false)
            self.equipedtwo:setVisible(false)
        end
    end
end              

-- 购买事件
function WeaponListLayer:buyWeapon(event)
     ui:closePopup("commonPopup")
    function delay( )
        self.weaponListModel:buyWeapon(self.weaponId)
    end
    scheduler.performWithDelayGlobal(delay, 0.4)

end

-- 升级事件
function WeaponListLayer:intensify(event)
    -- ui:closePopup()
    -- function delayplaystar( )
        self.weaponListModel:intensify(self.weaponId)
    -- end
    -- scheduler.performWithDelayGlobal(delayplaystar, 0.4)

end

function WeaponListLayer:closePopup()
    ui:closePopup("commonPopup")
end

-- 一键满级事件
function WeaponListLayer:onceFull(weaponid)
    self.weaponListModel:onceFull(weaponid)
end

-- 装备事件
function WeaponListLayer:equip(weaponid)
    ui:showPopup("WeaponBag",{weaponid = weaponid},{opacity = 150})

end

return WeaponListLayer