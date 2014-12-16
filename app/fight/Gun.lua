 
--[[--

“枪”的实体

]]

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")



local Gun = class("Gun", cc.mvc.ModelBase)

--config

-- 定义属性
Gun.schema = clone(cc.mvc.ModelBase.schema)

function Gun:ctor(properties)
    Gun.super.ctor(self, properties)
    -- dump(properties, "properties")

    self.config = getConfigByID("config/weapon_weapon.json", properties.id)
end

function Gun:getConfig()
	assert(self.config, "self.config is nil")
	return self.config
end

function Gun:getCooldown()
	assert(self.config.coolDown, "coolDown is nil id:"..self.config.id)
	local baseValue = self.config.coolDown
	return  baseValue
end

function Gun:getBulletNum()
	assert(self.config.bulletNum, "bulletNum is nil id:"..self.config.id)
	local baseValue = self.config.bulletNum
	local value = 0.0
    local inlayValue, isInlayed = self.hero:getInlayedValue("clip")
    if isInlayed then
        value = baseValue + inlayValue
    else
        value = baseValue
    end	
	return value
end

function Gun:getReloadTime()
	return 2.0
end

function Gun:getDemage()
	assert(self.config.demage, "bulletNum is nil id:"..self.config.id)
	local inlayScale = 1.0 -- 改为inlaymodel
	return self.config.demage * inlayScale
end

return Gun