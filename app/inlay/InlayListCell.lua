local ScrollViewCell = import("..includes.ScrollViewCell")

local InlayListCell = class("InlayListCell", ScrollViewCell)

function InlayListCell:ctor(record)
    self.inlayModel = md:getInstance("InlayModel")
    self.userModel = md:getInstance("UserModel")

	self:initCellUI(record)
end

function InlayListCell:initCellUI(record)
        -- display.newSprite()
        local panl_xuanze = display.newScale9Sprite("#panl_xuanze.png",0,0,cc.size(528,157),cc.rect(169,0,1,1))
        self:addChild(panl_xuanze)
        local btnbuy = display.newScale9Sprite("#btn_g3.png",10,-36,cc.size(155,59),cc.rect(20,0,41,78))
        self:addChild(btnbuy)
        btnbuy:setTouchEnabled(true)
        local btnload = display.newScale9Sprite("#btn_g3.png",170,-36,cc.size(155,59),cc.rect(40,0,1,78))
        self:addChild(btnload)
        btnload:setTouchEnabled(true)
        local panelimg = display.newSprite("#"..record["imgname"]..".png",-170,-16)
        self:addChild(panelimg)
        local jinbidi = display.newSprite("#jinbidi.png",-170,-53)
        jinbidi:setScale(1.2, 1.2)
        self:addChild(jinbidi)
        local icon_jibi = display.newSprite("#icon_jibi.png",-100,-53)
        icon_jibi:setScale(0.7)
        self:addChild(icon_jibi)

        local buy = cc.ui.UILabel.new({
            UILabelType = 2, text = "购买", size = 30})
        :align(display.CENTER, 78, 30)
        :addTo(btnbuy)
        buy:enableOutline(cc.c4b(0, 0, 0,255), 2)
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
        local equip = cc.ui.UILabel.new({
            UILabelType = 2, text = "装备", size = 30})
        :align(display.CENTER, 78, 30)
        :addTo(btnload)
        equip:enableOutline(cc.c4b(0, 0, 0,255), 2)
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

    addBtnEventListener(btnbuy, function(event)
            if event.name=='began' then
                return true
            elseif event.name=='ended' then
                if self.userModel:costMoney(record["goldPrice"]) then
                    num = num + 1
                    ownnumber:setString(num)
                    self.inlayModel:buyInlay(record["id"],false)
                    if device.platform == "android" then
                        local buyInfo = record["type"].."_"..record["property"]
                        cc.UMAnalytics:buy(buyInfo, 1, record["goldPrice"])   
                    end 
                end
                md:getInstance("StoreModel"):setGoldWeaponNum()
            end
            -- return false
        end)
    addBtnEventListener(btnload, function(event)
            if event.name=='began' then
                return true
            elseif event.name=='ended' then
                self.inlayModel:equipInlay(record["id"],true)
            end
        end)
end

return InlayListCell