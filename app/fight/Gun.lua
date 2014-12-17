 --[[--

“枪”的实体

]]

--includes
local FightInlay  = import(".FightInlay")
local WeaponModel = import("..weaponList.WeaponListModel")

local Gun = class("Gun", cc.mvc.ModelBase)

function Gun:ctor(properties)
    Gun.super.ctor(self, properties)
    -- dump(properties, "properties")

    --instance
    self.inlay 		= app:getInstance(FightInlay)
    self.weaponModel = app:getInstance(WeaponModel)

    self.bagIndex = properties.bagIndex
    self.config = self:getConfig()
end

function Gun:getConfig()
	self.config = self.weaponModel:getFightWeaponValue(self.bagIndex)
	dump(self.config, "self.config gun")
	return self.config
end

function Gun:getCooldown()
	assert(self.config.coolDown, "cooldown is nil bagIndex:"..self.bagIndex)
	local baseValue = self.config.coolDown

	return  baseValue
end

function Gun:getBulletNum()
	assert(self.config.bulletNum, "bulletNum is nil bagIndex:"..self.bagIndex)
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
	local baseValue = self.config.reloadTime
	local value = 0.0 
	local inlayValue, isInlayed = self.inlay:getInlayedValue("speed")
    if isInlayed then
        value = baseValue - baseValue * inlayValue
    else
        value = baseValue
    end		
	return value
end

function Gun:getCritPercent()
	local value
	local inlayValue, isInlayed = self.inlay:getInlayedValue("crit")
    if isInlayed then
        value = 0.00 + inlayValue
    else
        value = 0.00
    end		
	return value	
end

function Gun:getDemage()
	assert(self.config.demage, "self.config.demage nil bagIndex:"..self.bagIndex)
	local baseValue = self.config.demage
	return baseValue
end


return Gun