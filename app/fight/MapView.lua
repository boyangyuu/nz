
--[[--

“战斗地图”的视图
desc： 
	1.地图管理者
	2.敌人管理者
]]

local scheduler 	= require(cc.PACKAGE_NAME .. ".scheduler")

local Hero 			= import(".Hero")
local Fight         = import(".Fight")
local Actor 		= import(".Actor")
local EnemyFactroy	= import(".EnemyFactroy")
local MapAnimView  	= import(".MapAnimView")

local MapView = class("MapView", function()
    return display.newNode()
end)

_isZooming = false
local kMissileZorder = 10000
local kMissilePlaceIndex = 100
local kEffectZorder = 101
function MapView:ctor()
	--instance
	self.hero 			= md:getInstance("Hero")
	self.fight			= md:getInstance("Fight")
	self.mapModel 		= md:getInstance("Map")
	self.enemys 		= {}
	self.waveIndex 		= 1
	self.isPause 		= false
	self.fightDescModel = md:getInstance("FightDescModel")
	--ccs
	self:loadCCS()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Hero.GUN_FIRE_EVENT, handler(self, self.onHeroFire))
        :addEventListener(Hero.ENEMY_ADD_EVENT, handler(self, self.callfuncAddEnemys))
        :addEventListener(Hero.ENEMY_ADD_MISSILE_EVENT, handler(self, self.callfuncAddMissile))
        :addEventListener(Hero.SKILL_GRENADE_ARRIVE_EVENT, handler(self, self.enemysHittedInRange))
        :addEventListener(Hero.ENEMY_ATTACK_MUTI_EVENT, handler(self, self.enemysHittedInRange))
    
    cc.EventProxy.new(self.fight, self)   
        :addEventListener(self.fight.FIGHT_START_EVENT, handler(self, self.startFight))

	cc.EventProxy.new(self.mapModel, self)
		:addEventListener(self.mapModel.MAP_ZOOM_OPEN_EVENT   , handler(self, self.openZoom))
        :addEventListener(self.mapModel.MAP_ZOOM_RESUME_EVENT , handler(self, self.resumeZoom))
        :addEventListener(self.mapModel.EFFECT_SHAKE_EVENT	, handler(self, self.playEffectShaked))
	self:setNodeEventEnabled(true)
end

function MapView:loadCCS()
	--map

	local waveConfig = self.mapModel:getCurWaveConfig()
	dump(waveConfig, "waveConfig")
	local mapName = waveConfig:getMapId()
	local mapSrcName = mapName..".json"   -- todo 外界
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")

	self.map = cc.uiloader:load(mapSrcName)
	addChildCenter(self.map, self)

	--effect self.mapAnim
	self.mapAnim = MapAnimView.new()
	self.map:addChild(self.mapAnim, kEffectZorder)

	--bg
	self.bg = cc.uiloader:seekNodeByName(self.map, "bg")

	--init enemy places
	local index = 1
	self.places = {}
    while true do
    	local name_ = "place_" .. index
    	local name = "place" .. index
    	local placeNode_ =  cc.uiloader:seekNodeByName(self.map, name_)
    	local placeNode = cc.uiloader:seekNodeByName(placeNode_, name)
    	local scaleNode = cc.uiloader:seekNodeByName(placeNode, "scale")

    	if scaleNode then scaleNode:setVisible(false) end
        if placeNode == nil then
            break
        end
        if isTest == false then 
        	local colorNode = cc.uiloader:seekNodeByName(placeNode_, "color")
	        colorNode:setVisible(false)
	    end
        self.places[name] = placeNode
        index = index + 1
    end
end

function MapView:startFight(event)
	self.fightDescModel:start()
	scheduler.performWithDelayGlobal(
		handler(self, self.updateEnemys), 2.0)
end

function MapView:updateEnemys()
	--wave config
	local waveConfig = self.mapModel:getCurWaveConfig()
	local wave = waveConfig:getWaves(self.waveIndex)
	-- dump(wave, "wave")

	if wave == nil then 
		print("赢了")
		scheduler.unscheduleGlobal(self.checkWaveHandler)
		self.fight:onWin()
		return
	end

	--wave提示
	if wave.waveType == "boss" then 
		self.fightDescModel:bossShow()
	else 
		self.fightDescModel:waveStart(self.waveIndex)
	end

	--addEnemys
	local lastTime = 0
	for groupId, group in ipairs(wave.enemys) do

		for i = 1, group.num do
			--desc
			self:showEnemyIntro(group.descId)

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

function MapView:showEnemyIntro(descId)
	local function callfuncShow()
		print("descId", descId)
		if descId then 
			self.fightDescModel:showEnemyIntro(descId)
		end				
	end
	scheduler.performWithDelayGlobal(callfuncShow, 2.0)
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
	self.checkEnemysEmptyHandler = scheduler.scheduleGlobal(checkEnemysEmpty, 1.0)
end

function MapView:addEnemy(property, pos, zorder)
	local placeName = property.placeName
	assert(placeName , "invalid param placeName:"..placeName)
	assert(property , "invalid param property:" )
	
	--place
	local substr 		= string.sub(placeName,6,-1)
	local placeIndex 	= 	tonumber(substr)
	local placeNode 	= self.places[placeName]
	assert(placeNode, "no placeNode! invalid param:"..placeName)		
	local boundPlace 	= placeNode:getBoundingBox()
	local pWorld 		= placeNode:convertToWorldSpace(cc.p(0,0))
	boundPlace.x 		= pWorld.x
	boundPlace.y 		= boundPlace.y	
	property.boundPlace = boundPlace
	property.placeIndex = placeIndex

	--scale
	local scale = cc.uiloader:seekNodeByName(placeNode, "scale")
	assert(scale, "scale is nil wave index"..self.waveIndex)
	property.scale = scale:getScaleX() 
	
	--create
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
			--pop gold
			local boundingbox = enemy:getCascadeBoundingBox()
			local size = boundingbox.size
			local pos = cc.p(boundingbox.x + size.width / 2, boundingbox.y + size.height / 4)
			self:doKillAward(pos)
			--remove
			table.remove(self.enemys, i)
			enemy:removeFromParent()
		elseif enemy and enemy:getWillRemoved() then
			--remove
			table.remove(self.enemys, i)
			enemy:removeFromParent()
		end
	end

end
function MapView:doKillAward(pos)
	self.hero:dispatchEvent({name = Hero.ENEMY_KILL_ENEMY_EVENT, 
		enemyPos = pos})
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

function MapView:callfuncAddMissile(event)
	local property = event.property
	property.placeIndex = kMissilePlaceIndex
	kMissileZorder = kMissileZorder - 1
	-- dump(property, "property")
	local enemyView = EnemyFactroy.createEnemy(property)
	local pWorld = property.srcPos
	-- dump(pWorld, "pWorld")
	local pos = self.map:convertToNodeSpace(pWorld)
	-- dump(pos,"pos")
	enemyView:setPosition(pos)
	self.enemys[#self.enemys + 1] = enemyView
	self.map:addChild(enemyView, kMissileZorder)
end

function MapView:onHeroFire(event)
	-- dump(event, " MapView onHeroFire event")
	local focusRangeNode = event.focusRangeNode
	local datas = self:getTargetDatas(focusRangeNode)

	--isThrough
	local gun = self.hero:getGun()
	local isThrough = gun:isFireThrough()
	if isThrough then
		self:mutiFire(datas)
	else
		self:singleFire(datas)
	end

	--pos
	local pWorld1 = focusRangeNode:convertToWorldSpace(cc.p(0,0))
	local box = focusRangeNode:getBoundingBox()
	pWorld1.x, pWorld1.y = pWorld1.x + box.width/2, pWorld1.y + box.height/2

	--effect
	local isHitted = not (#datas == 0)
	-- print("isHitted", isHitted)
	self.mapAnim:playEffectShooted({isHitted = isHitted, 
		pWorld= pWorld1})
end

function MapView:mutiFire(datas)
	for i,data in ipairs(datas) do
		local demageScale = data.demageScale or 1.0
		local enemy = data.enemy
		enemy:onHitted(data)
	end
end

function MapView:singleFire(datas)
	local selectedData  = nil
	local maxPlaceIndex = -1
	local maxZorder 	= -1
	for i,data in ipairs(datas) do
		local enemy = data.enemy
		local zo  = enemy:getLocalZOrder()
		local pi  = enemy:getPlaceIndex()
		-- print("placeIndex: "..pi.." zorder: "..zo)
		if pi >= maxPlaceIndex then
			if zo >= maxZorder then 
				selectedData = data
				maxZorder    = zo
				maxPlaceIndex= pi 
			end
		end	 
	end

	--hitted
	if selectedData == nil then return end
	local demageScale = selectedData.demageScale or 1.0
	local enemy = selectedData.enemy
	
	enemy:onHitted(selectedData)	
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

function MapView:playEffectShaked(event)
	print("function MapView:playEffectShaked(event)")
	local tMove = cc.MoveBy:create(0.05, cc.p(-18, -20))
	self:runAction(cc.Sequence:create(tMove, tMove:reverse(),
		 tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))
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