-- import("..includes.functionUtils")
local scheduler			 = require(cc.PACKAGE_NAME .. ".scheduler")
local FightResultModel 	= import(".FightResultModel")
local InlayModel 		= import("..inlay.InlayModel")
local FightModel 		= import("..fight.Fight")

local FightResultLayer = class("FightResultLayer", function()
	return display.newLayer()
end)

function FightResultLayer:ctor(properties)
	local percent = properties.percent
	self.grade = self:getGrade(percent)

    self.fightResultModel = app:getInstance(FightResultModel)
    self.inlayModel 	  = app:getInstance(InlayModel)
    self.fightModel 	  = app:getInstance(FightModel)

    self.cardover = {}
    self.cardgold = {}
    self.cardnormal = {}
    self.cardtouch = {}
    self.cardicon = {}
    self.cardlabel = {}
    self.star = {}
    self.quickinlay = {}
    self.probaTable = {}
    self.showTable = {}
    
    self:initData()
	self:loadCCS()
	self:initUI()
	
	self:playstar(self.grade)
	self:playcard(self.showTable)
	self:setNodeEventEnabled(true)
end

function FightResultLayer:loadCCS()
	cc.FileUtils:getInstance():addSearchPath("res/LevelDetail")
	local controlNode = cc.uiloader:load("guanqiapingjia.ExportJson")
    self.ui = controlNode
    self:addChild(controlNode)

    --anim
    local src = "res/FightResult/anim/guangkajl/guangkajl.csb"
    local starsrc = "res/FightResult/anim/gkjs_xing/gkjs_xing.csb"
    local manager = ccs.ArmatureDataManager:getInstance()
    manager:addArmatureFileInfo(src)
    manager:addArmatureFileInfo(starsrc)

    --play 发牌

end

function FightResultLayer:initData()
	self.probaTable = self:getinlayfall()
	for k,v in pairs(self.probaTable) do
		self.showTable[k] = v
	end
	-- local ran = math.random(#self.showTable)
	table.insert(self.showTable,3,self.showTable[#self.showTable])
	table.remove(self.showTable,#self.showTable)
	dump(self.showTable)
end
    
local playFanHander = nil
function FightResultLayer:playcard(showTable)
	--开牌 洗牌 扣牌
	local function playanim()
		self.armature:getAnimation():play("kaichixu" , -1, 1)
	end

	self.armature = ccs.Armature:create("guangkajl")	
    self.armature:setAnchorPoint(0.5,0.5)
    -- self.armature:setPosition(display.cx,display.cy-40)
    -- self.panelcard:addChild(self.armature)
    addChildCenter(self.armature, self.panelcard)
	self.armature:getAnimation():setMovementEventCallFunc(handler(self, self.animationEvent))	
	
	for k,v in pairs(showTable) do
		local randomRecordID = v.inlayid
		local inlayrecord = self.fightResultModel:getInlayrecordByID(randomRecordID)
		
		local skin = ccs.Skin:createWithSpriteFrameName(inlayrecord["imgname"]..".png")
	    self.armature:getBone("icon00"..k):addDisplay(skin, 1)
	    self.armature:getBone("icon00"..k):changeDisplayWithIndex(1, true)


		local node = cc.ui.UILabel.new({
        UILabelType = 2, text = inlayrecord["describe2"], size = 20})
		node:setAnchorPoint(cc.p(0.5,0.5))
 	    self.armature:getBone("label00"..k):addDisplay(node, 1)
	    self.armature:getBone("label00"..k):changeDisplayWithIndex(0, true)
	end

	-- self.armature:getAnimation():play("kaichixu" , -1, 1)

	playFanHander =  scheduler.performWithDelayGlobal(playanim, 2)
end

local playStarHandler = nil
function FightResultLayer:playstar(numStar)
	local posXinterval = 112
	for i=1,numStar do
		local delay = i * 0.5
		local function starcall()
		    local starArmature = ccs.Armature:create("gkjs_xing")
		    -- starArmature:setAnchorPoint(0,0)
		    starArmature:setPosition(43.5,42)
		    self.star[i]:addChild(starArmature)
		    -- addChildCenter(starArmature,self.star[i])
			starArmature:getAnimation():play("gkjs_xing" , -1, 0)
		end
		playStarHandler = scheduler.performWithDelayGlobal(starcall, delay)
	end
end

function FightResultLayer:initUI()
    self.btnreplay = cc.uiloader:seekNodeByName(self, "btnreplay")
    self.btnback = cc.uiloader:seekNodeByName(self, "btnback")
    self.btnnext = cc.uiloader:seekNodeByName(self, "btnnext")
    self.btninlay = cc.uiloader:seekNodeByName(self, "btninlay")
    self.leftnumber = cc.uiloader:seekNodeByName(self, "leftnumber")
    self.label = cc.uiloader:seekNodeByName(self, "label")
    self.leftnumber:setVisible(false)
    self.label:setVisible(false)

	self.btninlay:setTouchEnabled(false)
	self.btnreplay:setTouchEnabled(false)
	self.btnback:setTouchEnabled(false)
	self.btnnext:setTouchEnabled(false)

	local curGroup, curLevel = self.fightModel:getCurGroupAndLevel()
	-- local nextGroup, nextLevel = self.fightModel:getNextGroupAndLevel()
	addBtnEventListener(self.btnback, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then		
        	ui:changeLayer("HomeBarLayer",{})
        end
    end)
    addBtnEventListener(self.btnreplay, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
	        -- ui:closePopup()
        	ui:changeLayer("FightPlayer",{groupId = curGroup, 
	 			levelId = curLevel})
        end
    end)
    addBtnEventListener(self.btnnext, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
			-- ui:closePopup()
			-- ui:changeLayer("FightPlayer",{groupId = nextGroup, 
		 -- 		levelId = nextLevel})
        end
    end)
    addBtnEventListener(self.btninlay, function(event)
        if event.name=='began' then
            return true
        elseif event.name=='ended' then
        	self:quickInlay()
        end
    end)
    self.card = {}
    for i=1,6 do
    	self.card[i] = cc.uiloader:seekNodeByName(self, "card"..i)
    	self.card[i]:setTouchEnabled(true)
    	self.card[i]:setVisible(false)
    	self.card[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name=='began' then                
                return true
            elseif event.name=='ended' then
	            self:turnOverCard(i)
            	if self.grade == 0 then
				    self.leftnumber:setVisible(false)
				    self.label:setVisible(false)
        			for i=1,6 do
        				self.card[i]:setTouchEnabled(false)
        			end
            	end
            end
        end)
    end

    for i=1,6 do
    	self.cardgold[i] = cc.uiloader:seekNodeByName(self, "cardgold"..i)
    	self.cardnormal[i] = cc.uiloader:seekNodeByName(self, "cardnormal"..i)
    	self.cardover[i] = cc.uiloader:seekNodeByName(self, "cardover"..i)
    	self.cardicon[i] = cc.uiloader:seekNodeByName(self, "icon"..i)
    	self.cardlabel[i] = cc.uiloader:seekNodeByName(self, "labelcard"..i)
    	self.cardover[i]:setVisible(false)
    end
    for i=1,5 do
    	self.star[i] = cc.uiloader:seekNodeByName(self, "panelstar"..i)
	end
	self.panelcard = cc.uiloader:seekNodeByName(self, "panelcard")
end

function FightResultLayer:animationEvent(armatureBack,movementType,movementID)
	if movementType == ccs.MovementEventType.loopComplete then
		armatureBack:stopAllActions()
		if movementID == "kaichixu" then
				armatureBack:stopAllActions()
				armatureBack:getAnimation():play("koupai" , -1, 1)
    	elseif movementID == "fouchixu" then

    	elseif movementID == "koupai" then
    		armatureBack:getAnimation():play("xipai",-1,1)
		elseif movementID == "xipai" then
			-- armatureBack:pause()
			-- self.armature:setVisible(false)
			self.armature:removeFromParent()
			for k,v in pairs(self.card) do
				v:setVisible(true)
			end
			self.leftnumber:setVisible(true)
			self.label:setVisible(true)
			self.leftnumber:setString(self.grade)
			self.btnreplay:setTouchEnabled(true)
			self.btnback:setTouchEnabled(true)
			self.btnnext:setTouchEnabled(true)
			self.btninlay:setTouchEnabled(true)

		end
	end
end

function FightResultLayer:getGrade(LeftPersent)
	if LeftPersent < 0.2 then
		return 1
	elseif LeftPersent < 0.4 then
		return 2
	elseif LeftPersent < 0.6 then
		return 3
	elseif LeftPersent < 0.95 then
		return 4
	else
		return 5
	end
end

function FightResultLayer:getinlayfall()
	math.randomseed(os.time())
	
	local probaTable = {}
    local config = getConfig("config/inlayfall.json")

	for i=1,5 do
		local ran = math.random( 100)
		local total = 0
		for k,v in pairs(config) do
			total = total + v["probability"]
			if total > ran then
				table.insert(probaTable,{inlayid = v["inlayid"]})
				break
			end
		end
	end

	local rans = math.random(100)
	local table = getRecordByKey("config/inlayfall.json","type","special")
	local totals = 0
	for k,v in pairs(table) do
		totals = totals + v["probability"]
		if totals > rans then
			probaTable[6]={inlayid = v["inlayid"]}
			break
		end
	end
	-- dump(probaTable)
    return probaTable
end

function FightResultLayer:turnOverCard(index)
	self.grade = self.grade - 1
	self.leftnumber:setString(self.grade)
	-- dump(self.probaTable)
	local ran = math.random(1, 100)
	local record
	if ran < 4 then
		print(ran)
		print("卧槽，你真翻到金的了")
		record = self:getRanRecord(#self.probaTable)
	else
		local ran = math.random(1, #self.probaTable-1)
		record = self:getRanRecord(ran)
	end
	self.card[index]:setTouchEnabled(false)
	transition.scaleTo(self.card[index], {scaleX = 0, time = 0.2})
	self.cardover[index]:setVisible(true)


	if record["property"] == 4 then
		self.cardnormal[index]:setVisible(false)
		self.cardgold[index]:setVisible(true)		
	else
		-- dump(record["property"])
		self.cardgold[index]:setVisible(false)
		self.cardnormal[index]:setVisible(true)
	end

	self.cardover[index]:setScaleX(0)
	self.cardlabel[index]:setString(record["describe2"])
	local icon = display.newSprite("#"..record["imgname"]..".png")
	addChildCenter(icon, self.cardicon[index]) 
	local sequence = transition.sequence({cc.ScaleTo:create(0.2,0,1),cc.ScaleTo:create(0.2,1,1)})
	self.cardover[index]:runAction(sequence)

end

function FightResultLayer:getRanRecord( ran )
	local randomRecord = self.probaTable[ran]
	local randomRecordID = randomRecord["inlayid"]
	local inlayrecord = self.fightResultModel:getInlayrecordByID(randomRecordID)
	record = inlayrecord
	table.insert(self.quickinlay, {inlayid = inlayrecord["id"]})
	self.inlayModel:buyInlay(inlayrecord["id"])
	table.remove(self.probaTable,ran)
	return record
end

function FightResultLayer:turnLeftCard()
	for i=1,6 do
		if self.cardover[i]:isVisible() == false then
			-- dump(i)
			self:turnOverCard(i)
		end
	end
end

function FightResultLayer:quickInlay()
	dump(self.quickinlay)
	self.inlayModel:equipAllBestInlays(self.quickinlay)
end

function FightResultLayer:onExit()
	if playFanHander then 
		scheduler.unscheduleGlobal(playFanHander)
	end

	if playStarHandler then 
		scheduler.unscheduleGlobal(playStarHandler)
	end	
end

return FightResultLayer