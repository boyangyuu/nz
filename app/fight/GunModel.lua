local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“枪”的实体

]]

local GunModel = class("GunModel", cc.mvc.ModelBase)

-- 常量
GunModel.FIRE_COOLDOWN = 10.2 -- 开火冷却时间

-- 定义属性
GunModel.schema = clone(cc.mvc.ModelBase.schema)
GunModel.schema["nickname"] = {"string"} -- 字符串类型，没有默认值
GunModel.schema["level"]    = {"number", 1} -- 数值类型，默认值 1
GunModel.schema["hp"]       = {"number", 1}


function GunModel:ctor(properties, events, callbacks)
    GunModel.super.ctor(self, properties)
end

return GunModel