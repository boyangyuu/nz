
--[[--

“奖励兵”的视图
1. 杀死获得指定奖励(黄武 手雷 金币 钻石 武器等)
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Attackable = import(".Attackable")
local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local AwardEnemyView = class("AwardEnemyView", BaseEnemyView)  


function AwardEnemyView:ctor(property)
	--instance
	AwardEnemyView.super.ctor(self, property) 

    -- --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, 	   handler(self, self.playKill)) 

    self.posIndex = 0
    self.posDatas = property.data
end

function AwardEnemyView:tick()
	
end

function AwardEnemyView:playStartState(state)
	print("playStartState")
	if state == "enterleft" then 
		self:playEnter("left")
	elseif state == "enterright" then
		self:playEnter("right")
	else 
		assert(false)
	end
end

function AwardEnemyView:playEnter(direct)
	--setPos
	local isLeft = direct == "left" 
	
	local toPosx = self:getPositionX()
	print("toPosx", toPosx)
	local posInMapx = self:getPosInMap().x
	local srcPosX = 0 
	if isLeft then 
		srcPosX =  toPosx - posInMapx - 300
	else
		srcPosX = toPosx + (display.width - posInMapx) + 300
	end
	print("srcPosX", srcPosX)
	self:setPositionX(srcPosX)

	--藏身处
	self:playMoveToNext()

end

function AwardEnemyView:playMoveToNext(direct)
	self.posIndex = self.posIndex + 1
	--check next
	local data = self.posDatas[self.posIndex]
	if data == nil then 
		print("离开")
		self:exit()
		return
	end 
	
	--armature
	local animName = "run" .. data["direct"]
	print("animName", animName)
	self.armature:getAnimation():play(animName , -1, 1) 
	self.direct = direct

	--dest pos
	local posPlace = self:getPlaceNode():getPositionX()
	local destPos = posPlace + data["pos"]
	print("posPlace:", posPlace)
	print("data[pos]:", data["pos"])

	--action
	local distance = math.abs(destPos - self:getPositionX())
	print("distance", distance)
	local time = distance / define.kAwardSpeed
	local action = cc.MoveTo:create(time, cc.p(destPos, self:getPositionY()))
	local callfunc = function ()
		self:playHide()
	end
    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))
end

function AwardEnemyView:playHide()
	print("self:playHide()")
	self.armature:getAnimation():play("dunxia" , -1, 1) 

	--move next
	local function callfunc()
		self:playMoveToNext()
	end
	local data = self.posDatas[self.posIndex]
	local delay = data["time"]
	self:performWithDelay(callfunc, delay)
end

function AwardEnemyView:exit()
	if self.enemy:isDead() then return end
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	self.isExiting = true
	local speed = define.kAwardSpeed
	local width = display.width
	local action = cc.MoveBy:create(width/speed, cc.p(width, 0))
	local callfunc = function ()
		self:setWillRemoved()
	end

    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))	
end

function AwardEnemyView:onHitted(targetData)
	AwardEnemyView.super.onHitted(self, targetData)
end

function AwardEnemyView:playHitted(event)
	--飘红
	self:playHittedEffect()
end

function AwardEnemyView:playKill(event)
	--clear
	self:clearPlayCache()
	self:stopAllActions()
	if self.schRestore  then 
		scheduler.unscheduleGlobal(self.schRestore)
	end
	self.armature:getAnimation():play("die" ,-1 , 1) 

  	self:performWithDelay(handler(self, self.sendAward), 0.1)
end

function AwardEnemyView:sendAward()
	--award
	local awardType = self.property.award 
	if awardType == "gold" then 
		local fightInlay = md:getInstance("FightInlay")
		fightInlay:activeGold()	
	end 	
end

function AwardEnemyView:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete 
		or movementType ==  ccs.MovementEventType.complete then
		-- print("animationEvent id ", movementID)
		if movementID == "dunxia" then return end
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
    	end 
	end
end

return AwardEnemyView