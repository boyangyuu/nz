 --[[--

“枪”的实体

]]

--includes
local FightInlay = import(".FightInlay")

local Gun = class("Gun", cc.mvc.ModelBase)


function Gun:ctor(properties)
    Gun.super.ctor(self, properties)
    -- dump(properties, "properties")

    --instance
    self.inlay = app:getInstance(FightInlay)

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
    local inlayValue, isInlayed = self.inlay:getInlayedValue("clip")
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
	assert(self.config.demage, "elf.config.demage nil id:"..self.config.id)
	local baseValue = self.config.demage
	return baseValue
end

return Gun