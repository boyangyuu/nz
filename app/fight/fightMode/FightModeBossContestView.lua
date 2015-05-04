
--[[--

“boss竞技模式”的视图

]]
local FightModeBaseView   = import(".FightModeBaseView") 

local FightModeBossContestView = class("FightModeBossContestView", FightModeBaseView)

function FightModeBossContestView:ctor()
	FightModeBossContestView.super.ctor(self)

	local map = md:getInstance("Map")
 	cc.EventProxy.new(map, self)
	 	:addEventListener(map.WAVE_UPDATE_EVENT  , handler(self, self.onUpdateWave))	 	
end

function FightModeBossContestView:initUI()
	FightModeBossContestView.super.initUI(self)
	self.lastWave  = cc.uiloader:seekNodeByName(self.ui, "lastWave")
	self.image	   = cc.uiloader:seekNodeByName(self.ui, "image")
	self.lastWave:setVisible(false)
	self.labelWave = cc.uiloader:seekNodeByName(self.ui, "labelWave")
	self.labelWave:setColor(cc.c3b(255, 0, 6))
end

function FightModeBossContestView:refreshUI()
	
end

function FightModeBossContestView:onFightStart(event)
	self.labelWave:setString(1)	
end

function FightModeBossContestView:onUpdateWave(event)
	local waveIndex = event.waveIndex
	self.labelWave:setString(waveIndex)	

	--check is last wave or not
	local map     = md:getInstance("Map")
	local waveNum = map:getWaveNum()
	if waveIndex == waveNum then 
		self.lastWave:setVisible(true)
		self.labelWave:setVisible(false)
		self.image:setVisible(false)
		return
	end

	--action
	local actionScale1 = cc.ScaleTo:create(0.2, 3.0)
	local actionScale2 = cc.ScaleTo:create(0.1, 1.0)
	local seq = cc.Sequence:create(actionScale1, actionScale2) 
	self.labelWave:runAction(seq)

	--fight save
	-- 等洞洞
end

function FightModeBossContestView:onFightPause(event)
	
end

function FightModeBossContestView:onFightEnd(event)
	
end

function FightModeBossContestView:onFightRelive(event)
	
end

return FightModeBossContestView
