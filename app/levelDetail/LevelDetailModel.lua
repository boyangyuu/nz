import("..includes.functionUtils")
--[[--

“关卡详情”类

]]

local LevelDetailModel = class("LevelDetailModel", cc.mvc.ModelBase)

function LevelDetailModel:ctor(properties)

end

function LevelDetailModel:getConfig(BigID,SmallID)
	local config = getConfig("config/3.json")
	local records = getRecord(config,"daguanqia",BigID)
	for k,v in pairs(records) do
		for k1,v1 in pairs(v) do
			if k1 == "xiaoguanqia" and v1==SmallID then
				dump(v)
				return v
			end
		end	
	end
	return nil
end

return LevelDetailModel