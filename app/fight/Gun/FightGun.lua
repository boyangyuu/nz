
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
		ui:showPopup("GunHelpPopup",
						 {gunId = gunData.id},
						 {animName = "normal",  opacity = 0})
	end

	local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
	fight:pauseFight(true)
    local dialog = md:getInstance("DialogModel")
    dialog:check("award",  callfuncDialogEnd)   
end

function FightGun:changeHelpGun(id)
	local hero = md:getInstance("Hero")
	hero:changeTempGun(id)
end

function FightGun:buyGun(id)
	local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()	
	local isJuji = fight:isJujiFight()
	local hero = md:getInstance("Hero")
	local preferBag = hero:getPreferBagIndex()
	local bagIndex = isJuji and 3 or preferBag

	--buy
	 local weaponListModel = md:getInstance("WeaponListModel")
	 weaponListModel:buyWeapon(id)
	
	--equip in bag
    weaponListModel:equipBag(id, bagIndex)	

    --gold weapon
	local inlayModel = md:getInstance("InlayModel")
	inlayModel:equipGoldInlays()
	local fightInlay = md:getInstance("FightInlay")
	fightInlay:checkNativeGold()

    --refresh hero
    hero:initGuns()
    hero:refreshGun()
end

function FightGun:playSkill(animName)
	self:dispatchEvent({name = FightGun.GUN_SKILL_EVENT, animName = animName})
end

return FightGun