local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local AwardTimeConfig = import(".AwardTimeConfig")
local AwardTimeModel = class("AwardTimeModel", cc.mvc.ModelBase)

function AwardTimeModel:ctor(property)
	self.remainTime = nil
	self.awardIndex = 1
	self:refreshTimer()
end

function AwardTimeModel:getAwardIndex()
	if self.awardIndex == 0 then return false end
	return self.awardIndex	
end

function AwardTimeModel:getRemainTime()
	return self.remainTime
end

function AwardTimeModel:refreshTimer()
	local config = AwardTimeConfig.getConfig(self.awardIndex)
	local needTime = config["time"]
	self.remainTime = needTime
	if self.sch then 
		scheduler.unscheduleGlobal(self.sch)
	end
	self.sch = scheduler.scheduleGlobal(handler(self, self.updateTime), 1)
end

function AwardTimeModel:updateTime()
	self.remainTime = self.remainTime - 1
	if self.remainTime == 0 then return end
end

function AwardTimeModel:achieveAward()
	--send award
    local cfg = AwardTimeConfig.getAward(self.awardIndex)
    local moneyNum   = cfg["money"] or 0
    local diamondNum = cfg["diamond"] or 0
    local user       = md:getInstance("UserModel")
    user:addDiamond(diamondNum)
    user:addMoney(moneyNum)
    print("function AwardTimeModel:achieveAward()")

    --next
    local num = cfg.getAwardNum()
    if num == self.awardIndex then 
    	self.awardIndex = 0
	else
    	self.awardIndex = self.awardIndex + 1 	 
    end

    --refresh timer
    self:refreshTimer()
end

return AwardTimeModel