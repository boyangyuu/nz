
local GunSkillLayer = class("GunSkillLayer", function()
	return display.newLayer()
end)

function GunSkillLayer:ctor()
	--instance
	self.hero     = md:getInstance("Hero")
	self.fightGun = md:getInstance("FightGun")


	--events
	cc.EventProxy.new(self.hero, self)
			:addEventListener(self.hero.GUN_CHANGE_EVENT, handler(self, self.refreshUI))
		
	self:refreshUI()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(false)
end

function GunSkillLayer:refreshUI(event)
	print("function GunSkillLayer:refreshUI(event)")
	--clear
	if self.ui then 
		self.ui:removeSelf()
		self.ui = nil 
	end

	--config
	local gun   = self.hero:getGun() 
	local name  = gun:getGunName()
	print("name", name)
	name = "huoqilin"
	local config = gun:getSkillConfig()
	if config == nil then return end

	--ui
	self.ui = cc.uiloader:load("res/Fight/fightLayer/gunSkill/" 
		.. name .. ".ExportJson")
	assert(self.ui, "no GunSkillLayer ui: " .. name)
	self:addChild(self.ui)	

	--btns
	for skillId,skillConfig in pairs(config) do
		local btn = cc.uiloader:seekNodeByName(self.ui, "btn_" .. skillId)
		assert(btn, "btn")
        btn:onButtonClicked(function()
	         self:onClickBtnSkill(skillId)
	    end)
	end
end

function GunSkillLayer:onClickBtnSkill(skillId)
	print("onClickBtnSkill(skillId)", skillId)
	
	--check cooldown
	local gun   	 = self.hero:getGun() 
	local isCooldown = gun:isSkillCding(skillId)
	if not isCooldown then 
		print(" not isCooldown")
		return 
	end
	gun:startSkillCd(skillId)

	--config
	local config = gun:getSkillConfig()
	local skillConfig = config[skillId]
	assert(skillConfig, "nil:" .. skillId)
	-- dump(skillConfig, "skillConfig")

	--play skill
	self.fightGun:playSkill(skillConfig["animName"])

	--play buff
	local demage = self.hero:getDemage() * skillConfig["value"]
	local buffData = {
		buffAnimName  = skillConfig["buffAnimName"],
		value = demage,
		times  = nil,
	}
	local enemyM = md:getInstance("EnemyManager")
	
	local function buffFunc()
		local funcName = skillConfig["buffFunc"] 
		enemyM:doBuff(funcName, buffData)
		-- enemyM:doBuffAll_pause(buffData)
	end	

	local delay = 0.0
	local timeOffset = skillConfig["timeOffset"]
	if timeOffset then
		for i=1,skillConfig["times"] do
			delay = delay + timeOffset
			self:performWithDelay(buffFunc, delay)
		end
	else
		self:performWithDelay(buffFunc, 0.1)
	end

end

return GunSkillLayer