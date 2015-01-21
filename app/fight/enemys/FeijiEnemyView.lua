
--[[--

“飞机兵”的视图
1. 临时兵种 指定时间离开屏幕
2. 有进入屏幕动画
3. 
]]


local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local Actor = import("..Actor")
local Enemy = import(".Enemy")
local BaseEnemyView = import(".BaseEnemyView")
local FeijiEnemyView = class("FeijiEnemyView", BaseEnemyView)  

function FeijiEnemyView:ctor(property)
	--instance
	FeijiEnemyView.super.ctor(self, property) 

    -- --events
    cc.EventProxy.new(self.enemy, self)
        :addEventListener(Actor.HP_DECREASE_EVENT, handler(self, self.playHitted)) 
        :addEventListener(Actor.KILL_EVENT, handler(self, self.playKill)) 
    
    self.direct = "right"
    self.isEntering = true
    self.isExiting  = false
    local lastTime = self.property["lastTime"]
    local sch = scheduler.performWithDelayGlobal(handler(self, self.exit), lastTime)
    self:addScheduler(sch)

    self:setData()
end

function FeijiEnemyView:setData()
	local type 		= self.property["type"]
	self.speed 		= define["k"..type.."Speed"]
	self.runTime 	= define["k"..type.."RunTime"]
	self.walkTime 	= define["k"..type.."WalkTime"]
end

function FeijiEnemyView:playStartState(state)
	print("playStartState")
	if state == "enterleft" then 
		self:playEnter("left")
	elseif state == "enterright" then
		self:playEnter("right")
	else 
		self:playStand()
	end
end

function FeijiEnemyView:tick()
	--change state
	if self.isExiting or self.isEntering then return end

	--fire
	local fireRate, isAble = self.enemy:getFireRate()
	assert(fireRate > 1, "invalid fireRate")
	if isAble then 
		randomSeed = math.random(1, fireRate)
		if randomSeed > fireRate - 1 then 
			self:playAfterAlert("playFire", handler(self, self.playFire))
			self.enemy:beginFireCd()
		end
	end

	--walk
	local walkRate, isAble = self.enemy:getWalkRate()
	assert(walkRate > 1, "invalid walkRate")
	if isAble then
		randomSeed =  math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:play("playRun", handler(self, self.playWalk))
		end
	end

	--roll
	local rollRate, isAble = self.enemy:getRollRate()
	assert(rollRate > 1, "invalid rollRate")
	if isAble then 
		randomSeed =  math.random(1, rollRate)
		if randomSeed > rollRate - 1 then 
			self:play("playRun", handler(self, self.playRun))
		end
	end
end

function FeijiEnemyView:playEnter(direct)
	self.isEntering = true
	self.isRuning = true
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
	local time = (toPosx - srcPosX) / self.speed
	local action = cc.MoveTo:create(time, cc.p(toPosx, 0))	
	local callfunc = function ()
		self.isEntering = false
		self.isRuning = false
		self:playStand()
	end

    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))		
end

function FeijiEnemyView:exit()
	print("function FeijiEnemyView:exit()")
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	self.isExiting = true
	self.isRuning = true
	local speed = self.speed
	local width = display.width * 1.5
	local action = cc.MoveBy:create(width/speed, cc.p(width, 0))
	local callfunc = function ()
		self:setWillRemoved()
	end

    self.armature:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))	
end

function FeijiEnemyView:playRun()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then
		self:play("playRunLeft", handler(self, self.playRunLeft))
	else
		self:play("playRunRight", handler(self, self.playRunRight))
	end
end

function FeijiEnemyView:playRunLeft()
	local speed = self.speed
	local time  = self.runTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(-width) then return end
	self.direct = "left"
	self.isRuning = true
	self.armature:getAnimation():play("runleft" , -1, 1) 
	local action = cc.MoveBy:create(time, cc.p(-width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)
	self.enemy:beginRollCd()
end

function FeijiEnemyView:playRunRight()
	local speed = self.speed
	local time  = self.runTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(width) then return end

	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	self.isRuning = true
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)		
	self.enemy:beginRollCd()	
end

function FeijiEnemyView:playWalk()
	local randomSeed = math.random(1, 2)
	if randomSeed == 1 then
		self:play("playWalkLeft", handler(self, self.playWalkLeft))
	else
		self:play("playWalkRight", handler(self, self.playWalkRight))
	end
end

function FeijiEnemyView:playWalkLeft()
	local speed = self.speed
	local time  = self.walkTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(-width) then return end
	self.direct = "left"
	self.isRuning = true
	self.armature:getAnimation():play("runleft" , -1, 1) 
	local action = cc.MoveBy:create(time, cc.p(-width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)
	self.enemy:beginWalkCd()    
end

function FeijiEnemyView:playWalkRight()
	local speed = self.speed
	local time  = self.walkTime
	local width = speed * time * self:getScale()

	if not self:checkPlace(width) then return end

	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	self.isRuning = true
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action)	

    self:restoreStand(time)		
	self.enemy:beginWalkCd()    	
end

function FeijiEnemyView:playFire()
	local name = self.direct == "right" and "fireright" or "fireleft"
	self.armature:getAnimation():play(name , -1, 1)

	--daodan
	local index = self.direct == "left" and -1 or 0
	while true do
		index = index + 2
		local name = "dao"..index
	    local boneDao = self.armature:getBone(name)
	    if boneDao == nil then break end
	    print("playFire index"..index)
	    local boneImage = boneDao:getDisplayRenderNode()
	    
	    local pWorldBone = boneImage:convertToWorldSpace(cc.p(0, 0))

	    local property = {
	        srcPos = pWorldBone,
	        srcScale = self:getScale() * 0.3,
	        destPos = pWorldBone,
	        type = "missile",
	        id = self.property["missileId"],
	        missileType = self.property["missileType"],
	    }
	    local function callfuncDaoDan()
	    	local hero = md:getInstance("Hero")
	        hero:dispatchEvent({name = hero.ENEMY_ADD_MISSILE_EVENT, property = property})
	    end
	    local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, 0.3)
	    self:addScheduler(sch)  

	end

end

function FeijiEnemyView:restoreStand(delay)
	local function restore()
		 self:playStand()
		 self.armature:stopAllActions()	
		 self.isRuning = false
	end
    self.schRestore =  scheduler.performWithDelayGlobal(restore, delay)
    self:addScheduler(self.schRestore)
end

function FeijiEnemyView:playStand()
	print("function FeijiEnemyView:playStand()")
	if self.direct == "left" then 
		self.armature:getAnimation():play("standleft" , -1, 1)
	else 
		self.armature:getAnimation():play("standright" , -1, 1)
	end
end

function FeijiEnemyView:onHitted(targetData)
	FeijiEnemyView.super.onHitted(self, targetData)
end

function FeijiEnemyView:playHitted(event)
	--飘红
	self:playHittedEffect()
end

function FeijiEnemyView:playKill(event)
	local name = self.direct == "right" and "dieright" or "dieleft"
	

	--clear
	self.armature:stopAllActions()
	if self.schRestore  then 
		scheduler.unscheduleGlobal(self.schRestore)
	end

	--anim
	self.armature:getAnimation():play(name , -1, 1)
	self:playBombEffects()

end

function FeijiEnemyView:playBombEffects()
    for i=1,8 do
        local sch  = scheduler.performWithDelayGlobal(
            handler(self, self.playBombEffect), i * 0.1)
        self:addScheduler(sch)
    end
end

function FeijiEnemyView:animationEvent(armatureBack,movementType,movementID)

	if movementType == ccs.MovementEventType.loopComplete then
		print("animationEvent id ", movementID)
		if movementID ~= "dieright" and movementID ~= "dieleft" then
			if self.isRuning then
				return 
			end	

			local playCache = self:getPlayCache()
			if playCache then 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "dieright" or movementID == "dieleft" then 
    		self:setDeadDone()
    	end 
	end
end

return FeijiEnemyView