
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
local RenzhiEnemyView = class("RenzhiEnemyView", BaseEnemyView)  


function RenzhiEnemyView:ctor(property)
	--instance
	RenzhiEnemyView.super.ctor(self, property) 

    -- --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 

    --
    self.isEntering = true
    self.playAnimId = nil
end

function RenzhiEnemyView:tick()
	--change state
	local walkRate, isAble = self.enemy:getWalkRate()
	assert(walkRate > 1, "invalid walkRate")

	if isAble then
		local randomSeed = math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:play("playWalk", handler(self, self.playRun))
			self.enemy:beginWalkCd()
		end
	end	
end

function RenzhiEnemyView:playStartState(state)
	print("playStartState")
	if state == "enterleft" then 
		self:playEnter("left")
	elseif state == "enterright" then
		self:playEnter("right")
	else 
		self:playStand()
	end
end

function RenzhiEnemyView:playEnter(direct)
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
	local action = cc.MoveTo:create(time, cc.p(toPosx, 0))
	local callfunc = function ()
		self.isEntering = false
		self:playStand()
	end

    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))		
end

function RenzhiEnemyView:playRun()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:play("playRunLeft", handler(self, self.playRunLeft))
	else
		self:play("playRunRight", handler(self, self.playRunRight))
	end
end

function RenzhiEnemyView:playRunLeft()
	print("function RenzhiEnemyView:playRunLeft()")
	local speed = define.kRenzhiSpeed
	local time  = define.kRenzhiRunTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(-width) then return end
	self.armature:getAnimation():play("runleft" , -1, 1) 
	print("self.playAnimId = runleft")
	self.playAnimId = "runleft"
	local action = cc.MoveBy:create(time, cc.p(-width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)
end

function RenzhiEnemyView:restoreStand(delay)
	local function restore()
		self.playAnimId = nil
		self:playStand()
		self.armature:stopAllActions()	
	end
    self.schRestore = scheduler.performWithDelayGlobal(restore, delay)
    self:addScheduler(self.schRestore)
end

function RenzhiEnemyView:playRunRight()
	print("function RenzhiEnemyView:playRunRight()")	
	local speed = define.kRenzhiSpeed
	local time  = define.kRenzhiRunTime
	local width = speed * time * self:getScale()
	print("width", width)
	if not self:checkPlace(width) then return end
	self.armature:getAnimation():play("runright" , -1, 1)	
	-- self:flipX(true)
	print("self.playAnimId = runleft") 
	self.playAnimId = "runright"
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)			
end

function RenzhiEnemyView:playKill(event)
	--clear
	self:clearPlayCache()
	self.armature:stopAllActions()
	if self.schRestore  then 
		scheduler.unscheduleGlobal(self.schRestore)
	end
	self.armature:getAnimation():play("die" ,-1 , 1)
end

function RenzhiEnemyView:animationEvent(armatureBack,movementType,movementID)
	if self.isEntering  then return end
	if movementType == ccs.MovementEventType.loopComplete then
		print("animationEvent id ", movementID)
		if movementID == "runleft" or movementID == "runright" then
			return 
		end

		if movementID == "hit" then
			if self.playAnimId ~= nil then 
				self.armature:getAnimation():play(self.playAnimId , -1, 1) 
				return
			end
		end

		if movementID ~= "die" then
			local playCache = self:getPlayCache()
			if playCache then 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "die" then 
    		self:setDeadDone()
    		local fight = md:getInstance("Fight")
    		fight:addKillRenzhiNum()
    	end 
	end
end

return RenzhiEnemyView