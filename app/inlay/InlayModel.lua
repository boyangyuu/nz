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
    dump(GameState.load())
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
    dump(GameState.load())
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
	local data = getUserData()
	local bestBullet,bestClip,bestSpeed,bestAim,bestBlood,bestHelper = 0,0,0,0,0,0
	local bags = {}
	for k,v in pairs(data.inlay.bags) do
		bags[k] = v
	end
	-- local allinlayed = self:getAllInlayed()
	for k,v in pairs(bags) do
		self:getBestInlay(v.inlayid)
	end
	self:refreshInfo("speed")
    dump(GameState.load())
end

function InlayModel:getBestInlay(inlayid)
	local allinlayed = self:getAllInlayed()
	local bestInlay = {bullet=0,clip=0,speed=0,aim=0,blood=0,helper=0}
	local typename = self:getInlayType(inlayid)
	if inlayid > bestInlay[typename] then
		bestInlay[typename] = inlayid
	end
	for k,v in pairs(allinlayed) do
		if v.typename == typename and bestInlay[typename] < v.index then
			bestInlay[typename] = v.index
		end
	end
	self:equipInlay(bestInlay[typename], false)
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
		local inlaydata = data.inlay.inlayed[k]
		local inlayedData = inlaydata[1]
		if inlayedData ~= nil then
			--todo
			table.insert(allInlayed,{index = inlayedData.inlayid,typename = k})
		end
	end
	return allInlayed

end

return InlayModel