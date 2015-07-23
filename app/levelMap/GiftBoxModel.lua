local GiftBoxConfig = import(".GiftBoxConfig")

local GiftBoxModel = class("GiftBoxModel", cc.mvc.ModelBase)

function GiftBoxModel:ctor(properties)
	GiftBoxModel.super.ctor(self, properties)
end

--"canReceive"可以领取,"alreadyReceive"已经领取,"futureReceive"还未领取
--[[MyApp information:
	data.giftBox = {
			{
				groupId = 1,
				levelId = 2,
				isReceive = true,
			}
        }
]]
function GiftBoxModel:getReceiveState(groupId,levelId)
	local data = getUserData()
	local isInfoExist = self:isInfoExist(groupId,levelId)
	if isInfoExist then
		for i,v in ipairs(data.giftBox) do
			if v.groupId == groupId and v.levelId == levelId then
				if v.isReceive == true then
					return "alreadyReceive"
				elseif v.isReceive == false then
					return "canReceive"
				end
			end
		end
	else
		return "futureReceive"
	end
end

function GiftBoxModel:setCanReceiveState(groupId,levelId)
	local data = getUserData()

	if data.giftBox then
		local isInfoExist = self:isInfoExist(groupId,levelId)
		if isInfoExist then
			return
		else
			local levelTable = {groupId = groupId,levelId = levelId,isReceive = false}
			table.insert(data.giftBox,levelTable)
		end
	else
		data.giftBox = {}
		local levelTable = {groupId = groupId,levelId = levelId,isReceive = false}
		table.insert(data.giftBox,levelTable)
	end
	setUserData()
end

function GiftBoxModel:isInfoExist(groupId,levelId)
	local data = getUserData()
	if data.giftBox then
		for i,v in pairs(data.giftBox) do
			if v.groupId == groupId and v.levelId == levelId then
				return true
			end
		end
		return false
	else
		return false
	end
end

function GiftBoxModel:receiveGiftBox()

end

return GiftBoxModel