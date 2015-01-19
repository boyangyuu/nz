
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

function RenzhiEnemyView:playRun()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then 
		self:play("playRunLeft", handler(self, self.playRunLeft))
	else
		self:play("playRunRight", handler(self, self.playRunRight))
	end
end

function RenzhiEnemyView:playRunLeft()
	local speed = define.kRenzhiSpeed
	local time  = define.kRenzhiRunTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(-width) then return end
	self.armature:getAnimation():play("runleft" , -1, 1) 
	self.playAnimId = "runleft"
	local action = cc.MoveBy:create(time, cc.p(-width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)
end

function RenzhiEnemyView:restoreStand(delay)
	local function restore()
		self.playAnimId = nil
		self:play("playStand", handler(self, self.playStand))
		self.armature:stopAllActions()	
	end
    scheduler.performWithDelayGlobal(restore, delay)
end

function RenzhiEnemyView:playRunRight()
	local speed = define.kRenzhiSpeed
	local time  = define.kRenzhiRunTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(width) then return end
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.playAnimId = "runright"
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)			
end

function RenzhiEnemyView:playKill(event)
	RenzhiEnemyView.super.playKill(self, event)
	--hero dispatch
end

function RenzhiEnemyView:playStartState(state)
	print("function RenzhiEnemyView:playStartState(state)")
end

function RenzhiEnemyView:animationEvent(armatureBack,movementType,movementID)
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