
--[[--

“战斗地图”的视图
desc： 
	1.地图管理者
	2.敌人管理者
]]

import("..includes.functionUtils")
import(".Fight_001")

_testMode = getIsTest()
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Timer = require("framework.cc.utils.Timer")
local FocusView = import(".FocusView")
local Hero = import(".Hero")
local Actor = import(".Actor")
local EnemyView = import(".enemys.EnemyView")
local BossView = import(".enemys.BossView")
local MissileEnemyView = import(".enemys.MissileEnemyView")
local EnemyManager = import(".EnemyManager")

local MapView = class("MapView", function()
    return display.newNode()
end)

function MapView:ctor()
	--instance
	self.hero = app:getInstance(Hero)
	self.focusView = app:getInstance(FocusView)
	self.enemys = {}
	self.waveIndex = 1
	self.enemyManager = app:getInstance(EnemyManager)

	--ccs
	self:loadCCS()

	--enemys
	self:updateEnemys()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Actor.FIRE_EVENT, handler(self, self.onHeroFire))
        :addEventListener("ENEMY_ADD", handler(self, self.callfuncAddEnemys))
        :addEventListener(Actor.FIRE_THROW_EVENT, handler(self, self.onHeroThrowFire))

end

function MapView:getEnemyDatas()
	return self.enemyManager:getEnemyDatas()
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
	if wave == nil then 
		print("赢了")
	end
	-- if wave.type = "enemy" then .. 
	-- if wave.type = "boss" then .. 
	local lastTime = 0
	for groupId, group in ipairs(wave.enemys) do
		
		for i = 1, group.num do
			--delay
			local delay = group.delay or 0.1
			delay = group.time + delay * i
			if delay > lastTime then lastTime = delay end
			
			--pos
			assert(group["pos"], "group pos")
			local pos = group["pos"][i] or 0

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
	self.checkEnemysEmptyHandler = scheduler.scheduleGlobal(checkEnemysEmpty, 0.1)
end

function MapView:callfuncAddEnemys(event)
	for i,enemyData in ipairs(event.enemys) do
		local function addEnemyFunc()
			self:addEnemy(enemyData.placeName, 
				enemyData.property, enemyData.pos.x) --todo
		end		
		
		scheduler.performWithDelayGlobal(addEnemyFunc, 
			enemyData.delayOffset * (i - 1) )
	end
end

function MapView:addEnemy(placeName, property, pos)
	assert(placeName and property, "invalid param")

	--place
	local placeNode = self.places[placeName]
	assert(placeNode, "invalid param")		
	local boundPlace = placeNode:getBoundingBox()
	local pWorld = placeNode:convertToWorldSpace(cc.p(0,0))
	boundPlace.x = pWorld.x
	boundPlace.y = boundPlace.y	
	property.boundPlace = boundPlace

	--enemy 改为工厂
	local enemyView
	print("create enemy", property.type)
	if property.type == "boss" then 
		enemyView = BossView.new(property)
	elseif property.type == "missile" then
		enemyView = MissileEnemyView.new(property)
	else
		enemyView = EnemyView.new(property)
	end
	self.enemys[#self.enemys + 1] = enemyView

	--scale
	local scale = cc.uiloader:seekNodeByName(placeNode, "scale")
	enemyView:setScaleX(scale:getScaleX())
	enemyView:setScaleY(scale:getScaleY())

	--pos
	local boundEnemy = enemyView:getRange("body1"):getBoundingBox()
	math.newrandomseed()
	local xPos = pos or math.random(boundEnemy.width/2, boundPlace.width)
	enemyView:setPosition(xPos, 0)
	
	--place
	placeNode:addChild(enemyView)
end

function MapView:addDaoDan()
	-- body
end



function MapView:getSize()
	local bg = self.bg
	local size = cc.size(bg:getBoundingBox().width ,
		bg:getBoundingBox().height)
	return size
end

--fight
function MapView:tick(dt)
	--检查enemy和boss的状态
	for i,enemy in ipairs(self.enemys) do
		if enemy and enemy:getDeadDone() then
			local pos = cc.p(enemy:getPositionX(), enemy:getPositionY())
			-- self:killEnmeyGold(pos)
			table.remove(self.enemys, i)
			enemy:removeFromParent()

			self.hero:dispatchEvent({name = Hero.ENEMY_KILL_EVENT, enemyPos = pos})
		end
	end
end

--[[
	TargetDatas = {
		{
			demageType = "head", --"head", "body"
			demageScale = 2.0,
			enemy = xx,
		},

	}
]]
function MapView:getTargetDatas()
	local targetDatas = {}
	for i,enemy in ipairs(self.enemys) do
		local rectFocus = self.focusView:getFocusRange()
		local isHited, targetData = enemy:getTargetData(rectFocus)
		if isHited then targetDatas[#targetDatas + 1] = targetData end
	end
	return targetDatas 
end

--events
function MapView:onHeroFire(event)
	-- dump(event, " MapView onHeroFire event")
	local datas = self:getTargetDatas()
	for i,data in ipairs(datas) do
		local demageScale = data.demageScale or 1.0
		data.enemy:onHitted(event.demage * demageScale)
	end

end

function MapView:onHeroThrowFire(event)
	--target

end

function MapView:onHeroPlaneFire(event)
	
end

return MapView