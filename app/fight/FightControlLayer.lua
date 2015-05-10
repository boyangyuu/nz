
local FightControlLayer = class("FightControlLayer", function()
    return display.newLayer()
end)

function FightControlLayer:ctor()
	--instance
	self.hero 			= md:getInstance("Hero")
    local fightFactory  = md:getInstance("FightFactory")
    self.fight 			= fightFactory:getFight()
    self.fightProp 		= md:getInstance("FightProp")
	--instance
	self.timerHp = nil
	self.hpCdPercent = 0

	self:loadCCS()
	self:initUI()
	self:refreshData()
	
	--events
	cc.EventProxy.new(self.fightProp, self)
			:addEventListener(self.fightProp.PROP_UPDATE_EVENT,
			 handler(self, self.refreshData))
		
	self:setTouchEnabled(true)
	self:setNodeEventEnabled(true)
	self:setTouchSwallowEnabled(false) 
end

function FightControlLayer:loadCCS()
	self.root = cc.uiloader:load("res/Fight/fightLayer/ui/buttonUI.ExportJson")
	self:addChild(self.root)	
end

function FightControlLayer:initUI()
	--btn hp
	local buttonHp = cc.uiloader:seekNodeByName(self.root, "buttonHp")
    buttonHp:onButtonClicked(function()
         self:onClickBtnHp()
    end)	

    --timer hp
    self.timerHp = display.newProgressTimer("#btn_dun03.png", display.PROGRESS_TIMER_RADIAL)
	buttonHp:addChild(self.timerHp)
    self.timerHp:setAnchorPoint(0.0,0.0)
    self.timerHp:setReverseDirection(true)
    self.timerHp:setPercentage(100)
    self.timerHp:setVisible(false)   

    --label hp
    self.labelHp = 	cc.uiloader:seekNodeByName(self.root, "labelHp")
end

function FightControlLayer:refreshData(event)
	--hp
	local numHp = self.fightProp:getHpBagNum()
	self.labelHp:setString(numHp)
end


function FightControlLayer:onClickBtnHp(event)
	--cd
	if self.hpCdPercent ~= 0 then return end
	local num = self.fightProp:getHpBagNum()
	if num < 1 then return end

	self.fightProp:costHpBag(1)
	self:startHpCd()
end

function FightControlLayer:getHpCdPercent()
	return self.hpCdPercent
end

function FightControlLayer:startHpCd()
	self.hpCdPercent = 100
	self.timerHp:setVisible(true)
	local cdTimes = define.kHeroHpBagCd
	local sch = nil
	local function resumeCd()
		if self.hpCdPercent == 0 then 
			transition.removeAction(sch)
			return
		end
		self.hpCdPercent = self.hpCdPercent - 1	
		self.timerHp:setPercentage(self.hpCdPercent)
	end
	local offsetTime = cdTimes / 100
	sch = self:schedule(resumeCd, offsetTime)
end

return FightControlLayer