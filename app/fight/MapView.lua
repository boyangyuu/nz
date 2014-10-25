
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
local EnemyView = import(".EnemyView")

local MapView = class("MapView", function()
    return display.newNode()
end)

function MapView:ctor()
	--model
	self.hero = app:getInstance(Hero)

	--map
	local mapId = ""   -- todo 外界
	self.bgMap = display.newSprite("Fight/maps/map_demo"..mapId..".png") 
	self:addChild(self.bgMap)

	--focus
	self.focusView = app:getInstance(FocusView)

	-- enemys
	self:createEnemys()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()    	
end

--enemy
function MapView:createEnemys()
	local enemyView = EnemyView.new()
	enemyView:setPosition( display.cx/2, display.cy/3 )
	self.bgMap:addChild(enemyView)
end

function MapView:getSize()
	local size = cc.size(self.bgMap:getBoundingBox().width * kScaleBg ,
		self.bgMap:getBoundingBox().height * kScaleBg)
	return size
end

--fight
function MapView:tick(dt)
	--更新大小

end

--check attack enemys 
function MapView:checkFire()
	for i=1,10 do
		print(i)
	end
end


return MapView