
--[[--

“战斗地图”的视图
desc： 
	1.地图管理者
	2.敌人管理者
]]

import("..includes.functionUtils")
local FightConfigs = import(".fightConfigs.FightConfigs")
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Timer = require("framework.cc.utils.Timer")
local FocusView = import(".FocusView")
local Hero = import(".Hero")
local Actor = import(".Actor")
local EnemyFactroy = import(".EnemyFactroy")

--常量
local groupId = 1
local levelId = 5

local MapView = class("MapView", function()
    return display.newNode()
end)

function MapView:ctor()
	--instance
	self.hero = app:getInstance(Hero)
	self.focusView = app:getInstance(FocusView)
	self.enemys = {}
	self.waveIndex = 1
	self.killEnemyCount = 0
	self.isPause = false
	self.fightConfigs = app:getInstance(FightConfigs)
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
        :addEventListener(Hero.SKILL_GRENADE_ARRIVE_EVENT, handler(self, self.onHeroThrowFire))
        :addEventListener(Actor.STOP_EVENT, handler(self, self.setAllEntityActive))

end


function MapView:setAllEntityActive( event )
	local actionManager = cc.Director:getInstance():getActionManager()
	self.isPause = not self.isPause
	for i,enemy in ipairs(self.enemys) do
		if enemy and not enemy:getDeadDone() then
			if true == self.isPause then
				enemy.armature:getAnimation():pause()
				enemy:pause()
				actionManager:pauseTarget(enemy)
			end
			if false == self.isPause then
				-- print("enemy resume")
				actionManager:resumeTarget(enemy)
				enemy.armature:getAnimation():resume()
				enemy:resume()

			end
		end
	end
end

function MapView:loadCCS()
	--map
	local groupId = self.hero:getGroupId()
	local levelId = self.hero:getLevelId()

	local mapSrcName = "map_"..groupId.."_"..levelId..".ExportJson"   -- todo 外界
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")

    local node = cc.uiloader:load(mapSrcName)
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

function MapView:checkWave()
	local function checkEnemysEmpty()
		if #self.enemys == 0 then 
			-- print("第"..self.waveIndex.."波怪物消灭完毕")
			self.waveIndex = self.waveIndex + 1
			self:updateEnemys()
			scheduler.unscheduleGlobal(self.checkEnemysEmptyHandler)
		end
	end
	self.checkEnemysEmptyHandler = scheduler.scheduleGlobal(checkEnemysEmpty, 0.1)
end

--enemy
function MapView:updateEnemys(event)
	--wave config
	local waveConfig = self.fightConfigs:getWaveConfig(groupId, levelId)
	local wave = waveConfig:getWaves(self.waveIndex)
	-- dump(wave, "wave")

	if wave == nil then 
		print("赢了")
		scheduler.unscheduleGlobal(self.checkWaveHandler)
		return
	end

	local lastTime = 0
	local waveDelay = 2.0
	for groupId, group in ipairs(wave.enemys) do
		for i = 1, group.num do
			--delay
			local delay = group.delay[i] or lastTime
			if delay > lastTime then lastTime = delay end
			
			--pos
			assert(group["pos"], "group pos"..i)
			local pos = group["pos"][i] or 0

			--add
			local function addEnemyFunc()
				self:addEnemy(group.place, group.property, pos)
			end

			scheduler.performWithDelayGlobal(addEnemyFunc, delay)
		end
	end
	--check next wave
	self.checkWaveHandler = scheduler.performWithDelayGlobal(handler(self, self.checkWave), lastTime + 5)
end

function MapView:callfuncAddEnemys(event)
	for i,enemyData in ipairs(event.enemys) do
		local function addEnemyFunc()
			self:addEnemy(enemyData.placeName, 
				enemyData.property, enemyData.pos.x) --todo
		end		
		
		scheduler.performWithDelayGlobal(addEnemyFunc, 
			enemyData.delay)
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
	local enemyView = EnemyFactroy.createEnemy(property)

	self.enemys[#self.enemys + 1] = enemyView

	--scale
	local scale = cc.uiloader:seekNodeByName(placeNode, "scale")

	--pos
	local boundEnemy = enemyView:getRange("body1"):getBoundingBox()
	math.newrandomseed()
	local xPos = pos or math.random(boundEnemy.width/2, boundPlace.width)
	enemyView:setPosition(xPos, 0)
	
	--place
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
	--检查enemy的状态
	for i,enemy in ipairs(self.enemys) do
		if enemy and enemy:getDeadDone() then
			self:removeEnemy(enemy, i)
		end
	end
end

function MapView:removeEnemy(enemy, i)
	-- self:popGold(enemy)
	table.remove(self.enemys, i)
	enemy:removeFromParent()
	self.killEnemyCount = self.killEnemyCount + 1

end

function MapView:popGold(enemy)
	local boundingbox = enemy:getCascadeBoundingBox()
	local size = boundingbox.size
	local pos = cc.p(boundingbox.x + size.width / 2, boundingbox.y + size.height / 4)
	self.hero:dispatchEvent({name = Hero.SKILL_KILL_ENEMY_EVENT, enemyPos = pos, goldCount = self.killEnemyCount * 50})
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
	-- target
	for i,enemy in ipairs(self.enemys) do
		if enemy and enemy:getCascadeBoundingBox():containsPoint(event.destPos) then
			enemy:onHitted(event.damage)
		end
	end
end

function MapView:onHeroPlaneFire(event)
	
end

return MapView