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
	if self:isInlayExist(inlayid)  then
		for k,v in pairs(data.inlay.inlayed) do
			for k1,v1 in pairs(v) do
				if k1 == "inlayid" and v1 == inlayid then
					return data.inlay.inlayed[k].ownednum
				end
			end
		end
	else
		return 0
	end
end

function InlayModel:refreshBtnIcon(string,index)
	self:dispatchEvent({name = "REFRESH_BTN_ICON_EVENT", string = string,index = index})
end

function InlayModel:buyInlay(inlayid)
 	local data = getUserData()
	if self:isInlayExist(inlayid)  then
		for k,v in pairs(data.inlay.inlayed) do
			for k1,v1 in pairs(v) do
				if k1 == "inlayid" and v1 == inlayid then
					data.inlay.inlayed[k].ownednum = data.inlay.inlayed[k].ownednum + 1
				end
			end
		end
	else
		local inlay = {inlayid = inlayid, ownednum = 1}
	    table.insert(data.inlay.inlayed, inlay)
	end
    setUserData(data)
    dump(GameState.load())
end

function InlayModel:equipInlay(inlayid)
	local data = getUserData()

		for k,v in pairs(data.inlay.inlayed) do
			for k1,v1 in pairs(v) do
				if k1 == "inlayid" and v1 == inlayid and data.inlay.inlayed[k].ownednum > 0 then
					data.inlay.inlayed[k].ownednum = data.inlay.inlayed[k].ownednum - 1
					if data.inlay.inlayed[k].ownednum == 0 then
						table.remove(data.inlay.inlayed,k)
					end
				end
			end
		end

    setUserData(data)
    dump(GameState.load())
end


function InlayModel:isInlayExist(inlayid)
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

return InlayModel