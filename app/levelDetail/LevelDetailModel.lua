import("..includes.functionUtils")

--[[--

“关卡详情”类

]]

local LevelDetailModel = class("LevelDetailModel", cc.mvc.ModelBase)

function LevelDetailModel:ctor(properties)

end
function LevelDetailModel:getConfig(LevelID)

	local config = getConfigByID("config/3.json", LevelID)
	-- for k,v in pairs(detailTb) do
	-- 	local switch = {
	-- 	    ["guanqiaName"] = function()    -- for case 1
	-- 			self.detailname = v
	-- 			end,
	-- 	    ["enemyNum"]    = function()    -- for case 2
	-- 			self.enemynum   = v
	-- 		    end,
	-- 	    ["task"]        = function()    -- for case 3
	-- 			self.task       = v			    
	-- 			end,
	-- 		["taskType"]    = function()    -- for case 3
	-- 			self.tasktype   = v			    
	-- 			end,
	-- 		["jijia"]       = function()    -- for case 3
	-- 			self.jijia      = v			    
	-- 			end,
	-- 		["gold"]        = function()    -- for case 3
	-- 			self.gold       = v			    
	-- 			end,
	-- 		["mapxiaoImg"]  = function()    -- for case 3
	-- 			self.map        = v			    
	-- 			end,
	-- 		["guanqiaNum"]  = function()    -- for case 3
	-- 			self.detailnum  = v			    
	-- 			end,
	-- 		["weapon"]      = function()    -- for case 3
	-- 			self.weapon     = v			    
	-- 			end
	-- 	}
	-- 	 local f = switch[k]
	-- 	 if(f) then
	-- 	     f()
	-- 	 else                -- for case default
	-- 	     print "Case default."
	-- 	 end	
	-- end

	return config
end

return LevelDetailModel