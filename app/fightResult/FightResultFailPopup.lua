local FightResultFailPopup = class("FightResultFailPopup", function()
	return display.newLayer()
end)

function FightResultFailPopup:ctor()
	self:loadCCS()
end

function FightResultFailPopup:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/FightResult/fightResultAnim")
	local controlNode = cc.uiloader:load("fightResultFail.ExportJson")
    self:addChild(controlNode)
    local btnrevive = cc.uiloader:seekNodeByName(self, "btnrevive")
    local btnback = cc.uiloader:seekNodeByName(self, "btnback")
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