local DailyLoginConfig = import(".DailyLoginConfig")
local DailyLoginLayer = class("DailyLoginLayer", function()
	return display.newLayer()
end)

function DailyLoginLayer:ctor()
	self.dailyLoginModel = md:getInstance("DailyLoginModel")
	self:loadCCS()
	self:initUI()
end

function DailyLoginLayer:loadCCS()
	local controlNode = cc.uiloader:load("res/GiftBag/GiftBag/GiftBag_LoginGiftBag.json")
    self:addChild(controlNode)
end

function DailyLoginLayer:initUI()
    local receiveBtn = cc.uiloader:seekNodeByName(self, "btn_Receive")
    local getnum = {}
    local bg = {}
    for i=1,7 do
    	local giftInfo = DailyLoginConfig.getConfig(i)

    	getnum[i] = cc.uiloader:seekNodeByName(self, "getnum"..i)
    	bg[i] = cc.uiloader:seekNodeByName(self, "bg"..i)
    	getnum[i]:setColor(cc.c3b(0,255,161))

    	if giftInfo["type"] == "gold" then
    		bg[i]:setColor(cc.c3b(156,98,0))
		elseif giftInfo["type"] == "lei" then
			bg[i]:setColor(cc.c3b(0,128,150))
		elseif giftInfo["type"] == "jijia" then
			bg[i]:setColor(cc.c3b(135,0,153))
		elseif giftInfo["type"] == "goldweapon" then
			bg[i]:setColor(cc.c3b(156,98,0))
		end
    end
    self.already = {}
    self.tx = {}
    for i=1,7 do
    	self.already[i] = cc.uiloader:seekNodeByName(self, "already"..i)
    	self.already[i]:setVisible(false)
    	self.tx[i] = cc.uiloader:seekNodeByName(self, "tx"..i)
    end




    local dailyInfo = self.dailyLoginModel:getDailyInfo()
    for i=1,dailyInfo["dailyid"] do
    	self.already[i]:setVisible(true)
    end
    
    local armature = ccs.Armature:create("mrdl")
    local parePanl = self.tx[dailyInfo["dailyid"]+1]
    armature:setScale(2)
    armature:setPosition(110,150)
    parePanl:addChild(armature) 
    armature:getAnimation():play("die" , -1, 1)

    receiveBtn:setTouchEnabled(true)
	addBtnEventListener(receiveBtn, function(event)
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("DailyLoginLayer")
			local dailyID = self.dailyLoginModel:getNextDailyID()
			dump(dailyID)
			self.dailyLoginModel:setGift(dailyID)
			-- for i=1,dailyInfo["dailyid"] do
		 --    	self.already[i]:setVisible(true)
		 --    end
			self.dailyLoginModel:setNextDailyID()
			self.dailyLoginModel:setGet(true)
		end
	end)
end

-- function function_name( ... )
-- 	-- body
-- end

return DailyLoginLayer