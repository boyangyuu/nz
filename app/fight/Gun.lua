local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“枪”的实体

]]

local Gun = class("Gun", cc.mvc.ModelBase)

--config
local kCoolDown = 0.1
local kDemage = 20

-- 定义属性
Gun.schema = clone(cc.mvc.ModelBase.schema)
Gun.schema["nickname"] = {"string"} -- 字符串类型，没有默认值
Gun.schema["level"]    = {"number", 1} -- 数值类型，默认值 1
Gun.schema["hp"]       = {"number", 1}


function Gun:ctor(properties, events, callbacks)
    Gun.super.ctor(self, properties)
end

function Gun:getCooldown()
	return kCoolDown
end

function Gun:getDemage()
	return kDemage
end

return Gun