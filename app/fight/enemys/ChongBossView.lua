local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local BaseBossView = import(".BaseBossView")
local FightConfigs = import("..fightConfigs.FightConfigs")
local ChongBossView = class("ChongBossView", BaseBossView)

function ChongBossView:ctor(property)
	ChongBossView.super.ctor(self, property) 
end

function ChongBossView:playSkill(skillName)
    local name = string.sub(skillName, 1, 7)
    if name == "moveOne" then 
        local function callfunc()
            self:platMoveOneDaoFireAction(skillName)
        end
        self:play("skill",callfunc)
        return 
    end
    ChongBossView.super.playSkill(self, skillName)
end

function ChongBossView:playFire()
	self.armature:getAnimation():play("daodan" , -1, 1) 
	local offsetPoses ={cc.p(-100,-100), cc.p(-100, 100), cc.p(100, 100), cc.p(100,-100) }
	for i=1, 4 do
		local boneName = "dao"..i
		local bone = self.armature:getBone(boneName):getDisplayRenderNode()		
		local delay = 0.3 + 0.10 * i 
		local property = {
			type = "missile",
			srcScale = self:getScale() * 0.3, --导弹view用
			id = self.property["missileId"], 
			demageScale = self.enemy:getDemageScale(),
			offset = offsetPoses[i],
		}
		local function callfuncAddDao()
			local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
			property.srcPos = srcPos
			property.destPos = srcPos
			self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
				property = property})
		end
		local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
	    self:addScheduler(sch)
	end
end

function ChongBossView:platMoveOneDaoFireAction(skillName)
	local isLeft = skillName == "moveOneLeftFire" and true or false 
	local posOri = cc.p(self:getPositionX(), self:getPositionY())
	local speed = 1000.0

	--向左/右出发
	local bound = self.armature:getCascadeBoundingBox() 
	local pos = self:getPosInMapBg()
	local disOut = isLeft and  -bound.width or 1560
	local time = math.abs(posOri.x - disOut) / speed
	local desPos = cc.p(disOut, posOri.y)
	local actionOut = cc.MoveTo:create(time, desPos)

	--到右屏幕
	desPos = cc.p(1660 + bound.width, posOri.y)
	local time = math.abs(1660 + 2 * bound.width) / speed
	local actionScreen1 = cc.MoveTo:create(time, desPos)

	--到左屏幕
	desPos = cc.p(- bound.width - 200, posOri.y)
	local time = math.abs(1660 + 2 * bound.width) / speed	
	local actionScreen2 = cc.MoveTo:create(time, desPos)

	--返回
	local time = math.abs(posOri.x - desPos.x) / speed
	local actionBack = cc.MoveTo:create(time, posOri)
	local seq = nil

	--出发之前
	local callfuncBeforeOut = function ()
		self.armature:getAnimation():play("moveleft" , -1, 1) --todo改为move
		self.pauseOtherAnim = true
		self:setUnhurted(true)
	end
	local beforeOutCall = cc.CallFunc:create(callfuncBeforeOut)

	--到右屏幕之前
	local callfuncBeforeRight = function ()
		self.armature:getAnimation():play("ksmoveright" , -1, 1) 
		self:playMoveDaoDan()
	end
	local beforeRightCall = cc.CallFunc:create(callfuncBeforeRight)
   
	--到左屏幕之前
	local callfuncBeforeLeft = function ()
		self.armature:getAnimation():play("ksmoveleft" , -1, 1)
		self:playMoveDaoDan()
	end
	local beforeLeftCall = cc.CallFunc:create(callfuncBeforeRight)

	--回去之前
	local callfuncBeforeBack = function ()
		self.armature:getAnimation():play("moveright" , -1, 1)
	end
	local beforeBackCall = cc.CallFunc:create(callfuncBeforeBack)

	--回去之后
	local callfuncAfterBack = function ()
		self.pauseOtherAnim = false
		self:setUnhurted(false)
	end	
	local afterBackCall = cc.CallFunc:create(callfuncAfterBack)

	--play
	if isLeft then 
		seq = cc.Sequence:create(
		beforeOutCall, actionOut,
		beforeRightCall, actionScreen1, 
		cc.DelayTime:create(2.0),
		actionBack, afterBackCall)	
	else 
		seq = cc.Sequence:create(
		beforeOutCall, actionOut,
		beforeLeftCall, actionScreen2, 
		cc.DelayTime:create(2.0),
		actionBack, afterBackCall)	
	end
	self:runAction(seq)
end

function ChongBossView:playTieQiu()
	self.armature:getAnimation():play("reng", -1, 1)
	local kDelayAnim = 1.0 		-- 导弹动画播放0.6s 再发导弹

	--导弹
	for i=1,1 do
		local boneName = "qiu"..i
		local bone = self.armature:getBone(boneName):getDisplayRenderNode()
		local delay = kDelayAnim
		local property = {
			type = "missile",
			missileType = "tie",
			srcScale = 0.3, 
			demageScale = self.enemy:getDemageScale(),
			id = self.property["qiuId"], 
		}
		local function callfuncAddDao()
			local srcPos = bone:convertToWorldSpace(cc.p(0.0,0.0))
			property.srcPos = srcPos
			property.destPos = srcPos			
			self.hero:dispatchEvent({name = self.hero.ENEMY_ADD_MISSILE_EVENT, 
				property = property})
		end
		local sch = scheduler.performWithDelayGlobal(callfuncAddDao, delay)
	    self:addScheduler(sch)    
	end		
end

return ChongBossView

