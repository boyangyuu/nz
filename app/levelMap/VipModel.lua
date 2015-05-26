local VipModel = class("VipModel", cc.mvc.ModelBase)

function VipModel:ctor(properties)
	VipModel.super.ctor(self,properties)
end

function VipModel:setGet(isget)
	local data = getUserData()
	data.vip.isGet = isget
	setUserData(data)
end

function VipModel:getVipInfo()
	local data = getUserData()
	local vipInfo = data.vip
	return vipInfo
end

function VipModel:setGift()
	local propModel = md:getInstance("PropModel")
    local inlayModel = md:getInstance("InlayModel")
    local userModel = md:getInstance("UserModel")
    propModel:addProp("lei",5)
    inlayModel:buyGoldsInlay(1)
    userModel:addMoney(10000)
end

function VipModel:isGet()
	local vipInfo = self:getVipInfo()
	if vipInfo["isGet"] then
		return true
	else
		return false
	end
end

return VipModel