
local GunSkillLayer = class("GunSkillLayer", function()
	return display.newLayer()
end)

function GunSkillLayer:ctor()
	--instance
	self.hero     = md:getInstance("Hero")
	self.fightGun = md:getInstance("FightGun")
    local fightFactory = md:getInstance("FightFactory")
    self.fight      = fightFactory:getFight()

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
	-- self.skillCdPercent = {}
	self:stopAllActions()

	--config
	self.gun   = self.hero:getGun()
	local name  = self.gun:getGunName()
	self.config = self.gun:getSkillConfig()
	if self.config == nil then return end

	--ui
	self.ui = cc.uiloader:load("res/Fight/fightLayer/gunSkill/"
		.. name .. ".ExportJson")
	assert(self.ui, "no GunSkillLayer ui: " .. name)
	self:addChild(self.ui)

	--btns timers
	for skillId,skillConfig in pairs(self.config) do
		print("skillId",skillId)
		local btn = cc.uiloader:seekNodeByName(self.ui, "btn_" .. skillId)
		assert(btn, "btn")
        btn:onButtonClicked(function()
	         self:onClickBtnSkill(skillId)
	    end)

        --timer
	    local bar = display.newProgressTimer("#btn_cd1.png", display.PROGRESS_TIMER_RADIAL)
		btn:addChild(bar)
		bar:setPosition(-3, 10)
	    bar:setAnchorPoint(0.5, 0.5)
	    bar:setReverseDirection(true)
	    self.timers[skillId] = bar
	end

	self:schRefresh()

	--guide

	self:initGuide()
	self:checkGuide()
end

function GunSkillLayer:schRefresh()
	self:schedule(handler(self, self.refreshTimers), 0.1)
end

function GunSkillLayer:refreshTimers()
	for skillId,timerBar in pairs(self.timers) do
		local cdRemain = self.gun:getSkillCdRemain()
		-- print("cdRemain", cdRemain)
		local isHide   = cdRemain == 0
		local cd       = self.gun:getSkillCd("skill1")
		local per      = cdRemain / cd * 100
		timerBar:setPercentage(per)
		timerBar:setVisible(not isHide)
	end
end

function GunSkillLayer:onClickBtnSkill(skillId)
	--check cooldown
	if self.gun:getSkillCdRemain() ~= 0 then
		return
	end
	self.gun:startSkillCd(skillId)

	--config
	local skillConfig = self.config[skillId]
	assert(skillConfig, "nil:" .. skillId)
	-- dump(skillConfig, "skillConfig")

	--play skill
	self.fightGun:playSkill(skillConfig["animName"])

	--play buff
	skillConfig.buffFunc()
end


function GunSkillLayer:checkGuide()
	local gun   = self.hero:getGun()
	local name  = gun:getGunName()
    --guide
    local function guide()
        print("function GunSkillLayer:checkGuide()")
        local guide = md:getInstance("Guide")
        guide:check("fight01_skill")
    end

	if name == "huoqilin" then
        self:performWithDelay(guide, 2.0)
    end
end

function GunSkillLayer:initGuide()
    local gid, lid= self.fight:getGroupId(), self.fight:getLevelId()
    local isWillGuide = lid == 0 and gid == 0
    if isWillGuide == false then return end

    --skill
    local skillId = "skill1"
    self.guide      = md:getInstance("Guide")
    local btn = cc.uiloader:seekNodeByName(self.ui, "btn_" .. skillId)
    self.guide:addClickListener( {
        id = "fight_skill",
        groupId = "fight01_skill",
        rect = cc.rect(565,25, 100, 100),
        endfunc = function (touchEvent)
        	self:onClickBtnSkill(skillId)
        end
    })
end


return GunSkillLayer