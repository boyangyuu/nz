 --[[--

“枪”的实体

]]

--includes




local Defence = class("Defence", cc.mvc.ModelBase)

--events
Defence.DEFENCE_SWITCH_EVENT = "DEFENCE_SWITCH_EVENT"
Defence.DEFENCE_RESUME_EVENT = "DEFENCE_RESUME_EVENT"

function Defence:ctor()
    Defence.super.ctor(self)
    self.isDefending = false
end

function Defence:getIsAble()
	
end

function Defence:getIsDefending()
	return self.isDefending
end

function Defence:setIsDefending(isDefending_)
	self.isDefending = isDefending_
end

function Defence:switchStatus()
	self.isDefending = not self.isDefending
	print("self.isDefending", self.isDefending)
	self:dispatchEvent({name = Defence.DEFENCE_SWITCH_EVENT, isDefend = self.isDefending})
end

return Defence