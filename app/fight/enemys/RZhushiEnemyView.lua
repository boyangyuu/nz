
--[[--

“人质兵”的视图
1. 死亡达到关卡指定个数 杀死英雄
2. 左右移动范围大
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local RZHushiEnemyView = class("RZHushiEnemyView", BaseEnemyView)  


function RZHushiEnemyView:ctor(property)
	--instance
	RZHushiEnemyView.super.ctor(self, property) 

    -- --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self.isEntering = true
    self.isExiting  = false
    self.playAnimId = nil
    local lastTime = self.property["lastTime"] or 1.0
    local sch = scheduler.performWithDelayGlobal(handler(self, self.exit), lastTime)
    self:addScheduler(sch)        
end

function RZHushiEnemyView:tick()
	--change state
	local walkRate, isAble = self.enemy:getWalkRate()
	assert(walkRate > 1, "invalid walkRate")

	--walk
	if isAble then
		local randomSeed = math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:play("walk", handler(self, self.playRun))
			self.enemy:beginWalkCd()
		end
	end

	local rollRate, isAble = self.enemy:getRollRate()
	assert(rollRate > 1, "invalid rollRate")

	--roll
	if isAble then
		local randomSeed = math.random(1, rollRate)
		if randomSeed > rollRate - 1 then 
			self:play("roll", handler(self, self.playRoll))
			self.enemy:beginRollCd()
		end
	end	

	--speak
	local speakRate, isAble = self.enemy:getSpeakRate()
	assert(speakRate > 1, "invalid speakRate")

	if isAble then
		local randomSeed = math.random(1, speakRate)
		if randomSeed > speakRate - 1 then 
			self:play("playSpeak", handler(self, self.playSpeak))
			self.enemy:beginSpeakCd()
		end
	end		
end

function RZHushiEnemyView:playStartState(state)
	print("playStartState")
	if state == "enterleft" then 
		self:playEnter("left")
	elseif state == "enterright" then
		self:playEnter("right")
	else 
		self:playStand()
	end
end

function RZHushiEnemyView:playEnter(direct)
	self.isEntering = true
	local isLeft = direct == "left" 
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	local toPosx = self:getPositionX()
	print("toPosx", toPosx)

	local posInMapx = self:getPosInMap().x
	local srcPosX = 0 
	if isLeft then 
		srcPosX =  toPosx - posInMapx - 300
	else
		srcPosX = toPosx + (display.width - posInMapx) + 300
	end

	self:setPositionX(srcPosX)
	local time = (toPosx - srcPosX) / define.kRenzhiSpeed
	local action = cc.MoveTo:create(time, cc.p(toPosx, self:getPositionY()))
	local callfunc = function ()
		self.isEntering = false
		self:playStand()
	end

    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))		
end

function RZHushiEnemyView:exit()
	if self.enemy:isDead() then return end
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	self.isExiting = true
	local speed = define.kRenzhiSpeed * self:getScale()
	local width = display.width * 1.0
	local action = cc.MoveBy:create(width/speed, cc.p(width, 0))
	local callfunc = function ()
		self:setWillRemoved()
	end

    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))	
end

function RZHushiEnemyView:playSpeak()
	local randomSeed = math.random(1, 2)
	local animName = "speak"..randomSeed
	self.armature:getAnimation():play(animName , -1, 1) 
end

function RZHushiEnemyView:playRun()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:playRunAction(1, false)
	else
		self:playRunAction(-1, false)
	end
end

function RZHushiEnemyView:playRoll()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:playRunAction(1, true)
	else
		self:playRunAction(-1, true)
	end
end

function RZHushiEnemyView:playRunAction(direct, isRoll)
	print("function RZHushiEnemyView:playRunLeft():",isRoll)
	local speed = define.kRenzhiSpeed
	local time 
	if isRoll then 
		time = define.kRenzhiRunTime
	else
		time = define.kRenzhiWalkTime
	end
	print("time"..time)
	local width = speed * time * self:getScale() * direct
	print("width", width)
	if not self:checkPlace(width) then 
		self:checkIdle()
		return 
	end

	local animName = direct == 1 and "runright" or "runleft"
	self.armature:getAnimation():play(animName , -1, 1) 
	print("self.playAnimId = "..animName)
	self.playAnimId = animName
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))	

    --sound
    local soundSrc  = "res/Music/fight/rz_kp.wav"
    self.audioId =  audio.playSound(soundSrc,false)   
end

function RZHushiEnemyView:getIsWudi()
	return self.isEntering or self.isExiting
end

function RZHushiEnemyView:onHitted(targetData)
	if self:getIsWudi() then 
		return
	end
	RZHushiEnemyView.super.onHitted(self, targetData)
    --sound
    local soundSrc  = "res/Music/fight/rz_bj.wav"
	audio.playSound(soundSrc,false)  	
end

function RZHushiEnemyView:playKill(event)
	--clear
	self:clearPlayCache()
	self.armature:stopAllActions()
	if self.schRestore  then 
		scheduler.unscheduleGlobal(self.schRestore)
	end
	self.armature:getAnimation():play("die" ,-1 , 1)

	--sound
    local soundSrc  = "res/Music/fight/rz_die.wav"
    local audioId =  audio.playSound(soundSrc,false)   	
end

function RZHushiEnemyView:animationEvent(armatureBack,movementType,movementID)
	if self.isEntering or self.isExiting then 
		print("self.isEntering or self.isExiting")
		return 
	end
	if movementType == ccs.MovementEventType.loopComplete 
		or movementType ==  ccs.MovementEventType.complete then
		-- print("animationEvent id ", movementID)
		if movementID == "runleft" 
			or movementID == "runright"  then
				self.armature:getAnimation():play(movementID , -1, 1)
			return 
		end

		if movementID == "hit" then
			if self.playAnimId ~= nil then 
				self.armature:getAnimation():play(self.playAnimId , -1, 1) 
				return
			end
		end

		if movementID ~= "die" then
			self:playNextAnimCache()
    	elseif movementID == "die" then 
    		self:setDeadDone()
    		local fight = md:getInstance("Fight")
    		fight:addKillRenzhiNum()
    	end 
	end
end



return RZHushiEnemyView