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
    self.weaponId = 1

    self.weaponListModel = md:getInstance("WeaponListModel")
    self.commonPopModel = md:getInstance("commonPopModel")
    self.userModel = md:getInstance("UserModel")
    self.levelDetailModel = md:getInstance("LevelDetailModel")
    self.buyModel = md:getInstance("BuyModel")
    self.levelMapModel = md:getInstance("LevelMapModel")
end

function WeaponListLayer:onShow()
     if self.ui == nil then
        self.weaponId = 1
        --init ui
        cc.FileUtils:getInstance():addSearchPath("res/WeaponList/")
        self:loadCCS()
        self:initUI()
        self:initListView()
    end
    
    --refersh
    self:refreshUI() 

    --events
    cc.EventProxy.new(self.weaponListModel, self)
        :addEventListener(self.weaponListModel.WEAPON_UPDATE_EVENT   , handler(self, self.refreshUI))
        :addEventListener(self.weaponListModel.WEAPON_UPDATE_EVENT   , handler(self, self.refreshLists))
        :addEventListener(self.weaponListModel.WEAPON_STAR_ONE_EVENT , handler(self, self.playOneStar))
        :addEventListener(self.weaponListModel.WEAPON_STAR_FULL_EVENT, handler(self, self.playFullStar))

    --guide
    self:initGuide()        
end

function WeaponListLayer:loadCCS()
    cc.FileUtils:getInstance():addSearchPath("res/WeaponList")
    self.ui = cc.uiloader:load("wuqiku.ExportJson")
    assert(self.ui , "self.ui  is nil")
    self:addChild(self.ui)

    -- anim
    local src = "res/WeaponList/btbuyanim/bt_goumai.ExportJson"
    local starsrc = "res/FightResult/anim/gkjs_xing/gkjs_xing.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(starsrc)
    local plist = "res/WeaponList/btbuyanim/bt_goumai0.plist"
    local png = "res/WeaponList/btbuyanim/bt_goumai0.png"
    display.addSpriteFrames(plist,png)
    local starplist = "res/FightResult/anim/gkjs_xing/gkjs_xing0.plist"
    local starpng = "res/FightResult/anim/gkjs_xing/gkjs_xing0.png"
    display.addSpriteFrames(starplist,starpng)

    local wqsjsrc = "res/WeaponList/wqsj/wqsj.ExportJson"
    manager:addArmatureFileInfo(wqsjsrc)
    local plist = "res/WeaponList/wqsj/wqsj0.plist"
    local png   = "res/WeaponList/wqsj/wqsj0.png"
    display.addSpriteFrames(plist, png)          
end

function WeaponListLayer:initUI()
    self.weaponLV         = cc.uiloader:seekNodeByName(self, "listviewweapon")
    local layerBtn        = cc.uiloader:seekNodeByName(self, "panelbutton")
    self.paneldetail      = cc.uiloader:seekNodeByName(self, "paneldetail")
    self.panelDamage      = cc.uiloader:seekNodeByName(self, "Panel_damage")
    self.panelAccuracy    = cc.uiloader:seekNodeByName(self, "panelaccuracy")
    self.panelReload      = cc.uiloader:seekNodeByName(self, "panelreload")
    self.panelBullet      = cc.uiloader:seekNodeByName(self, "panelbullet")

    self.layerGun         = cc.uiloader:seekNodeByName(self.paneldetail, "imgweapon")

    self.labelPercent     = cc.uiloader:seekNodeByName(self.panelDamage, "labelpercent")
    self.btnEquiped       = cc.uiloader:seekNodeByName(layerBtn, "btnequiped")
    self.btnEquip         = cc.uiloader:seekNodeByName(layerBtn, "btnequip")
    self.btnUpgrade       = cc.uiloader:seekNodeByName(layerBtn, "btnupgrade")
    self.btnFull          = cc.uiloader:seekNodeByName(layerBtn, "btnfull")
    self.btnOncefull      = cc.uiloader:seekNodeByName(layerBtn, "btnoncefull")
    self.btnBuy           = cc.uiloader:seekNodeByName(layerBtn, "btnbuy")
    self.equipedone       = cc.uiloader:seekNodeByName(layerBtn, "bag1")
    self.equipedtwo       = cc.uiloader:seekNodeByName(layerBtn, "bag2")
    self.equipedju        = cc.uiloader:seekNodeByName(layerBtn, "bag3")
    self.upgradecost      = cc.uiloader:seekNodeByName(layerBtn, "upgradecost")
    self.buycost          = cc.uiloader:seekNodeByName(layerBtn, "buycost")
    self.damagepluse      = cc.uiloader:seekNodeByName(self.panelDamage, "damagepluse")
    self.suipiannum       = cc.uiloader:seekNodeByName(self.paneldetail, "suipiannum")

    cc.uiloader:seekNodeByName(self.panelDamage, "shanghai")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(self.panelAccuracy, "jingzhun")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(self.panelReload, "huandan")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(self.panelBullet, "danjia")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(layerBtn, "zhuangbei")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(layerBtn, "yimanji")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(layerBtn, "shengji")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(layerBtn, "goumai")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    cc.uiloader:seekNodeByName(layerBtn, "yijianmanji")
                :enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.buycost:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.upgradecost:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.damagepluse:enableOutline(cc.c4b(0, 255, 79,255), 2)
    self.damagepluse:setColor(cc.c3b(0, 255, 79))
    
    self.stars = {}
    self.panlStars = {}    
    for i=1,10 do
        self.stars[i] = cc.uiloader:seekNodeByName(self.paneldetail, "icon_sx0"..i)
        self.stars[i]:setVisible(false)
    end
    for i=1,10 do
        self.panlStars[i] = cc.uiloader:seekNodeByName(self.paneldetail, "Panel_x_"..i)
    end

    self.labelDamage = cc.uiloader:seekNodeByName(self.panelDamage, "labeldamage")

    self.progBullet = cc.uiloader:seekNodeByName(self.panelBullet, "progressbullet")
    self.progAccuracy = cc.uiloader:seekNodeByName(self.panelAccuracy, "progressaccuracy")
    self.progReload = cc.uiloader:seekNodeByName(self.panelReload, "progressreload")

    self.progBulletNext   = cc.uiloader:seekNodeByName(self.panelBullet, "progressbulletnext")
    self.progAccuracyNext = cc.uiloader:seekNodeByName(self.panelAccuracy, "progressaccuracynext")
    self.progReloadNext   = cc.uiloader:seekNodeByName(self.panelReload, "progressreloadnext")

    self.progReloadMax   = cc.uiloader:seekNodeByName(self.panelReload, "progressreloadmax")
    self.progBulletMax   = cc.uiloader:seekNodeByName(self.panelBullet, "progressbulletmax")
    self.progAccuracyMax   = cc.uiloader:seekNodeByName(self.panelAccuracy, "progressaccuracymax")

    self.labelName        = cc.uiloader:seekNodeByName(self.paneldetail, "labelname")
    self.labelDescribe    = cc.uiloader:seekNodeByName(self.paneldetail, "labeldescribe")

    self.equipedone:setVisible(false)
    self.equipedtwo:setVisible(false)
    self.equipedju:setVisible(false)
    
    self.weaponLV:onTouch(handler(self,self.touchListener))
    self.btnBuy:setTouchEnabled(true)
    self.btnUpgrade:setTouchEnabled(true)
    self.btnOncefull:setTouchEnabled(true)
    self.btnEquip:setTouchEnabled(true)
    self.btnEquiped:setTouchEnabled(true)
    addBtnEventListener(self.btnBuy, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnBuy()
        end
    end)
    addBtnEventListener(self.btnUpgrade, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            if self.userModel:costMoney(self.costupgrade) then
                local wqsj = "res/Music/ui/wqsj.wav"
                audio.playSound(wqsj,false)
                self:onClickBtnUpgrade(self.weaponId)
            else
                ui:showPopup("commonPopup",
                  {type = "style2", content = "您的金币不足"},
                  {opacity = 155})
            end
        end
    end)
    addBtnEventListener(self.btnOncefull, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnOncefull()
        end
    end)
    addBtnEventListener(self.btnEquip, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnEquip(self.weaponId)
        end
    end)

    addBtnEventListener(self.btnEquiped, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            self:onClickBtnEquip(self.weaponId)
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

function WeaponListLayer:onClickBtnEquip(weaponid)
    ui:showPopup("WeaponBag",{weaponid = weaponid},{opacity = 150})
end

function WeaponListLayer:onClickBtnOncefull()
    self.buyModel:showBuy("onceFull",{weaponid = self.weaponId},
             "武器库界面_点击一键满级"..self.weaponRecord["name"])
end

function WeaponListLayer:onClickBtnBuy()
    -- 暂时不用
    -- local guide = md:getInstance("Guide")
    -- if self.buyModel:checkBought("weaponGiftBag") == false then
    --     self.buyModel:showBuy("weaponGiftBag",{payDoneFunc = handler(self, self.onBuyWeaponGiftSucc),
    --       deneyBuyFunc = handler(self, self.onCancelWeaponGift),isNotPopKefu = true}, 
    --                                    "武器库界面_点击解锁武器"..self.weaponRecord["name"])
    -- end

    self:onCancelWeaponGift()

end

function WeaponListLayer:onClickBtnUpgrade(event)
    self.weaponListModel:intensify(self.weaponId)
end

function WeaponListLayer:onCancelWeaponGift()
    if self.userModel:getDiamond() >= self.weaponRecord["cost"] then
        ui:showPopup("commonPopup",
            {type = "style3", content = "是否花费"..self.weaponRecord["cost"].."宝石购买该武器？",
             callfuncCofirm =  handler(self, self.onBuyWeaponSucc),
             callfuncClose  =  handler(self, self.closePopup)},
             { opacity = 155})
    else
        local rmbCost = self.weaponRecord["rmbCost"]
        if  rmbCost == 6 then
            self.buyModel:showBuy("unlockWeapon",{weaponid = self.weaponId,
                payDoneFunc = handler(self, self.onBuyWeaponSucc)},
                 "武器库界面_点击解锁武器"..self.weaponRecord["name"])
        elseif rmbCost == 10 then
            self.buyModel:showBuy("highgradeWeapon",{weaponid = self.weaponId}, "武器库界面_点击解锁高级武器"..self.weaponRecord["name"])

        end
    end
end

function WeaponListLayer:onCancelOncefull()
    self.buyModel:showBuy("onceFull",{weaponid = self.weaponId}, "武器库界面_点击一键满级"..self.weaponRecord["name"])
end

function WeaponListLayer:onBuyWeaponGiftSucc()
    self.levelMapModel:hideGiftBagIcon()
end

function WeaponListLayer:onBuyWeaponSucc()
    if self.userModel:costDiamond(self.weaponRecord["cost"]) then
        self.weaponListModel:buyWeapon(self.weaponId)
        if self.weapontype == "ju" then
            self.weaponListModel:equipBag(self.weaponId,3)
        end
        local gmcg = "res/Music/ui/gmcg.wav"
        audio.playSound(gmcg,false)

        ui:showPopup("WeaponNotifyLayer",
         {type = "gun",weaponId = self.weaponId})
    end
end

function WeaponListLayer:initListView()
    removeAllItems(self.weaponLV)
    local configTab = getConfig("config/weapon_weapon.json")
   
    for i=1, #configTab do
        local weaponRecord = self.weaponListModel:getWeaponRecord(i)
        local item = self.weaponLV:newItem()
        local content
        if configTab[i] then
            content = WeaponListCell.new({weaponRecord = weaponRecord})
        end
        item:addContent(content)
        item:setItemSize(280, 140)
        self.weaponLV:addItem(item)
    end
    self.weaponLV:reload()

    self.selectedContent = nil
end

-- ListView 点击事件
function WeaponListLayer:touchListener(event)
    if "clicked" == event.name then
        self.weaponId = event.itemPos
        self:refreshUI()
    end
end

function WeaponListLayer:refreshUI(event)
    self:refreshComment()
    self:refreshBtns()
    self:refreshStar()
end

function WeaponListLayer:refreshLists()
    for k,item in pairs(self.weaponLV.items_) do
        local content = item:getContent()
        content:setOwned()
    end
end

function WeaponListLayer:refreshComment()
    -- refresh 详情内容
    self.layerGun:removeAllChildren()
    self.weaponRecord = self.weaponListModel:getWeaponRecord(self.weaponId)
    self.weaponId = self.weaponRecord["id"]
    self.weapontype = self.weaponRecord["type"]
    self.labelName:setString(self.weaponRecord["name"])
    self.buycost:setString(self.weaponRecord["cost"])
    self.labelDescribe:setString(self.weaponRecord["describe"])
    local weaponImg = display.newSprite("#icon_"..self.weaponRecord["imgName"]..".png")
    weaponImg:setScale(1.43)
    addChildCenter(weaponImg, self.layerGun)
    local imageName = self.weaponRecord["imgName"]
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

    local suipiannum = self.levelDetailModel:getSuiPianNum(self.weaponId)
    local needSuipianNum = self.levelDetailModel:getNeedSuipianNum(self.weaponId)
    local isGot = self.weaponListModel:isWeaponExist(self.weaponId)
    if self.weaponRecord["partNum"] ~= nil and not isGot then
        self.suipiannum:setVisible(true)
        self.suipiannum:setString("DSLJ"..suipiannum.."/"..needSuipianNum)
    elseif isGot then
        self.suipiannum:setVisible(false)
    end

    -- refresh 选择状态
    local itemContent = self.weaponLV.items_[self.weaponId]:getContent()
    if self.selectedContent == nil then
        self.selectedContent = itemContent
    else
        self.selectedContent:setSelected(false)
        self.selectedContent = itemContent
    end

    self.selectedContent:setOwned(self.weaponId)

    itemContent:setSelected(true)

end

function WeaponListLayer:playOneStar(event)
    local curLevel = tonumber(self.weaponListModel:getIntenlevel(self.weaponId))

    --hide
    self.stars[curLevel]:setVisible(false)

    --star
    local delay = 0.1
    function delayStar()
        self.starArmature = ccs.Armature:create("gkjs_xing")
        self.starArmature:setPosition(19.5,19)
        self.starArmature:setScale(0.448,0.452)
        self.panlStars[curLevel]:addChild(self.starArmature)
        self.starArmature:getAnimation():play("gkjs_xing" , -1, 0)
        local zx = "res/Music/ui/zx.wav"
        audio.playSound(zx,false)
        --show
        self.stars[curLevel]:setVisible(true)
    end
    self:performWithDelay(delayStar, delay)

    --weapon anim
    local armature = ccs.Armature:create("wqsj")
    armature:setPosition(750,450)
    self:addChild(armature)
    armature:getAnimation():setMovementEventCallFunc(
    function ( armatureBack,movementType,movement) 
        if movementType == ccs.MovementEventType.complete then
            armatureBack:stopAllActions()
            armatureBack:removeFromParent() 
        end 
    end)
    armature:getAnimation():play("wqsj" , -1, 0)
end

function WeaponListLayer:playFullStar(event)
    dump(event.lastLevel)
    local destWeaponId = event.weaponId
    if destWeaponId ~= self.weaponId then return end
    local lastLevel = event.lastLevel
    local fromStar, toStar = lastLevel + 1, 10
    local delay = 0

    for i= fromStar, toStar do
        self.stars[i]:setVisible(false)
        delay = delay + 0.1
        function delayStar( )
            self.starArmature = ccs.Armature:create("gkjs_xing")
            self.starArmature:setPosition(19.5,19)
            self.starArmature:setScale(0.448,0.452)
            self.panlStars[i]:addChild(self.starArmature)
            self.starArmature:getAnimation():play("gkjs_xing" , -1, 0)
            local zx = "res/Music/ui/zx.wav"
            audio.playSound(zx,false)
        end
        self:performWithDelay(delayStar, delay)
    end

    local armature = ccs.Armature:create("wqsj")
    armature:setPosition(750,450)
    self:addChild(armature)
    armature:getAnimation():setMovementEventCallFunc(
    function ( armatureBack,movementType,movement) 
        if movementType == ccs.MovementEventType.complete then
            armatureBack:stopAllActions()
            armatureBack:removeFromParent() 
        end 
    end)
    armature:getAnimation():play("wqsj" , -1, 0)
end


function WeaponListLayer:refreshStar()
    self:hideStars()
    for k,v in pairs(self.panlStars) do
        if self.starArmature then
            v:removeAllChildren()
        end
    end
    local curLevel = tonumber(self.weaponListModel:getIntenlevel(self.weaponId))
    for k,v in pairs(self.stars) do
        if k < curLevel + 1 then
            v:setVisible(true)
        end
    end
end

function WeaponListLayer:hideStars()
    for i,v in pairs(self.stars) do
        v:setVisible(false)
    end    
end

function WeaponListLayer:refreshBtns()
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

function WeaponListLayer:closePopup()
    ui:closePopup("commonPopup")
end

function WeaponListLayer:initGuide()
    --check   
    local guide = md:getInstance("Guide")
    local isDone = guide:isDone("weapon")
    if isDone then return end

    --点击左侧mp5
    local rect1 = cc.rect(50, 270, 240, 110)
    guide:addClickListener({
        id = "weapon_shengji1",
        groupId = "weapon",
        rect = rect1,
        endfunc = function (touchEvent)
            self:touchListener({name = "clicked", itemPos = 2})
        end
     })       

    --点击右侧升级
    local rect2 = cc.rect(945, 130, 131, 64)
    guide:addClickListener({
        id = "weapon_shengji2",
        groupId = "weapon",
        rect = rect2,
        endfunc = function (touchEvent)
            if self.userModel:costMoney(self.costupgrade) then
                self:onClickBtnUpgrade(self.weaponId)
            end
        end
     })   

    --祝贺
    guide:addClickListener({
        id = "weapon_shengji3",
        groupId = "weapon",
        rect =  cc.rect(0, 0, display.width1, display.height1),
        endfunc = function (touchEvent)

        end
     })   
     
end

return WeaponListLayer