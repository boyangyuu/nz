
--[[--

“战斗地图”的视图
desc： 
	1.生成enemy
	2.加载地图 	
	3.enemy的活动
	4.攻击检测
]]

import("..includes.functionUtils")
import(".Fight_001")

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Timer = require("framework.cc.utils.Timer")
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
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")
    local node = cc.uiloader:load("map_1.ExportJson")	
	self.map = node
	addChildCenter(self.map, self)
	
	-- enemys
	-- local appTimer = Timer.new()
	-- appTimer:addEventListener("REFRESH_WAVES", handler(self, self.createEnemys))
	-- appTimer:addCountdown("REFRESH_WAVES", 40)
	self:updateEnemys()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.onHeroFire))

end

--enemy
function MapView:updateEnemys(event)
	--timer
    -- if event.countdown > 0 then
    -- 	return
    -- end

	--config
	local waves = getWaves()
	dump(waves, "waves")
	for i, wave in ipairs(waves) do
		for groupId, group in ipairs(wave.enemys) do
			function addEnemysFunc()
				self:addEnemys(group.id, group.num, group.place)
			end
			scheduler.performWithDelayGlobal(addEnemysFunc ,group.time)
		end
	end
end

function MapView:addEnemys(id , num, place)
	assert(id and num and place, "invalid param")
	local enemyView = EnemyView.new()
	self.enemys[#self.enemys + 1] = enemyView
	local placeNode = cc.uiloader:seekNodeByName(self, place)

	local boundEnemy = enemyView:getRange("body"):getBoundingBox()
	print("enemyView width", boundEnemy.width)

	local boundPlace = placeNode:getBoundingBox()
	print("boundPlace width", boundPlace.width)
	math.newrandomseed()
	local xPos = math.random(boundEnemy.width, boundPlace.width)
	enemyView:setPosition(xPos, 0)
	placeNode:addChild(enemyView)
end

function MapView:getSize()
	local bg = cc.uiloader:seekNodeByName(self, "bg")
	local size = cc.size(bg:getBoundingBox().width ,
		bg:getBoundingBox().height)
	return size
end

--fight
function MapView:tick(dt)
	--检查enemys的状态
	for i,enemy in ipairs(self.enemys) do
		if enemy and enemy:getDeadDone() then
			table.remove(self.enemys, i)
			enemy:removeFromParent()
		end
	end
end

function MapView:getDestEnemys()
	local enemys = {}
	for i,enemy in ipairs(self.enemys) do
		local rectEnemy = enemy:getRange("body") 
		local rectFocus = self.focusView:getFocusRange()
		local isInRange = rectIntersectsRect(rectEnemy, rectFocus)
		if isInRange and enemy:canChangeState("hit") then 
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