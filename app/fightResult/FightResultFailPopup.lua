local FightResultFailPopup = class("FightResultFailPopup", function()
	return display.newLayer()
end)

function FightResultFailPopup:ctor()
	self:initUI()
    -- self:popUpGift()
end

function FightResultFailPopup:popUpGift()
    local buy = md:getInstance("BuyModel")
    buy:buy("goldGiftBag", {payDoneFunc = handler(self,self.payDone)})
end

function FightResultFailPopup:initUI()
    --loadCCS
	cc.FileUtils:getInstance():addSearchPath("res/FightResult/fightResultAnim")
	local controlNode = cc.uiloader:load("fightResultFail.ExportJson")
    self:addChild(controlNode)

    local btnback = cc.uiloader:seekNodeByName(self, "btnback")
    local btnrevive = cc.uiloader:seekNodeByName(self, "btnrevive")
    local rolepanel = cc.uiloader:seekNodeByName(self, "role")
    local roleimg = display.newSprite("#role_anqi.png")

    local armature = ccs.Armature:create("ydfh")
    armature:setPosition(180,60)
    btnrevive:addChild(armature)
    -- addChildCenter(armature, btnrevive)
    armature:getAnimation():play("ydfh" , -1, 1)

    roleimg:scale(1.33)
    addChildCenter(roleimg, rolepanel)
    btnback:setTouchEnabled(true)
    addBtnEventListener(btnback, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            local fight  = md:getInstance("Fight")
            local groupid,levelid = fight:getCurGroupAndLevel()
	        ui:closePopup("FightResultFailPopup")
           local curGroup, curLevel = fight:getCurGroupAndLevel()
            ui:changeLayer("HomeBarLayer",{groupid = curGroup})
        end
    end)
    btnrevive:setTouchEnabled(true)
    addBtnEventListener(btnrevive, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
            local buy = md:getInstance("BuyModel")
            -- function cancelGoldGift()
                buy:buy("resurrection", {payDoneFunc = handler(self,self.payDone)})
            -- end
            -- buy:buy("goldGiftBag", {payDoneFunc = handler(self,self.payDone),
            --                         deneyBuyFunc = cancelGoldGift})
        end
    end)
end



function FightResultFailPopup:payDone()
    local fight = md:getInstance("Fight")
   fight:payDone()
    --黄武
    -- local inlay = md:getInstance("InlayModel")
    -- inlay:equipGoldInlays(false)
    
    -- fight:relive()
    -- ui:closePopup("FightResultFailPopup")
end

return FightResultFailPopup