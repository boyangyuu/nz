local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local FightGun = class("FightGun", cc.mvc.ModelBase)

FightGun.HELP_START_EVENT = "HELP_START_EVENT"
FightGun.HELP_END_EVENT   = "HELP_END_EVENT"
FightGun.GUN_SKILL_EVENT  = "GUN_SKILL_EVENT"

function FightGun:ctor(properties)
	FightGun.super.ctor(self, properties)
	self.isCooldown = true
end

--枪械简介
function FightGun:showGunIntro(gunData) -- showEnemyIntro
	assert(gunData, "gunData is nil")
	local function callfuncDialogEnd()
		self:dispatchEvent({name = FightGun.HELP_START_EVENT,
			gunId = gunData.id})
	end

	local function callfuncStart()
		local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
		fight:pauseFight(true)
	    local dialog = md:getInstance("DialogModel")
	    dialog:check("award",  callfuncDialogEnd)   
	end

	scheduler.performWithDelayGlobal(callfuncStart, gunData.delay)
end

function FightGun:changeHelpGun(id)
	local hero = md:getInstance("Hero")
	hero:changeTempGun(id)
end

function FightGun:playSkill(animName)
	self:dispatchEvent({name = FightGun.GUN_SKILL_EVENT, animName = animName})
end

return FightGun