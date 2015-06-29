local InlayListCell = class("InlayListCell", function()
    return display.newNode()
end)

function InlayListCell:ctor(record)
    self.inlayModel = md:getInstance("InlayModel")
    self.userModel = md:getInstance("UserModel")

	self:initCellUI(record)
end

function InlayListCell:initCellUI(record)
    local panl_xuanze = display.newScale9Sprite("#panl_xuanze.png",0,0,cc.size(528,157),cc.rect(169,0,1,1))
    self:addChild(panl_xuanze)
    local panelimg = display.newSprite("#"..record["imgname"]..".png",-170,-16)
    self:addChild(panelimg)
    local jinbidi = display.newSprite("#jinbidi.png",-170,-53)
    jinbidi:setScale(1.2, 1.2)
    self:addChild(jinbidi)
    local icon_jibi = display.newSprite("#icon_jibi.png",-100,-53)
    icon_jibi:setScale(0.7)
    self:addChild(icon_jibi)
    local already = cc.ui.UILabel.new({
        UILabelType = 2, text = "已拥有:", size = 25})
    :align(display.CENTER, 150, 48)
    :addTo(self)
    already:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local  goldprice= cc.ui.UILabel.new({
        UILabelType = 2, text = record["goldPrice"], size = 22})
    :addTo(jinbidi)
    :align(display.CENTER, 66, 12)
    goldprice:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local  detail= cc.ui.UILabel.new({
        UILabelType = 2, text = record["describe2"], size = 24})
    :align(display.CENTER, -180, 48)
    :addTo(self)
    detail:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local property = cc.ui.UILabel.new({
        UILabelType = 2, text = record["describe1"].." "..record["valueDisplay"], size = 28})
    :align(display.CENTER, 0, 16)
    :addTo(self)
    self.num = self.inlayModel:getInlayNum(record["id"])
    self.ownNumber = cc.ui.UILabel.new({
        UILabelType = 2, text = self.num, size = 25})
    :align(display.CENTER, 220, 48)
    :addTo(self)
    self.ownNumber:enableOutline(cc.c4b(0, 0, 0,255), 2)

    local buy = cc.ui.UILabel.new({text = "购买",size = 30})
    buy:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local equip = cc.ui.UILabel.new({text = "装备",size = 30})
    equip:enableOutline(cc.c4b(0, 0, 0,255), 2)
    -- 按钮
    cc.ui.UIPushButton.new("#btn_g3.png", {scale9 = true})
        :setButtonSize(155, 59)
        :setButtonLabel(buy)
        :onButtonPressed(function(event)
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function(event)
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
            self:onClickBtnBuy(record)
        end)
        :pos(10, -36)
        :addTo(self)
    function deneyGoldGift()
        ui:showPopup("commonPopup",
            {type = "style2",content = "金币不足，请去商城购买"},
            {opacity = 155})
    end
    cc.ui.UIPushButton.new("#btn_g3.png", {scale9 = true})
        :setButtonSize(155, 59)
        :setButtonLabel(equip)
        :onButtonPressed(function(event)
            event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
        end)
        :onButtonRelease(function(event)
            event.target:runAction(cc.ScaleTo:create(0.1, 1))
        end)
        :onButtonClicked(function()
            self:onClickBtnEquip(record)
        end)
        :pos(170, -36)
        :addTo(self)
end

function InlayListCell:onClickBtnBuy(record)
    local dianji = "res/Music/ui/button.wav"
    audio.playSound(dianji,false)

    function refresh()
        self.inlayModel:refreshInfo(record["type"])
    end

    if self.userModel:costMoney(record["goldPrice"]) then
        local gmcg = "res/Music/ui/gmcg.wav"
        audio.playSound(gmcg,false)

        self.num = self.num + 1
        self.ownNumber:setString(self.num)
        self.inlayModel:buyInlay(record["id"])
        um:buy(record["describe2"],1, record["goldPrice"])   
    else
        local guideModel = md:getInstance("GuideModel")
        if guideModel:getIsGuiding() then return end

        local buyModel = md:getInstance("BuyModel")
        buyModel:showBuy("goldGiftBag",{payDoneFunc = refresh,deneyBuyFunc = deneyGoldGift},
             "镶嵌页面_购买单个镶嵌金币不足")
    end
end

function InlayListCell:onClickBtnEquip(record)
    local dianji = "res/Music/ui/button.wav"
    audio.playSound(dianji,false)
    local xqcg = "res/Music/ui/xqcg.wav"
    audio.playSound(xqcg,false)
    self.inlayModel:equipInlay(record["id"])
end

return InlayListCell