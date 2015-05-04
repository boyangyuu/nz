local StoreCell = class("StoreCell", function()
    return display.newNode()
end)

function StoreCell:ctor(parameter)
    self.inlayModel = md:getInstance("InlayModel")
    self.propModel = md:getInstance("propModel")
    self.userModel = md:getInstance("UserModel")
    self.storeModel = md:getInstance("StoreModel")
    self.buyModel = md:getInstance("BuyModel")

    self.record = parameter.record
    self.type = parameter.celltype
	
    self:initCellUI()
    self:initCellData()
    self:addBtnEvent()
end

function StoreCell:initCellUI()
    local panl_xuanze = display.newScale9Sprite("#panl_xuanze.png",3,0,cc.size(735,157),cc.rect(169,0,1,1))
    self:addChild(panl_xuanze)
    local jinbidi = display.newSprite("#jinbidi.png",0,25)
    jinbidi:setScale(2, 1.5)
    self:addChild(jinbidi)

    self.btnbuy = cc.ui.UIPushButton.new("#btn_g3.png", {scale9 = true})
            :setButtonSize(155, 59)
            :onButtonPressed(function(event)
                event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
            end)
           :onButtonRelease(function(event)
                event.target:runAction(cc.ScaleTo:create(0.1, 1))
            end)
            :pos(270,-30)
            :addTo(self)

    self.icon_zuanshi = display.newSprite("#icon_zuanshi.png",41,1)
    self.icon_zuanshi:setScale(0.7)
    self.btnbuy:addChild(self.icon_zuanshi)
    self.icon_zuanshi:setVisible(false)
    self.icon_jibi = display.newSprite("#icon_jibi.png",41,1)
    self.icon_jibi:setScale(0.8)
    self.btnbuy:addChild(self.icon_jibi)
    self.icon_jibi:setVisible(false)
    
    self.property= cc.ui.UILabel.new({
        UILabelType = 2, text = self.record["name"], size = 28})
    :align(display.CENTER, 0, -20)
    :addTo(self)
    self.buynumber= cc.ui.UILabel.new({
        UILabelType = 2, text = "X 50", size = 29, color = cc.c3b(254, 233, 2)})
    :align(display.CENTER, 80, 26)
    :addTo(self)
    self.already = cc.ui.UILabel.new({
        UILabelType = 2, text = "已拥有", size = 31})
    :align(display.CENTER, 265, 48)
    :addTo(self)
    self.already:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.ownnumber = cc.ui.UILabel.new({
        UILabelType = 2, text = "60", size = 31})
    :align(cc.ui.TEXT_ALIGN_CENTER, 332, 48)
    :addTo(self)
    self.ownnumber:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.detail = cc.ui.UILabel.new({
        UILabelType = 2, text = "黄金精准", size = 31})
    :align(display.CENTER, -40, 25)
    :addTo(self)
    self.detail:enableOutline(cc.c4b(0, 0, 0,255), 2)

    self.icon_yuan = cc.ui.UILabel.new({
        UILabelType = 2, text = "元", size = 25})
    :align(display.CENTER, 25 , 4)
    :addTo(self.btnbuy)
    self.icon_yuan:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.icon_yuan:setVisible(false)
    self.price= cc.ui.UILabel.new({
        UILabelType = 2, text = "50000", size = 28})
    :align(display.CENTER, -16, 3)
    :addTo(self.btnbuy)
    self.price:enableOutline(cc.c4b(0, 0, 0,255), 2)
    self.redline = display.newScale9Sprite("#honggang.png",0,-23,cc.size(160,9),cc.rect(12,0,1,1))
    self.redline:setRotation(170)
    self:addChild(self.redline)
    self.redline:setVisible(false)

    local pos = display.newScale9Sprite("#honggang.png",-250,0,cc.size(160,9),cc.rect(12,0,1,1))
    pos:setScale(0.1)
    pos:setRotation(170)
    self:addChild(pos)

    local btnarmature = ccs.Armature:create("bt_yjzb")
    btnarmature:setPosition(2,3)
    self.btnbuy:addChild(btnarmature)
    btnarmature:getAnimation():play("yjzb" , -1, 1)

    local sctbsrc = "res/Store/shangchengz_tb/shangchengz_tb.ExportJson"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(sctbsrc)
    local plist = "res/Store/shangchengz_tb/shangchengz_tb0.plist"
    local png = "res/Store/shangchengz_tb/shangchengz_tb0.png"
    display.addSpriteFrames(plist,png)

    local armature = ccs.Armature:create("shangchengz_tb")
    armature:setPosition(-220,0)
    self:addChild(armature)
    armature:getAnimation():play("die" , -1, 1)
end

function StoreCell:initCellData()
    if self.type == "prop" then
        self.icon_zuanshi:setVisible(true)
        local Img = display.newSprite("#"..self.record["imgname"]..".png",-230,0)
        self:addChild(Img)
        self.detail:setString(self.record["name"])
        self.buynumber:setString("X "..self.record["buynum"])
        self.property:setString(self.record["describe"])
        self.price:setString(self.record["price"])
        if self.record["nameid"] == "goldweapon" then
            local goldnum = self.inlayModel:getGoldWeaponNum()
            self.ownnumber:setString(goldnum)
        else
            self.ownnumber:setString(self.propModel:getPropNum(self.record["nameid"]))
        end
    elseif self.type == "bank" then
        self.ownnumber:setVisible(false)
        self.already:setVisible(false)
        self.icon_yuan:setVisible(true)
        self.redline:setVisible(true)

        local Img = display.newSprite("#"..self.record["imgname"]..".png",-230,0)
        self:addChild(Img)

        local discount = display.newSprite("#dazhe.png",-300,30)
        discount:setScale(0.9)
        self:addChild(discount)

        local discountlabel = cc.ui.UILabel.new({
        UILabelType = 2, text = "+20%", size = 32})
            :align(display.CENTER, 78, 58)
            :addTo(discount)
        discountlabel:enableShadow(cc.c4b(0, 0, 0,255), cc.size(2,-2))
        discountlabel:enableOutline(cc.c4b(255, 255, 255,255), 2)

        self.detail:setString(self.record["name"])
        self.buynumber:setString("X "..self.record["number"])
        discountlabel:setString("+"..self.record["discount"].."%")
        self.property:setString("原价："..self.record["costprice"].." 元")
        self.price:setString(self.record["price"])

        if self.record["price"] == 1 then
            discount:setVisible(false)
            self.redline:setVisible(false)
        end
    elseif self.type == "inlay" then
        self.buynumber:setVisible(false)
        self.icon_jibi:setVisible(true)

        local Img = display.newSprite("#"..self.record["imgname"]..".png",-240,0)
        Img:setScale(1.2)
        self:addChild(Img)
        self.detail:setString(self.record["describe2"])
        self.detail:setPosition(0,25)
        self.property:setString(self.record["describe1"].." "..self.record["valueDisplay"])
        self.property:setPosition(0,-20)
        self.price:setString(self.record["goldPrice"])
        self.ownnumber:setString(self.inlayModel:getInlayNum(self.record["id"]))
    end
end

function StoreCell:addBtnEvent()
    self.btnbuy:onButtonClicked(function()
        local dianji = "res/Music/ui/button.wav"
        audio.playSound(dianji,false)

        if self.type == "prop" then
            if self.userModel:costDiamond(self.record["price"]) then
                self:playSound()
                if self.record["nameid"] == "goldweapon" then
                    self.inlayModel:buyGoldsInlay(self.record["buynum"])
                else
                    self.propModel:addProp(self.record["nameid"],self.record["buynum"])
                end
                um:buy(self.record["name"], 1, self.record["price"])   
                if self.record["nameid"] == "goldweapon" then
                    local goldnum = self.inlayModel:getGoldWeaponNum()
                    self.ownnumber:setString(goldnum)
                else
                    self.ownnumber:setString(self.propModel:getPropNum(self.record["nameid"]))
                end
            else
                if self.record["nameid"] == "goldweapon" then
                    self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.onBuyPropGoldGift),
                        deneyBuyFunc = handler(self, self.deneyGoldGift)}, "商城页面_黄武钻石不够")
                elseif self.record["nameid"] == "jijia" then
                    self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.onBuyPropGoldGift),
                        deneyBuyFunc = handler(self, self.deneyGoldGift)}, "商城页面_机甲钻石不够")
                elseif self.record["nameid"] == "lei" then
                    self.buyModel:showBuy("goldGiftBag", {payDoneFunc = handler(self, self.onBuyPropGoldGift),
                        deneyBuyFunc = handler(self, self.deneyGoldGift)}, "商城页面_手雷钻石不够")
                end
            end
        elseif self.type == "bank" then
            self.buyModel:showBuy("stone"..self.record["number"],{payDoneFunc = handler(self,self.playSound)}, "商城界面_点击钻石"..self.record["number"])
        elseif self.type == "inlay" then
            if self.userModel:costMoney(self.record["goldPrice"]) then
                self:playSound()
                self.inlayModel:buyInlay(self.record["id"])
                self.ownnumber:setString(self.inlayModel:getInlayNum(self.record["id"]))
            else
                function deneyGoldGift()
                    ui:showPopup("commonPopup",
                        {type = "style2",content = "您的金币不足"},
                        {opacity = 155})
                end
                self.buyModel:showBuy("goldGiftBag",{payDoneFunc = handler(self,self.onBuyGoldGiftSucc) ,
                    deneyBuyFunc = deneyGoldGift},
                     "商城页面_购买单个镶嵌金币不足")
            end
            um:buy(self.record["describe2"], 1, self.record["goldPrice"])   
        end
    end)
end

function StoreCell:onBuyGoldGiftSucc()
    self.storeModel:refreshInfo("inlay")
end

function StoreCell:deneyGoldGift()
    if self.record["nameid"] == "goldweapon" then
        self.buyModel:showBuy("goldWeapon",{payDoneFunc = handler(self,self.onBuyPropGoldGift)}, "商城界面_取消土豪买黄武")
    elseif self.record["nameid"] == "jijia" then
        self.buyModel:showBuy("armedMecha",{payDoneFunc = handler(self,self.onBuyPropGoldGift)}, "商城界面_取消土豪买机甲")
    elseif self.record["nameid"] == "lei" then
        self.buyModel:showBuy("handGrenade",{payDoneFunc = handler(self,self.onBuyPropGoldGift)}, "商城界面_取消土豪买手雷")
    end
end

function StoreCell:onBuyPropGoldGift()
    self:playSound()
    self.storeModel:refreshInfo("prop")
end

function StoreCell:playSound()
    local gmcg   = "res/Music/ui/gmcg.wav"
    audio.playSound(gmcg,false)
end

return StoreCell