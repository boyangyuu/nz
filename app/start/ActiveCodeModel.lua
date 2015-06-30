local ActiveCodeConfig = import(".ActiveCodeConfig")

local ActiveCodeModel = class("ActiveCodeModel", cc.mvc.ModelBase)

function ActiveCodeModel:ctor(properties)
	ActiveCodeModel.super.ctor(self, properties)
end

function ActiveCodeModel:sentActiveGift(activeCode)
    local acType = self:getType(activeCode)
    local rewardTable = ActiveCodeConfig.getConfig(acType)

	local userModel = md:getInstance("UserModel")
	local propModel = md:getInstance("PropModel")

    for i=1,#rewardTable do
		local award = rewardTable[i]
		for k,v in pairs(award) do
			if k == "healthBag" then
				propModel:addProp("hpBag",v)
			elseif k == "lei" then
				propModel:addProp("lei",v)
			elseif k == "money" then
				userModel:addMoney(v)
			elseif k == "diamond" then
				userModel:addDiamond(v)
			end
		end
	end
end

function ActiveCodeModel:getType(activeCode)
	local acParam = string.sub(activeCode,0,1)
	if acParam == "A" then
		return "wuxing"
    elseif acParam == "B" then
		return "qudao"
    elseif acParam == "C" then
		return "diamond120"
    elseif acParam == "D" then
		return "diamond260"
    elseif acParam == "E" then
		return "diamond450"
    end
end

function ActiveCodeModel:checkGet(activeCode)
	local acType = self:getType(activeCode)
	if acType == "wuxing" or acType == "qudao" then
		local data = getUserData()
		local isGet = data.activeCode[acType] 
		return isGet
	else
		return false
	end
end

function ActiveCodeModel:setGet(activeCode)
	local acType = self:getType(activeCode)
	if acType == "wuxing" or acType == "qudao" then
		local data = getUserData()
		data.activeCode[acType] = true
		setUserData(data)
	end
end

return ActiveCodeModel