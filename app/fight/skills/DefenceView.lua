
--[[--

“枪”的视图

]]
local scheduler  = require(cc.PACKAGE_NAME .. ".scheduler")
local Defence   = import(".Defence") 
--events


local DefenceView = class("DefenceView", function()
    return display.newNode()
end)

function DefenceView:ctor()
	--instance
	-- dump(properties, "DefenceView properties")
	self.hero 	 = md:getInstance("Hero")
	self.defence = md:getInstance("Defence")
	--event
	cc.EventProxy.new(self.defence, self)
		:addEventListener(Defence.DEFENCE_SWITCH_EVENT	, handler(self, self.onSwitchDefence))
		:addEventListener(Defence.DEFENCE_RESUME_EVENT	, handler(self, self.onResumeDefence))
		:addEventListener(Defence.DEFENCE_BEHURTED_EVENT, handler(self, self.defenceBehurtEffect))
		:addEventListener(Defence.DEFENCE_CRACK_EVENT	, handler(self, self.addCrack))
		:addEventListener(Defence.DEFENCE_BROKEN_EVENT	, handler(self, self.onDefenceBroken))
 	
	self:loadCCS()
 	self:initData()
 	self:initUI()
end

function DefenceView:loadCCS()
	self.ui = cc.uiloader:load("res/Fight/fightLayer/fightDun/fightDun.ExportJson")
	self:addChild(self.ui)
	self.crackRange = cc.uiloader:seekNodeByName(self.ui, "crackRange")
end

function DefenceView:initData()
	self.crackSprites = {}
end

function DefenceView:initUI()
	self:setPositionY(-display.height1)	
end

--盾牌恢复完成的回调
function DefenceView:onResumeDefence(event)
	
end
-- 

function DefenceView:onSwitchDefence(event)
	local isDefend = event.isDefend
	if isDefend then
		self:showDefence()
	else
		self:hideDefence()
	end
end

function DefenceView:hideDefence()
	self:runAction( 
		cc.Sequence:create( 
			cc.MoveTo:create(0.5, cc.p(0, -display.height1)), 
			cc.CallFunc:create(
				function ()
					self:setVisible(false)
					self.defence:setIsDefending(false)
					self:setPositionY(-display.height1)
				end
			)
		)
	)	
end

function DefenceView:showDefence()
	self:setVisible(true)
	self:runAction(cc.MoveTo:create(0.5, cc.p(0,0)))
end

--盾牌受伤效果
function DefenceView:defenceBehurtEffect(event)
	--defence behurted action effect
	local tMove = cc.MoveBy:create(0.05, cc.p(-18, -20))
	self.ui:runAction(cc.Sequence:create(tMove, tMove:reverse(),
		 tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))
end


function DefenceView:addCrack(event)
	--defence behurted crack effect
	for i=1,event.num do
		local crackSprite = display.newSprite("#hit_boli.png")
		local crackSize = crackSprite:getBoundingBox()
		local bgSize = self.crackRange:getContentSize()
		crackSprite:setPosition(
			math.random(crackSize.width / 2,
			 bgSize.width - crackSize.width / 2), 
			math.random(crackSize.height / 2,
			 bgSize.height - crackSize.height / 2))
		self.crackRange:addChild(crackSprite)
		self.crackSprites[#self.crackSprites + 1] = crackSprite	
	end
end

function DefenceView:onDefenceBroken(event)
	--clear
	for k, v in pairs(self.crackSprites) do
		v:removeFromParent()
	end
	self.crackSprites = {}

	--hide action
	self:hideDefence()
end

return DefenceView