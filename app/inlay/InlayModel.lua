import("..includes.functionUtils")

local InlayModel = class("InlayModel", cc.mvc.ModelBase)

function InlayModel:ctor(properties, events, callbacks)
	InlayModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function InlayModel:getConfigTable(propertyName, index)
	assert(propertyName and index, "invalid param")
	local config = getConfig("config/items_xq.json")
	local records = getRecord(config, propertyName, index) or {}
	return records
end

function InlayModel:getInlayNum(inlayid)
	local data = getUserData()
	if self:isBagsExist(inlayid)  then
		for k,v in pairs(data.inlay.bags) do
			for k1,v1 in pairs(v) do
				if k1 == "inlayid" and v1 == inlayid then
					return data.inlay.bags[k].ownednum
				end
			end
		end
	else
		return 0
	end
end

function InlayModel:refreshBtnIcon(index)
	self:dispatchEvent({name = "REFRESH_BTN_ICON_EVENT",index = index})
end

function InlayModel:buyInlay(inlayid)
 	local data = getUserData()
	if self:isBagsExist(inlayid)  then
		for k,v in pairs(data.inlay.bags) do
			for k1,v1 in pairs(v) do
				if k1 == "inlayid" and v1 == inlayid then
					data.inlay.bags[k].ownednum = data.inlay.bags[k].ownednum + 1
				end
			end
		end
	else
		local inlay = {inlayid = inlayid, ownednum = 1}
	    table.insert(data.inlay.bags, inlay)
	end
    setUserData(data)
    dump(GameState.load())
end

function InlayModel:equipInlay(inlayid)
	local data = getUserData()
	for k,v in pairs(data.inlay.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "inlayid" and v1 == inlayid and data.inlay.bags[k].ownednum > 0 then
				data.inlay.bags[k].ownednum = data.inlay.bags[k].ownednum - 1
				self:replaceInlayed(inlayid)
				if data.inlay.bags[k].ownednum == 0 then
					table.remove(data.inlay.bags,k)
				end
			end
		end
	end
    setUserData(data)
    self:refreshBtnIcon(inlayid)
end

function InlayModel:replaceInlayed(inlayid)
	local data = getUserData()
	if self:isInlayedExist(inlayid) then
		return
	else
		for k,v in pairs(data.inlay.inlayed) do
			for k1,v1 in pairs(v) do
				if k1 == "inlayid" and self:getInlayType(v1) == self:getInlayType(inlayid) then
					table.remove(data.inlay.inlayed,k)
				end
			end
		end
		table.insert(data.inlay.inlayed,{inlayid = inlayid})
	end
end

function InlayModel:oneForAllBtn()
	local data = getUserData()
	local bestBullet,bestClip,bestSpeed,bestAim,bestBlood,bestHelper = 0,0,0,0,0,0
	for k,v in pairs(data.inlay.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "inlayid" then
				if self:getInlayType(v1) == "bullet" then
					if v1 > bestBullet then
						bestBullet = v1
					end
					self:equipInlay(bestBullet)
				elseif self:getInlayType(v1) == "clip" then
					if v1 > bestClip then
						bestClip = v1
					end
					self:equipInlay(bestClip)
				elseif self:getInlayType(v1) == "speed" then
					if v1 > bestSpeed then
						bestSpeed = v1
					end
					self:equipInlay(bestSpeed)
				elseif self:getInlayType(v1) == "aim" then
					if v1 > bestAim then
						bestAim = v1
					end
					self:equipInlay(bestAim)
				elseif self:getInlayType(v1) == "blood" then
					if v1 > bestBlood then
						bestBlood = v1
					end
					self:equipInlay(bestBlood)
				elseif self:getInlayType(v1) == "helper" then
					if v1 > bestHelper then
						bestHelper = v1
					end
					self:equipInlay(bestHelper)
				end
			end
		end
	end
    dump(GameState.load())
end

function InlayModel:getBestInlay(item)
	local allItem = {}
	table.insert(self.all)

	local best = nil

end

function InlayModel:isBagsExist(inlayid)
	local data = getUserData()
	for k,v in pairs(data.inlay.bags) do
		for k1,v1 in pairs(v) do
			if k1 == "inlayid" and v1 == inlayid then
				return true
			end
		end
	end
	return false
end

function InlayModel:isInlayedExist(inlayid)
	local data = getUserData()
	for k,v in pairs(data.inlay.inlayed) do
		for k1,v1 in pairs(v) do
			if k1 == "inlayid" and v1 == inlayid then
				return true
			end
		end
	end
	return false
end

function InlayModel:getInlayType(inlayid)
	if inlayid > 0 and inlayid<5 then
		return "bullet"
	elseif inlayid < 9 then
		return "clip"
	elseif inlayid < 13 then
		return "speed"
	elseif inlayid < 17 then
		return "aim"
	elseif inlayid < 21 then
		return "blood"
	else
		return "helper"
	end
end

return InlayModel