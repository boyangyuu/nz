

local PauseBMPopup = class("PauseBMPopup",function()
	return display.newLayer()
end)

function PauseBMPopup:ctor()
	self:loadCCS()
	self:initButtons()
end

function PauseBMPopup:loadCCS()
	local pauseBMNode = cc.uiloader:load("res/bangzhu/dadituzhanting.ExportJson")
	self:addChild(pauseBMNode) 
end

function PauseBMPopup:initButtons()
	local gameContinueBtn = cc.uiloader:seekNodeByName(self, "Panel_GameContinue")
	gameContinueBtn:setTouchEnabled(true)
	addBtnEventListener(gameContinueBtn, function( event )
		if event.name == 'began' then
			cc.ColorUtil:isHighLighted(gameContinueBtn, true)
			return true
		elseif event.name == 'ended' then 
			cc.ColorUtil:isHighLighted(gameContinueBtn, false)
			ui:closePopup("PauseBMPopup")
			assert("gameContinue is pressed!")
		end
	end)

	local homeBackBtn = cc.uiloader:seekNodeByName(self, "Panel_HomeBack")
	homeBackBtn:setTouchEnabled(true)
	addBtnEventListener(homeBackBtn, function( event )
		if event.name == 'began' then
			cc.ColorUtil:isHighLighted(homeBackBtn, true)
			return true
		elseif event.name == 'ended' then
			cc.ColorUtil:isHighLighted(homeBackBtn, false)
			-- ui:closePopupAndChangeLayer("PauseBMPopup")
			ui:closePopup("PauseBMPopup")
			ui:changeLayer("HomeBarLayer", {})
			print("homeBackBtn is pressed!")
		end
	end)

	local musicClosedBtn = cc.uiloader:seekNodeByName(self, "Panel_MusicClosed")
	musicClosedBtn:setTouchEnabled(true)
	addBtnEventListener(musicClosedBtn, function( event )
		if event.name == 'began' then
			cc.ColorUtil:isHighLighted(musicClosedBtn, true)
			return true
		elseif event.name == 'ended' then 
			cc.ColorUtil:isHighLighted(musicClosedBtn, false)
			audio:pauseMusic()
			audio:pauseAllSounds()
			print("musicClosedBtn is pressed!")
		end
	end)

	local closeBtn = cc.uiloader:seekNodeByName(self, "btn_guanbi")
	closeBtn:setTouchEnabled(true)
	addBtnEventListener(closeBtn, function( event )
		if event.name == 'began' then
			cc.ColorUtil:isHighLighted(closeBtn, true)
			return true
		elseif event.name == 'ended' then
			cc.ColorUtil:isHighLighted(closeBtn, false)
			ui:closePopup("PauseBMPopup")
		end
	end)
end

return PauseBMPopup