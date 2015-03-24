
local MapPausePopup = class("MapPausePopup",function()
	return display.newLayer()
end)

local director = cc.Director:getInstance()

function MapPausePopup:ctor(properties)
	self:loadCCS()
	self:initButtons()
end

function MapPausePopup:loadCCS()
	local pauseNode = cc.uiloader:load("res/help/bangzhu/homeSet.ExportJson")
	self:addChild(pauseNode) 
end

function MapPausePopup:initButtons()
	--继续游戏
	local gameContinueBtn = cc.uiloader:seekNodeByName(self, "Panel_GameContinue")
	gameContinueBtn:setTouchEnabled(true)
	addBtnEventListener(gameContinueBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then 
			pm:closePopup()
			assert("gameContinue is pressed!")
		end
	end)

	--返回登陆页
	local backBtn = cc.uiloader:seekNodeByName(self, "Panel_HomeBack")
	backBtn:setTouchEnabled(true)
	addBtnEventListener(backBtn, function( event )
		if event.name == 'began' then
			self:btnColor(backBtn, true)
			return true
		elseif event.name == 'ended' then
			if self.isChanging then return end 
			self.isChanging = true
			self:btnColor(backBtn, false)
			pm:closePopup()
			ui:changeLayer("StartLayer", {})
			print("homeBackBtn is pressed!")
		end
	end)

	--音乐开关
	local musicClosedBtn = cc.uiloader:seekNodeByName(self, "Panel_MusicClosed")
	local musicplay = cc.uiloader:seekNodeByName(musicClosedBtn, "musicplay")
	local musicclose = cc.uiloader:seekNodeByName(musicClosedBtn, "musicclose")
	local userData = getUserData()
	local isPlaying = userData.preference.isOpenMusic
	if isPlaying then
		musicplay:setVisible(false)
		musicclose:setVisible(true)
	else
		musicplay:setVisible(true)
		musicclose:setVisible(false)
	end
	musicClosedBtn:setTouchEnabled(true)
	addBtnEventListener(musicClosedBtn, function( event )
		if event.name == 'began' then
			self:btnColor(musicClosedBtn, true)
			return true
		elseif event.name == 'ended' then 

		self:btnColor(musicClosedBtn, false)
			local userData = getUserData()
			local isOpen = userData.preference.isOpenMusic
			print("isOpen : ", isOpen)
			musicplay:setVisible(isOpen)
			musicclose:setVisible(not isOpen)
			isPlaying = not isOpen
			audio.switchAllMusicAndSounds(isPlaying)

			--save
		    userData.preference["isOpenMusic"] = isPlaying
		    setUserData(userData)
		end
	end)

	--关闭按钮
	local closeBtn = cc.uiloader:seekNodeByName(self, "Panel_Close")
	closeBtn:setTouchEnabled(true)
	addBtnEventListener(closeBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			pm:closePopup()
		end
	end)
end

function MapPausePopup:btnColor(btn,isPress)
	if isPress then 
		btn:setColor(cc.c3b(150, 150, 150))
	else 
		btn:setColor(cc.c3b(0, 0, 0))
	end
end

return MapPausePopup