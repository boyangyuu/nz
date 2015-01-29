
local dir = "res/help/bangzhu/"
local postfix = ".ExportJson"
local config = {}

config["mapset"]      = dir.."homeSet"..postfix
config["fightset"]    = dir.."fightSet"..postfix

local PausePopup = class("PausePopup",function()
	return display.newLayer()
end)

local director = cc.Director:getInstance()

function PausePopup:ctor(properties)
	self.popupName = properties.popupName
	self:loadCCS()
	self:initButtons()
end

function PausePopup:loadCCS()
	local pauseNode = cc.uiloader:load(config[self.popupName])
	self:addChild(pauseNode) 
end

function PausePopup:initButtons()
	local gameContinueBtn = cc.uiloader:seekNodeByName(self, "Panel_GameContinue")
	gameContinueBtn:setTouchEnabled(true)
	addBtnEventListener(gameContinueBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then 
			-- ui:closePopup("PausePopup")
			director:popScene()

			-- director:resume()
			assert("gameContinue is pressed!")
		end
	end)

	local backBtn = cc.uiloader:seekNodeByName(self, "Panel_HomeBack")
	backBtn:setTouchEnabled(true)
	addBtnEventListener(backBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			director:popScene()
			-- ui:closePopup("PausePopup")
			self:btnEvent()
			print("homeBackBtn is pressed!")
		end
	end)

	local musicClosedBtn = cc.uiloader:seekNodeByName(self, "Panel_MusicClosed")
	local musicplay = cc.uiloader:seekNodeByName(musicClosedBtn, "musicplay")
	local musicclose = cc.uiloader:seekNodeByName(musicClosedBtn, "musicclose")
	local isMusicPlaying = audio:isMusicPlaying()
	if isMusicPlaying then
		musicplay:setVisible(false)
	else
		musicclose:setVisible(false)
	end
	
	musicClosedBtn:setTouchEnabled(true)
	addBtnEventListener(musicClosedBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then 
			local isMusicPlaying = audio:isMusicPlaying()
			if isMusicPlaying then
				print("music is playing")
				musicplay:setVisible(false)
				musicclose:setVisible(true)
				audio:pauseMusic()
				audio:pauseAllSounds()
			else
				print("music is close")
				musicplay:setVisible(true)
				musicclose:setVisible(false)
				audio:resumeMusic()
				audio:resumeAllSounds()
			end
			
			print("musicClosedBtn is pressed!")
		end
	end)

	local closeBtn = cc.uiloader:seekNodeByName(self, "Panel_Close")
	closeBtn:setTouchEnabled(true)
	addBtnEventListener(closeBtn, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			director:popScene()
		end
	end)
end

function PausePopup:btnEvent()
	if self.popupName == "mapset" then
		ui:changeLayer("StartLayer", {})

	elseif self.popupName == "fightset" then
		ui:changeLayer("HomeBarLayer",{})

	end
end

return PausePopup