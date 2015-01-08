local FightResultFailPopup = class("FightResultFailPopup", function()
	return display.newLayer()
end)

function FightResultFailPopup:ctor()
	self:initUI()
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
    roleimg:scale(1.33)
    addChildCenter(roleimg, rolepanel)
    btnback:setTouchEnabled(true)
    addBtnEventListener(btnback, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	        ui:closePopup()
        	ui:changeLayer("HomeBarLayer",{})
        end
    end)
    addBtnEventListener(btnrevive, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	self:revive()
        end
    end)
end

function FightResultFailPopup:revive()
    
end

return FightResultFailPopup