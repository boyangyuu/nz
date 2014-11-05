
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
	self.waveIndex = 1

	--ccs
	self:loadCCS()

	--enemys
	self:updateEnemys()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.onHeroFire))

end

function MapView:loadCCS()
	--map
	local mapId = ""   -- todo 外界
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")
    local node = cc.uiloader:load("map_1.ExportJson")	
	self.map = node
	addChildCenter(self.map, self)	

	--bg
	self.bg = cc.uiloader:seekNodeByName(self, "bg")

	--init enemy places
	local index = 1
	self.places = {}
    while true do
    	local name = "place" .. index 
    	local placeNode = cc.uiloader:seekNodeByName(self, name)
    	local scaleNode = cc.uiloader:seekNodeByName(placeNode, "scale")
    	if scaleNode then scaleNode:setVisible(false) end
        if placeNode == nil then
            break
        end
        self.places[name] = placeNode
        index = index + 1
    end
end

--enemy
function MapView:updateEnemys(event)
	--timer
    -- if event.countdown > 0 then
    -- 	return
    -- end

	--wave config
	local wave = getWaves(self.waveIndex)
	dump(wave, "wave")
	if wave == nil then return end
	-- if wave.type = "enemy" then .. 
	local lastTime = 0
	for groupId, group in ipairs(wave.enemys) do
		
		for i = 1, group.num do
			--delay
			local delay = group.delay or 0.1
			delay = group.time + delay * i
			if delay > lastTime then lastTime = delay end
			--pos
			local pos = nil
			if group.pos then 
				pos = group.pos + group.offset * i
			end

			--add
			local function addEnemyFunc()
				self:addEnemy(group.place, group.property, pos)
			end
			scheduler.performWithDelayGlobal(addEnemyFunc, delay)
		end
	end
	--check next wave
	scheduler.performWithDelayGlobal(handler(self, self.checkWave), lastTime + 5)
end



function MapView:checkWave()
	local function checkEnemysEmpty()
		if #self.enemys == 0 then 
			print("第"..self.waveIndex.."波怪物消灭完毕")
			self.waveIndex = self.waveIndex + 1
			self:updateEnemys()
			scheduler.unscheduleGlobal(self.checkEnemysEmptyHandler)
		end
	end
	self.checkEnemysEmptyHandler = scheduler.scheduleGlobal(checkEnemysEmpty, 2)
end

function MapView:addEnemy(placeName, property, pos)
	assert(placeName and property, "invalid param")

	--enemy
	local enemyView = EnemyView.new(property)
	self.enemys[#self.enemys + 1] = enemyView

	--scale
	local placeNode = self.places[placeName]
	assert(placeNode, "invalid param")		
	local scale = cc.uiloader:seekNodeByName(placeNode, "scale")
	enemyView:setScaleX(scale:getScaleX())
	enemyView:setScaleY(scale:getScaleY())

	--pos
	local boundEnemy = enemyView:getRange("body1"):getBoundingBox()
	local boundPlace = placeNode:getBoundingBox()
	-- print("enemyView width", boundEnemy.width)
	-- print("boundPlace width", boundPlace.width)
	math.newrandomseed()
	local xPos = pos or math.random(boundEnemy.width/2, boundPlace.width)
	enemyView:setPosition(xPos, 0)
	
	--place
	local pWorld = placeNode:convertToWorldSpace(cc.p(0,0))
	-- dump(boundPlace, "boundPlace")
	boundPlace.x = pWorld.x
	boundPlace.y = boundPlace.y
	-- dump(boundPlace, "boundPlace--------------")
	EnemyView:setPlaceBound(boundPlace)
	placeNode:addChild(enemyView)
end

function MapView:getSize()
	local bg = self.bg
	local size = cc.size(bg:getBoundingBox().width ,
		bg:getBoundingBox().height)
	return size
end

--fight
function MapView:tick(dt)
	--检查enemys的状态
	-- print("MapView:tick ------------- ")
	for i,enemy in ipairs(self.enemys) do
		 -- print("self.enemy:getHp()",enemy.enemy:getHp() == 0 )

		 -- print("enemy.enemy:canDie",enemy.enemy:canDie())
		if enemy and enemy:getDeadDone() then
			table.remove(self.enemys, i)
			enemy:removeFromParent()
		end
	end
end

function MapView:getDestEnemys()
	local enemys = {}
	for i,enemy in ipairs(self.enemys) do
		local rectEnemy = enemy:getRange("body1") 
		-- dump(rectEnemy, "rectEnemy")
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