
local Hero 				 = import(".Hero")
local ModeViewFactory    = import(".fightMode.ModeViewFactory")
local JujiFight          = import(".fightTypes.JujiFight")

local StoreLayer   = import("..store.StoreLayer")

local InfoLayer = class("InfoLayer", function()
    return display.newLayer()
end)

function InfoLayer:ctor()
	--instance
	self.hero 			= md:getInstance("Hero")
	self.weaponModel 	= md:getInstance("WeaponListModel")
	self.guide 			= md:getInstance("Guide")
    local fightFactory  = md:getInstance("FightFactory")
    self.fight 			= fightFactory:getFight()
	self.inlay 			= md:getInstance("FightInlay")
	-- self.fightTippedIds = {}

	cc.EventProxy.new(self.hero, self)
		:addEventListener(Hero.GUN_CHANGE_EVENT		, handler(self, self.onRefreshGun))
		:addEventListener(Hero.GUN_BULLET_EVENT 	, handler(self, self.onRefreshBullet))
		:addEventListener(Hero.HP_INCREASE_EVENT	, handler(self, self.onHeroHpChange))
		:addEventListener(Hero.HP_DECREASE_EVENT	, handler(self, self.onHeroHpChange))
		:addEventListener(Hero.EFFECT_FIGHTTIPS_EVENT, handler(self, self.playAnimFightTips))
		-- :addEventListener(Hero.TIPS_CLICK_EVENT		, handler(self, self.playAnimFightTipsClick))

	cc.EventProxy.new(self.fight, self)
		:addEventListener(self.fight.INFO_HIDE_EVENT, handler(self, self.onHide))
		:addEventListener(self.fight.INFO_SHOW_EVENT, handler(self, self.onShow))
		:addEventListener(JujiFight.JUJIFIGHT_SCORE_EVENT, handler(self, self.onJujiScoreUpdate))

	self:loadCCS()
	self:initUI()
	self:setTouchEnabled(true)
	self:setNodeEventEnabled(true)
	self:setTouchSwallowEnabled(false)
end

function InfoLayer:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/infoUI.ExportJson")
	self:addChild(self.root)

	--modeView
	local fightModeView = ModeViewFactory.getModeView()
	self:addChild(fightModeView)

	--blood
 	self.bloodNode  = cc.uiloader:seekNodeByName(self.root, "bloodNode")
 	self.blood2 	= cc.uiloader:seekNodeByName(self.bloodNode, "progressBar1")
 	self.blood1 	= cc.uiloader:seekNodeByName(self.bloodNode, "progressBar2")
 	self.bloodLabel = cc.uiloader:seekNodeByName(self.bloodNode, "labelValue")

	--gold
	if device.platform ~= "windows" then
		self.bloodLabel :enableShadow(cc.c4b(0, 0, 0,255), cc.size(2,-2))
	    self.bloodLabel :enableOutline(cc.c4b(255, 255, 255,255), 2)
	end
    self.goldNode 	= cc.uiloader:seekNodeByName(self.root, "goldNode")
    self.goldProgress = cc.uiloader:seekNodeByName(self.goldNode, "progressBar1")
    self.goldAnim 	= cc.uiloader:seekNodeByName(self.goldNode, "animNode")
    self.goldProgress:setPercent(1)
	self.goldAnim:setVisible(false)
	self.goldProgress:setVisible(false)
end

function InfoLayer:initUI()
	self:initGun()
	self:initBullet()
	self:initBtns()
	self:initBlood()
end

function InfoLayer:initBlood()
	local maxHp = math.floor(self.hero:getMaxHp())
	self.bloodLabel:setString(maxHp)

	--
	local per = self.hero:getHp() / self.hero:getMaxHp() * 100
	print("per", per)
	local displayHp = math.floor(self.hero:getHp() )
	self.bloodLabel:setString(displayHp)
    self.blood2:setPercent(per)
    self.blood1:setPercent(per)
end

function InfoLayer:initGun()
	self.gunDisplay		= cc.uiloader:seekNodeByName(self.root, "gunDisplay")
	self:onRefreshGun({bagIndex = "bag1"})
end

function InfoLayer:initBullet()
	self.labelBulletNum = cc.uiloader:seekNodeByName(self.root, "labelBulletNum")
	if device.platform ~= "windows" then
		self.labelBulletNum :enableShadow(cc.c4b(0, 0, 0,255), cc.size(2,-2))
	    self.labelBulletNum :enableOutline(cc.c4b(255, 255, 255,255), 2)
	end
	local gun = self.hero:getGun()
	self.labelBulletNum:setAnchorPoint(cc.p(0.5, 0.5))
	self:onRefreshBullet({num = gun:getBulletNum()})
end

function InfoLayer:initBtns()
	local btnStop = cc.uiloader:seekNodeByName(self.root, "btnStop")
	btnStop:setTouchEnabled(true)
	btnStop:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	        local guide = md:getInstance("Guide")
	        local isUntouch = guide:getCurGroupId() == "fight01"
	        if isUntouch then return end
            if event.name =='began' then
                return true
            elseif event.name =='ended' then
            	local pauseModel = md:getInstance("PauseModel")
			    pauseModel:showPopup("FightPausePopup",{},{anim = true})
            end
        end)

	--guide
	local fightFactory = md:getInstance("FightFactory")
    local fight = fightFactory:getFight()
	local gid, lid = fight:getCurGroupAndLevel()
	if gid == 0 and lid == 0 then
		btnStop:setVisible(false)
	end

	--shop
	local btnShop = cc.uiloader:seekNodeByName(self.root, "btnShop")
	btnShop:setTouchEnabled(true)
	btnShop:onButtonClicked(function()
         ui:showPopup("StorePopup",{},{animName = "scale"})
    end)
end

function InfoLayer:onRefreshGun(event)
	self.gunDisplay:removeAllChildren()
	local record = self.hero:getGun():getConfig()
	local icon = display.newSprite("#icon_"..record["imgName"]..".png")
	icon:setScaleX(0.05)
	icon:setScaleY(0.05)
	icon:scaleTo(0.20, 0.35)
	addChildCenter(icon, self.gunDisplay)
end

function InfoLayer:onRefreshBullet(event)
	local num = event.num
	assert(num, "num is nil")
	self.labelBulletNum:setString(num)
end

function InfoLayer:onHeroHpChange(event)
	local per = self.hero:getHp() / self.hero:getMaxHp() * 100
	local displayHp = math.floor(self.hero:getHp() )
	self.bloodLabel:setString(displayHp)
	if event.name == self.hero.HP_DECREASE_EVENT then
	    self.blood2:setPercent(per)
	    self.blood1:setPercentWithDelay(per, 0.3)
	else
	    self.blood1:setPercent(per)
	    self.blood2:setPercentWithDelay(per, 0.3)
    end
end

function InfoLayer:onShow(event)
	self:setVisible(true)
end

function InfoLayer:onHide(event)
	self:setVisible(false)
end

function InfoLayer:onJujiScoreUpdate(event)
	local layer = cc.uiloader:seekNodeByName(self.root, "layer_jujiFight")
	local label = cc.uiloader:seekNodeByName(self.root, "label")
	layer:setVisible(true)
	local score = event.score
	local isDirect = event.isDirect
	isDirect = true
	if isDirect then
		label:setString(score)
		return
	end
end

function InfoLayer:playAnimFightTips(event)
	print("function HeroAnimView:playAnimFightTips(event)")
	if self.fightTips then return end
	local strTips = event.strTips
	self.fightTips = cc.uiloader:load("res/fight/fightLayer/fightTips/fightTips.ExportJson")
    local labelTips = cc.uiloader:seekNodeByName(self.fightTips, "labelTips")
    labelTips:setString(strTips)
    labelTips :enableOutline(cc.c4b(255, 255, 255,255), 2)
    self:addChild(self.fightTips, 1000)
    local seq = transition.sequence({
    	cc.MoveBy:create(0.5, cc.p(0,-10)),
    	cc.MoveBy:create(0.5, cc.p(0,10)),})
    self.fightTips:runAction(cc.RepeatForever:create(seq))
    local removeFunc = function ()
		self.fightTips:removeSelf()
		self.fightTips = nil
    end
    self:performWithDelay(removeFunc, 3.0)
end

-- function InfoLayer:playAnimFightTipsClick(event)
-- 	print("function infolayer:playAnimFightTipsClick(event)")
-- 	local id = event.id
-- 	if self.fightTippedIds[id] == "isTiped" then return end
-- 	self.fightTippedIds[id] = "isTiped"
-- 	local tips = {
-- 		gold  = {pos = cc.p(10, 10)},
-- 		jijia = {pos = cc.p(110, 110)},
-- 		hpBag = {pos = cc.p(110, 110)},
-- 	}
-- 	local tipCfg = tips[id]
-- 	assert(tipCfg, "tipCfg is nil" .. id)

-- 	--res
--     local manager = ccs.ArmatureDataManager:getInstance()
--     manager:addArmatureFileInfo("res/xinshou/yd_dianji/yd_dianji.ExportJson")
--     display.addSpriteFrames("res/xinshou/yd_dianji/yd_dianji0.plist",
--         "res/xinshou/yd_dianji/yd_dianji0.png")
-- 	local armature = ccs.Armature:create("yd_dianji")
-- 	armature:getAnimation():play("yd_dianji" , -1, 1)
-- 	armature:setPosition(tipCfg.pos.x, tipCfg.pos.y)
-- 	self:addChild(armature)

--     local removeFunc = function ()
-- 		armature:removeSelf()
-- 		armature = nil
--     end
--     self:performWithDelay(removeFunc, 3.0)
-- end

function InfoLayer:onEnter()

end


return InfoLayer