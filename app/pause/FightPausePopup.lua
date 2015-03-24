

local FightPausePopup = class("FightPausePopup", function( )
	return display.newLayer()
end)

function FightPausePopup:ctor()
	self:loadCCS()
	self:initButtons()
end

function FightPausePopup:loadCCS()
	local pauseNode = cc.uiloader:load("res/help/bangzhu/fightSet.ExportJson")
	self:addChild(pauseNode)
end

function FightPausePopup:initButtons()
	-- 继续游戏
	local gameContinue = cc.uiloader:seekNodeByName(self, "Panel_GameContinue")
	gameContinue:setTouchEnabled(true)
	addBtnEventListener(gameContinue, function( event )
		if event.name == 'began' then 
			return true
		elseif event.name == 'ended' then 
			pm:closePopup()
		end
	end)

	-- 回大地图
	local mapBack = cc.uiloader:seekNodeByName(self, "Panel_HomeBack")
	mapBack:setTouchEnabled(true)
	addBtnEventListener(mapBack, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then
			--获得当前关卡id
			local fight  = md:getInstance("Fight")
	        local groupid,levelid = fight:getCurGroupAndLevel()
	        local levelInfo = groupid.."-"..levelid
	        print("levelInfo ",levelInfo)

	        --um
	        local umData = {}
	    	umData[levelInfo] = "中途退出"
	    	um:event("关卡完成情况", umData)
			ui:changeLayer("HomeBarLayer",{groupId = groupid})
			print("中途退出")

			--pauseModel
			pm:closePopup()
			
		end
	end)

	-- 音乐开关
	
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

	-- 关闭Popup
	local btnClose = cc.uiloader:seekNodeByName(self, "Panel_Close")
	btnClose:setTouchEnabled(true)
	addBtnEventListener(btnClose, function( event )
		if event.name == 'began' then
			return true
		elseif event.name == 'ended' then

			pm:closePopup()
		end
	end)
end

function FightPausePopup:onEnter()
	local fight = md:getInstance("Fight")
	fight:pauseFight(true)
end

function FightPausePopup:btnColor(btn,isPress)
	if isPress then 
		btn:setColor(cc.c3b(150, 150, 150))
	else 
		btn:setColor(cc.c3b(0, 0, 0))
	end
end

return FightPausePopup