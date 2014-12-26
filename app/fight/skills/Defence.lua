 --[[--

“枪”的实体

]]

--includes

local Defence = class("Defence", cc.mvc.ModelBase)

--events
Defence.DEFENCE_SWITCH_EVENT = "DEFENCE_SWITCH_EVENT"
Defence.DEFENCE_RESUME_EVENT = "DEFENCE_RESUME_EVENT"
Defence.DEFENCE_BROKEN_EVENT = "DEFENCE_BROKEN_EVENT"
Defence.DEFENCE_BEHURTED_EVENT = "DEFENCE_BEHURTED_EVENT"
Defence.DEFENCE_CRACK_EVENT = "DEFENCE_CRACK_EVENT"

function Defence:ctor()
    Defence.super.ctor(self)
    --instance
    self.isDefending = false
    self.isAble = true
	self:refreshHp()
    --event

end

function Defence:setIsAble(isAble)
	self.isAble = isAble
	if isAble then 
		self:dispatchEvent({name = Defence.DEFENCE_RESUME_EVENT})
	else
		self:dispatchEvent({name = Defence.DEFENCE_BROKEN_EVENT})
	end

	--hp
	self:refreshHp()
end

function Defence:getIsAble()
	return self.isAble
end

function Defence:getIsDefending()
	return self.isDefending
end

function Defence:setIsDefending(isDefending_)
	self.isDefending = isDefending_
end

function Defence:refreshHp()
	local hero = md:getInstance("Hero")
	self.maxHp = hero:getMaxHp()
	self.hp = hero:getMaxHp()
end

function Defence:decreseHp(demage)
	print("myhp:", self.hp)
	print("Defence:decreseHp(demage)", demage)
	assert(self.hp > 0, "Defence is dead")
	local curHp = self.hp - demage
	if curHp <= 0 then 
		self:setIsAble(false)
		return
	else
		local demageSum = self.maxHp - curHp
		local demagePercent = demageSum / self.maxHp
		self:dispatchEvent({name = Defence.DEFENCE_BEHURTED_EVENT, percent = demagePercent})
		local cur   = math.ceil (curHp / 10)
		local last  = math.ceil(self.hp / 10) 
		if cur ~= last then 
			self:dispatchEvent({name = Defence.DEFENCE_CRACK_EVENT,
				 num = last - cur})
		end
		self.hp = curHp
	end
end

function Defence:onHitted(demage)
	--hp
	print("demage", demage)
	self:decreseHp(demage)
end

function Defence:switchStatus()
	if self.isAble == false then return end

	if self.isDefending then
		self:endDefence()
	else
		self:startDefence()
	end
end

function Defence:startDefence()
	print("Defence:startDefence()")
	self.isDefending = true
	self:dispatchEvent({name = Defence.DEFENCE_SWITCH_EVENT, isDefend = true})
end

function Defence:endDefence()
	print("Defence:endDefence()")
	self.isDefending = false
	self:dispatchEvent({name = Defence.DEFENCE_SWITCH_EVENT, isDefend = false})
end

return Defence