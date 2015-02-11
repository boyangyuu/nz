
--[[--

“战斗地图”的视图
desc： 
	1.地图管理者
	2.敌人管理者
]]

local Hero 			= import(".Hero")
local Fight         = import(".Fight")
local Actor 		= import(".Actor")
local EnemyFactroy	= import(".EnemyFactroy")
local MapAnimView  	= import(".MapAnimView")

local MapView = class("MapView", function()
    return display.newNode()
end)


local kMissileZorder = 10000
local kMissilePlaceZOrder = 100
local kEffectZorder = 101
local kDefine = {
	orderMax = 20,  	--敌人同时出场最大序号
	zorderOffset = 100 	--
}
function MapView:ctor()
	--instance
	self.hero 			= md:getInstance("Hero")
	self.fight			= md:getInstance("Fight")
	self.mapModel 		= md:getInstance("Map")
	self.enemys 		= {}
	self.cacheEnemys    = {}
	self.waveIndex 		= 1
	self.isPause 		= false
	self.isZooming 		= false
	self.fightDescModel = md:getInstance("FightDescModel")
	--ccs
	self:loadCCS()

	-- event
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()
    cc.EventProxy.new(self.hero, self)
        :addEventListener(Hero.GUN_FIRE_EVENT, handler(self, self.onHeroFire))
        :addEventListener(Hero.ENEMY_WAVE_ADD_EVENT, handler(self, self.callfuncAddWave))
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
        :addEventListener(self.mapModel.EFFECT_JUSHAKE_EVENT	, handler(self, self.playEffectJuShaked))
		
	self:setNodeEventEnabled(true)

	self:schedule(handler(self, self.checkNumLimit),  1)	
end

function MapView:loadCCS()
	--map

	local waveConfig = self.mapModel:getCurWaveConfig()
	-- dump(waveConfig, "waveConfig")
	local mapName = waveConfig:getMapId()
	local mapSrcName = mapName..".json"   -- todo 外界
    cc.FileUtils:getInstance():addSearchPath("res/Fight/Maps")

	self.map = cc.uiloader:load(mapSrcName)
	addChildCenter(self.map, self) --todoyby 

	--effect self.mapAnim
	self.mapAnim = MapAnimView.new()
	self.map:addChild(self.mapAnim, kEffectZorder)

	--bg
	self.bg = cc.uiloader:seekNodeByName(self.map, "bg")
	self.mapModel:setMapBgNode(self.bg)
	local box = self.bg:getBoundingBox()
	-- dump(box, "box")
	self:loadPlaces()
end

function MapView:loadPlaces()
	--init enemy places
	local index = 1
	self.places = {}
    while true do
        if index == 40 then
            break
        end

    	local name = "place" .. index
    	local placeNode = cc.uiloader:seekNodeByName(self.map, name)

        if placeNode then 		
			placeZOrder = placeNode:getLocalZOrder()
			-- print("placeZOrder", placeZOrder)
	    	local scaleNode = cc.uiloader:seekNodeByName(placeNode, "scale")

	    	if scaleNode then scaleNode:setVisible(false) end

	        if isTest == false then 
	        	local colorNode = cc.uiloader:seekNodeByName(placeNode, "color")
		        colorNode:setVisible(false)
		    end
	        self.places[name] = placeNode
	    end
        index = index + 1
    end

    --init enemy cover
    self.covers = {}
	local index = 1
    while true do
    	if index == 20 then break end
    	local name = "cover" .. index
    	local coverNode = cc.uiloader:seekNodeByName(self.map, name)
	    if coverNode then
	        self.covers[#self.covers + 1] = coverNode
			if isTest then coverNode:setColor(cc.c3b(255, 195, 0)) end
		end
        index = index + 1
    end   

    --init cover image
    self.coverimages = {}
	local index = 1
    while true do
    	if index == 20 then break end
    	local name = "image" .. index
    	local node = cc.uiloader:seekNodeByName(self.map, name)
	    if node then
	        self.coverimages[#self.coverimages + 1] = node
		end
        index = index + 1
    end       	
end

function MapView:startFight(event)
	self.fightDescModel:start()
	self:performWithDelay(handler(self, self.updateEnemys), 2.0)
end

function MapView:updateEnemys()
	--wave config
	local waveConfig = self.mapModel:getCurWaveConfig()
	local wave = waveConfig:getWaves(self.waveIndex)
	-- dump(wave, "wave")

	if wave == nil then 
		print("赢了")
		local function win()
			self.fight:onWin()			
		end
		self:performWithDelay(win, 3.0)
		return
	end

	--wave提示
	if wave.waveType == "boss" then 
		self.fightDescModel:bossShow()
	else 
		self.fightDescModel:waveStart(self.waveIndex)
	end

	--addEnemys
	self:addWave(wave.enemys)
end

function MapView:addWave(waveData)
	local lastTime = 0
	local order = kDefine["orderMax"]
	for groupId, group in ipairs(waveData) do
		--desc
		self:showEnemyIntro(group.descId, group.time)

		--cache
		for i = 1, group.num do
			--delay
			local delay = (group.delay[i] or lastTime) + group.time
			if delay > lastTime then lastTime = delay end
			
			--pos
			assert(group["pos"], "group pos"..i)
			local pos = group["pos"][i] or 0
			
			--add
			local function addEnemyFunc()
				order = order - 1
				local enemyProperty = group.property
				--出场顺序
				enemyProperty["order"] = order  
				enemyProperty["offsetX"] = pos 
				self:cacheEnemy(enemyProperty)
			end
			--todo
			self:performWithDelay(addEnemyFunc, delay)
		end
	end	
	self:performWithDelay(handler(self, self.checkWave), lastTime + 1)	
end

function MapView:showEnemyIntro(descId, time)
	local function callfuncShow()
		if descId then 
			self.fightDescModel:showEnemyIntro(descId)
		end				
	end
	self:performWithDelay(callfuncShow, time)
end

function MapView:checkWave()
	local function checkEnemysEmpty()
		local leftnum =  self:getLeftEnemyNum()
		local cachenum = #self.cacheEnemys
		if leftnum == 0 and cachenum == 0 then 
			print("第"..self.waveIndex.."波怪物消灭完毕")
			self.waveIndex = self.waveIndex + 1

			self:updateEnemys()
			transition.removeAction(self.checkEnemysEmptyHandler)
		end
	end
	self.checkEnemysEmptyHandler = self:schedule(checkEnemysEmpty, 1.0)
end

function MapView:getLeftEnemyNum()
	local num = 0
	for i,enemyView in ipairs(self.enemys) do
		local type = enemyView:getEnemyType()
		if type ~= "missile" and type ~= "renzhi" 
			and type ~= "jinbi" and type ~= "dao_wang" then 
			num = num + 1
		end
	end
	return num
end

function MapView:addEnemy(property)
	local placeName = property.placeName
	assert(placeName , "invalid param placeName:"..placeName)
	assert(property , "invalid param property:" )
	
	--place
	local placeNode 	= self.places[placeName]
	assert(placeNode, "no placeNode! invalid param:"..placeName)		
	property.placeNode  = placeNode

	--scale
	local scale = cc.uiloader:seekNodeByName(placeNode, "scale")
	assert(scale, "scale is nil wave index"..self.waveIndex)
	property.scale = scale:getScaleX() 
	
	--create
	local enemyView = EnemyFactroy.createEnemy(property)
	self.enemys[#self.enemys + 1] = enemyView

	--pos
	local offsetX = property["offsetX"]
	
	--add
	local worldPlace    = placeNode:convertToWorldSpace(cc.p(0,0))
	local posPlaceInMap = self.map:convertToNodeSpace(worldPlace)
	enemyView:setPosition(cc.p(posPlaceInMap.x + offsetX, posPlaceInMap.y))
	self.map:addChild(enemyView)
end

function MapView:checkNumLimit()
	local waveConfig = self.mapModel:getCurWaveConfig()
	local limit 	 = waveConfig:getEnemyNumLimit()

	local num = self:getLeftEnemyNum()
	if num >= limit then return end

	local cacheData = self.cacheEnemys[1]
	if cacheData == nil then return end

	table.remove(self.cacheEnemys, 1)
	self:addEnemy(cacheData.property)
end

function MapView:checkZorder()
	local objects  = self:getSortedObjects()
	if #objects == 0 then return end
	local offset  = kDefine["zorderOffset"]
	local zIndex  = 1
	local curPosy = 1136
	for i,object in ipairs(objects) do
		local posy 		  = object["posy"]
		local appearorder = object["appearorder"] 
		local node        = object["node"]
		if curPosy - posy > 1 then 
			curPosy = posy
			zIndex = zIndex + 1
		end

		--zorder
		local zorder 	  = zIndex * offset - appearorder
		-- print("....................")
		-- print(i .." posy ".. posy)
		-- print("zorder", zorder)
		node:setLocalZOrder(zorder) 
	end
end

function MapView:getSortedObjects()
	local objects = {}
	for i,v in ipairs(self.enemys) do
		local object = {
			posy  		= v:getPositionY()	,
			appearorder = v:getProperty()["order"] or 0,
			type        = "enemy",
			node        = v,
		}
		objects[#objects + 1] = object 
	end

	for i,v in ipairs(self.covers) do
		local object = {
			posy  		= v:getPositionY()	,
			appearorder = 0,
			type        = "cover",
			node        = v,
		}
		objects[#objects + 1] = object 
	end

	for i,v in ipairs(self.coverimages) do
		local object = {
			posy  		= v:getPositionY()	,
			appearorder = 0,
			type        = "coverimage",
			node        = v,
		}
		objects[#objects + 1] = object 
	end

	local function sortfunction(object1, object2)
		local posy1 = object1["posy"]
		local posy2 = object2["posy"]
		return posy1 > posy2
	end
	table.sort(objects, sortfunction)
	-- dump(objects, "objects")
	return objects
end

function MapView:cacheEnemy(property)
	self.cacheEnemys[#self.cacheEnemys + 1] = {property = property}
end

function MapView:getBgSize()
	local bg = self.bg
	local size = cc.size(bg:getBoundingBox().width ,
		bg:getBoundingBox().height)
	return size 
end

function MapView:getBgOffset()
	local pos = cc.p(self.bg:getPositionX() - 1136/2, 
		self.bg:getPositionY() - 640/2)
	return pos
end

function MapView:openZoom(event)
	if self.isZooming then return end

	--event data
	local destWorldPos = event.destWorldPos
	local scale = event.scale
	local time = event.time
	self.hero:setMapZoom(scale)

	--todo 禁止触摸 todoyby
	self.isZooming = true
	local function zoomEnd()
		-- 回复触摸Ftodoyby
		self.isZooming = false
	end
	local pWorldMap = self:convertToNodeSpace(cc.p(0, 0))
	local offsetX = (destWorldPos.x  - pWorldMap.x) * (scale - 1)
	local offsetY = (destWorldPos.y - pWorldMap.y) * (scale - 1)	
	local action = cc.MoveBy:create(time, cc.p(offsetX, offsetY))
	self:runAction(cc.Sequence:create(action, cc.CallFunc:create(zoomEnd)))
	self:runAction(cc.ScaleBy:create(time, scale))	
end

function MapView:resumeZoom(event)
	if self.isZooming then return end
	self.hero:setMapZoom(1.0)

	local time = event.time
	local function zoomEnd()
		self.isZooming = false
	end
	local w, h = display.width, display.height1
	self:setPosition(cc.p(w * 0.5, h * 0.5))
	self:setScale(1.0)
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
			local enemyModel = enemy:getEnemyModel()
			local award = enemyModel:getAward()
			self:doKillAward(pos, award)
			--remove
			enemy:removeFromParent()			
			table.remove(self.enemys, i)
			enemy = nil
		elseif enemy and enemy:getWillRemoved() then
			--remove
			enemy:removeFromParent()			
			table.remove(self.enemys, i)
			enemy = nil
		end
	end

	--检查cache
	self:checkNumLimit()

	--检查zorder
	self:checkZorder()

end
function MapView:doKillAward(pos, award)
	self.hero:killEnemy(pos, award)
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
		local isCovered = self:isCovered(enemy, focusNode)
		if not isCovered then 
			local isHited, targetData = enemy:getTargetData(focusNode)
			if isHited then targetDatas[#targetDatas + 1] = targetData end
		end
	end
	return targetDatas 
end

function MapView:isCovered(enemy, focusNode)
	--isThrough
	local gun = self.hero:getGun()
	local isThrough = gun:isFireThrough()
	if isThrough then return false end	

	local focusBox = focusNode:getBoundingBox()
    local pFocus = focusNode:convertToWorldSpace(cc.p(0,0))
    focusBox.x = pFocus.x
    focusBox.y = pFocus.y
    -- dump(focusBox, "focusNodeBox")

	for i,cover in ipairs(self.covers) do
		--focus
		local coverBox = cover:getBoundingBox()

	    local pCover = cover:convertToWorldSpace(cc.p(0,0))
	    coverBox.x = pCover.x
	    coverBox.y = pCover.y
	    -- dump(coverBox, "coverBox")
	    --
		local isCovered = cc.rectIntersectsRect(focusBox, coverBox)
		if isCovered then 
			local placeZ = enemy:getPlaceZOrder() --todozorder
			local coverZ = cover:getLocalZOrder()
			if placeZ < coverZ then return true end
		end
	end
	return false
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
				enemys[#enemys + 1] = enemy
			end
		end
	end	
	return enemys
end

--events
function MapView:callfuncAddWave(event)
	-- dump(event, "event")
	self:addWave(event.waveData)

end

function MapView:callfuncAddEnemys(event)
	for i,enemyData in ipairs(event.enemys) do
		local function addEnemyFunc()
			local p = enemyData.property 
			p["order"] = i
			self:addEnemy(p)
		end		
		self:performWithDelay(addEnemyFunc, enemyData.delay)
	end
end

function MapView:callfuncAddMissile(event)
	local property = event.property
	property.placeZOrder = kMissilePlaceZOrder
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
	local robot = md:getInstance("Robot")
	local isRobotFire = robot:getIsRoboting()

	local isThrough = gun:isFireThrough() and not isRobotFire
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
	local maxPlaceZOrder = -1
	local maxZorder 	= -1
	for i,data in ipairs(datas) do
		local enemy = data.enemy
		local zo  = enemy:getLocalZOrder()  --todozorder
		local pi  = enemy:getPlaceZOrder()  --todozorder
		-- print("placeZOrder: "..pi.." zorder: "..zo)
		-- print("maxPlaceZOrder", maxPlaceZOrder)
		-- print("maxZorder", maxZorder)
		if pi >= maxPlaceZOrder then
			if zo >= maxZorder then 
				selectedData = data
				maxZorder    = zo
				maxPlaceZOrder= pi 
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
	local tMove = cc.MoveBy:create(0.07, cc.p(-36, -40))
	self:runAction(cc.Sequence:create(tMove, tMove:reverse(),
		 tMove, tMove:reverse(), tMove, tMove:reverse(), tMove, tMove:reverse()))
end

function MapView:playEffectJuShaked(event)
	local x = 100
	local y = 300
	local tMove = cc.MoveBy:create(event.time1, cc.p(-x, -y))
	local tMove1 = cc.MoveBy:create(event.time2, cc.p(x, y))
	self:runAction(cc.Sequence:create(tMove, tMove1))
end

return MapView