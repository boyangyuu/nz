local ScrollViewCell = import("..includes.ScrollViewCell")
local InlayModel = import(".InlayModel")
local UserModel = import("..homeBar.UserModel")

local InlayListCell = class("InlayListCell", ScrollViewCell)

function InlayListCell:ctor(record)
    self.inlayModel = app:getInstance(InlayModel)
    self.userModel = app:getInstance(UserModel)

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
        local panelimg = display.newSprite("#"..record["imgnam"]..".png",-170,-16)
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
        local buy = cc.ui.UILabel.new({
            UILabelType = 2, text = "装备", size = 30})
        :align(display.CENTER, 78, 30)
        :addTo(btnload)
        local property = cc.ui.UILabel.new({
            UILabelType = 2, text = record["describe1"].." "..record["valueDisplay"], size = 28})
        :align(display.CENTER, 0, 16)
        :addTo(self)
        local ownnumber = cc.ui.UILabel.new({
            UILabelType = 2, text = self.inlayModel:getInlayNum(record["id"]), size = 25})
        :align(display.CENTER, 220, 48)
        :addTo(self)
        ownnumber:enableOutline(cc.c4b(0, 0, 0,255), 2)

    addBtnEventListener(btnbuy, function(event)
            if event.name=='began' then
                return true
            elseif event.name=='ended' then
                -- if self.userModel:costMoney(record["goldPrice"]) then
                    self.inlayModel:buyInlay(record["id"])
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