
--[[--

“战斗地图”的视图
desc： 
	1.地图管理者
	2.敌人管理者
]]

local scheduler 	= require(cc.PACKAGE_NAME .. ".scheduler")
local FightConfigs  = import(".fightConfigs.FightConfigs")

local Hero 			= import(".Hero")
local Fight         = import(".Fight")
local Actor 		= import(".Actor")
local EnemyFactroy	= import(".EnemyFactroy")

local MapView = class("MapView", function()
    return display.newNode()
end)

_isJu = false
_isZooming = false

function MapView:ctor()
	--instance
	self.hero = app:getInstance(Hero)
	self.fight = app:getInstance(Fight)
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
        :addEventListener(Hero.GUN_FIRE_EVENT, handler(self, self.onHeroFire))
        :addEventListener(Hero.ENEMY_ADD_EVENT, handler(self, self.callfuncAddEnemys))
        :addEventListener(Hero.ENEMY_ADD_MISSILE_EVENT, handler(self, self.callfuncAddMissile))
        :addEventListener(Hero.SKILL_GRENADE_ARRIVE_EVENT, handler(self, self.enemysHittedInRange))
        :addEventListener(Hero.ENEMY_ATTACK_MUTI_EVENT, handler(self, self.enemysHittedInRange))
        :addEventListener(Hero.MAP_ZOOM_OPEN_EVENT, handler(self, self.openZoom))
        :addEventListener(Hero.MAP_ZOOM_RESUME_EVENT, handler(self, self.resumeZoom))

	self:setNodeEventEnabled(true)
end

function MapView:loadCCS()
	--map
	local groupId = self.fight:getGroupId()
	local levelId = self.fight:getLevelId()

	local mapSrcName = "map_"..groupId.."_"..levelId..".json"   -- todo 外界
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
			print("第"..self.waveIndex.."波怪物消灭完毕")
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
		self.fight:setResult(true)
		return
	end

	local lastTime = 0
	local waveDelay = 2.0
	for groupId, group in ipairs(wave.enemys) do
		for i = 1, group.num do
			--delay
			print("group time", group.time)
			local delay = (group.delay[i] or lastTime) + group.time
			if delay > lastTime then lastTime = delay end
			
			--pos
			assert(group["pos"], "group pos"..i)
			local pos = group["pos"][i] or 0

			--zorder
			local zorder = group.num - i

			--add
			local function addEnemyFunc()
				self:addEnemy(group.property, pos, zorder)
			end

			scheduler.performWithDelayGlobal(addEnemyFunc, delay)
		end
	end
	--check next wave
	self.checkWaveHandler = scheduler.performWithDelayGlobal(handler(self, self.checkWave), lastTime + 5)
end

function MapView:callfuncAddEnemys(event)
	for i,enemyData in ipairs(event.enemys) do
		local zorder = #event.enemys - i
		local function addEnemyFunc()
			self:addEnemy(enemyData.property, 
			enemyData.pos.x, zorder) --todo
		end		
		
		scheduler.performWithDelayGlobal(addEnemyFunc, 
			enemyData.delay)
	end
end

local kMissileZorder = 1000
function MapView:callfuncAddMissile(event)
	print("MapView:addMissile(event)")
	local property = event.property
	kMissileZorder = kMissileZorder - 1
	-- dump(property, "property")
	local enemyView = EnemyFactroy.createEnemy(property)
	enemyView:setPosition(property.srcPos)
	self.enemys[#self.enemys + 1] = enemyView
	self.map:addChild(enemyView, kMissileZorder)
end

function MapView:addEnemy(property, pos, zorder)
	local placeName = property.placeName
	assert(placeName , "invalid param placeName:"..placeName )
	assert(property , "invalid param property:" )
	
	--place
	local placeNode = self.places[placeName]
	assert(placeNode, "no placeNode! invalid param:"..placeName)		
	local boundPlace = placeNode:getBoundingBox()
	local pWorld = placeNode:convertToWorldSpace(cc.p(0,0))
	boundPlace.x = pWorld.x
	boundPlace.y = boundPlace.y	
	property.boundPlace = boundPlace

	--scale
	local scale = cc.uiloader:seekNodeByName(placeNode, "scale")
	property.scale = scale:getScaleX() 
	-- property.scale = 0.5
	--enemy 改为工厂
	local enemyView = EnemyFactroy.createEnemy(property)
	self.enemys[#self.enemys + 1] = enemyView

	--pos
	local boundEnemy = enemyView:getRange("body1"):getBoundingBox()
	local xPos = pos or math.random(boundEnemy.width/2, boundPlace.width)
	enemyView:setPosition(xPos, 0)
	
	--add
	placeNode:addChild(enemyView, zorder)
end

function MapView:getSize()
	local bg = self.bg
	local size = cc.size(bg:getBoundingBox().width ,
		bg:getBoundingBox().height)
	return size 
end

function MapView:openZoom(event)
	if _isZooming then return end

	--event data
	local destWorldPos = event.destWorldPos
	local scale = event.scale
	local time = event.time
	self.hero:setMapZoom(scale)

	--todo 禁止触摸 todoyby
	_isZooming = true
	local function zoomEnd()
		-- 回复触摸Ftodoyby
		_isZooming = false
	end
	local pWorldMap = self:convertToNodeSpace(cc.p(0, 0))
	local offsetX = (destWorldPos.x  - pWorldMap.x) * (scale - 1)
	local offsetY = (destWorldPos.y - pWorldMap.y) * (scale - 1)	
	local action = cc.MoveBy:create(time, cc.p(offsetX, offsetY))
	self:runAction(cc.Sequence:create(action, cc.CallFunc:create(zoomEnd)))
	self:runAction(cc.ScaleBy:create(time, scale))	
end

function MapView:resumeZoom(event)
	if _isZooming then return end
	_isZooming = true
	self.hero:setMapZoom(1.0)

	local time = event.time
	local function zoomEnd()
		_isZooming = false
	end
	local w, h = display.width, display.height
	local action = cc.MoveTo:create(time , cc.p(w * 0.5, h * 0.5))	
	self:runAction(cc.Sequence:create(action, cc.CallFunc:create(zoomEnd)))
	self:runAction(cc.ScaleTo:create(time , 1))
end

--fight
function MapView:tick(dt)
	-- 检查enemy的状态
	for i,enemy in ipairs(self.enemys) do
		if enemy and enemy:getDeadDone() then
			self:removeEnemy(enemy, i)
		end
	end
end

function MapView:removeEnemy(enemy, i)
	self:popGold(enemy)
	table.remove(self.enemys, i)
	enemy:removeFromParent()
	self.killEnemyCount = self.killEnemyCount + 1
end

function MapView:popGold(enemy)
	local boundingbox = enemy:getCascadeBoundingBox()
	local size = boundingbox.size
	local pos = cc.p(boundingbox.x + size.width / 2, boundingbox.y + size.height / 4)
	self.hero:dispatchEvent({name = Hero.ENEMY_KILL_ENEMY_EVENT, 
		enemyPos = pos, goldCount = self.killEnemyCount * 50})
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
function MapView:getTargetDatas(focusNode)
	local targetDatas = {}
	for i,enemy in ipairs(self.enemys) do
		local isHited, targetData = enemy:getTargetData(focusNode)
		if isHited then targetDatas[#targetDatas + 1] = targetData end
	end
	return targetDatas 
end

--返回rect里包含enemy的点位置的enemys
function MapView:getEnemysInRect(rect)
	-- dump(rect, "rect") 
	local enemys = {}
	for i,enemy in ipairs(self.enemys) do
		if enemy then
			local armature = enemy:getEnemyArmature()
			local box = armature:getBoundingBox()
			local scale = enemy:getScale()
			local pos = armature:convertToWorldSpace(cc.p(0,0))
			pos = cc.p(pos.x - box.width/2 * scale, pos.y)  --pos 为左下角
			-- dump(pos, "pos")
			local enemyRect = cc.rect(pos.x, pos.y, 
				box.width * scale, box.height * scale)   --有scale问题
			-- dump(enemyRect, "enemyRect") 
			if cc.rectIntersectsRect(rect, enemyRect) then
			-- if cc.rectContainsPoint(rect, pos) then
				enemys[#enemys + 1] = enemy
			end
		end
	end	
	return enemys
end

--events
function MapView:onHeroFire(event)
	-- dump(event, " MapView onHeroFire event")
	local datas = self:getTargetDatas(event.focusRangeNode)
	
	for i,data in ipairs(datas) do
		local demageScale = data.demageScale or 1.0
		data.enemy:onHitted(data)
		if "穿透" then
			-- break  --todoyby 改为谁的zorder在前面 就打谁！！
		else
		end
	end 
end

function MapView:enemysHittedInRange(event)
	-- target
	assert(event.destRect, "event destRect is nil")
	local enemys = self:getEnemysInRect(event.destRect)
	for i,enemy in ipairs(enemys) do
		local targetData = event.targetData
		enemy:onHitted(targetData)
	end
end

function MapView:onHeroPlaneFire(event)
	
end
function MapView:onExit() 
	if self.checkEnemysEmptyHandler then
		scheduler.unscheduleGlobal(self.checkEnemysEmptyHandler)
	end
	if self.checkWaveHandler then
		scheduler.unscheduleGlobal(self.checkWaveHandler)
	end	
	
end


return MapView