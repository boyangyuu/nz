
--[[--

“复活提示”的视图

]]

local JujiAwardPopup = class("JujiAwardPopup", function()
    return display.newLayer()
end)

function JujiAwardPopup:ctor(property)

	--instance
	self.jujiMode = md:getInstance("JujiModeModel")
	self.property = property
    -- cc.EventProxy.new(self.fightGun, self)
    --     :addEventListener(self.fightGun.HELP_START_EVENT, handler(self, self.onShow))
    self:loadCCS()
    self:setNodeEventEnabled(true) 
end

function JujiAwardPopup:onEnter()

end

function JujiAwardPopup:loadCCS()
	self.node = cc.uiloader:load("res/JujiMode/wuxianjuji/paihang.json")
    self:addChild(self.node)    

    self:refreshList()

    --btn close
    local btnClose = cc.uiloader:seekNodeByName(self.node, "btnClose")
    btnClose:onButtonClicked(function()
         self:onClickClose()
    end)

    local bg =   cc.uiloader:seekNodeByName(self.node, "bg")  
    bg:setOpacity(190)
end

function JujiAwardPopup:refreshList()
    --item
    local itemIndex = 1
    while true do
    	print("itemIndex") 
    	local item = cc.uiloader:seekNodeByName(self.node, "item"..itemIndex)
    	if item == nil then break end

    	--status
    	local isAvaliable = self.jujiMode:isScoreAwardAvailable(itemIndex)
    	local isGetted    = self.jujiMode:isScoreAwardGetted(itemIndex)

		--bg
		local bg   = cc.uiloader:seekNodeByName(item, "bg")
		local bg1  = cc.uiloader:seekNodeByName(item, "bg1")

    	--btn
    	local btn  = cc.uiloader:seekNodeByName(item, "btnGet")
	    local index = itemIndex
	    btn:onButtonClicked(function()
	         self:onClickGet(index)
	    end)

	    if isGetted then 
	    	bg1:setVisible(false)
	    	btn:setButtonImage(btn.NORMAL, "btn_lingqu3.png")
	    elseif isAvaliable then 
	    	btn:setButtonImage(btn.NORMAL, "btn_lingqu1.png")
	    else
	    	bg1:setVisible(false)
	    	btn:setButtonImage(btn.NORMAL, "btn_lingqu2.png")
	    end

    	itemIndex = itemIndex + 1
    end	
end

function JujiAwardPopup:onClickGet(itemIndex)
	print("function JujiAwardPopup:onClickGet(index)", itemIndex)
	local isAvaliable = self.jujiMode:isScoreAwardAvailable(itemIndex)
	local isGetted    = self.jujiMode:isScoreAwardGetted(itemIndex)
    local str = ""
    if isGetted then 
        str = "该奖励已领取！"
    elseif isAvaliable then 
    	self.jujiMode:getAward(itemIndex)
    	self:refreshList()
        str = "领取成功！"
    else
        str = "积分不足，无法领取！"
    end	

    ui:showPopup("commonPopup",{type = "style2",content = str, delay = 2},
         {opacity = 100})    
end

function JujiAwardPopup:onClickClose()
    self:closePopup()
end

function JujiAwardPopup:closePopup()
	ui:closePopup("JujiAwardPopup", {animName = "scale"})
end

return JujiAwardPopup