
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
	--clear
	if self.ui then 
		self.ui:removeSelf()
		self.ui = nil 
	end
	self.timers = {}
	self.config = {}
	self.skillCdPercent = {}
	self:stopAllActions()

	--config
	local gun   = self.hero:getGun() 
	local name  = gun:getGunName()
	name = "huoqilin"
	self.config = gun:getSkillConfig()
	if self.config == nil then return end

	--ui
	self.ui = cc.uiloader:load("res/Fight/fightLayer/gunSkill/" 
		.. name .. ".ExportJson")
	assert(self.ui, "no GunSkillLayer ui: " .. name)
	self:addChild(self.ui)	

	--btns timers
	for skillId,skillConfig in pairs(self.config) do
		local btn = cc.uiloader:seekNodeByName(self.ui, "btn_" .. skillId)
		assert(btn, "btn")
        btn:onButtonClicked(function()
	         self:onClickBtnSkill(skillId)
	    end)

        --timer
        self.skillCdPercent[skillId] = 0
	    local bar = display.newProgressTimer("#btn_cd1.png", display.PROGRESS_TIMER_RADIAL)
		btn:addChild(bar)
	    bar:setAnchorPoint(0.5, 0.5)
	    bar:setReverseDirection(true)
	    bar:setPercentage(100)
	    bar:setVisible(false)
		self.timers[skillId] = bar
	end
end

function GunSkillLayer:onClickBtnSkill(skillId)	
	--check cooldown
	local percent = self:getSkillCdPercent(skillId)
	if percent ~= 0 then
		return 
	end
	self:startSkillCd(skillId)

	--config
	local skillConfig = self.config[skillId]
	assert(skillConfig, "nil:" .. skillId)
	-- dump(skillConfig, "skillConfig")

	--play skill
	self.fightGun:playSkill(skillConfig["animName"])

	--play buff
	skillConfig.buffFunc()
end

function GunSkillLayer:getSkillCdPercent(skillId)
	local percent = self.skillCdPercent[skillId]
	assert(percent ~= nil, "percent cd is nil" .. skillId)	
	return percent
end

function GunSkillLayer:startSkillCd(skillId)
	self.skillCdPercent[skillId] = 100
	self.timers[skillId]:setVisible(true)
	local cdTimes = self.config[skillId]["cd"]
	assert(cdTimes ~= nil, "cdTimes is nil" .. skillId)
	local sch = nil	
	local function resumeCd()
		if self.skillCdPercent[skillId] == 0 then 
			transition.removeAction(sch)
			return
		end
		local nextPer = self.skillCdPercent[skillId] - 1	
		self.skillCdPercent[skillId] = nextPer
		self.timers[skillId]:setPercentage(nextPer)
	end
	local offsetTime = cdTimes / 100
	sch = self:schedule(resumeCd, offsetTime)
end

return GunSkillLayer