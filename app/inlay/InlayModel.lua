import("..includes.functionUtils")

local InlayModel = class("InlayModel", cc.mvc.ModelBase)

function InlayModel:ctor(properties, events, callbacks)
	InlayModel.super.ctor(self, properties)
	self:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function InlayModel:getConfigTable(propertyName, index)
	assert(propertyName and index, "invalid param")
	local records = getRecordByKey("config/items_xq.json", propertyName, index) or {}
	return records
end

function InlayModel:getInlayNum(inlayid)
	local data = getUserData()
	if self:isBagsExist(inlayid)  then
		for k,v in pairs(data.inlay.bags) do
			if v.inlayid == inlayid then
				return data.inlay.bags[k].ownednum
			end
		end
	else
		return 0
	end
end

function InlayModel:refreshInfo(typename)
	self:dispatchEvent({name = "REFRESH_INLAY_EVENT",typename = typename})
end


function InlayModel:buyInlay(inlayid)
 	local data = getUserData()
	if self:isBagsExist(inlayid)  then
		for k,v in pairs(data.inlay.bags) do
			if v.inlayid == inlayid then
				data.inlay.bags[k].ownednum = data.inlay.bags[k].ownednum + 1
			end
		end
	else
		local inlay = {inlayid = inlayid, ownednum = 1}
	    table.insert(data.inlay.bags, inlay)
	end
    setUserData(data)
    -- dump(GameState.load())
    self:refreshInfo(self:getInlayType(inlayid))
end

function InlayModel:equipInlay(inlayid, isRefresh)
	local data = getUserData()
	-- dump(data.inlay.bags)
	for k,v in pairs(data.inlay.bags) do
		if v.inlayid == inlayid and data.inlay.bags[k].ownednum > 0 then
			print("equipInlay", self:isInlayedExist(inlayid))
		-- case 1 已经装备过相同的
			if self:isInlayedExist(inlayid) == 2 then
				print("已经装备过了")

		-- case 2 有相同type的，但是不同的inlay
			elseif self:isInlayedExist(inlayid) == 1 then
				-- 1、bags数量-1
				data.inlay.bags[k].ownednum = data.inlay.bags[k].ownednum - 1
				if data.inlay.bags[k].ownednum == 0 then
					table.remove(data.inlay.bags,k)
				end

				-- 2、从inlayed里替换,找到这个inlayed在bags里数量+1
				self:replaceInlayed(inlayid)

		-- case 3 不存在
			else
				data.inlay.bags[k].ownednum = data.inlay.bags[k].ownednum - 1
				local typeName = self:getInlayType(inlayid)
				local inlayed = data.inlay.inlayed
				inlayed[typeName] = inlayid
				if data.inlay.bags[k].ownednum == 0 then
					table.remove(data.inlay.bags,k)
				end
			end 
		end
	end

	if isRefresh then
		self:refreshInfo(self:getInlayType(inlayid))
	end
    
    setUserData(data)
    -- dump(GameState.load())
end

function InlayModel:replaceInlayed(inlayid)
	local data = getUserData()
	local strType = self:getInlayType(inlayid)
	local inlaydata = data.inlay.inlayed[strType]

	if self:isBagsExist(inlaydata) then
		for k1,v1 in pairs(data.inlay.bags) do
			if v1.inlayid == inlaydata then
				data.inlay.bags[k1].ownednum = data.inlay.bags[k1].ownednum + 1
			end
		end
	else
		local inlay = {inlayid = inlaydata, ownednum = 1}
	    table.insert(data.inlay.bags, inlay)
	end
	data.inlay.inlayed[strType] = inlayid
    setUserData(data)
end

function InlayModel:equipAllInlays()
	local bestInlay = { bullet = 0,clip =0 ,speed = 0,crit = 0 ,blood = 0, helper = 0}
	local bestInlayId = { bullet = 0,clip =0 ,speed = 0,crit = 0 ,blood = 0, helper = 0}
	local data = getUserData()
	local allinlayed = self:getAllInlayed()
	local bags = {}
	for k,v in pairs(data.inlay.bags) do
		bags[k] = v
	end
	for k,v in pairs(bags) do
		local priority = self:getInlayPriority(v.inlayid)
		local typename = self:getInlayType(v.inlayid)
		if priority > bestInlay[typename] then
			bestInlay[typename] = priority
		end
		for k1,v1 in pairs(allinlayed) do
			local inlayedPriority = self:getInlayPriority(v1)
			if k1 == typename and bestInlay[typename] < inlayedPriority then
				bestInlay[typename] = inlayedPriority
			end
		end
	end

	for k,v in pairs(bestInlay) do
		local typeTable = self:getConfigTable("type", k)
	    for k1,v1 in pairs(typeTable) do
	        for k2,v2 in pairs(v1) do
	            if k2 == "property" and v2 == bestInlay[k] then
	                bestInlayId[k] = v1["id"]
	            end
	        end
	    end
	end

	for k,v in pairs(bestInlayId) do
		if v ~= 100 then
			self:equipInlay(v, false)
		end
	end
	self:refreshInfo("speed")
end

function InlayModel:equipAllBestInlays(table)
	local bestInlay = {bullet=0,clip=0,speed=0,crit=0,blood=0,helper=0}	
	local bestInlayId = { bullet = 0,clip =0 ,speed = 0,crit = 0 ,blood = 0, helper = 0}
	for k,v in pairs(table) do
		local priority = self:getInlayPriority(v.inlayid)
		local typename = self:getInlayType(v.inlayid)
		if priority > bestInlay[typename] then
			bestInlay[typename] = priority
		end
	end
	
	for k,v in pairs(bestInlay) do
	local typeTable = self:getConfigTable("type", k)
	    for k1,v1 in pairs(typeTable) do
	        for k2,v2 in pairs(v1) do
	            if k2 == "property" and v2 == bestInlay[k] then
	                bestInlayId[k] = v1["id"]
	            end
	        end
	    end
	end
	dump(bestInlayId)

	for k,v in pairs(bestInlayId) do
		if v ~= 100 then
			-- dump(v)
			self:equipInlay(v, false)
		end
	end
end

function InlayModel:isBagsExist(inlayid)
	local data = getUserData()
	for k,v in pairs(data.inlay.bags) do
		if v.inlayid == inlayid then
			return true
		end
	end
	return false
end

function InlayModel:isInlayedExist(inlayid)
	local data = getUserData()
	local strType = self:getInlayType(inlayid)
	local inlaydata = data.inlay.inlayed[strType]
	if inlaydata == nil then
		-- 没有装备
		return 0
	elseif inlaydata ~= inlayid then
		-- 装备过同类型
		return 1
	else
		-- 装备了一样的
		return 2
	end
end

function InlayModel:isGetAllGold()
	local allInlayed = self:getAllInlayed()
	local x = 0
	for k,v in pairs(allInlayed) do
		x = x + 1
	end
	-- dump(allInlayed)
	-- print(x)
	if x ~= 6 then
		return false
	end
	for k,v in pairs(allInlayed) do
		local Priority = self:getInlayPriority(v)
		if Priority ~= 4 then
			return false
		end
	end
	return true	
end

function InlayModel:getInlayType(inlayid)
	return self:getConfigTable("id", inlayid)[1]["type"]
end

function InlayModel:getInlayPriority(inlayid)
	return self:getConfigTable("id", inlayid)[1]["property"]
end

function InlayModel:getAllInlayed()
	local data = getUserData()
	local allInlayed = {}
    for k,v in pairs(data.inlay.inlayed) do
    	allInlayed[k] = v
	end
	return allInlayed
end

--[[
	@return {id = 1, ... }
]]
function InlayModel:getGoldByType( typeName )
	local records = self:getConfigTable("type", typeName)
	for k,v in pairs(records) do
		for k1,v1 in pairs(v) do
			local kGoldPriority = 4
			if k1 == "property" and v1 == kGoldPriority then
				return v
			end
		end
	end
	return false
end

function InlayModel:removeAllInlay()
	local data = getUserData()
	data.inlay.inlayed = {}

	setUserData(data)
	
end

return InlayModel