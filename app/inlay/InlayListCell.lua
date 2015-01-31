local ScrollViewCell = import("..includes.ScrollViewCell")

local InlayListCell = class("InlayListCell", ScrollViewCell)

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
    local num = self.inlayModel:getInlayNum(record["id"])
    local ownnumber = cc.ui.UILabel.new({
        UILabelType = 2, text = num, size = 25})
    :align(display.CENTER, 220, 48)
    :addTo(self)
    ownnumber:enableOutline(cc.c4b(0, 0, 0,255), 2)

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
            local dianji = "res/Music/ui/dianji.wav"
            audio.playSound(dianji,false)
            if self.userModel:costMoney(record["goldPrice"]) then
                local gmcg = "res/Music/ui/gmcg.wav"
                audio.playSound(gmcg,false)

                num = num + 1
                ownnumber:setString(num)
                self.inlayModel:buyInlay(record["id"],false)
                local buyInfo = record["type"].."_"..record["property"]
                um:buy(buyInfo, 1, record["goldPrice"])   
            end
            local storeModel = md:getInstance("StoreModel")
            storeModel:refreshInfo("prop")
        end)
        :pos(10, -36)
        :addTo(self)

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
            local dianji = "res/Music/ui/dianji.wav"
            audio.playSound(dianji,false)
            local xqcg = "res/Music/ui/xqcg.wav"
            audio.playSound(xqcg,false)
            self.inlayModel:equipInlay(record["id"],true)
        end)
        :pos(170, -36)
        :addTo(self)
end

return InlayListCell