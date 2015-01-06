


local AboutPopup = class("AboutPopup", function()
	return display.newLayer()
end)
function AboutPopup:ctor()
	-- body
	self:loadCCS()
	self:initButtons()
end

function AboutPopup:loadCCS()
	local aboutNode = cc.uiloader:load("res/help/bangzhu/guangyu.ExportJson")
	aboutNode:setPosition(display.cx/5, display.cy/5)
	self:addChild(aboutNode)
end

function AboutPopup:initButtons()
	local closeBtn = cc.uiloader:seekNodeByName(self,"btn_guanbi")
	closeBtn:setTouchEnabled(true)
	addBtnEventListener(closeBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("AboutPopup")
		end
	end)
end

return AboutPopup