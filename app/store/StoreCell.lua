local ScrollViewCell = import("..includes.ScrollViewCell")

local StoreCell = class("StoreCell", ScrollViewCell)

function StoreCell:ctor(parameter)
    self.inlayModel = md:getInstance("InlayModel")
    self.propModel = md:getInstance("propModel")
    self.userModel = md:getInstance("UserModel")
    self.storeModel = md:getInstance("StoreModel")
	self:initCellUI(parameter)
end

function StoreCell:initCellUI(parameter)


	local record = parameter.record
	local type = parameter.celltype
    local panl_xuanze = display.newScale9Sprite("#panl_xuanze.png",3,0,cc.size(735,157),cc.rect(169,0,1,1))
    self:addChild(panl_xuanze)
    local jinbidi = display.newSprite("#jinbidi.png",0,25)
    jinbidi:setScale(2, 1.5)
    self:addChild(jinbidi)


    local btnbuy = cc.ui.UIPushButton.new("#btn_g3.png", {scale9 = true})
            :setButtonSize(155, 59)
            :onButtonPressed(function(event)
                event.target:runAction(cc.ScaleTo:create(0.05, 1.1))
            end)
            :onButtonRelease(function(event)
                event.target:runAction(cc.ScaleTo:create(0.1, 1))
            end)
            
            :pos(270,-30)
            :addTo(self)


    local icon_zuanshi = display.newSprite("#icon_zuanshi.png",41,1)
    icon_zuanshi:setScale(0.7)
    btnbuy:addChild(icon_zuanshi)
    icon_zuanshi:setVisible(false)
    local icon_jibi = display.newSprite("#icon_jibi.png",41,1)
    icon_jibi:setScale(0.8)
    btnbuy:addChild(icon_jibi)
    icon_jibi:setVisible(false)
    
    local  property= cc.ui.UILabel.new({
        UILabelType = 2, text = record["name"], size = 28})
    :align(display.CENTER, 0, -20)
    :addTo(self)
    local  buynumber= cc.ui.UILabel.new({
        UILabelType = 2, text = "X 50", size = 29, color = cc.c3b(254, 233, 2)})
    :align(display.CENTER, 80, 26)
    :addTo(self)
    local already = cc.ui.UILabel.new({
        UILabelType = 2, text = "已拥有", size = 31})
    :align(display.CENTER, 265, 48)
    :addTo(self)
    already:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local ownnumber = cc.ui.UILabel.new({
        UILabelType = 2, text = "60", size = 31})
    :align(cc.ui.TEXT_ALIGN_CENTER, 332, 48)
    :addTo(self)
    ownnumber:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local detail = cc.ui.UILabel.new({
        UILabelType = 2, text = "黄金精准", size = 31})
    :align(display.CENTER, -40, 25)
    :addTo(self)
    detail:enableOutline(cc.c4b(0, 0, 0,255), 2)

    local icon_yuan = cc.ui.UILabel.new({
        UILabelType = 2, text = "元", size = 25})
    :align(display.CENTER, 25 , 4)
    :addTo(btnbuy)
    icon_yuan:enableOutline(cc.c4b(0, 0, 0,255), 2)
    icon_yuan:setVisible(false)
    local  price= cc.ui.UILabel.new({
        UILabelType = 2, text = "50000", size = 28})
    :align(display.CENTER, -16, 3)
    :addTo(btnbuy)
    price:enableOutline(cc.c4b(0, 0, 0,255), 2)
    local redline = display.newScale9Sprite("#honggang.png",0,-23,cc.size(160,9),cc.rect(12,0,1,1))
    redline:setRotation(170)
    self:addChild(redline)
    redline:setVisible(false)

    local pos = display.newScale9Sprite("#honggang.png",-250,0,cc.size(160,9),cc.rect(12,0,1,1))
    pos:setScale(0.1)
    pos:setRotation(170)
    self:addChild(pos)

    -- local node = display.newSprite("#icon_zuanshi.png",41,1)
    -- node:setScale(1)
    -- node:setPosition(-240,0)
    -- self:addChild(node)

    -- local node = display.newNode()
    -- node:setPosition(-240,0)
    -- self:addChild(node)

    local armature = ccs.Armature:create("guang")
    -- armature:setPosition(130,80)
    armature:setScale(20)
    pos:addChild(armature)
    armature:getAnimation():play("guangtx" , -1, 1)
    dump(armature:getContentSize())

    local btnarmature = ccs.Armature:create("sczg")
    btnarmature:setPosition(-8,5)
    -- btnarmature:setScale(1.2)
    btnbuy:addChild(btnarmature)
    btnarmature:getAnimation():play("sczg" , -1, 1)


    if type == "prop" then
        icon_zuanshi:setVisible(true)
        local Img = display.newSprite("#"..record["imgname"]..".png",-230,0)
        self:addChild(Img)
        detail:setString(record["name"])
        buynumber:setString("X "..record["buynum"])
        property:setString(record["describe"])
        price:setString(record["price"])
        ownnumber:setString(self.propModel:getPropNum(record["nameid"]))

    elseif type == "bank" then
        ownnumber:setVisible(false)
        already:setVisible(false)
        icon_yuan:setVisible(true)
        redline:setVisible(true)

        local Img = display.newSprite("#"..record["imgname"]..".png",-230,0)
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

        detail:setString(record["name"])
        buynumber:setString("X "..record["number"])
        discountlabel:setString("+"..record["discount"].."%")
        property:setString("原价："..record["costprice"].." 元")
        price:setString(record["price"])

    elseif type == "inlay" then
        buynumber:setVisible(false)
        icon_jibi:setVisible(true)

        local Img = display.newSprite("#"..record["imgname"]..".png",-240,0)
        Img:setScale(1.2)
        self:addChild(Img)
        detail:setString(record["describe2"])
        detail:setPosition(0,25)
        property:setString(record["describe1"].." "..record["valueDisplay"])
        property:setPosition(0,-20)
        price:setString(record["goldPrice"])
        ownnumber:setString(self.inlayModel:getInlayNum(record["id"]))
    end

    btnbuy:onButtonClicked(function()
            if tonumber(ownnumber:getString())<100 then
                if type == "prop" then
                    if self.userModel:costDiamond(record["price"]) then
                        if record["nameid"] == "goldweapon" then
                            self.inlayModel:buyGoldsInlay(record["buynum"])
                            local goldnum = self.inlayModel:getGoldWeaponNum()
                            self.storeModel:setGoldWeaponNum(goldnum)
                            self.inlayModel:refreshInfo("speed")
                        else
                            self.propModel:buyProp(record["nameid"],record["buynum"])
                        end
                        um:buy(record["nameid"], 1, record["price"])   
                        ownnumber:setString(self.propModel:getPropNum(record["nameid"]))
                    end
                elseif type == "bank" then
                    self.userModel:buyDiamond(record["number"])
                elseif type == "inlay" then
                    if self.userModel:costMoney(record["goldPrice"]) then
                        self.inlayModel:buyInlay(record["id"])
                        ownnumber:setString(self.inlayModel:getInlayNum(record["id"]))
                    end
                    local buyInfo = record["type"].."_"..record["property"]
                    um:buy(buyInfo, 1, record["goldPrice"])   
                end
            else
                ui:showPopup("commonPopup",
                 {type = "style2", content = "最多只能购买99个喔"},
                 {opacity = 0})
            end
        end)
end

return StoreCell