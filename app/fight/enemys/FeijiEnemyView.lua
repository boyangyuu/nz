
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
    self:schedule(handler(self, self.playExit), lastTime)
    
    self:setData()
end

function FeijiEnemyView:setData()
	local type 		= self.property["type"]
	self.speed 		= define["k"..type.."Speed"]
	self.runTime 	= define["k"..type.."RunTime"]
	self.walkTime 	= define["k"..type.."WalkTime"]
end

function FeijiEnemyView:playStartState(state)
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
		local randomSeed = math.random(1, fireRate)
		if randomSeed > fireRate - 1 then 
			self:playAfterAlert("skill", handler(self, self.playFire))
			self.enemy:beginFireCd()
		end
	end

	--walk
	local walkRate, isAble = self.enemy:getWalkRate()
	assert(walkRate > 1, "invalid walkRate")
	if isAble then
		local randomSeed =  math.random(1, walkRate)
		if randomSeed > walkRate - 1 then 
			self:playWalk()
		end
	end

	--roll
	local rollRate, isAble = self.enemy:getRollRate()
	assert(rollRate > 1, "invalid rollRate")
	if isAble then 
		local randomSeed =  math.random(1, rollRate)
		if randomSeed > rollRate - 1 then 
			self:playRun()
		end
	end
end

function FeijiEnemyView:playEnter(direct)
	self.isEntering = true
	local isLeft = direct == "left" 
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	local toPosx = self:getPositionX()
	local toPosY = self:getPositionY()

	local posInMapx = self:getPosInMap().x
	local srcPosX = 0 
	if isLeft then 
		srcPosX =  toPosx - posInMapx - 300
	else
		srcPosX = toPosx + (display.width - posInMapx) + 300
	end

	self:setPositionX(srcPosX)
	local speed = self.speed * self:getScale()
	local time =  math.abs(toPosx - srcPosX) / speed
	local action = cc.MoveTo:create(time, cc.p(toPosx, toPosY))	
	local callfunc = function ()
		self.isEntering = false
		self:playStand()
	end

    self:runAction(cc.Sequence:create(action, 
    		cc.CallFunc:create(callfunc)))	

    --sound
    local soundSrc  = "res/Music/fight/plane.wav"
    self.audioId =  audio.playSound(soundSrc,true) 
end

function FeijiEnemyView:playExit()
	if self.enemy:isDead() then return end
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	self.isExiting = true
	local speed = self.speed * self:getScale()
	local width = display.width * 1.0
	local action = cc.MoveBy:create(width/speed, cc.p(width, 0))
	local callfunc = function ()
		self:setWillRemoved()
		--sound
		audio.stopSound(self.audioId)
	end

    self:runAction(cc.Sequence:create(action, 
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
	local speed = self.speed * self:getScale()
	local time  = self.runTime
	local width = speed * time 

	if not self:checkPlace(-width) then return end
	self.direct = "left"
	self.armature:getAnimation():play("runleft" , -1, 1) 
	-- print("width", width)
	local action = cc.MoveBy:create(time, cc.p(-width, 0))
    self.armature:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))	
	self.enemy:beginRollCd()
end

function FeijiEnemyView:playRunRight()
	local speed = self.speed * self:getScale()
	local time  = self.runTime
	local width = speed * time 

	if not self:checkPlace(width) then return end
	-- print("width", width)
	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))		
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
	local speed = self.speed * self:getScale()
	local time  = self.walkTime
	local width = speed * time 
	-- print()
	if not self:checkPlace(-width) then return end

	self.direct = "left"
	self.armature:getAnimation():play("runleft" , -1, 1) 
	local action = cc.MoveBy:create(time, cc.p(-width, 0))
    self.armature:runAction(action)	

    self.armature:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))		
	self.enemy:beginWalkCd()    
end

function FeijiEnemyView:playWalkRight()
	local speed = self.speed * self:getScale()
	local time  = self.walkTime
	local width = speed * time

	if not self:checkPlace(width) then return end

	self.armature:getAnimation():play("runright" , -1, 1) 
	self.direct = "right"
	local action = cc.MoveBy:create(time, cc.p(width, 0))
    self.armature:runAction(action)	

    self.armature:runAction(cc.Sequence:create(action, 
    	cc.CallFunc:create(handler(self, self.restoreStand))
    	))				
	self.enemy:beginWalkCd()    	
end

function FeijiEnemyView:playFire()
	-- print("function FeijiEnemyView:playFire()")
	local name = self.direct == "right" and "fireright" or "fireleft"
	self.armature:getAnimation():play(name , -1, 1)

	--daodan
	local index = self.direct == "left" and -1 or 0
	local offsetPoses = self.property["missileOffsets"]
	local offsetIndex = 0
	while true do
		offsetIndex = offsetIndex + 1
		index = index + 2
		local name = "dao"..index
	    local boneDao = self.armature:getBone(name)
	    if boneDao == nil then break end
	    -- print("playFire index"..index)
	    local boneImage = boneDao:getDisplayRenderNode()
	    
	    local pWorldBone = boneImage:convertToWorldSpace(cc.p(0, 0))

	    local property = {
	        srcPos = pWorldBone,
	        srcScale = self:getScale() * 0.3,
	        destPos = pWorldBone,
	        type = "missile",
	        id = self.property["missileId"],
	        demageScale = self.enemy:getDemageScale(),
	        missileType = self.property["missileType"],
	        offset = offsetPoses[offsetIndex]
	    }
	    local function callfuncDaoDan()
	    	-- print("local function callfuncDaoDan()")
	    	local hero = md:getInstance("Hero")
	        hero:dispatchEvent({name = hero.ENEMY_ADD_MISSILE_EVENT, property = property})
	    end
	    local sch = scheduler.performWithDelayGlobal(callfuncDaoDan, 0.5)
	    self:addScheduler(sch)  
	end
end

function FeijiEnemyView:playStand()
	if self.direct == "left" then 
		self.armature:getAnimation():play("standleft" , -1, 1)
	else 
		self.armature:getAnimation():play("standright" , -1, 1)
	end
end

function FeijiEnemyView:onHitted(targetData)
	if self.isEntering or self.isExiting then 
		return 
	end
	-- print("function FeijiEnemyView:onHitted(targetData)")
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

	--sound
	audio.stopSound(self.audioId)
end

function FeijiEnemyView:playBombEffects()
    for i=1,8 do
        local sch  = scheduler.performWithDelayGlobal(
            handler(self, self.playBombEffect), i * 0.1)
        self:addScheduler(sch)
    end
end

function FeijiEnemyView:animationEvent(armatureBack,movementType,movementID)
	if self.isEntering or self.isExiting then return end
	if movementType == ccs.MovementEventType.loopComplete then
		-- print("animationEvent id ", movementID)
		if movementID == "runright" or movementID == "runleft" then 
			return 
		end

		if movementID ~= "dieright" and movementID ~= "dieleft" then
	  		local playCache = self:getPlayCache()
			if playCache then
				-- print("playCache") 
				playCache()
			else 					
				self:playStand()
			end
    	elseif movementID == "dieright" or movementID == "dieleft" then 
    		self:setDeadDone()
    	end 
	end
end

function FeijiEnemyView:onExit()
	audio.stopSound(self.audioId)
end

return FeijiEnemyView