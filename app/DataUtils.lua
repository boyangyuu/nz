local json = require("framework.json")

local DataUtils = class("DataUtils", function()
	return display.newNode()
end)


function DataUtils:ctor()
end

-- 获取res下json文件内容
function DataUtils:getConfig( configFileDir )
    assert(configFileDir ~= "" and type(configFileDir) == "string", "invalid param")
    local fileUtil = cc.FileUtils:getInstance()
    local fullPath = fileUtil:fullPathForFilename(configFileDir)
    local jsonStr = fileUtil:getStringFromFile(fullPath)
    local configTb = json.decode(jsonStr)
    return configTb
end

-- 通过表ID获取res下json文件内容
function DataUtils:getConfigByID( configFileDir, tableID  )
    assert(tableID ~= "" and type(tableID) == "number", "invalid param")
    local configTable = self:getConfig(configFileDir)
    for k,v in pairs(configTable) do
        if k == tableID then
            dump(v)
            return v
        end
    end
    print("not found")
    return nil
end

return DataUtils