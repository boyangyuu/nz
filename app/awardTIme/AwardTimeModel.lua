local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local AwardTimeConfig = import(".AwardTimeConfig")
local AwardTimeModel = class("AwardTimeModel", cc.mvc.ModelBase)

function AwardTimeModel:ctor(property)
	self.remainTime = nil
	self.awardIndex = 1
	self.isAwardedAll = false
	self:refreshTimer()
end

function AwardTimeModel:getAwardIndex()
	if self.awardIndex == 0 then return false end
	return self.awardIndex	
end

function AwardTimeModel:getRemainTime()
	return self.remainTime
end

function AwardTimeModel:getContent()
	if self.isAwardedAll then 
		return "已全部领取"
	elseif self:isCanAward() then 
	    local cfg = AwardTimeConfig.getConfig(self.awardIndex)
	    local moneyNum   = cfg["money"]
	    return moneyNum .. "金币"
	end
	local time = self.remainTime
	local minutes = math.floor(time / 60)
	if minutes <  10 then 
		minutes = "0" .. minutes
	end

	local seconds = time % 60 
	if seconds < 10 then 
		seconds = "0" .. seconds
	end
	return minutes .. ":" .. seconds	
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
	if self.remainTime == 0 then return end
	self.remainTime = self.remainTime - 1
end

function AwardTimeModel:isCanAward()
	return not self.isAwardedAll and self.remainTime == 0 
end

function AwardTimeModel:achieveAward()
	if self:isCanAward() == false then return end
	--send award
    local cfg = AwardTimeConfig.getConfig(self.awardIndex)
    local moneyNum   = cfg["money"] or 0
    local diamondNum = cfg["diamond"] or 0
    local user       = md:getInstance("UserModel")
    user:addDiamond(diamondNum)
    user:addMoney(moneyNum)
    print("function AwardTimeModel:achieveAward()")

    --next
    local num = AwardTimeConfig.getAwardNum()
    if num == self.awardIndex then 
    	self.isAwardedAll = true
	else
    	self.awardIndex = self.awardIndex + 1 	 
    end

    --refresh timer
    self:refreshTimer()
end

return AwardTimeModel