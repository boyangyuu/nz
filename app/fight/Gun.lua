local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

--[[--

“枪”的实体

]]

local Gun = class("Gun", cc.mvc.ModelBase)

--config

-- 定义属性
Gun.schema = clone(cc.mvc.ModelBase.schema)

function Gun:ctor(properties, events, callbacks)
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
	local inlayScale = 1.0 -- 改为inlaymodel
	return self.config.coolDown * inlayScale
end

function Gun:getBulletNum()
	assert(self.config.bulletNum, "bulletNum is nil id:"..self.config.id)
	local inlayScale = 1.0 -- 改为inlaymodel
	-- return 4
	return self.config.bulletNum * inlayScale	
end

function Gun:getReloadTime()
	return 2.0
end

function Gun:getDemage()
	assert(self.config.bulletNum, "bulletNum is nil id:"..self.config.id)
	local inlayScale = 1.0 -- 改为inlaymodel
	return self.config.bulletNum * inlayScale
end





return Gun