


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

	cc.EventProxy.new(self.hero, self)
		:addEventListener(Hero.GUN_CHANGE_EVENT		, handler(self, self.onRefreshGun))
		:addEventListener(Hero.GUN_BULLET_EVENT 	, handler(self, self.onRefreshBullet))	
		:addEventListener(Hero.HP_INCREASE_EVENT	, handler(self, self.onHeroHpChange))
		:addEventListener(Hero.HP_DECREASE_EVENT	, handler(self, self.onHeroHpChange))
	cc.EventProxy.new(self.fight, self)
		:addEventListener(self.fight.INFO_HIDE_EVENT, handler(self, self.onHide))
		:addEventListener(self.fight.INFO_SHOW_EVENT, handler(self, self.onShow))
		
	self:loadCCS()
	self:initUI()
	self:initGuide()
	self:setTouchEnabled(true)
	self:setNodeEventEnabled(true)
	self:setTouchSwallowEnabled(false) 
	scheduler.performWithDelayGlobal(handler(self, self.initGuide), 0.01)
end

function InfoLayer:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/infoUI.ExportJson")
	self:addChild(self.root)

	self.blood = cc.uiloader:load("res/Fight/fightLayer/fightBlood/heroBlood.ExportJson")
	self:addChild(self.blood)
	local bloodAnimNode = cc.uiloader:seekNodeByName(self.blood, "bloodAnimNode")
	self.bloodAnim = ccs.Armature:create("xuetiao")
 	bloodAnimNode:addChild(self.bloodAnim)
 	self:rejustBloodAnim()
 	self.bloodAnim:getAnimation():setMovementEventCallFunc(
 		handler(self, self.onBloodMovementEvent)) 
 	self.bloodAnim:getAnimation():play("chixu", -1, 1)
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
	local gun = self.hero:getGun()
	self.labelBulletNum:setAnchorPoint(cc.p(0.5, 0.5))
	self:onRefreshBullet({num = gun:getBulletNum()})
end

function InfoLayer:initBtns()
	local btnStop = cc.uiloader:seekNodeByName(self.root, "btnStop")
	btnStop:setTouchEnabled(true)
	btnStop:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name =='began' then                
                cc.ColorUtil:isHighLighted(btnStop, true)
                return true
            elseif event.name =='ended' then
            	cc.ColorUtil:isHighLighted(btnStop, false)
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
	-- print("per", per)
	-- print("event.name", event.name)
	local blood1 = cc.uiloader:seekNodeByName(self.blood, "progressBar1") 
	local blood2 = cc.uiloader:seekNodeByName(self.blood, "progressBar2")
	if event.name == "HP_DECREASE_EVENT" then 
	    blood2:setPercent(per)
	    blood1:setPercentWithDelay(per, 0.3)
	    self:rejustBloodAnim()
	else
	    blood1:setPercent(per)
	    blood2:setPercentWithDelay(per, 0.3)
	    scheduler.performWithDelayGlobal(handler(self, self.rejustBloodAnim), 0.3)
    end		
    self.bloodAnim:getAnimation():play("xuetiao_s" , -1, 1)	
end

function InfoLayer:onShow(event)
	self:setVisible(true)
end

function InfoLayer:onHide(event)
	self:setVisible(false)
end

function InfoLayer:rejustBloodAnim()
	local per = self.hero:getHp() / self.hero:getMaxHp()
	local blood2 = cc.uiloader:seekNodeByName(self.blood, "progressBar2")
    local box  = blood2:getBoundingBox()
	-- dump(box, "box")
    local posx = per * box.width
    local posy = box.height / 2
    self.bloodAnim:setPosition(cc.p(posx, posy))

end

function InfoLayer:onBloodMovementEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:getAnimation():play("chixu", -1, 1)
	end
end

function InfoLayer:initGuide()
    local isDone = self.guide:check("fight")
    if isDone then return end
	
	local rect = self.blood:getBoundingBox()
	rect.height = rect.height * 3
	rect.y = rect.y - rect.height * 0.5
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
	scheduler.performWithDelayGlobal(function()
		self.guide:startGuide("fight")
	end, 0.2)
end


return InfoLayer