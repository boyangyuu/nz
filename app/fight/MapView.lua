
--[[--

“战斗地图”的视图
desc： 
	1.生成enemy
	2.加载地图 	
	3.enemy的活动
	4.攻击检测
]]
-- local scheduler = require("framework.scheduler")
local kScaleBg = 2
local FocusView = import(".FocusView")
local Hero = import(".Hero")
local Actor = import(".Actor")
local EnemyView = import(".EnemyView")

local MapView = class("MapView", function()
    return display.newNode()
end)

function MapView:ctor()
	--instance
	self.hero = app:getInstance(Hero)
	self.focusView = app:getInstance(FocusView)
	self.enemys = {}

	--map
	local mapId = ""   -- todo 外界
	self.bgMap = display.newSprite("Fight/maps/map_demo"..mapId..".png") 
	self.bgMap:setScale(kScaleBg)
	self:addChild(self.bgMap)

	-- enemys
	self:createEnemys()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()    	
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.onHeroFire))       
end

--enemy
function MapView:createEnemys()
	local enemyView = EnemyView.new()
	enemyView:setScale(0.5)  --暂时这么写 实际上要bg和enemy的层是分开的
	enemyView:setPosition( display.cx/2, display.cy/3 )
	self.enemys[#self.enemys + 1] = enemyView
	self.bgMap:addChild(enemyView, 1000)
end

function MapView:getSize()
	local size = cc.size(self.bgMap:getBoundingBox().width ,
		self.bgMap:getBoundingBox().height)
	return size
end

--fight
function MapView:tick(dt)
	--检查enemys的状态
	for i,enemy in ipairs(self.enemys) do
		if enemy:getDeadDone() then 
			table.remove(self.enemys, i)
		end
	end
end

function MapView:getDestEnemys()
	local enemys = {}
	for i,enemy in ipairs(self.enemys) do
		local rectEnemy = enemy:getRect("body") 
		local rectFocus = self.focusView:getFocusRect()
		local isHit = cc.rectIntersectsRect(rectEnemy, rectFocus)
		
		dump(rectEnemy, "rectEnemy")
		dump(rectFocus, "rectFocus")
		if isHit then 
			enemys[#enemys + 1] = enemy
		end
	end
	return enemys 
end

--events
function MapView:onHeroFire(event)
	-- dump(event, " MapView onHeroFire event")
	local enemys = self:getDestEnemys()
	for i,enemy in ipairs(enemys) do
		enemy:onHitted(event.demage)
	end
end

return MapView