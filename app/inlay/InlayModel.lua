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

function InlayModel:equipInlay(inlayid, Refresh)
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
				table.insert(data.inlay.inlayed[self:getInlayType(inlayid)],{inlayid = inlayid})
				if data.inlay.bags[k].ownednum == 0 then
					table.remove(data.inlay.bags,k)
				end
			end 
		end
	end

	if Refresh then
		self:refreshInfo(self:getInlayType(inlayid))
	end
    
    setUserData(data)
    -- dump(GameState.load())
end

function InlayModel:replaceInlayed(inlayid)
	local data = getUserData()
	local strType = self:getInlayType(inlayid)
	local inlaydata = data.inlay.inlayed[strType]
	local inlayedData = inlaydata[1]

	if self:isBagsExist(inlayedData.inlayid) then
		for k1,v1 in pairs(data.inlay.bags) do
			if v1.inlayid == inlayedData.inlayid then
				data.inlay.bags[k1].ownednum = data.inlay.bags[k1].ownednum + 1
			end
		end
	else
		local inlay = {inlayid = inlayedData.inlayid, ownednum = 1}
	    table.insert(data.inlay.bags, inlay)
	end
	table.remove(inlaydata,1)
	table.insert(inlaydata,{inlayid = inlayid})
	    setUserData(data)
end

function InlayModel:oneForAllBtn()
	local bestInlay = {bullet=100,clip=100,speed=100,aim=100,blood=100,helper=100}
	local data = getUserData()
	local allinlayed = self:getAllInlayed()
	local bags = {}
	for k,v in pairs(data.inlay.bags) do
		bags[k] = v
	end
	for k,v in pairs(bags) do
		local typename = self:getInlayType(v.inlayid)
		if v.inlayid < bestInlay[typename] then
			bestInlay[typename] = v.inlayid
		end
		for k1,v1 in pairs(allinlayed) do
			if v1.typename == typename and bestInlay[typename] > v1.index then
				bestInlay[typename] = v1.index
			end
		end
	end
	for k,v in pairs(bestInlay) do
		if v ~= 100 then
			self:equipInlay(v, false)
		end
	end
	self:refreshInfo("speed")
	dump(bestInlay)
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

function InlayModel:BestInlayInTable(table)
	local bestInlay = {bullet=100,clip=100,speed=100,aim=100,blood=100,helper=100}
	for k,v in pairs(table) do
		local typename = self:getInlayType(v.inlayid)
		if v.inlayid < bestInlay[typename] then
			bestInlay[typename] = v.inlayid
		end
	end
	
	for k,v in pairs(bestInlay) do
		if v ~= 100 then
			dump(v)
			self:equipInlay(v, false)
		end
	end

end

-- function InlayModel:equipInlaysInTable(table)
-- 	local data = getUserData()
-- 	for k,v in pairs(table) do
-- 		self:equipInlay(v["inlayid"],false)
-- 	end
--     dump(GameState.load())
-- end

function InlayModel:isInlayedExist(inlayid)
	local data = getUserData()
	local strType = self:getInlayType(inlayid)
	local inlaydata = data.inlay.inlayed[strType]
	local inlayedData = inlaydata[1]
	if inlayedData == nil then
		-- 没有装备
		return 0
	elseif inlayedData.inlayid ~= inlayid then
		-- 装备过同类型
		return 1
	else
		-- 装备了一样的
		return 2
	end
end

function InlayModel:getInlayType(inlayid)
	return self:getConfigTable("id", inlayid)[1]["type"]
end

function InlayModel:getAllInlayed()
	local data = getUserData()
	local allInlayed = {}
    for k,v in pairs(data.inlay.inlayed) do
		local inlayedData = v[1]
		if inlayedData ~= nil then
			--todo
			table.insert(allInlayed,{index = inlayedData.inlayid,typename = k})
		end
	end
	dump(allInlayed)
	return allInlayed
end

return InlayModel