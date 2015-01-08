

local PauseFLPopup = class("PauseFLPopup", function( )
	return display.newLayer()
end)

function PauseFLPopup:ctor()
	self:loadCCS()
	self:initButtons()
end

function PauseFLPopup:loadCCS()
	local pauseNode = cc.uiloader:load("res/help/bangzhu/zhandouzhanting.ExportJson")
	self:addChild(pauseNode)
end

function PauseFLPopup:initButtons()
	-- 继续游戏
	local gameContinue = cc.uiloader:seekNodeByName(self, "Panel_GameContinue")
	gameContinue:setTouchEnabled(true)
	addBtnEventListener(gameContinue, function( event )
		if event.name == 'began' then 
			return true
		elseif event.name == 'ended' then 
			ui:closePopup("PauseFLPopup")
		end
	end)

	-- 回大地图
	local mapBack = cc.uiloader:seekNodeByName(self, "Panel_MapBack")
	mapBack:setTouchEnabled(true)
	addBtnEventListener(mapBack, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("PauseFLPopup")
			ui:changeLayer("HomeBarLayer")
		end
	end)

	-- 音乐开关
	local musicClosed = cc.uiloader:seekNodeByName(self, "Panel_MusicClosed")
	musicClosed:setTouchEnabled(true)
	addBtnEventListener(musicClosed, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then 
			local isMusicPlay = audio:isMusicPlaying()
			if isMusicPlay then 
				audio:pauseMusic()
				audio:pauseAllSounds()
			else
				audio:resumeMusic()
				audio:resumeAllSounds()
			end
		end
	end)

	-- 关闭Popup
	local btnClose = cc.uiloader:seekNodeByName(self, "btn_guanbi")
	btnClose:setTouchEnabled(true)
	addBtnEventListener(btnClose, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			ui:closePopup("PauseFLPopup")
		end
	end)
end

return PauseFLPopup