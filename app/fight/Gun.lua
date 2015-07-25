 --[[--

“枪”的实体

]]

--events

--includes
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Gun = class("Gun", cc.mvc.ModelBase)
local GunConfigs = import(".Gun.GunConfigs")

function Gun:ctor(properties)
    Gun.super.ctor(self, properties)
    dump(properties, "properties")

    --instance
    self.inlay 		 = md:getInstance("FightInlay")
    self.weaponModel = md:getInstance("WeaponListModel")
    self.bagIndex    = properties.bagIndex
    self.configId    = properties.configId
    self.config      = nil 
    self.skillConfig = nil

	self:initConfig()
	self.curBulletNum = self:getBulletNum()
end

function Gun:initConfig()
	
	local isHelpGun = self.configId ~= nil 
	if not isHelpGun then 
		local data = getUserData()
		local weapon = data.weapons.weaponed[self.bagIndex]
		self.configId = weapon["weaponid"]
	else
		print("is help gun")
  	end

	self.config = self.weaponModel:getFightWeaponValue(self.configId, isHelpGun)
	dump(self.config, "self.config gun")

	--skill
	local name = self:getGunName()
	self.skillConfig = GunConfigs.getConfig(name)
	if self.skillConfig == nil then return end
	self.skillCd = 0

end

function Gun:getConfig()
	assert(self.config, "self.config is nil" .. self.bagIndex)
	return self.config
end

function Gun:getSkillConfig()
	dump(self.skillConfig, "self.skillConfig")
	return self.skillConfig
end

function Gun:getCooldown()
	assert(self.config.coolDown, "cooldown is nil bagIndex:"..self.bagIndex)
	local baseValue = 1 / self.config.coolDown
	local isGold = md:getInstance("FightInlay"):getIsActiveGold()
	local scale = isGold and self.config["goldCoolDownScale"] or 1.0
	local value = scale * baseValue

	local value = self:justCooldownValue(value)
	return value
end

function Gun:justCooldownValue(value)
	if device.platform ~= "android" then 
		return value
	end
	-- print("justCooldownValue value:", value)
	local scale = 1.0
	if 0.15 < value and value <= 0.5 then 
		scale = 0.90 	
	elseif 0.1 < value and value <= 0.15 then 
		scale = 0.85 
	elseif 0.08 < value and value <= 0.1 then 
		scale = 0.80 
	elseif 0.06 < value and value <= 0.08 then 
		scale = 0.75
	elseif  value <= 0.06 then 
		scale = 0.75
	end
	local value = value * scale
	return value
end

function Gun:setFullBulletNum()
	local fullNum = self:getBulletNum()
	self:setCurBulletNum(fullNum)
end

function Gun:setCurBulletNum(num)
	self.curBulletNum  = num
	local hero = md:getInstance("Hero")
	hero:dispatchEvent({name = hero.GUN_BULLET_EVENT, num = num})	
end

function Gun:getCurBulletNum()
	return self.curBulletNum 
end

function Gun:getBulletNum()
	assert(self.config.bulletNum, "bulletNum is nil bagIndex:"..self.bagIndex)
	local baseValue = self.config.bulletNum
	local value = 0.0
    -- local inlayValue, isInlayed = self.inlay:getInlayedValue("clip")
    -- if isInlayed then
    --     value = baseValue + baseValue * inlayValue
    -- else
    value = baseValue
    -- end	
    value = math.floor(value)
	return value
end

function Gun:isFireThrough()
	local isGold = md:getInstance("FightInlay"):getIsActiveGold()
	local type = self.config["type"]
	assert(type, "type is nil")
	if type == "pz" or type == "rpg" then 
		return true
	elseif isGold then 
		return true
	else
		return false
	end
end

function Gun:getReloadTime()
	local baseValue = self.config.reloadTime
	local value = 0.0 
	-- local inlayValue, isInlayed = self.inlay:getInlayedValue("speed")
 --    if isInlayed then
 --        value = baseValue - baseValue * inlayValue
 --    else
    value = baseValue
    -- end		
	return value
end

function Gun:getCritPercent()
	local value = (self.config["crit"] - 1)

	-- local inlayValue, isInlayed = self.inlay:getInlayedValue("crit")
 --    if isInlayed then
 --        value = 0.00 + inlayValue
 --    else
 --        value = 0.00
 --    end		
 	return value
	-- return value	
end

function Gun:getDemage()
	local baseValue = self.config.demage
	assert(baseValue, "baseValue nil bagIndex:"..self.bagIndex)
	return baseValue
end

function Gun:getConfigId()
	return self.configId
end

function Gun:getGunName()
	return self.config.growTable
end

function Gun:getSkillCdRemain(skillId)
	return self.skillCd
end

function Gun:getSkillCd(skillId)
	if self.skillConfig == nil then return end
	return  self.skillConfig[skillId].cd
end

function Gun:startSkillCd(skillId, cdEndFunc)
	self.skillCd = self.skillConfig[skillId]["cd"]

	local handle 
	local function resumeFunc()
		if self.skillCd <= 0 then 
			scheduler.unscheduleGlobal(handle)
			self.skillCd = 0
			return
		end
		self.skillCd = self.skillCd - 0.1
	end
	handle = scheduler.scheduleGlobal(resumeFunc, 0.1) 
end

return Gun