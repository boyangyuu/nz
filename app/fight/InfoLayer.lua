


local scheduler = require("framework.scheduler")
local Hero 		= import(".Hero")
local Fight 	= import(".Fight")

local InfoLayer = class("InfoLayer", function()
    return display.newLayer()
end)

function InfoLayer:ctor()
	--instance
	self.hero 			= md:getInstance("Hero")
	self.weaponModel 	= md:getInstance("WeaponListModel")
	self.guide 			= md:getInstance("Guide")
	self.fight  		= md:getInstance("Fight")
	self.inlay 			= md:getInstance("FightInlay")

	cc.EventProxy.new(self.hero, self)
		:addEventListener(Hero.GUN_CHANGE_EVENT		, handler(self, self.onRefreshGun))
		:addEventListener(Hero.GUN_BULLET_EVENT 	, handler(self, self.onRefreshBullet))	
		:addEventListener(Hero.HP_INCREASE_EVENT	, handler(self, self.onHeroHpChange))
		:addEventListener(Hero.HP_DECREASE_EVENT	, handler(self, self.onHeroHpChange))
		:addEventListener(Hero.ENEMY_KILL_ENEMY_EVENT, handler(self, self.onKillEnemy))	
	
	cc.EventProxy.new(self.fight, self)
		:addEventListener(self.fight.INFO_HIDE_EVENT, handler(self, self.onHide))
		:addEventListener(self.fight.INFO_SHOW_EVENT, handler(self, self.onShow))

	cc.EventProxy.new(self.inlay, self)
		:addEventListener(self.inlay.INLAY_GOLD_BEGIN_EVENT	, handler(self, self.onActiveGold))
		:addEventListener(self.inlay.INLAY_GOLD_END_EVENT	, handler(self, self.onActiveGoldEnd))

	self:loadCCS()
	self:initUI()
	self:initGuide()
	self:setTouchEnabled(true)
	self:setNodeEventEnabled(true)
	self:setTouchSwallowEnabled(false) 
end

function InfoLayer:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/infoUI.ExportJson")
	self:addChild(self.root)

	-- self.blood = cc.uiloader:load("res/Fight/fightLayer/fightBlood/heroBlood.ExportJson")
	-- self:addChild(self.blood)
	-- local bloodAnimNode = cc.uiloader:seekNodeByName(self.blood, "bloodAnimNode")
	-- self.bloodAnim = ccs.Armature:create("xuetiao")
 -- 	bloodAnimNode:addChild(self.bloodAnim)
 	-- self:rejustBloodAnim()
 	-- self.bloodAnim:getAnimation():setMovementEventCallFunc(
 	-- 	handler(self, self.onBloodMovementEvent)) 
 	-- self.bloodAnim:getAnimation():play("chixu", -1, 1)


 	self.bloodNode  = cc.uiloader:seekNodeByName(self.root, "bloodNode")
 	self.blood2 	= cc.uiloader:seekNodeByName(self.bloodNode, "progressBar1") 
 	self.blood1 	= cc.uiloader:seekNodeByName(self.bloodNode, "progressBar2") 
 	self.bloodLabel = cc.uiloader:seekNodeByName(self.bloodNode, "labelValue") 
	
	if device.platform ~= "windows" then
		self.bloodLabel :enableShadow(cc.c4b(0, 0, 0,255), cc.size(2,-2))
	    self.bloodLabel :enableOutline(cc.c4b(255, 255, 255,255), 2)
	end
    self.goldNode 	= cc.uiloader:seekNodeByName(self.root, "goldNode")
    self.gold1    	= cc.uiloader:seekNodeByName(self.goldNode, "progressBar1") 
    -- self.gold1:setPercent(1)
end

function InfoLayer:initUI()
	self:initGun()
	self:initBullet()
	self:initBtns()
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
            if event.name =='began' then                
                -- cc.ColorUtil:isHighLighted(btnStop, true)
                return true
            elseif event.name =='ended' then
            	-- cc.ColorUtil:isHighLighted(btnStop, false)
            	ui:showPopup("FightPopup")
            end
        end)
end

function InfoLayer:onRefreshGun(event)
	self.gunDisplay:removeAllChildren()
	local record = self.hero:getGun():getConfig()
	local icon = display.newSprite("#icon_"..record["imgName"]..".png")
	icon:setScaleX(0.05)
	icon:setScaleY(0.05)
	icon:scaleTo(0.20, 0.20)
	addChildCenter(icon, self.gunDisplay)
end

function InfoLayer:onRefreshBullet(event)
	local num = event.num
	assert(num, "num is nil") 
	self.labelBulletNum:setString(num)
end

function InfoLayer:onHeroHpChange(event)
	local per = self.hero:getHp() / self.hero:getMaxHp() * 100
	-- print("self.hero:getMaxHp()", self.hero:getMaxHp())
	-- print("self.hero:getHp()", self.hero:getHp())
	-- print("event.name", event.name)

	local displayHp = math.floor(self.hero:getHp() )
	self.bloodLabel:setString(displayHp)
	if event.name == "HP_DECREASE_EVENT" then 
		-- self.blood2:setScaleX(per / 100)
		-- self.blood1:setScaleX(per / 100)
		print("per", per)
	    self.blood2:setPercent(per)
	    self.blood1:setPercentWithDelay(per, 0.3)
	    -- self:rejustBloodAnim()
	else
		-- self.blood1:setScaleX(per / 100)		
		-- self.blood2:setScaleX(per / 100)
	    self.blood1:setPercent(per)
	    self.blood2:setPercentWithDelay(per, 0.3)
	    -- scheduler.performWithDelayGlobal(handler(self, self.rejustBloodAnim), 0.3)
    end		
    -- self.bloodAnim:getAnimation():play("xuetiao_s" , -1, 1)	
end

function InfoLayer:onKillEnemy(event)
	if self.isGolding then return end 

	local per = self.hero:getKillCnt() / self.hero:getCurGoldLimit() * 100
	self.gold1:setPercent(per)
	-- if per == 100 then 
	-- 	self:onHide
	-- 	self.isPlayGolding = true

end

function InfoLayer:onActiveGold(event)
	print("循环播放激活动画")
end

function InfoLayer:onActiveGoldEnd(event)
	print("停止播放动画")
end

function InfoLayer:onShow(event)
	self:setVisible(true)
end

function InfoLayer:onHide(event)
	self:setVisible(false)
end

-- function InfoLayer:rejustBloodAnim()
-- 	local per = self.hero:getHp() / self.hero:getMaxHp()
-- 	local blood2 = cc.uiloader:seekNodeByName(self.blood, "progressBar2")
--     local box  = blood2:getBoundingBox()
-- 	-- dump(box, "box")
--     local posx = per * box.width
--     local posy = box.height / 2
--     self.bloodAnim:setPosition(cc.p(posx, posy))

-- end

-- function InfoLayer:onBloodMovementEvent(armatureBack,movementType,movementID)
-- 	if movementType == ccs.MovementEventType.loopComplete then
-- 		armatureBack:getAnimation():play("chixu", -1, 1)
-- 	end
-- end

function InfoLayer:initGuide()
    local isDone = self.guide:isDone("fight")
    if isDone then return end
	
	local rect = self.blood2:getBoundingBox()
	--blood
    local data1 = {
        id = "fight_blood",
        groupId = "fight",
        rect = rect,
        endfunc = function (touchEvent)
        	
        end
    }
    self.guide:addClickListener(data1)  
end

function InfoLayer:onEnter()

end


return InfoLayer